import 'package:cultritracker/iniciarsesion.dart';
import 'package:flutter/material.dart';

class MyPrincipalPage extends StatefulWidget {
  const MyPrincipalPage({super.key});
  @override
  State<StatefulWidget> createState() => _MyPrincipalPage();
}

class _MyPrincipalPage extends State<MyPrincipalPage> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });

          if (index == 3) {
            // Ir a MyMainPage
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MyIniciarSesionPage(),
              ),
            );
          }
        },
        indicatorColor: Colors.grey,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home), label: 'Inicio'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Perfil'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Ajustes'),
          NavigationDestination(
            icon: Icon(Icons.arrow_back),
            label: 'Regresar',
          ),
        ],
      ),
    );
  }
}
