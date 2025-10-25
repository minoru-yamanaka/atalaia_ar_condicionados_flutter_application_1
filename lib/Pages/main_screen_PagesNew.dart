import 'package:flutter/material.dart';
import 'package:atalaia_ar_condicionados_flutter_application/Pages/calculadora_page.dart';
import 'package:atalaia_ar_condicionados_flutter_application/Pages/home_page.dart';
import 'package:atalaia_ar_condicionados_flutter_application/Pages/localizacao_page.dart';
import 'package:atalaia_ar_condicionados_flutter_application/Pages/info_page.dart';
import 'package:atalaia_ar_condicionados_flutter_application/Pages/agenda_page.dart';

class MainScreen2 extends StatefulWidget {
  const MainScreen2({super.key});

  @override
  State<MainScreen2> createState() => _MainScreenState2();
}

class _MainScreenState2 extends State<MainScreen2> {
  int _selectedIndex = 0;

  // Lista de telas que serão exibidas com base na navegação
  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    InfoPage(),
    const AgendaPage(),
    const CalculadoraPage(),
    const LocalizacaoPage(),
    // ExitPage(),
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
        // CORREÇÃO APLICADA AQUI
        type: BottomNavigationBarType.fixed,

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Início'),
          BottomNavigationBarItem(
            icon: Icon(Icons.build_circle),
            label: 'Informações',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Agenda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate_sharp),
            label: 'Calculadora',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Contato',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.exit_to_app),
          //   label: 'Sair',
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF343B6C),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}
