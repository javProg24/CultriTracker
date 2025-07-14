import 'package:flutter/material.dart';
import 'package:cultritracker/domain/tareas.dart';

class TareasFormularioPage extends StatefulWidget {
  final Tareas? tarea;

  const TareasFormularioPage({super.key, this.tarea});

  @override
  State<TareasFormularioPage> createState() => _TareasFormularioPageState();
}

class _TareasFormularioPageState extends State<TareasFormularioPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _descripcionController;
  late TextEditingController _fechaController;
  late ValueNotifier<String?> _tipoActividadSeleccionada;
  late ValueNotifier<String?> _estadoSeleccionado;

  final List<String> tiposActividad = ['Riego', 'Cosecha', 'Siembra', 'Fertilización'];
  final List<String> estados = ['Pendiente', 'En proceso', 'Completado'];

  @override
  void initState() {
    super.initState();
    _descripcionController =
        TextEditingController(text: widget.tarea?.descripcion ?? '');
    _fechaController = TextEditingController(text: widget.tarea?.fecha ?? '');
    _tipoActividadSeleccionada =
        ValueNotifier(widget.tarea?.tipoActividad ?? tiposActividad.first);
    _estadoSeleccionado =
        ValueNotifier(widget.tarea?.estado ?? estados.first);
  }

  String? validarCampo(String? valor, String mensaje) {
    if (valor == null || valor.isEmpty) return mensaje;
    return null;
  }

  ElevatedButton calendario(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.calendar_today),
      label: const Text("Elegir fecha"),
      onPressed: () async {
        DateTime? fecha = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (fecha != null) {
          _fechaController.text = '${fecha.day}/${fecha.month}/${fecha.year}';
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 58, 137, 183),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget mostrarFechaSeleccionada() {
    return TextFormField(
      controller: _fechaController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Fecha',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        prefixIcon: const Icon(Icons.event),
      ),
      validator: (value) => validarCampo(value, 'La fecha es obligatoria'),
    );
  }

  Widget comboBoxTipoActividad() {
    return ValueListenableBuilder<String?>(
      valueListenable: _tipoActividadSeleccionada,
      builder: (context, valor, _) {
        return DropdownButtonFormField<String>(
          value: valor,
          decoration: InputDecoration(
            labelText: 'Tipo de actividad',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            prefixIcon: const Icon(Icons.category),
          ),
          items: tiposActividad.map((tipo) {
            return DropdownMenuItem(value: tipo, child: Text(tipo));
          }).toList(),
          onChanged: (nuevo) => _tipoActividadSeleccionada.value = nuevo,
          validator: (value) => validarCampo(value, 'Selecciona un tipo'),
        );
      },
    );
  }

  Widget comboBoxEstado() {
    return ValueListenableBuilder<String?>(
      valueListenable: _estadoSeleccionado,
      builder: (context, valor, _) {
        return DropdownButtonFormField<String>(
          value: valor,
          decoration: InputDecoration(
            labelText: 'Estado',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            prefixIcon: const Icon(Icons.flag),
          ),
          items: estados.map((estado) {
            return DropdownMenuItem(value: estado, child: Text(estado));
          }).toList(),
          onChanged: (nuevo) => _estadoSeleccionado.value = nuevo,
          validator: (value) => validarCampo(value, 'Selecciona el estado'),
        );
      },
    );
  }

  Widget campoDescripcion() {
    return TextFormField(
      controller: _descripcionController,
      maxLines: 3,
      decoration: InputDecoration(
        labelText: 'Descripción',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        prefixIcon: const Icon(Icons.description),
      ),
      validator: (value) => validarCampo(value, 'La descripción es obligatoria'),
    );
  }

  Widget botonAccion(String texto, Color color, VoidCallback onPressed, IconData icono) {
    return ElevatedButton.icon(
      icon: Icon(icono),
      label: Text(texto),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final esEdicion = widget.tarea != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(esEdicion ? 'Editar tarea' : 'Registrar tarea'),
        backgroundColor: const Color.fromARGB(255, 58, 137, 183),
        foregroundColor: Colors.white,
        actions: [
          if (esEdicion)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                Navigator.pop(context, 'eliminado');
              },
            ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            elevation: 8,
            margin: const EdgeInsets.all(24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      'Formulario de Tareas',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 58, 137, 183),
                      ),
                    ),
                    const SizedBox(height: 24),
                    comboBoxTipoActividad(),
                    const SizedBox(height: 16),
                    campoDescripcion(),
                    const SizedBox(height: 16),
                    comboBoxEstado(),
                    const SizedBox(height: 16),
                    calendario(context),
                    const SizedBox(height: 16),
                    mostrarFechaSeleccionada(),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        botonAccion('Guardar', Colors.green, () {
                          if (_formKey.currentState!.validate()) {
                            final nuevaTarea = Tareas(
                              id: widget.tarea?.id ?? 0,
                              tipoActividad: _tipoActividadSeleccionada.value!,
                              descripcion: _descripcionController.text,
                              estado: _estadoSeleccionado.value!,
                              fecha: _fechaController.text,
                            );
                            Navigator.pop(context, nuevaTarea);
                          }
                        }, Icons.check),
                        botonAccion('Cancelar', Colors.redAccent, () {
                          Navigator.pop(context);
                        }, Icons.clear),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
