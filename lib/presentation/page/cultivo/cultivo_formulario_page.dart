import 'package:cultritracker/domain/cultivo.dart';
import 'package:flutter/material.dart';

class CultivoFormularioPage extends StatefulWidget {
  final Cultivo? cultivo;

  const CultivoFormularioPage({super.key, this.cultivo});

  @override
  State<CultivoFormularioPage> createState() => _CultivoFormularioPageState();
}

class _CultivoFormularioPageState extends State<CultivoFormularioPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _fechaSiembraController;
  late TextEditingController _ubicacionController;
  late TextEditingController _areaController;
  late ValueNotifier<String?> tipoSeleccionado;

  final List<String> tiposCultivo = [
    'Hortaliza',
    'Fruta',
    'Cereal',
    'Leguminosa',
  ];

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(
      text: widget.cultivo?.nombre ?? '',
    );
    _fechaSiembraController = TextEditingController(
      text: widget.cultivo?.fechaSiembra ?? '',
    );
    _ubicacionController = TextEditingController(
      text: widget.cultivo?.ubicacion ?? '',
    );
    _areaController = TextEditingController(
      text: widget.cultivo?.area.toString() ?? '',
    );
    tipoSeleccionado = ValueNotifier<String?>(widget.cultivo?.tipo ?? null);
  }

  String? validarCampo(String? valor, String mensaje) {
    if (valor == null || valor.isEmpty) return mensaje;
    return null;
  }

  Widget cajaTexto(
    String label, {
    TextEditingController? controller,
    IconData? icon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        prefixIcon: Icon(icon ?? Icons.edit),
      ),
      validator: (value) => validarCampo(value, 'El $label es obligatorio'),
    );
  }

  Widget comboBoxTipo() {
    return ValueListenableBuilder<String?>(
      valueListenable: tipoSeleccionado,
      builder: (context, valor, _) {
        return DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Tipo de cultivo',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            prefixIcon: const Icon(Icons.category),
          ),
          value: valor,
          items: tiposCultivo
              .map((tipo) => DropdownMenuItem(value: tipo, child: Text(tipo)))
              .toList(),
          onChanged: (nuevo) => tipoSeleccionado.value = nuevo,
          validator: (value) => validarCampo(value, 'Selecciona un tipo'),
        );
      },
    );
  }

  ElevatedButton calendario(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.calendar_today),
      label: const Text("Elegir fecha de siembra"),
      onPressed: () async {
        DateTime? fecha = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (fecha != null) {
          _fechaSiembraController.text =
              '${fecha.day}/${fecha.month}/${fecha.year}';
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
      controller: _fechaSiembraController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Fecha de siembra',
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
    final esEdicion = widget.cultivo != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(esEdicion ? 'Editar cultivo' : 'Registrar cultivo'),
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
                      'Formulario de Cultivo',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 58, 137, 183),
                      ),
                    ),
                    const SizedBox(height: 24),
                    cajaTexto(
                      'Nombre',
                      controller: _nombreController,
                      icon: Icons.eco,
                    ),
                    const SizedBox(height: 16),
                    comboBoxTipo(),
                    const SizedBox(height: 16),
                    calendario(context),
                    const SizedBox(height: 16),
                    mostrarFechaSeleccionada(),
                    const SizedBox(height: 16),
                    cajaTexto(
                      'Ubicación',
                      controller: _ubicacionController,
                      icon: Icons.place,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _areaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Área cultivada (m²)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.square_foot),
                      ),
                      validator: (value) =>
                          validarCampo(value, 'El área es obligatoria'),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        botonAccion('Guardar', Colors.green, () {
                          if (_formKey.currentState!.validate()) {
                            final nuevoCultivo = Cultivo(
                              id: widget.cultivo?.id ?? 0,
                              nombre: _nombreController.text,
                              tipo: tipoSeleccionado.value ?? '',
                              fechaSiembra: _fechaSiembraController.text,
                              ubicacion: _ubicacionController.text,
                              area:
                                  double.tryParse(_areaController.text) ?? 0.0,
                            );
                            Navigator.pop(context, nuevoCultivo);
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
