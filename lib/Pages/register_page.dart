import 'package:atalaia_ar_condicionados_flutter_application/Pages/home_page.dart';
import 'package:atalaia_ar_condicionados_flutter_application/Pages/login_page.dart';
import 'package:atalaia_ar_condicionados_flutter_application/Pages/main_screen_PagesNew.dart';
import 'package:atalaia_ar_condicionados_flutter_application/model/usuario.dart';
import 'package:atalaia_ar_condicionados_flutter_application/service/firebase_service.dart';
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

<<<<<<< HEAD
  
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
=======
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmacaoController = TextEditingController();
>>>>>>> origin/minoru

  final FirebaseService _firebaseService = FirebaseService(
    collectionName: "usuarios",
  );

<<<<<<< HEAD
          // --- CAMPO DE EMAIL ---
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email -> Page de registro ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 55, 0, 255),

=======
  Future<void> salvarUsuario() async {
    Usuario usuario = Usuario(
      id: "",
      nome: nomeController.text,
      email: emailController.text,
      senha: senhaController.text,
    );

    try {
      String idUser = await _firebaseService.create(usuario.toMap());
      Navigator.of(context).pushReplacement(
        // MaterialPageRoute(builder: (context) => const MainScreen()),
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
      if (idUser.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Column(
              children: [
                Text(
                  "Sucesso",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
>>>>>>> origin/minoru
                  ),
                ),
                Text("Usuário cadastrado com sucesso"),
              ],
            ),
          ),
        );
      } else {
        SnackBar(
          backgroundColor: Colors.green,
          content: Column(
            children: [
              Text(
                "ERRO",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("Erro ao Cadastrar usuario"),
            ],
          ),
        );
      }
    } catch (erro) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
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
                    controller: nomeController,
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
                    controller: emailController,
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
                    controller: senhaController,
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
                    controller: confirmacaoController,
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
                      setState(() {
                        isCheckd = value!;
                      });
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
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onPressed: isCheckd
                        ? () {
                            salvarUsuario();
                          }
                        : null,
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
                        // Navega para a tela principal e remove a tela de login da pilha
                        Navigator.of(context).pushReplacement(
                          // MaterialPageRoute(builder: (context) => const MainScreen()),
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
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
                        // Ação para "Esqueceu a senha
                      },
                      child: const Text(
                        'Ou continue com',
                        style: TextStyle(color: Color.fromARGB(255, 6, 0, 90)),
                      ),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    FaIcon(
                      FontAwesomeIcons.google,
                      size: 30,
                      color: Colors.red,
                    ),
                    SizedBox(width: 10),
                    FaIcon(
                      FontAwesomeIcons.apple,
                      size: 30,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    FaIcon(
                      FontAwesomeIcons.facebook,
                      size: 30,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
