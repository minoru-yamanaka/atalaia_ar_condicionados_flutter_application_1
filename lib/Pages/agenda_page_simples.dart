import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import "package:shared_preferences/shared_preferences.dart";
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

// 1. MODELO DE DADOS PARA O AGENDAMENTO
class Appointment {
  final String id;
  final String customerName;
  final String service;
  final DateTime date;

  Appointment({
    required this.id,
    required this.customerName,
    required this.service,
    required this.date,
  });

  // Métodos para converter o objeto para/de JSON, para salvar no SharedPreferences
  Map<String, dynamic> toJson() => {
    'id': id,
    'customerName': customerName,
    'service': service,
    'date': date.toIso8601String(),
  };

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
    id: json['id'],
    customerName: json['customerName'],
    service: json['service'],
    date: DateTime.parse(json['date']),
  );
}

// 2. A PÁGINA EM SI (STATEFULWIDGET)
class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  // Chave para validar o formulário
  final _formKey = GlobalKey<FormState>();
  // Controladores para os campos do formulário
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _searchController = TextEditingController();
  String _selectedService = 'Higienização';

  // Listas para gerenciar os agendamentos
  List<Appointment> _allAppointments = [];
  List<Appointment> _filteredAppointments = [];

  @override
  void initState() {
    super.initState();
    _loadAppointments(); // Carrega o histórico ao iniciar a tela
    // Adiciona um listener no campo de busca para filtrar em tempo real
    _searchController.addListener(() {
      _filterAppointments();
    });
  }

  // --- LÓGICA DE DADOS (CARREGAR, SALVAR, FILTRAR) ---

  Future<void> _loadAppointments() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> appointmentsJson =
        prefs.getStringList('appointments') ?? [];
    setState(() {
      _allAppointments = appointmentsJson
          .map((json) => Appointment.fromJson(jsonDecode(json)))
          .toList();
      _allAppointments.sort(
        (a, b) => b.date.compareTo(a.date),
      ); // Ordena por data
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
        return nameMatches || serviceMatches || dateMatches;
      }).toList();
    });
  }

  Future<void> _deleteAppointment(String id) async {
    setState(() {
      _allAppointments.removeWhere((app) => app.id == id);
      _filterAppointments(); // Atualiza a lista filtrada também
    });
    await _saveAppointments();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Agendamento removido!'),
        backgroundColor: Colors.red,
      ),
    );
  }

  // --- LÓGICA DE INTERAÇÃO (SELECIONAR DATA, ENVIAR WHATSAPP) ---

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

  Future<void> _sendToWhatsApp() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final service = _selectedService;
      final date = _dateController.text;

      final newAppointment = Appointment(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        customerName: name,
        service: service,
        date: DateFormat('dd/MM/yyyy').parse(date),
      );

      // Adiciona na lista e salva
      setState(() {
        _allAppointments.add(newAppointment);
        _allAppointments.sort((a, b) => b.date.compareTo(a.date));
        _filterAppointments();
      });
      await _saveAppointments();

      // Monta e envia a mensagem para o WhatsApp
      final phoneNumber = '5511959473402'; // SUBSTITUA PELO SEU NÚMERO
      final message =
          'Olá! Gostaria de solicitar um agendamento:\n\n'
          '*Cliente:* $name\n'
          '*Serviço:* $service\n'
          '*Data Sugerida:* $date';

      final Uri whatsappUri = Uri.parse(
        'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}',
      );

      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri);
        // Limpa o formulário após o sucesso
        _nameController.clear();
        _dateController.clear();
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
      appBar: AppBar(title: const Text('Agendamentos')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- 3. FORMULÁRIO DE AGENDAMENTO ---
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
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nome do Cliente',
                          border: OutlineInputBorder(),
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
                          border: OutlineInputBorder(),
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
                          border: OutlineInputBorder(),
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
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _sendToWhatsApp,
                          icon: const Icon(Icons.messenger),
                          label: const Text('Agendar via WhatsApp'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // --- 4. HISTÓRICO E BUSCA ---
            const Text(
              'Histórico de Agendamentos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Buscar por nome, serviço ou data (dd/mm/aaaa)',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
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
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          title: Text(appointment.customerName),
                          subtitle: Text(
                            '${appointment.service} - ${DateFormat('dd/MM/yyyy').format(appointment.date)}',
                          ),
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
