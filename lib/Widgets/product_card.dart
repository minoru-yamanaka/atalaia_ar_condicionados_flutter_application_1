// product_card.dart

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Importe o pacote

class ProductCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final String price;

  const ProductCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(imagePath, fit: BoxFit.cover, width: double.infinity, height: 150),
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(description, style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(price, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
                ElevatedButton(
                  onPressed: () {
                    // Chama a função para abrir o WhatsApp, passando o nome do serviço
                    _launchWhatsApp(context, title);
                  },
                  // Muda o texto do botão
                  child: const Text('Contratar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


  // Função para abrir o WhatsApp
  void _launchWhatsApp(BuildContext context, String serviceName) async {
    // Substitua pelo número de telefone da sua empresa
    final String phoneNumber = '5511987654321'; 
    // Mensagem que será pré-preenchida no WhatsApp
    final String message = 'Olá! Gostaria de contratar o serviço de *$serviceName*.';
    
    // Codifica a mensagem para ser usada na URL
    final Uri whatsappUri = Uri.parse(
      'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}'
    );

    // Tenta abrir a URL
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {
      // Mostra um erro caso não consiga abrir o WhatsApp
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível abrir o WhatsApp.')),
      );
    }
  }