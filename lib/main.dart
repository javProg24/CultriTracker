// pagina de bienvenida
import 'package:flutter/material.dart';

void main() {
  runApp(const MainAppCul());
}

class MainAppCul extends StatelessWidget {
  const MainAppCul({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const MyBievenidaPage());
  }
}

class MyBievenidaPage extends StatefulWidget {
  const MyBievenidaPage({super.key});
  @override
  State<StatefulWidget> createState() => _MyBievenidaPage();
}

class _MyBievenidaPage extends State<MyBievenidaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fondo.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: const Text(
                    'TE DAMOS LA BIENVENIDA A CULTITRAKER',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PressStart2P',
                      color: Colors.indigoAccent,
                      letterSpacing: 2,
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          offset: Offset(2, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: const Text(
                    'Gestiona tus riegos y cultivos',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontFamily: 'Roboto2',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
