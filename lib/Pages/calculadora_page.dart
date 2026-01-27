// Navegue no seu projeto até a seguinte pasta e abra o arquivo:
// android/app/src/main/AndroidManifest.xml e add:
// <queries>
//         <intent>
//             <action android:name="android.intent.action.VIEW" />
//             <data android:scheme="https" />
//         </intent>
//         <intent>
//             <action android:name="android.intent.action.VIEW" />
//             <data android:scheme="whatsapp" />
//         </intent>
//     </queries>
//  e Confirme que a linha url_launcher: ^6.2.6 (ou uma versão mais nova)
//  está no seu pubspec.yaml e que você rodou flutter pub get.

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({super.key});

  @override
  State<CalculadoraPage> createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  final _areaController = TextEditingController();
  final _pessoasController = TextEditingController();
  final _eletronicosController = TextEditingController();
  final _janelasController = TextEditingController();

  String _recebeSol = 'nao';
  String _resultado = 'Preencha os campos para calcular.';

  bool _isResultAvailable = false;

  void _launchWhatsAppWithBTUs(BuildContext context, String btuResult) async {
    // IMPORTANTE: Substitua pelo número de telefone da sua empresa
    final String phoneNumber = '5511959473402';
    final String message =
        'Olá! A calculadora de BTUs do app indicou um resultado de *$btuResult*. Gostaria de um orçamento.';

    final Uri whatsappUri = Uri.parse(
      'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}',
    );

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível abrir o WhatsApp.')),
      );
    }
  }

  void _calcularBTUs() {
    final double? area = double.tryParse(_areaController.text);
    final int? pessoas = int.tryParse(_pessoasController.text);
    final int eletronicos = int.tryParse(_eletronicosController.text) ?? 0;
    final int janelas = int.tryParse(_janelasController.text) ?? 0;

    if (area == null || pessoas == null || area <= 0 || pessoas <= 0) {
      setState(() {
        _resultado = 'Por favor, insira valores válidos de área e pessoas.';
        _isResultAvailable = false;
      });
      return;
    }

    // Com a verificação acima, agora podemos garantir ao Dart que as variáveis não são nulas
    // usando o operador '!' (asserção nula).
    int baseBTUs = (area * 600).toInt();
    if (pessoas > 1) {
      baseBTUs += (pessoas - 1) * 600;
    }
    baseBTUs += eletronicos * 600;
    if (_recebeSol == 'sim') {
      baseBTUs += 800 + (janelas * 200);
    }

    setState(() {
      _resultado = '$baseBTUs BTUs';
      _isResultAvailable = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de BTUs'),
        backgroundColor: const Color(0xFF0C1D34),
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Não sabe qual a potência ideal? Use nossa calculadora para ter uma estimativa.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _areaController,
              decoration: const InputDecoration(
                labelText: 'Área do ambiente (em m²)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _pessoasController,
              decoration: const InputDecoration(
                labelText: 'Número de pessoas no ambiente',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _eletronicosController,
              decoration: const InputDecoration(
                labelText: 'Quantidade de eletrônicos (TV, PC)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _janelasController,
              decoration: const InputDecoration(
                labelText: 'Quantidade de janelas no ambiente',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _recebeSol,
              decoration: const InputDecoration(
                labelText: 'O ambiente recebe sol intenso?',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'nao',
                  child: Text('Não (sol da manhã)'),
                ),
                DropdownMenuItem(
                  value: 'sim',
                  child: Text('Sim (sol da tarde)'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _recebeSol = value;
                  });
                }
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calcularBTUs,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Calcular'),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    'Potência Recomendada:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _resultado,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Visibility(
              visible: _isResultAvailable,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.chat_bubble_outline),
                label: const Text('PEDIR ORÇAMENTO VIA WHATSAPP'),
                onPressed: () {
                  _launchWhatsAppWithBTUs(context, _resultado);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '*Este é um cálculo aproximado. Para uma avaliação precisa, consulte um de nossos técnicos.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
