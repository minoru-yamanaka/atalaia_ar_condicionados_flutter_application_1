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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFF58524), // Cor do ícone ativo
        onTap: _onItemTapped,
      ),
    );
  }
}