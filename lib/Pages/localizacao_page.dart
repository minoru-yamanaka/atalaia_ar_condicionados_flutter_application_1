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

  // NOVO: Função para abrir o discador do telefone
  void _launchPhone(BuildContext context) {
    final Uri url = Uri.parse('tel:+5511948887050'); // Use o formato tel:+55...
    _launchUrl(context, url);
  }

  // NOVO: Função para abrir o cliente de e-mail
  void _launchEmail(BuildContext context) {
    final Uri url = Uri.parse('atalaiaarcondicionado@gmail.com');
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
                    const ListTile(
                      leading: Icon(
                        Icons.location_city,
                        color: AppColors.primaryColor,
                      ), // MODIFICADO: Cor
                      title: Text('Endereço'),
                      subtitle: Text(
                        'Rua das Soluções, 123 - Bairro Central, Sua Cidade - SP',
                      ),
                    ),
                    const Divider(indent: 16, endIndent: 16),
                    ListTile(
                      leading: const Icon(
                        Icons.phone,
                        color: AppColors.primaryColor,
                      ), // MODIFICADO: Cor
                      title: const Text('Telefone'),
                      subtitle: const Text('(11) 94888-7050'),
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
                      subtitle: const Text('atalaiaarcondicionado@gmail.com'),
                      onTap: () =>
                          _launchEmail(context), // NOVO: Ação de clique
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              const SizedBox(height: 32),

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
            ],
          ),
        ),
      ),
    );
  }
}
