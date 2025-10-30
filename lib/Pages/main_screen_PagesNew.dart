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
  int _selectedIndex = 3;

  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    InfoPage(),
    AgendaPage(),
    CalculadoraPage(),
    LocalizacaoPage(),
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

      // --- MUDANÇA APLICADA AQUI ---
      // Para arredondar os cantos, envolvemos a BottomNavigationBar
      // em um widget "ClipRRect" e definimos o borderRadius.
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24.0), // <- Raio do canto esquerdo
          topRight: Radius.circular(24.0), // <- Raio do canto direito
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF0C1D34),
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
              icon: Icon(Icons.calculate),
              label: 'Calculadora',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: 'Contato',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.6),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: _onItemTapped,
        ),
      ),
      // --- FIM DA MUDANÇA ---
    );
  }
}

// badge -> criar uma notificação na navbar
// add um container escolher um shappe
// ver d eonde puxaer as notificações
