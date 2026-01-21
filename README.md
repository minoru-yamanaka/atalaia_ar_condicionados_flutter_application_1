# Atalaia Ar Condicionados - Aplicativo Flutter

Aplicativo móvel desenvolvido em Flutter para gestão de serviços de climatização, incluindo agendamentos, calculadora de BTUs, chatbot assistente e informações sobre manutenção de ar condicionado.

## 📱 Funcionalidades

### 🏠 Página Inicial (Home)
- Apresentação dos serviços disponíveis
- Cards informativos sobre:
  - Higienização Completa
  - Manutenção Preventiva
  - Instalação Profissional
  - Projeto e Infraestrutura
  - Outros Serviços
- Integração direta com WhatsApp para contratação

### 📅 Agendamentos
- Criação de novos agendamentos via formulário
- Campos: Nome do Cliente, Data, Serviço, Notas/Detalhes
- Histórico completo de agendamentos
- Sistema de busca por nome, serviço, data ou notas
- Envio automático de solicitação via WhatsApp
- Persistência local usando SharedPreferences

### 🧮 Calculadora de BTUs
- Cálculo personalizado de potência ideal para ar condicionado
- Parâmetros considerados:
  - Área do ambiente (m²)
  - Número de pessoas
  - Quantidade de eletrônicos
  - Quantidade de janelas
  - Incidência solar
- Botão direto para solicitar orçamento via WhatsApp

### 💬 Chatbot Assistente
- Assistente virtual inteligente
- Respostas predefinidas para perguntas frequentes
- Integração com API OpenRouter (modelo DeepSeek)
- Interface em Modal Bottom Sheet
- Tópicos abordados:
  - Serviços disponíveis
  - Dicas de economia de energia
  - Manutenção preventiva
  - Temperatura ideal
  - Diferenças entre modelos
  - Solução de problemas comuns

### ℹ️ Informações e Dicas
- Cards informativos sobre:
  - Periodicidade de higienização
  - Economia de energia
  - Sinais de necessidade de manutenção
- Acesso rápido ao chatbot assistente
- Link para página de contato

### 📍 Localização e Contato
- Informações da empresa (endereço, telefone, email)
- Links interativos:
  - Click-to-call (telefone)
  - Click-to-email
  - Integração com Google Maps
- Opção de logout

### 🔐 Sistema de Login/Registro
- Tela de login com validação
- Registro de novos usuários
- Opções de login social (Google, Apple, Facebook)
- Visualização/ocultação de senha

## 🎨 Design e UX

### Cores Principais
- **Primary Color**: `#0D47A1` (Azul profissional)
- **Selected Item**: `#343B6C` (Azul sóbrio)
- **Background**: `#F5F5F5` (Cinza claro)
- **AppBar**: Branco

### Tipografia
- **Título AppBar**: 32px, Bold, Letter Spacing -1
- **Subtítulos**: 18px, Medium, Blueish Grey
- **Conteúdo**: 16px, Regular, Black87

### Componentes
- Cards com elevação e bordas arredondadas
- Bottom Navigation Bar com 5 seções
- Formulários com validação
- Modal Bottom Sheets para chatbot
- Listas com scroll infinito

## 🛠️ Tecnologias e Dependências

### Principais Pacotes
```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: # Armazenamento local
  url_launcher: # Abertura de links externos
  intl: # Formatação de datas
  http: # Requisições HTTP
  font_awesome_flutter: # Ícones sociais
```

### Estrutura de Pastas
```
lib/
├── Config/
│   ├── app_colors.dart
│   ├── app_text_style.dart
│   └── app_texts.dart
├── Pages/
│   ├── home_page.dart
│   ├── agenda_page.dart
│   ├── calculadora_page.dart
│   ├── info_page.dart
│   ├── localizacao_page.dart
│   ├── chatbot_widget.dart
│   ├── login_page.dart
│   ├── register_page.dart
│   └── main_screen_PagesNew.dart
├── Widgets/
│   ├── product_card.dart
│   ├── service_card.dart
│   └── info_card.dart
├── app.dart
└── main.dart
```

## 🚀 Como Executar

### Pré-requisitos
- Flutter SDK (versão 3.0 ou superior)
- Dart SDK
- Android Studio ou VS Code
- Emulador Android/iOS ou dispositivo físico

### Instalação
1. Clone o repositório:
```bash
git clone https://github.com/seu-usuario/atalaia-ar-condicionados.git
```

2. Navegue até a pasta do projeto:
```bash
cd atalaia-ar-condicionados
```

3. Instale as dependências:
```bash
flutter pub get
```

4. Execute o aplicativo:
```bash
flutter run
```

## ⚙️ Configurações Necessárias

### WhatsApp Integration
Atualize o número de telefone em:
- `lib/Pages/agenda_page.dart` (linha 147)
- `lib/Pages/calculadora_page.dart` (linha 53)
- `lib/Widgets/product_card.dart` (linha 59)

```dart
final phoneNumber = '5511959473402'; // Substitua pelo seu número
```

### API Chatbot
Configure sua chave da API OpenRouter em:
- `lib/Pages/chatbot_widget.dart` (linha 24)

```dart
final String _apiKey = 'sua-chave-api-aqui';
```

### Android Manifest
Para integração com WhatsApp, adicione em `android/app/src/main/AndroidManifest.xml`:

```xml
<queries>
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="https" />
    </intent>
    <intent>
        <action android:name="android.intent.action.VIEW" />
        <data android:scheme="whatsapp" />
    </intent>
</queries>
```

## 📊 Funcionalidades de Dados

### Persistência Local
- Agendamentos salvos com SharedPreferences
- Serialização/Deserialização JSON
- Sincronização automática

### Modelo de Dados - Appointment
```dart
class Appointment {
  final String id;
  final String customerName;
  final String service;
  final DateTime date;
  final String notes;
}
```

## 🔍 Busca e Filtros
- Busca em tempo real
- Filtros por múltiplos campos
- Ordenação por data (mais recentes primeiro)

## 📱 Compatibilidade
- Android 5.0 (API 21) ou superior
- iOS 11.0 ou superior

## 🤝 Contribuindo
Contribuições são bem-vindas! Por favor:
1. Faça um Fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📝 Licença
Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

## 👥 Autores e perfils
- [MINORU YAMANAKA](https://github.com/minoru-yamanaka)
- [MARCOS SILVA](https://github.com/Marvin-marcos)
- [GUSTAVO BARROS](https://github.com/guhbarros99)
- [RENATO NAVARRO](https://github.com/RenatoNMG)


## 🎯 Roadmap
- [ ] Implementar autenticação real (Firebase)
- [ ] Adicionar notificações push
- [ ] Sistema de avaliações e feedback
- [ ] Histórico de serviços realizados
- [ ] Integração com calendário do dispositivo
- [ ] Modo offline completo
- [ ] Temas claro/escuro


