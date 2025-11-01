import 'package:atalaia_ar_condicionados_flutter_application/Config/app_colors.dart';
import 'package:atalaia_ar_condicionados_flutter_application/Config/app_text_style.dart';
import 'package:atalaia_ar_condicionados_flutter_application/pages/login_page.dart';
import 'package:flutter/material.dart';
// import 'package.flutter/material.dart';
// IMPORTANTE: Descomente esta linha para as funções de link funcionarem
import 'package:url_launcher/url_launcher.dart';

class LocalizacaoPage extends StatelessWidget {
  const LocalizacaoPage({super.key});

  // --- FUNÇÕES DE AÇÃO ---

  // Função genérica para abrir URLs e tratar erros
  Future<void> _launchUrl(BuildContext context, Uri url) async {
    if (!await launchUrl(url)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Não foi possível abrir o link: ${url.path}')),
      );
    }
  }

  // Função para abrir o mapa com o endereço da empresa
  void _launchMaps(BuildContext context) {
    const String address =
        'Rua das Soluções, 123, Bairro Central, Sua Cidade, SP';
    // URL padrão do Google Maps para busca
    final Uri url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}',
    );
    _launchUrl(context, url);
  }

  // NOVO: Função para abrir o discador do telefone
  void _launchPhone(BuildContext context) {
    final Uri url = Uri.parse('tel:+5511987654321'); // Use o formato tel:+55...
    _launchUrl(context, url);
  }

  // NOVO: Função para abrir o cliente de e-mail
  void _launchEmail(BuildContext context) {
    final Uri url = Uri.parse('mailto:contato@suaempresa.com.br');
    _launchUrl(context, url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Localização e Contato'),
        backgroundColor: const Color(0xFF0C1D34),
        foregroundColor: Colors.white,
        elevation: 1,
      ),
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

              // Seção 2: Informações de Contato (MODIFICADO para ser interativo)
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.location_city,
                        // color: AppColors.primaryColor, // Certifique-se que AppColors está definido
                      ),
                      title: const Text('Endereço'),
                      subtitle: const Text(
                        'Rua das Soluções, 123 - Bairro Central, Sua Cidade - SP',
                      ),
                      onTap: () => _launchMaps(
                        context,
                      ), // MODIFICADO: Ação de clique para abrir mapas
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                    ),
                    const Divider(indent: 16, endIndent: 16),
                    ListTile(
                      leading: const Icon(
                        Icons.phone,
                        color: AppColors.primaryColor,
                      ), // MODIFICADO: Cor
                      title: const Text('Telefone'),
                      subtitle: const Text('(11) 98765-4321'),
                      onTap: () =>
                          _launchPhone(context), // NOVO: Ação de clique
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                    ),
                    const Divider(indent: 16, endIndent: 16),
                    ListTile(
                      leading: const Icon(
                        Icons.email,
                        color: AppColors.primaryColor,
                      ), // MODIFICADO: Cor
                      title: const Text('Email'),
                      subtitle: const Text('contato@suaempresa.com.br'),
                      onTap: () =>
                          _launchEmail(context), // NOVO: Ação de clique
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Seção 4: Logout (MODIFICADO para consistência de cor)
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
                          const Icon(
                            Icons.logout,
                            color: AppColors.primaryColor,
                          ),
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
                            color: AppColors.primaryColor, // MODIFICADO: Cor
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Seção 4: Logout (MODIFICADO para consistência de cor)
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
                          const Icon(
                            Icons.logout,
                            color: AppColors.primaryColor,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "Encerrar Sessão",
                            style: AppTextStyle.subtitlePages.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
