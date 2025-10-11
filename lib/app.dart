// -------------------------------------------------------------------------------------
// NOTA SOBRE A ESTRUTURA DO PROJETO:
// Você tem duas linhas de import para a LoginPage. A que está ativa determina qual
// "versão" do seu aplicativo será iniciada. Isso funciona, mas para gerenciar
// versões diferentes, a prática recomendada é usar "branches" do Git.
// -------------------------------------------------------------------------------------

// Esta linha está comentada, então o código dentro de 'Pages0/login_page.dart' não será usado.
// import 'package:atalaia_ar_condicionados_flutter_application/Pages0/login_page.dart';

// Esta é a linha que está ativa. O aplicativo vai carregar a LoginPage da pasta 'Pages'.
import 'package:atalaia_ar_condicionados_flutter_application/Pages/login_page.dart';

// Importa a biblioteca principal do Flutter, que contém os widgets e ferramentas essenciais.
import 'package:flutter/material.dart';

// 'MyApp' é o widget raiz (o componente principal) da sua aplicação.
// Ele é um StatelessWidget, o que significa que seu estado não muda após ser criado.
class MyApp extends StatelessWidget {
  // O construtor da classe. 'super.key' passa a chave para a classe pai (StatelessWidget).
  const MyApp({super.key});

  // O método 'build' é obrigatório. É ele que descreve como construir a interface do widget.
  // Ele é chamado pelo Flutter sempre que este widget precisa ser desenhado na tela.
  @override
  Widget build(BuildContext context) {
    // 'MaterialApp' é um widget fundamental que configura a aplicação para seguir
    // as diretrizes do Material Design (o estilo visual do Android).
    return MaterialApp(
      // O título da sua aplicação. Usado pelo sistema operacional (ex: na lista de apps recentes).
      title: 'Flutter Demo',

      // 'theme' define a aparência visual global do seu aplicativo (cores, fontes, etc.).
      theme: ThemeData(
        // 'colorScheme' é a forma moderna de definir o esquema de cores.
        // 'fromSeed' gera uma paleta de cores harmoniosa a partir de uma cor principal (seedColor).
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      // 'home' define qual será a primeira tela (página) a ser exibida quando o app iniciar.
      // Aqui, você está dizendo para o app começar com a 'LoginPage'.
      home: const LoginPage(),

      // Esta linha remove a faixa vermelha "Debug" que aparece no canto superior direito da tela.
      debugShowCheckedModeBanner: false,
    );
  }
}
