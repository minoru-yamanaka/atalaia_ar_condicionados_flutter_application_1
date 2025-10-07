import 'package:flutter/material.dart';
// Para abrir o mapa, adicione o pacote `url_launcher` ao seu pubspec.yaml
// import 'package:url_launcher/url_launcher.dart';

class LocalizacaoPage extends StatelessWidget {
  const LocalizacaoPage({super.key});

  // Função para abrir o mapa
  // void _launchMaps() async {
  //   const url = 'https://maps.google.com/?q=Rua das Soluções, 123, Sua Cidade, SP';
  //   if (await canLaunchUrl(Uri.parse(url))) {
  //     await launchUrl(Uri.parse(url));
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Onde nos Encontrar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Venha nos visitar ou entre em contato para agendar uma visita técnica.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: const [
                    ListTile(
                      leading: Icon(Icons.location_city),
                      title: Text('Endereço'),
                      subtitle: Text('Rua das Soluções, 123 - Bairro Central, Sua Cidade - SP'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Telefone'),
                      subtitle: Text('(11) 98765-4321'),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text('Email'),
                      subtitle: Text('contato@suaempresa.com.br'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Simulação do mapa
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade300,
                  image: const DecorationImage(
                    image: AssetImage('assets/img/mapa-placeholder.png'), // Crie uma imagem de placeholder
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.map),
                    label: const Text('Abrir no Mapa'),
                    onPressed: () {
                      // Descomente a função e a importação para usar
                      // _launchMaps();
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// https://gemini.google.com/app/9a7df1b013a420ef?hl=pt-PT