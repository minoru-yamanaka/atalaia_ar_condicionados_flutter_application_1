import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({super.key});

  @override
  State<CalculadoraPage> createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  final _areaController = TextEditingController();
  final _pessoasController = TextEditingController();
  String _recebeSol = 'nao';
  String _resultado = 'Preencha os campos para calcular.';

  void _calcularBTUs() {
    final double? area = double.tryParse(_areaController.text);
    final int? pessoas = int.tryParse(_pessoasController.text);

    if (area == null || pessoas == null || area <= 0 || pessoas <= 0) {
      setState(() {
        _resultado = 'Por favor, insira valores válidos.';
      });
      return;
    }

    // Lógica de cálculo simplificada
    int baseBTUs = (area * 600).toInt();
    if (pessoas > 1) {
      baseBTUs += (pessoas - 1) * 600;
    }
    if (_recebeSol == 'sim') {
      baseBTUs += 800;
    }

    setState(() {
      _resultado = '$baseBTUs BTUs';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora de BTUs')),
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
  