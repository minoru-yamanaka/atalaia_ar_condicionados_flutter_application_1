import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Modelo de Dados para cada Mensagem
class ChatMessage {
  final String text;
  final bool isUserMessage;

  ChatMessage({required this.text, required this.isUserMessage});
}

// O Widget do Chatbot
class ChatbotWidget extends StatefulWidget {
  const ChatbotWidget({super.key});

  @override
  State<ChatbotWidget> createState() => _ChatbotWidgetState();
}

class _ChatbotWidgetState extends State<ChatbotWidget> {
  final String _apiKey = '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';
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;

  final Map<String, String> _respostasPredefinidas = {
    "olá": "Olá! Sou o assistente virtual da Atalaia Ar Condicionados. Como posso ajudar?",
    "oi": "Olá! Sou o assistente virtual da Atalaia Ar Condicionados. Como posso ajudar?",
    "bom dia": "Bom dia! Bem-vindo ao nosso assistente virtual. Em que posso ser útil?",
    "boa tarde": "Boa tarde! Bem-vindo ao nosso assistente virtual. Em que posso ser útil?",
    "boa noite": "Boa noite! Bem-vindo ao nosso assistente virtual. Em que posso ser útil?",
    "higienização": "A higienização completa remove ácaros e bactérias. Recomendamos fazer a cada 6 ou 12 meses. Gostaria de agendar?",
    "manutenção": "A manutenção preventiva aumenta a vida útil do seu aparelho. É ideal para garantir o bom funcionamento. Podemos agendar uma visita?",
    "instalação": "Realizamos a instalação de aparelhos de todas as marcas. Para um orçamento, preciso de mais detalhes.",
    "preço": "Nossos preços variam dependendo do serviço. Qual serviço te interessa?",
    "agendar": "Para agendar uma visita técnica, por favor, entre em contato pelo nosso WhatsApp.",
    "obrigado": "De nada! Se precisar de mais alguma coisa, é só perguntar.",
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _messages.add(ChatMessage(
            text: "Olá! Sou seu assistente virtual de climatização. Pergunte-me sobre nossos serviços!",
            isUserMessage: false, 
          ));
        });
      }
    });
  }

  void _handleSendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _isLoading) return;

    _controller.clear();

    setState(() {
      _messages.add(ChatMessage(text: text, isUserMessage: true));
      _isLoading = true;
    });
    _scrollToBottom();

    await Future.delayed(const Duration(milliseconds: 500));

    String? predefinedAnswer;
    for (var key in _respostasPredefinidas.keys) {
      if (text.toLowerCase().contains(key)) {
        predefinedAnswer = _respostasPredefinidas[key];
        break;
      }
    }

    if (predefinedAnswer != null) {
      setState(() {
        _messages.add(ChatMessage(text: predefinedAnswer!, isUserMessage: false));
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
            text: "Desculpe, estou com dificuldades na minha conexão. Tente novamente mais tarde.",
            isUserMessage: false,
          ));
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
    _scrollToBottom();
  }
  
  Future<String> _getApiResponse(String question) async {
    final url = Uri.parse("https://openrouter.ai/api/v1/chat/completions");
    final headers = {"Authorization": "Bearer $_apiKey", "Content-Type": "application/json"};
    final body = jsonEncode({
      "model": "deepseek/deepseek-v3-base:free",
      "messages": [
        {"role": "system", "content": "Você é um assistente virtual de uma empresa de ar condicionado chamada Atalaia. Seja prestativo e foque em responder sobre serviços como instalação, manutenção, higienização e orçamentos."},
        {"role": "user", "content": question}
      ]
    });
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception('Failed to load response from API');
    }
  }
  
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Este widget retorna apenas a Coluna com o chat, sem Scaffold ou AppBar
    return Column(
      children: [
        // Adicionando um cabeçalho para o BottomSheet
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text("Assistente Virtual", style: Theme.of(context).textTheme.titleLarge),
        ),
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(8.0),
            itemCount: _messages.length,
            itemBuilder: (context, index) => _buildMessageBubble(_messages[index]),
          ),
        ),
        if (_isLoading) const Padding(padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
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
          color: message.isUserMessage ? Colors.blue.shade600 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(message.text, style: TextStyle(color: message.isUserMessage ? Colors.white : Colors.black87)),
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
              decoration: const InputDecoration(
                hintText: "Digite sua mensagem...",
                border: InputBorder.none, filled: true, fillColor: Color(0xFFF0F0F0),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              onSubmitted: (_) => _handleSendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(icon: const Icon(Icons.send, color: Colors.blue), onPressed: _handleSendMessage),
        ],
      ),
    );
  }
}