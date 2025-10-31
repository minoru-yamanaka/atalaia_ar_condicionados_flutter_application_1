import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

// 1. MODELO DE DADOS ATUALIZADO
class Appointment {
  final String id;
  final String customerName;
  final String service;
  final DateTime date;
  final String notes; // NOVO: Campo para as notas

  Appointment({
    required this.id,
    required this.customerName,
    required this.service,
    required this.date,
    required this.notes, // NOVO
  });

  // MODIFICADO: Métodos toJson e fromJson para incluir as notas
  Map<String, dynamic> toJson() => {
    'id': id,
    'customerName': customerName,
    'service': service,
    'date': date.toIso8601String(),
    'notes': notes, // NOVO
  };

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
    id: json['id'],
    customerName: json['customerName'],
    service: json['service'],
    date: DateTime.parse(json['date']),
    notes:
        json['notes'] ??
        '', // NOVO: Usa ?? '' para compatibilidade com agendamentos antigos
  );
}

// 2. A PÁGINA EM SI (STATEFULWIDGET)
class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  final _formKey = GlobalKey<FormState>();
  // Controladores para os campos do formulário
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _notesController =
      TextEditingController(); // NOVO: Controlador para as notas
  final _searchController = TextEditingController();
  String _selectedService = 'Higienização';

  List<Appointment> _allAppointments = [];
  List<Appointment> _filteredAppointments = [];

  @override
  void initState() {
    super.initState();
    _loadAppointments();
    _searchController.addListener(() {
      _filterAppointments();
    });
  }

  // --- LÓGICA DE DADOS ---

  Future<void> _loadAppointments() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> appointmentsJson =
        prefs.getStringList('appointments') ?? [];
    setState(() {
      _allAppointments = appointmentsJson
          .map((json) => Appointment.fromJson(jsonDecode(json)))
          .toList();
      _allAppointments.sort((a, b) => b.date.compareTo(a.date));
      _filteredAppointments = _allAppointments;
    });
  }

  Future<void> _saveAppointments() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> appointmentsJson = _allAppointments
        .map((app) => jsonEncode(app.toJson()))
        .toList();
    await prefs.setStringList('appointments', appointmentsJson);
  }

  // MODIFICADO: Busca agora inclui as notas
  void _filterAppointments() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredAppointments = _allAppointments.where((appointment) {
        final nameMatches = appointment.customerName.toLowerCase().contains(
          query,
        );
        final serviceMatches = appointment.service.toLowerCase().contains(
          query,
        );
        final dateMatches = DateFormat(
          'dd/MM/yyyy',
        ).format(appointment.date).contains(query);
        final notesMatches = appointment.notes.toLowerCase().contains(
          query,
        ); // NOVO
        return nameMatches || serviceMatches || dateMatches || notesMatches;
      }).toList();
    });
  }

  Future<void> _deleteAppointment(String id) async {
    setState(() {
      _allAppointments.removeWhere((app) => app.id == id);
      _filterAppointments();
    });
    await _saveAppointments();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Agendamento removido!'),
        backgroundColor: Colors.red,
      ),
    );
  }

  // --- LÓGICA DE INTERAÇÃO ---

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  // MODIFICADO: Função de envio para incluir as notas
  Future<void> _sendToWhatsApp() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final service = _selectedService;
      final date = _dateController.text;
      final notes = _notesController.text; // NOVO: Captura o valor das notas

      final newAppointment = Appointment(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        customerName: name,
        service: service,
        date: DateFormat('dd/MM/yyyy').parse(date),
        notes: notes, // NOVO: Passa as notas para o objeto
      );

      setState(() {
        _allAppointments.add(newAppointment);
        _allAppointments.sort((a, b) => b.date.compareTo(a.date));
        _filterAppointments();
      });
      await _saveAppointments();

      // MODIFICADO: Mensagem do WhatsApp agora inclui as notas se houver
      String message =
          'Olá! Gostaria de solicitar um agendamento:\n\n'
          '*Cliente:* $name\n'
          '*Serviço:* $service\n'
          '*Data Sugerida:* $date';

      if (notes.isNotEmpty) {
        message += '\n*Observações:* $notes';
      }

      final phoneNumber = '5511959473402'; // SUBSTITUA PELO SEU NÚMERO
      final Uri whatsappUri = Uri.parse(
        'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}',
      );

      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri);
        _nameController.clear();
        _dateController.clear();
        _notesController.clear(); // NOVO: Limpa o campo de notas
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Não foi possível abrir o WhatsApp.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendamentos'),
        backgroundColor: const Color(0xFF0C1D34),
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- 3. FORMULÁRIO DE AGENDAMENTO ATUALIZADO ---
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Novo Agendamento',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF343B6C),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nome do Cliente',
                          border: OutlineInputBorder(
                           borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Campo obrigatório'
                            : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _dateController,
                        decoration: const InputDecoration(
                          labelText: 'Data Desejada',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          prefixIcon: Icon(Icons.calendar_today), 
                        ),
                        readOnly: true,
                        onTap: _pickDate,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Campo obrigatório'
                            : null,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        initialValue: _selectedService,
                        decoration: const InputDecoration(
                          labelText: 'Serviço',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        items:
                            [
                                  'Higienização',
                                  'Manutenção',
                                  'Instalação',
                                  'Infraestrutura',
                                  'Outros',
                                ]
                                .map(
                                  (label) => DropdownMenuItem(
                                    value: label,
                                    child: Text(label),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _selectedService = value);
                          }
                        },
                      ),
                      const SizedBox(height: 12),
                      // NOVO: Campo de texto para as notas
                      TextFormField(
                        controller: _notesController,
                        decoration: const InputDecoration(
                          labelText: 'Notas / Detalhes (opcional)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        maxLines: 3, // Permite múltiplas linhas de texto
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _sendToWhatsApp,
                          icon: const Icon(Icons.message),
                          label: const Text('Agendar via WhatsApp'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            iconColor: Color(0xFF343B6C),
                            shadowColor: Color(0xFF343B6C),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // --- 4. HISTÓRICO E BUSCA ATUALIZADOS ---
            const Text(
              'Histórico de Agendamentos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Buscar por nome, serviço, data ou nota',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _filteredAppointments.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text('Nenhum agendamento encontrado.'),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _filteredAppointments.length,
                    itemBuilder: (context, index) {
                      final appointment = _filteredAppointments[index];
                      // MODIFICADO: Exibe a nota no subtítulo se ela existir
                      String subtitleText =
                          '${appointment.service} - ${DateFormat('dd/MM/yyyy').format(appointment.date)}';
                      if (appointment.notes.isNotEmpty) {
                        subtitleText += '\nNota: ${appointment.notes}';
                      }
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          title: Text(
                            appointment.customerName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(subtitleText),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                            onPressed: () => _deleteAppointment(appointment.id),
                            tooltip: 'Remover agendamento',
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
