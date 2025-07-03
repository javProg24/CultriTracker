import 'package:cultritracker/presentation/principal.dart';
import 'package:flutter/material.dart';

class MyIniciarSesionPage extends StatefulWidget {
  const MyIniciarSesionPage({super.key});
  @override
  State<StatefulWidget> createState() => _MyIniciarSesionPage();
}

class _MyIniciarSesionPage extends State<MyIniciarSesionPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();

  void _mostrarError(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/fondo.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Iniciar Sesion',
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget botones() {
    return Column(
      children: <Widget>[
        SizedBox(
          width: 300,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                bool existe = true;
                if (existe) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => MyPrincipalPage(),
                    ),
                  );
                } else {
                  _mostrarError('Usuario o contraseña incorrectos');
                }
              }
            },
            child: const Text(
              'Iniciar Sesión',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget elementosIngreso() {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: _correoController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Correo',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Ingrese su correo';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)) {
              return 'Correo no válido';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: _contrasenaController,
          obscureText: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Contraseña',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Ingrese su contraseña';
            }
            if (value.length < 4) {
              return 'Debe tener al menos 4 caracteres';
            }
            return null;
          },
        ),
      ],
    );
  }
}
