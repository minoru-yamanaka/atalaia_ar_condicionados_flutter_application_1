import 'package:atalaia_ar_condicionados_flutter_application/Pages/page00.dart';
import 'package:flutter/material.dart';
import 'projects_page.dart';
import 'profile_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Índice da tela atual (0 = Home, 1 = Perfil, etc.)

  // Lista de telas que serão exibidas
  static const List<Widget> _widgetOptions = <Widget>[
    ProjectsPage(),
    ProfilePage(),
    Page00(),
    Text('Messages Page'), // Tela de Mensagens (placeholder)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Home'),

          BottomNavigationBarItem(
            icon: Icon(Icons.contact_emergency_rounded),
            label: 'Profile',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.calculate_sharp),
            label: 'Calculadora',
          ),

          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Informações'),

          //   BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Informações'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor:
            // selectedItemColor
            const Color(0xFF343B6C),
        // const Color(0xFFF58524), // Cor do ícone ativo
        // ADICIONADO: Define uma cor para os ícones inativos para que fiquem visíveis.
        unselectedItemColor: Colors.grey,

        // OPCIONAL: Adicione uma cor de fundo explícita para a barra, se desejar.
        // backgroundColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
