import 'package:cultritracker/domain/parcela.dart';
import 'package:flutter/material.dart';

class ParcelaFormularioPage extends StatefulWidget {
  final Parcela? parcela;

  const ParcelaFormularioPage({super.key, this.parcela});

  @override
  State<ParcelaFormularioPage> createState() => _ParcelaFormularioPageState();
}

class _ParcelaFormularioPageState extends State<ParcelaFormularioPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _tamanoController;
  late TextEditingController _cantidadCultivoController;

  late ValueNotifier<String?> _cultivoSeleccionado;
  final List<String> _cultivos = ['Maíz', 'Arroz', 'Papa', 'Tomate'];

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(
      text: widget.parcela?.nombre ?? '',
    );
    _tamanoController = TextEditingController(
      text: widget.parcela?.tamano.toString() ?? '',
    );
    _cantidadCultivoController = TextEditingController(
      text: widget.parcela?.cantidadCultivo.toString() ?? '',
    );
    _cultivoSeleccionado = ValueNotifier<String?>(
      widget.parcela?.cultivo ?? null,
    );
  }

  String? validarCampo(String? valor, String mensaje) {
    if (valor == null || valor.isEmpty) return mensaje;
    return null;
  }

  Widget campoTexto(
    String label, {
    TextEditingController? controller,
    IconData? icon,
    TextInputType? tipo,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: tipo ?? TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon ?? Icons.text_fields),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) => validarCampo(value, 'El $label es obligatorio'),
    );
  }

  Widget comboBoxCultivo() {
    return ValueListenableBuilder<String?>(
      valueListenable: _cultivoSeleccionado,
      builder: (context, valor, _) {
        return DropdownButtonFormField<String>(
          value: valor,
          decoration: InputDecoration(
            labelText: 'Cultivo asociado',
            prefixIcon: const Icon(Icons.agriculture),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          items: _cultivos.map((c) {
            return DropdownMenuItem(value: c, child: Text(c));
          }).toList(),
          onChanged: (nuevo) => _cultivoSeleccionado.value = nuevo,
          validator: (value) => validarCampo(value, 'Selecciona un cultivo'),
        );
      },
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
    final esEdicion = widget.parcela != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(esEdicion ? 'Editar Parcela' : 'Registrar Parcela'),
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
                      'Formulario de Parcela',
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
                      icon: Icons.landscape,
                    ),
                    const SizedBox(height: 16),
                    campoTexto(
                      'Tamaño (ha)',
                      controller: _tamanoController,
                      icon: Icons.square_foot,
                      tipo: TextInputType.numberWithOptions(decimal: true),
                    ),
                    const SizedBox(height: 16),
                    comboBoxCultivo(),
                    const SizedBox(height: 16),
                    campoTexto(
                      'Cantidad de Cultivos',
                      controller: _cantidadCultivoController,
                      icon: Icons.format_list_numbered,
                      tipo: TextInputType.number,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        botonAccion('Guardar', Colors.green, () {
                          if (_formKey.currentState!.validate()) {
                            final nuevaParcela = Parcela(
                              id: widget.parcela?.id ?? 0,
                              nombre: _nombreController.text,
                              tamano: double.parse(_tamanoController.text),
                              cultivo: _cultivoSeleccionado.value ?? '',
                              cantidadCultivo: int.parse(
                                _cantidadCultivoController.text,
                              ),
                            );
                            Navigator.pop(context, nuevaParcela);
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
