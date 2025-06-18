// login
import 'package:flutter/material.dart';

class MyIniciarSesionPage extends StatefulWidget {
  const MyIniciarSesionPage({super.key});
  @override
  State<StatefulWidget> createState() => _MyIniciarSesionPage();
}

class _MyIniciarSesionPage extends State<MyIniciarSesionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fondo.png'), // Fondo de pantalla
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // LOGO O TEXTO SUPERIOR
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: const Text(
                    'CULTITRAKER',
                    style: TextStyle(
                      fontSize: 25,
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
                ),

                Container(
                  width: 320,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade300, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(2, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Inicio Sesion',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 20),
                      elementosIngreso(),
                      const SizedBox(height: 20),
                      botones(),
                      const SizedBox(height: 10),
                      Row(
                        children: const [
                          Checkbox(value: false, onChanged: null),
                          Text('Recordar contraseña'),
                        ],
                      ),
                    ],
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
            onPressed: () {},
            child: Text('Iniciar Sesion'),
          ),
        ),
      ],
    );
  }

  Widget elementosIngreso() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Correo',
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Contraseña',
          ),
        ),
      ],
    );
  }
}
