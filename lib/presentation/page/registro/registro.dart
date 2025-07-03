import 'package:cultritracker/domain/usuario.dart';
import 'package:cultritracker/domain/usuarios_registrados.dart';
import 'package:cultritracker/presentation/page/registro/formulario_registro.dart';
import 'package:flutter/material.dart';

// Widget principal
class MyRegistroPage extends StatefulWidget {
  const MyRegistroPage({super.key});

  @override
  State<MyRegistroPage> createState() => _MyRegistroPageState();
}

// Enum para el tipo de usuario
enum TipoUsuario { estudiante, docente }

class _MyRegistroPageState extends State<MyRegistroPage> {
  final _correoController = TextEditingController();
  final _contrasenaController = TextEditingController();

  void limpiarCampos() {
    _correoController.clear();
    _contrasenaController.clear();
  }

  void guardarFormulario() {
    UsuariosRegistrados.usuarios.add(
      Usuario(
        correo: _correoController.text.trim(),
        contrasena: _contrasenaController.text.trim(),
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
          child: Container(
            width: 320,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
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
                  'Registro',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PressStart2P',
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 20),
                FormularioRegistro(
                  correoController: _correoController,
                  contrasenaController: _contrasenaController,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        guardarFormulario();
                        limpiarCampos();
                      },
                      child: const Text(
                        'Guardar',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        limpiarCampos();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
