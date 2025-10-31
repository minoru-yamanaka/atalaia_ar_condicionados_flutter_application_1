//import 'package:atalaia_ar_condicionados_flutter_application/Pages/main_screen_PagesNew.dart';
import 'package:atalaia_ar_condicionados_flutter_application/Pages/main_screen_PagesNew.dart';
import 'package:atalaia_ar_condicionados_flutter_application/Pages/register_page.dart';
import 'package:atalaia_ar_condicionados_flutter_application/service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // CORREÇÃO: Adicionados controllers para gerenciar o texto dos campos.
  // Isso é essencial para ler os valores de email e senha.

  final FirebaseService _firebaseService = FirebaseService(
    collectionName: "usuarios",
  );

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  realizarLogin() async {
    final email = _emailController.text.trim();
    final senha = _passwordController.text.trim();

    if (email.isEmpty || senha.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Preencha todos os campos')));
      return;
    }

    try {
      final usuario = await _firebaseService.getByEmail(email);

      if (usuario == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Conta não encontrado')));
        return;
      }

      if (usuario['senha'] == senha) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainScreen2()),
        );
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
                  ),
                ),
                Text("Usuário Logado com sucesso"),
              ],
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Senha incorreta')));
      }
    } catch (erro) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao fazer login: $erro')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Image.asset('assets/img/Atalaiabanner.png'),
            ),
            const SizedBox(height: 50.0),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _emailController, // Adicionado controller
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _passwordController, // Adicionado controller
                // CORREÇÃO: A visibilidade agora depende da variável de estado.
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  // CORREÇÃO: Adicionado ícone para mostrar/ocultar a senha.
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      // CORREÇÃO: setState atualiza a UI quando o estado muda.
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(color: Color(0xFFF58524)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8.0),

            // --- ESQUECEU A SENHA ---
            // (Você pode adicionar um TextButton aqui se precisar)

            // --- BOTÃO LOGIN ---
            // CORREÇÃO: Ajustada a estrutura para o botão expandir
            Padding(
              // 1. Usamos o mesmo padding dos campos de texto
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                // 2. Forçamos o SizedBox a ocupar toda a largura disponível
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                      255,
                      14,
                      2,
                      82,
                    ), // cor de fundo azul
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ), // cantos arredondados
                    ),
                  ),
                  onPressed: () {
                    realizarLogin();
                  },
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white, // texto branco pra contrastar
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8.0),

            // --- BOTÃO DE REGISTRO ---
            TextButton(
              onPressed: () {
                // CORREÇÃO: Adicionada a navegação para a página de registro.
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
              child: const Text(
                'Registre-se agora',
                style: TextStyle(color: Color.fromARGB(255, 6, 0, 90)),
              ),
            ),

            const SizedBox(height: 20),
            const SizedBox(width: 300, child: Divider()),
            const SizedBox(height: 20),

            // CORREÇÃO: Trocado TextButton por um simples Text, pois não tinha ação.
            const Text(
              'Ou continue com',
              style: TextStyle(color: Color.fromARGB(255, 6, 0, 90)),
            ),
            const SizedBox(height: 10),

            // --- ÍCONES SOCIAIS ---
            Row(
              // CORREÇÃO: Removida a propriedade 'spacing', que não existe em Row.
              // O espaçamento já é feito com os SizedBox.
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                FaIcon(FontAwesomeIcons.google, size: 30, color: Colors.red),
                SizedBox(width: 20),
                FaIcon(FontAwesomeIcons.apple, size: 30, color: Colors.black),
                SizedBox(width: 20),
                FaIcon(FontAwesomeIcons.facebook, size: 30, color: Colors.blue),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
