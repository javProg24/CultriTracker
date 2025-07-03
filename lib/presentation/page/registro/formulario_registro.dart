import 'package:flutter/material.dart';

class FormularioRegistro extends StatelessWidget {
  final TextEditingController correoController;
  final TextEditingController contrasenaController;

  const FormularioRegistro({
    super.key,
    required this.correoController,
    required this.contrasenaController,
  });

  InputDecoration buildDecoration(String label) =>
      InputDecoration(border: const OutlineInputBorder(), labelText: label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        TextField(
          controller: correoController,
          keyboardType: TextInputType.emailAddress,
          decoration: buildDecoration('Correo'),
        ),
        const SizedBox(height: 15),
        TextField(
          controller: contrasenaController,
          obscureText: true,
          decoration: buildDecoration('Contraseña'),
        ),
      ],
    );
  }
}
