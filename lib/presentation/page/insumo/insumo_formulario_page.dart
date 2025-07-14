import 'package:cultritracker/domain/insumo.dart';
import 'package:flutter/material.dart';

class InsumoFormularioPage extends StatefulWidget {
  final Insumo? insumo;

  const InsumoFormularioPage({super.key, this.insumo});

  @override
  State<InsumoFormularioPage> createState() => _InsumoFormularioPageState();
}

class _InsumoFormularioPageState extends State<InsumoFormularioPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nombreController;
  late TextEditingController _cantidadController;
  late TextEditingController _fechaController;
  late TextEditingController _proveedorController;

  late ValueNotifier<String?> _tipoSeleccionado;
  final List<String> _tipos = [
    'Fertilizante',
    'Pesticida',
    'Semilla',
    'Herramienta',
  ];

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(
      text: widget.insumo?.nombre ?? '',
    );
    _cantidadController = TextEditingController(
      text: widget.insumo?.cantidad.toString() ?? '',
    );
    _fechaController = TextEditingController(text: widget.insumo?.fecha ?? '');
    _proveedorController = TextEditingController(
      text: widget.insumo?.proveedor ?? '',
    );
    _tipoSeleccionado = ValueNotifier<String?>(widget.insumo?.tipo ?? null);
  }

  String? validarCampo(String? valor, String mensaje) {
    if (valor == null || valor.isEmpty) return mensaje;
    return null;
  }

  Widget campoTexto(
    String label, {
    TextEditingController? controller,
    IconData? icon,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: label == 'Cantidad'
          ? TextInputType.number
          : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon ?? Icons.text_fields),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) => validarCampo(value, 'El $label es obligatorio'),
    );
  }

  Widget comboBoxTipo() {
    return ValueListenableBuilder<String?>(
      valueListenable: _tipoSeleccionado,
      builder: (context, valor, _) {
        return DropdownButtonFormField<String>(
          value: valor,
          decoration: InputDecoration(
            labelText: 'Tipo de insumo',
            prefixIcon: const Icon(Icons.category),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          items: _tipos.map((tipo) {
            return DropdownMenuItem(value: tipo, child: Text(tipo));
          }).toList(),
          onChanged: (nuevo) => _tipoSeleccionado.value = nuevo,
          validator: (value) => validarCampo(value, 'El tipo es obligatorio'),
        );
      },
    );
  }

  Widget selectorFecha() {
    return ElevatedButton.icon(
      icon: const Icon(Icons.calendar_today),
      label: const Text("Elegir fecha"),
      onPressed: () async {
        final DateTime? fecha = await showDatePicker(
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

  Widget mostrarFecha() {
    return TextFormField(
      controller: _fechaController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Fecha de ingreso',
        prefixIcon: const Icon(Icons.event),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
    final esEdicion = widget.insumo != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(esEdicion ? 'Editar insumo' : 'Registrar insumo'),
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
                      'Formulario de Insumo',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 58, 137, 183),
                      ),
                    ),
                    const SizedBox(height: 24),
                    campoTexto(
                      'Nombre',
                      controller: _nombreController,
                      icon: Icons.label,
                    ),
                    const SizedBox(height: 16),
                    comboBoxTipo(),
                    const SizedBox(height: 16),
                    campoTexto(
                      'Cantidad',
                      controller: _cantidadController,
                      icon: Icons.format_list_numbered,
                    ),
                    const SizedBox(height: 16),
                    campoTexto(
                      'Proveedor',
                      controller: _proveedorController,
                      icon: Icons.local_shipping,
                    ),
                    const SizedBox(height: 16),
                    selectorFecha(),
                    const SizedBox(height: 16),
                    mostrarFecha(),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        botonAccion('Guardar', Colors.green, () {
                          if (_formKey.currentState!.validate()) {
                            final nuevoInsumo = Insumo(
                              id: widget.insumo?.id ?? 0,
                              nombre: _nombreController.text,
                              tipo: _tipoSeleccionado.value ?? '',
                              cantidad: int.parse(_cantidadController.text),
                              fecha: _fechaController.text,
                              proveedor: _proveedorController.text,
                            );
                            Navigator.pop(context, nuevoInsumo);
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
