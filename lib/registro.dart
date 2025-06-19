// formulario de registro
//https://www.youtube.com/watch?v=d3mpzn6Ko2o&t=20s
import 'package:cultritracker/main.dart';
import 'package:flutter/material.dart';

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
  //
  String? itemSeleccionado;
  DateTime? fechaSeleccionada;
  final myControllerFecha = TextEditingController();
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

  TipoUsuario? _tipoUsuario = TipoUsuario.estudiante;
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
    print('Fecha de Nacimiento: ${myControllerFecha.text}');
    print('Genero: ${itemSeleccionado ?? "No seleccionado"}');
    print('Tipo de Usuario: ${_tipoUsuario.toString().split('.').last}');
  }

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
      mainAxisAlignment: MainAxisAlignment.center, // Centra horizontalmente
      children: <Widget>[
        SizedBox(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            onPressed: () {
              guardarFormulario();
              limpiarCampos();
            },
            // mostrar en consola
            child: const Text(
              'Guardar',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16), // Espacio entre los botones
        SizedBox(
          child: ElevatedButton(
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
            // limpiar campos y volver al main
            child: const Text(
              'Cancelar',
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

  Widget elementosFormulario() {
    // -Calendario, - ComboBox,RadioButton
    // 6 campos
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: cedulaController,
          onChanged: (value) {},
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Cedula',
            labelStyle: TextStyle(color: Colors.grey[600]),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
            ),
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          controller: nombreController,
          onChanged: (value) {},
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Nombre',
            labelStyle: TextStyle(color: Colors.grey[600]),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
            ),
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          controller: apellidoController,
          onChanged: (value) {},
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Apellido',
            labelStyle: TextStyle(color: Colors.grey[600]),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
            ),
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Fecha de Nacimiento',
                  labelStyle: TextStyle(color: Colors.grey[600]),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.blue.shade600,
                      width: 2,
                    ),
                  ),
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
              child: const Icon(
                Icons.calendar_today,
                color: Colors.white, // Color del ícono
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        DropdownButtonFormField<String>(
          value: itemSeleccionado,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade400, width: 1.2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
          ),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
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
