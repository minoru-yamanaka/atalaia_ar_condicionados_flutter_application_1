import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Modelo de Dados para cada Mensagem
class ChatMessage {
  final String text;
  final bool isUserMessage;

  ChatMessage({required this.text, required this.isUserMessage});
}

class ChatbotWidget extends StatefulWidget {
  const ChatbotWidget({super.key, required String text});

  @override
  State<ChatbotWidget> createState() => _ChatbotWidgetState();
}

class _ChatbotWidgetState extends State<ChatbotWidget> {
  final String _apiKey = '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';
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;

  // Seus dados originais
  final Map<String, String> _respostasPredefinidas = {
    "higienização": "A higienização completa remove ácaros e bactérias. Recomendamos fazer a cada 6 ou 12 meses.",
    "manutenção": "A manutenção preventiva aumenta a vida útil do seu aparelho. É ideal para garantir o bom funcionamento. ",
    "instalação": "Realizamos a instalação de aparelhos de todas as marcas. Para um orçamento, preciso de mais detalhes.",
    "preço": "Nossos preços variam dependendo do serviço.",
    "agendar": "Para agendar uma visita técnica, por favor, entre em contato pelo nosso WhatsApp.",
    "horário de atendimento": "Nosso horário de atendimento é de segunda a sexta, das 8h às 18h, e aos sábados das 8h às 12h.",
    "formas de pagamento": "Aceitamos pagamento via Pix, dinheiro e cartões de débito e crédito.",
    "não está gelando": "A falta de refrigeração pode indicar necessidade de limpeza ou falta de gás. É importante uma avaliação técnica.",
    "pingando": "Um vazamento de água pode ser causado por sujeira no dreno ou falta de gás.",
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _messages.add(
            ChatMessage(
              text: "Olá! Bem-vindo à Atalaia Ar Condicionados. ❄️\n\n"
                    "Digite o número da opção desejada:\n\n"
                    "1. Higienização\n"
                    "2. Manutenção\n"
                    "3. Instalação\n"
                    "4. Preços\n"
                    "5. Agendar Visita\n"
                    "6. Horário de Atendimento\n"
                    "7. Formas de Pagamento\n"
                    "8. Problemas (Não gela / Pingando)",
              isUserMessage: false,
            ),
          );
        });
      }
    });
  }

  // MÉTODO PRINCIPAL DE ENVIO (Lógica estilo WhatsApp)
  void _handleSendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _isLoading) return;

    _controller.clear();

    setState(() {
      _messages.add(ChatMessage(text: text, isUserMessage: true));
      _isLoading = true;
    });
    _scrollToBottom();

    await Future.delayed(const Duration(milliseconds: 600));

    String? responseText;

    // 1. MAPEAMENTO DO MENU (Onde a mágica acontece)
    final Map<String, String> menuNumerico = {
      "1": "higienização",
      "2": "manutenção",
      "3": "instalação",
      "4": "preço",
      "5": "agendar",
      "6": "horário de atendimento",
      "7": "formas de pagamento",
      "8": "não está gelando",
    };

    // 2. VERIFICA SE É UM NÚMERO DO MENU
    if (menuNumerico.containsKey(text)) {
      String chaveEncontrada = menuNumerico[text]!;
      responseText = _respostasPredefinidas[chaveEncontrada];
    }

    // 3. SE NÃO FOR NÚMERO, BUSCA POR PALAVRA-CHAVE
    if (responseText == null) {
      for (var key in _respostasPredefinidas.keys) {
        if (text.toLowerCase().contains(key.toLowerCase())) {
          responseText = _respostasPredefinidas[key];
          break;
        }
      }
    }

    // 4. MOSTRA RESPOSTA OU CHAMA IA
    if (responseText != null) {
      setState(() {
        _messages.add(ChatMessage(text: responseText!, isUserMessage: false));
        _isLoading = false;
      });
    } else {
      try {
        final response = await _getApiResponse(text);
        setState(() {
          _messages.add(ChatMessage(text: response, isUserMessage: false));
        });
      } catch (e) {
        setState(() {
          _messages.add(ChatMessage(
            text: "Desculpe, não entendi. Digite um número de 1 a 8 ou descreva sua dúvida no nosso contato do WhatsApp, seria um prazer ajudar atender pelo número 5511948887050.",
            isUserMessage: false,
          ));
        });
      } finally {
        setState(() => _isLoading = false);
      }
    }
    _scrollToBottom();
  }

  Future<String> _getApiResponse(String question) async {
    final url = Uri.parse("https://openrouter.ai/api/v1/chat/completions");
    final headers = {
      "Authorization": "Bearer $_apiKey",
      "Content-Type": "application/json",
    };
    final body = jsonEncode({
      "model": "deepseek/deepseek-v3-base:free",
      "messages": [
        {
          "role": "system",
          "content": "Você é o assistente da Atalaia Ar Condicionado. Seja breve e educado."
        },
        {"role": "user", "content": question},
      ],
    });
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception('Erro na API');
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Assistente Virtual",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0E0252),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(8.0),
            itemCount: _messages.length,
            itemBuilder: (context, index) => _buildMessageBubble(_messages[index]),
          ),
        ),
        if (_isLoading)
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
        _buildInputArea(),
      ],
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment: message.isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: message.isUserMessage ? const Color(0xFF0C1D34) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: message.isUserMessage ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(8.0).copyWith(bottom: MediaQuery.of(context).padding.bottom + 8),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Digite um número ou mensagem...",
                filled: true,
                fillColor: const Color(0xFFF0F0F0),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(color: Color(0xFF343B6C))),
              ),
              onSubmitted: (_) => _handleSendMessage(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Color(0xFF0C1D34)),
            onPressed: _handleSendMessage,
          ),
        ],
      ),
    );
  }
}