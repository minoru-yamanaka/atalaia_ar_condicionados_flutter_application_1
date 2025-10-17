import 'package:atalaia_ar_condicionados_flutter_application/Config/app_colors.dart';
import 'package:atalaia_ar_condicionados_flutter_application/Widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:atalaia_ar_condicionados_flutter_application/Pages/localizacao_page.dart';
// IMPORTANTE: Importe o novo widget do chatbot que criamos
import 'package:atalaia_ar_condicionados_flutter_application/Pages/chatbot_widget.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  // Função para abrir o chatbot em um Modal Bottom Sheet
  void _openChatbot(BuildContext context) {
    showModalBottomSheet(
      context: context,
      // Permite que o sheet seja mais alto que a metade da tela
      isScrollControlled: true,
      // Deixa os cantos superiores arredondados
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        // Define a altura do BottomSheet para 90% da tela
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: const ChatbotWidget(), // Aqui usamos nosso novo widget!
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Color(0xFF343B6C),
    );
    const contentStyle = TextStyle(
      fontSize: 16,
      color: Colors.black87,
      height: 1.5,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Informações e Dicas'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      // Adicionamos o botão flutuante aqui
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openChatbot(context),
        icon: Icon(Icons.chat_bubble_outline),
        label: Text("Assistente"),
        // backgroundColor: Colors.blue,
        backgroundColor: Colors.blue.shade800,
      ),
      body: ListView(
        padding: const EdgeInsets.all(
          16.0,
        ).copyWith(bottom: 80), // Espaço extra no final para o FAB não cobrir
        children: [
          // --- Seus Cards de informação permanecem os mesmos ---
          SizedBox(height: 16),
          InfoCard(
            title: "Como economizar energia com o ar-condicionado?",
            text:
                "• Mantenha os filtros sempre limpos.\n• Deixe portas e janelas fechadas.\n• Mantenha uma temperatura estável (entre 22ºC e 24ºC).",
          ),

          const SizedBox(height: 16),
          InfoCard(
            title: "Sinais de que seu ar precisa de manutenção",
            text:
                "• Ruídos ou vibrações estranhas.\n• O aparelho não gela como antes.\n• Vazamentos de água ou cheiro de mofo.",
          ),

          const SizedBox(height: 24),
          InfoCard(
            title: "Contato e Informações da Empresa",
            text:
                "• Ruídos ou vibrações estranhas.\n• O aparelho não gela como antes.\n• Vazamentos de água ou cheiro de mofo.",
          ),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.support_agent,
                // color: Colors.blue.shade800
                color: AppColors.primaryColor,
                // color: Color(0xFF343B6C),
              ),
              title: const Text(
                '',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LocalizacaoPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
