// import 'package:atalaia_ar_condicionados_flutter_application/PagesNew/main_screen_PagesNew.dart';
import 'package:atalaia_ar_condicionados_flutter_application/Pages/main_screen_PagesNew.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Cor principal baseada no seu design
    // const primaryColor = Color(0xFFF58524);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // --- LOGO ---
              // Substitua o Icon por sua imagem.
              // Lembre-se de adicionar a imagem na pasta 'assets' e no pubspec.yaml
              // Ex: Image.asset('assets/logo.png', height: 80)
              Image.asset('assets/img/logo.png', height: 80),
              const SizedBox(height: 16.0),
              // Icon(
              //   Icons.whatshot, // Ícone de exemplo
              //   size: 80,
              //   // arranquei o const primaryColor = Color(0xFFF58524);
              //   color: Color(0xFFF58524),
              // ),
              const SizedBox(height: 8),
              const Text(
                'DIEGO ÁQUILA teste 2 ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  // arranquei o const primaryColor = Color(0xFFF58524);
                  color: Color(0xFFF58524),
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 48.0),

              // --- TEXTO DE BOAS-VINDAS ---
              const Text(
                'Welcome!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24.0),

              // --- CAMPO DE EMAIL ---
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Color(0xFFF58524)),
                  ),
                ),
              ),
              const SizedBox(height: 12.0),

              // --- CAMPO DE SENHA ---
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      // arranquei o const primaryColor = Color(0xFFF58524);
                      color: Color(0xFFF58524),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),

              // --- ESQUECEU A SENHA ---
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Ação para "Esqueceu a senha?"
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),

              // --- BOTÃO DE LOGIN ---
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF58524),
                  // backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onPressed: () {
                  // Navega para a tela principal e remove a tela de login da pilha
                  Navigator.of(context).pushReplacement(
                    // MaterialPageRoute(builder: (context) => const MainScreen()),
                    MaterialPageRoute(
                      builder: (context) => const MainScreen2(),
                    ),
                  );
                },
                child: const Text(
                  'LOGIN',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
