// pagina de bienvenida
import 'package:cultritracker/presentation/iniciar_sesion.dart';
import 'package:cultritracker/presentation/page/registro/registro.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
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
  void nuevoFormulario() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => MyRegistroPage()),
    );
  }

  void validarUsuario() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => MyIniciarSesionPage(),
      ),
    );
  }

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
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'CULTITRAKER',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PressStart2P',
                          color: Colors.indigo,
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
                      SizedBox(height: 8),
                      Text(
                        'Gestiona tus riegos y cultivos',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 320,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [botones()],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget botones() {
    return Column(
      children: <Widget>[
        SizedBox(
          width: 300,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            onPressed: () {
              validarUsuario();
            },
            child: Text(
              'Iniciar Sesion',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 300,
          child: ElevatedButton(
            onPressed: () {
              nuevoFormulario();
            },
            child: Text(
              'Registrarse',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void metodo() {
    nuevoFormulario();
  }
}
