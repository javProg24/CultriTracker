import 'package:cultritracker/domain/riego.dart';
import 'package:flutter/material.dart';

class RiegoFormularioPage extends StatefulWidget {
  final Riego? riego;

  const RiegoFormularioPage({super.key, this.riego});

  @override
  State<RiegoFormularioPage> createState() => _RiegoFormularioPageState();
}

class _RiegoFormularioPageState extends State<RiegoFormularioPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fechaController;
  late TextEditingController _horaController;
  late TextEditingController _aguaController;
  late ValueNotifier<String?> opcionSeleccionada;

  final List<String> opciones = ['Manual', ' Goteo', 'Aspersor pequeño'];

  @override
  void initState() {
    super.initState();
    _fechaController = TextEditingController(text: widget.riego?.fecha ?? '');
    _horaController = TextEditingController(text: widget.riego?.hora ?? '');
    _aguaController = TextEditingController(
      text: widget.riego?.cantidadAgua.toString() ?? '',
    );
    opcionSeleccionada = ValueNotifier<String?>(
      widget.riego?.metodoRiego ?? null,
    );
  }

  String? validarCampo(String? valor, String mensaje) {
    if (valor == null || valor.isEmpty) {
      return mensaje;
    }
    return null;
  }

  Widget cajaTexto(String label, {TextEditingController? controller}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        prefixIcon: label == 'Hora'
            ? const Icon(Icons.access_time)
            : const Icon(Icons.water_drop),
      ),
      validator: (value) => validarCampo(value, 'El $label es obligatorio'),
    );
  }

  Widget comboBox() {
    return ValueListenableBuilder<String?>(
      valueListenable: opcionSeleccionada,
      builder: (context, valor, _) {
        return DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Tipo de riego',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            prefixIcon: const Icon(Icons.agriculture),
          ),
          value: valor,
          items: opciones.map((dato) {
            return DropdownMenuItem(value: dato, child: Text(dato));
          }).toList(),
          onChanged: (nuevoValor) {
            opcionSeleccionada.value = nuevoValor;
          },
          validator: (value) =>
              validarCampo(value, 'Selecciona un tipo de riego'),
        );
      },
    );
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
        labelText: 'Fecha seleccionada',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        prefixIcon: const Icon(Icons.event),
      ),
      validator: (value) => validarCampo(value, 'La fecha es obligatoria'),
    );
  }

  Widget botonAccion(
    String texto,
    Color color,
    VoidCallback onPressed,
    IconData icono,
  ) {
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
    final esEdicion = widget.riego != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(esEdicion ? 'Editar riego' : 'Registrar riego'),
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
                      'Formulario de Riego',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 58, 137, 183),
                      ),
                    ),
                    const SizedBox(height: 24),
                    calendario(context),
                    const SizedBox(height: 16),
                    mostrarFechaSeleccionada(),
                    const SizedBox(height: 16),
                    cajaTexto('Hora', controller: _horaController),
                    const SizedBox(height: 16),
                    cajaTexto('Cantidad de agua', controller: _aguaController),
                    const SizedBox(height: 16),
                    comboBox(),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        botonAccion('Guardar', Colors.green, () {
                          if (_formKey.currentState!.validate()) {
                            final nuevoRiego = Riego(
                              id: widget.riego?.id ?? 0,
                              fecha: _fechaController.text,
                              hora: _horaController.text,
                              cantidadAgua: int.parse(_aguaController.text),
                              metodoRiego: opcionSeleccionada.value ?? 'Manual',
                            );
                            Navigator.pop(context, nuevoRiego);
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
