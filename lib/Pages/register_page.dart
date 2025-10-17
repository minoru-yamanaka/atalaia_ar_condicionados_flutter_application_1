import 'package:atalaia_ar_condicionados_flutter_application/Pages/main_screen_PagesNew.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Variável para controlar a visibilidade da senha
  final bool _isPasswordVisible = false;
  bool isCheckd = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadiusGeometry.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: Image.asset('assets/img/Atalaiabanner.png'),
          ),

          const SizedBox(height: 50.0),

          // --- CAMPO DE EMAIL ---
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 55, 0, 255),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12.0),

          // --- CAMPO DE SENHA ---
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Endereço de Email',
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
          ),
          const SizedBox(height: 12.0),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 55, 0, 255),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12.0),

          // --- CAMPO DE SENHA ---
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
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
          ),

          // --- ESQUECEU A SENHA ---
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: CheckboxListTile(
              title: Text("Aceito os termos"),
              value: isCheckd,
              onChanged: (bool? value) {
                isCheckd = true;
              },
            ),
          ),

          const SizedBox(height: 24.0),

          // --- BOTÃO DE LOGIN ---
          SizedBox(
            width: 360,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 14, 2, 82),
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
                  MaterialPageRoute(builder: (context) => const MainScreen2()),
                );
              },
              child: const Text(
                'REGISTRAR',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  print("registar uruario");
                },
                child: const Text(
                  'Já tem uma conta? Entrar',
                  style: TextStyle(color: Color.fromARGB(255, 6, 0, 90)),
                ),
              ),
            ),
          ),
          SizedBox(height: 50),

          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  // Ação para "Esqueceu a senha?"
                },
                child: const Text(
                  'Ou continue com',
                  style: TextStyle(color: Color.fromARGB(255, 6, 0, 90)),
                ),
              ),
            ),
          ),

          Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              FaIcon(FontAwesomeIcons.google, size: 30, color: Colors.red),
              SizedBox(width: 10),
              FaIcon(FontAwesomeIcons.apple, size: 30, color: Colors.black),
              SizedBox(width: 10),
              FaIcon(FontAwesomeIcons.facebook, size: 30, color: Colors.blue),
            ],
          ),
        ],
      ),
    );
  }
}
