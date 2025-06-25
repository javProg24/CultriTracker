import 'package:cultritracker/main.dart';
import 'package:flutter/material.dart';

class UsuariosRegistrados {
  static final List<Map<String, String>> usuarios = [];
}

class MyRegistroPage extends StatefulWidget {
  const MyRegistroPage({super.key});
  @override
  State<StatefulWidget> createState() => _MyRegistroPage();
}

enum TipoUsuario { estudiante, docente }

class _MyRegistroPage extends State<MyRegistroPage> {
  final TextEditingController cedulaController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();
  final myControllerFecha = TextEditingController();

  String? itemSeleccionado;
  DateTime? fechaSeleccionada;
  TipoUsuario? _tipoUsuario = TipoUsuario.estudiante;

  Future<void> _seleccionarFecha() async {
    final DateTime? pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    setState(() {
      fechaSeleccionada = pickerDate;
      myControllerFecha.value = TextEditingValue(
        text: fechaSeleccionada != null
            ? '${fechaSeleccionada!.day}/${fechaSeleccionada!.month}/${fechaSeleccionada!.year}'
            : '',
      );
    });
  }

  final List<DropdownMenuItem<String>> items = [
    const DropdownMenuItem(
      value: null,
      child: Text('Seleccione su género', style: TextStyle(color: Colors.grey)),
    ),
    const DropdownMenuItem(value: 'Masculino', child: Text('Masculino')),
    const DropdownMenuItem(value: 'Femenino', child: Text('Femenino')),
  ];

  final List<Map<String, dynamic>> opcionesUsuario = [
    {'label': 'Estudiante', 'value': TipoUsuario.estudiante},
    {'label': 'Docente', 'value': TipoUsuario.docente},
  ];

  void limpiarCampos() {
    cedulaController.clear();
    nombreController.clear();
    apellidoController.clear();
    correoController.clear();
    contrasenaController.clear();
    myControllerFecha.clear();
    itemSeleccionado = null;
    fechaSeleccionada = null;
    _tipoUsuario = TipoUsuario.estudiante;
    setState(() {});
  }

  void guardarFormulario() {
    print('--Datos Guardados--');
    print('Cedula: ${cedulaController.text}');
    print('Nombre: ${nombreController.text}');
    print('Apellido: ${apellidoController.text}');
    print('Correo: ${correoController.text}');
    print('Contraseña: ${contrasenaController.text}');
    print('Fecha de Nacimiento: ${myControllerFecha.text}');
    print('Genero: ${itemSeleccionado ?? "No seleccionado"}');
    print('Tipo de Usuario: ${_tipoUsuario.toString().split('.').last}');

    UsuariosRegistrados.usuarios.add({
      'correo': correoController.text.trim(),
      'contrasena': contrasenaController.text.trim(),
      'nombre': nombreController.text.trim(),
    });
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
                      elementosFormulario(),
                      const SizedBox(height: 20),
                      botones(),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
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
          style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
          onPressed: () {
            limpiarCampos();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => MyBievenidaPage(),
              ),
            );
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
    );
  }

  Widget elementosFormulario() {
    return Column(
      children: <Widget>[
        TextField(
          controller: cedulaController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Cedula',
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          controller: nombreController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Nombre',
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          controller: apellidoController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Apellido',
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          controller: correoController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Correo',
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          controller: contrasenaController,
          obscureText: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Contraseña',
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: TextField(
                controller: myControllerFecha,
                readOnly: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Fecha de Nacimiento',
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: _seleccionarFecha,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(12),
                backgroundColor: Colors.indigo,
              ),
              child: const Icon(Icons.calendar_today, color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 15),
        DropdownButtonFormField<String>(
          value: itemSeleccionado,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 28,
          style: const TextStyle(color: Colors.black87, fontSize: 16),
          dropdownColor: Colors.white,
          items: items,
          onChanged: (String? nuevoValor) {
            setState(() {
              itemSeleccionado = nuevoValor;
            });
          },
        ),
        ...opcionesUsuario.map((opcion) {
          return ListTile(
            title: Text(opcion['label']),
            leading: Radio<TipoUsuario>(
              value: opcion['value'],
              groupValue: _tipoUsuario,
              activeColor: Colors.indigo,
              onChanged: (TipoUsuario? value) {
                setState(() {
                  _tipoUsuario = value;
                });
              },
            ),
          );
        }),
      ],
    );
  }
}
