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
  const ChatbotWidget({super.key, required String text});

  @override
  State<ChatbotWidget> createState() => _ChatbotWidgetState();
  // Detecta se a mensagem contém o link do WhatsApp e cria um texto com link clicável
}

class _ChatbotWidgetState extends State<ChatbotWidget> {
  // final String _apiKey = dotenv.env['API_KEY_GPT']!;
  // API com chave trocar
  final String _apiKey =
      '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';
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;

  final Map<String, String> _respostasPredefinidas = {
    "olá":
        "Olá! Sou o assistente virtual da Atalaia Ar Condicionados. Como posso ajudar?",
    "oi":
        "Olá! Sou o assistente virtual da Atalaia Ar Condicionados. Como posso ajudar?",
    "bom dia":
        "Bom dia! Bem-vindo ao nosso assistente virtual. Em que posso ser útil?",
    "boa tarde":
        "Boa tarde! Bem-vindo ao nosso assistente virtual. Em que posso ser útil?",
    "boa noite":
        "Boa noite! Bem-vindo ao nosso assistente virtual. Em que posso ser útil?",
    "higienização":
        "A higienização completa remove ácaros e bactérias. Recomendamos fazer a cada 6 ou 12 meses. Gostaria de agendar?",
    "manutenção":
        "A manutenção preventiva aumenta a vida útil do seu aparelho. É ideal para garantir o bom funcionamento. Podemos agendar uma visita?",
    "instalação":
        "Realizamos a instalação de aparelhos de todas as marcas. Para um orçamento, preciso de mais detalhes.",
    "preço":
        "Nossos preços variam dependendo do serviço. Qual serviço te interessa?",
    "agendar":
        "Para agendar uma visita técnica, por favor, entre em contato pelo nosso WhatsApp.",
    "obrigado": "De nada! Se precisar de mais alguma coisa, é só perguntar.",

    "qual o horário de atendimento?":
        "Nosso horário de atendimento é de segunda a sexta, das 8h às 18h, e aos sábados das 8h às 12h.",
    "vocês atendem na minha região?":
        "Atendemos em toda a cidade. Para confirmar a disponibilidade em seu bairro, por favor, informe seu CEP.",
    "como agendar uma visita?":
        "Você pode agendar uma visita técnica diretamente pelo nosso WhatsApp. Um de nossos atendentes irá confirmar o melhor dia e horário para você.",
    "o que inclui a higienização?":
        "Nossa higienização completa inclui a limpeza de filtros, serpentina, turbina e bandeja com produtos bactericidas, garantindo a remoção de ácaros e fungos.",
    "qual a importância da manutenção preventiva?":
        "A manutenção preventiva garante a eficiência energética do seu aparelho, previne quebras inesperadas e aumenta a vida útil dos componentes.",
    "quanto custa para instalar um ar condicionado?":
        "O valor da instalação depende da capacidade (BTUs) do aparelho e da complexidade da infraestrutura. Para um orçamento preciso, precisamos de mais detalhes. Pode nos contatar via WhatsApp?",
    "quanto custa a higienização?":
        "O preço da higienização varia com a capacidade (BTUs) do aparelho. Qual é a potência do seu ar condicionado?",
    "formas de pagamento":
        "Aceitamos pagamento via Pix, dinheiro e cartões de débito e crédito.",
    "como economizar energia com o ar condicionado?":
        "Para economizar, mantenha portas e janelas fechadas, limpe os filtros regularmente e use a função 'timer' ou 'sleep' para desligar o aparelho durante a noite. Ajustar a temperatura para confortáveis 23°C também ajuda muito!",
    "qual a temperatura ideal?":
        "A temperatura ideal para conforto térmico e economia de energia, recomendada pela ANVISA, é de 23°C a 26°C. Temperaturas muito baixas forçam o motor e gastam mais luz.",
    "posso manter o ar ligado o dia todo?":
        "Sim, mas não é o mais eficiente. Se precisar, use o modo 'auto' para que o aparelho ajuste a intensidade conforme a necessidade, economizando energia.",
    "limpar o filtro melhora o funcionamento?":
        "Sim! Filtros sujos bloqueiam a passagem de ar, forçando o aparelho a trabalhar mais e gastando mais energia. Recomendamos a limpeza dos filtros a cada 15 ou 30 dias.",
    "o que significa BTU?":
        "BTU é a sigla para 'Unidade Térmica Britânica'. É a medida que define a capacidade de refrigeração do ar condicionado. Quanto maior o ambiente, mais BTUs são necessários.",
    "qual a diferença entre ar inverter e convencional?":
        "O ar 'Inverter' é mais moderno e econômico. Ele ajusta a velocidade do compressor para manter a temperatura constante sem picos de energia. O convencional liga e desliga o compressor, o que gasta mais energia.",
    "o ar condicionado renova o ar do ambiente?":
        "Não, a maioria dos modelos 'split' não renova o ar. Eles apenas recirculam e resfriam o ar que já está no ambiente. Por isso, é importante arejar o local de vez em quando.",
    "tchau":
        "Até logo! Se precisar de algo mais, a Atalaia Ar Condicionados está à sua disposição.",
    "meu ar condicionado está pingando":
        "Um vazamento de água pode ser causado por sujeira no dreno ou falta de gás. Nossos técnicos podem resolver isso. Deseja agendar uma visita para diagnóstico?",
    "meu ar não está gelando":
        "A falta de refrigeração pode indicar necessidade de limpeza ou falta de gás. É importante uma avaliação técnica para identificar a causa exata. Podemos agendar?",
    "meu ar condicionado está com cheiro ruim":
        "O mau cheiro geralmente é causado por mofo e bactérias nos componentes internos. Nossa higienização completa elimina o odor e protege sua saúde. Gostaria de agendar?",
    "meu ar está fazendo barulho":
        "Ruídos anormais podem indicar peças soltas ou problemas no motor. Recomendamos desligar o aparelho e agendar uma visita técnica para evitar danos maiores.",

    "o que é 'BTU' e como sei qual preciso?":
        "BTU é a unidade que mede a capacidade de refrigeração. A quantidade de BTUs necessária depende do tamanho do ambiente, da incidência de sol e do número de pessoas e eletrônicos no local.",
    "qual a temperatura ideal para economizar energia?":
        "A temperatura de conforto recomendada é de 23°C. Manter o ar em temperaturas muito baixas (como 17°C) força o compressor e aumenta significativamente o consumo de energia.",
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _messages.add(
            ChatMessage(
              text:
                  "Olá! Sou seu assistente virtual de climatização. Pergunte-me sobre nossos serviços ou entre em contato conosco pelo WhatsApp clicando aqui: https://wa.me/5511959473402",
              isUserMessage: false,
            ),
          );
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
        _messages.add(
          ChatMessage(text: predefinedAnswer!, isUserMessage: false),
        );
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
          _messages.add(
            ChatMessage(
              text:
                  "Desculpe, estou com dificuldades na minha conexão. Tente novamente mais tarde.",
              isUserMessage: false,
            ),
          );
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
    final headers = {
      "Authorization": "Bearer $_apiKey",
      "Content-Type": "application/json",
    };
    final body = jsonEncode({
      "model": "deepseek/deepseek-v3-base:free",
      "messages": [
        {
          "role": "system",
          "content":
              "Você é um assistente virtual de uma empresa de ar condicionado chamada Atalaia. Seja prestativo e foque em responder sobre serviços como instalação, manutenção, higienização e orçamentos.",
        },
        {"role": "user", "content": question},
      ],
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
    // Este widget retorna apenas a Coluna com o chat, sem Scaffold ou AppBar
    return Column(
      children: [
        // Adicionando um cabeçalho para o BottomSheet
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Assistente Virtual",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(8.0),
            itemCount: _messages.length,
            itemBuilder: (context, index) =>
                _buildMessageBubble(_messages[index]),
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
      alignment: message.isUserMessage
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: message.isUserMessage
              // ? Colors.blue.shade600
              // : Colors.grey.shade200,
              ? const Color(0xFF0C1D34)
              : Colors.grey.shade200,
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
      padding: const EdgeInsets.all(
        8.0,
      ).copyWith(bottom: MediaQuery.of(context).padding.bottom + 8),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Digite sua mensagem...",
                border: InputBorder.none,
                filled: true,
                fillColor: Color(0xFFF0F0F0),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
              ),
              onSubmitted: (_) => _handleSendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            // icon: const Icon(Icons.send, color: Colors.blue),
            icon: const Icon(Icons.send, color: Color(0xFF0C1D34)),
            onPressed: _handleSendMessage,
          ),
        ],
      ),
    );
  }
}
