import 'package:atalaia_ar_condicionados_flutter_application/Config/app_colors.dart';
import 'package:atalaia_ar_condicionados_flutter_application/Config/app_text_style.dart';
import 'package:atalaia_ar_condicionados_flutter_application/Pages/login_page.dart';
import 'package:flutter/material.dart';
// Import necessário para abrir links externos, como o mapa
// import 'package:url_launcher/url_launcher.dart';

class LocalizacaoPage extends StatelessWidget {
  const LocalizacaoPage({super.key});

  // Função para abrir o mapa com o endereço da empresa
  void _launchMaps() async {
    // Codifica o endereço para ser usado em uma URL de forma segura
    const String address =
        'Rua das Soluções, 123, Bairro Central, Sua Cidade, SP';
    final String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}';

    final Uri url = Uri.parse(googleMapsUrl);

    // if (await canLaunchUrl(url)) {
    //   await launchUrl(url);
    // } else {
    //   // Em um app real, seria bom mostrar um erro para o usuário (ex: com um SnackBar)
    //   throw 'Não foi possível abrir o mapa em: $url';
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Localização e Contato'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      // Usamos SingleChildScrollView para garantir que a tela seja rolável
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Seção 1: Texto Introdutório
              const Text(
                'Venha nos visitar ou entre em contato para agendar uma visita técnica.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),

              // Seção 2: Informações de Contato
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.location_city),
                      title: Text('Endereço'),
                      subtitle: Text(
                        'Rua das Soluções, 123 - Bairro Central, Sua Cidade - SP',
                      ),
                    ),
                    Divider(indent: 16, endIndent: 16),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text('Telefone'),
                      subtitle: Text('(11) 98765-4321'),
                    ),
                    Divider(indent: 16, endIndent: 16),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text('Email'),
                      subtitle: Text('contato@suaempresa.com.br'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Seção 3: Mapa
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade300,
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/img/mapa-placeholder.png', // Verifique se o caminho da imagem está correto
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.map),
                      label: const Text('Abrir no Mapa'),
                      onPressed:
                          _launchMaps, // Chama a função para abrir o mapa
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Seção 4: Logout
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.logout, color: AppColors.primaryColor),
                          const SizedBox(width: 12),
                          Text(
                            "Encerrar Sessão",
                            style: AppTextStyle.subtitlePages.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Navega para a tela de login e remove TODAS as rotas anteriores da pilha
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: Text(
                          "Sair",
                          style: AppTextStyle.titleAppBar.copyWith(
                            color: Colors.blue,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24), // Espaçamento final
            ],
          ),
        ),
      ),
    );
  }
}
