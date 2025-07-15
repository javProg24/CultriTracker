import 'package:cultritracker/domain/insumo.dart';
import 'package:flutter/material.dart';

import 'insumo_formulario_page.dart'; // Asegúrate de crear este archivo luego

class InsumoListaPage extends StatefulWidget {
  const InsumoListaPage({super.key});

  @override
  State<InsumoListaPage> createState() => _InsumoListaPageState();
}

class _InsumoListaPageState extends State<InsumoListaPage> {
  List<Insumo> insumos = [];

  void _agregarInsumo() async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const InsumoFormularioPage()),
    );

    if (resultado is Insumo) {
      setState(() {
        insumos.add(resultado);
      });
    }
  }

  void _editarInsumo(int index) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InsumoFormularioPage(insumo: insumos[index]),
      ),
    );

    if (resultado == 'eliminado') {
      setState(() {
        insumos.removeAt(index);
      });
    } else if (resultado is Insumo) {
      setState(() {
        insumos[index] = resultado;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 58, 137, 183),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: _agregarInsumo,
      ),
      body: insumos.isEmpty
          ? const Center(
              child: Text(
                'No hay insumos registrados',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: insumos.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) {
                final insumo = insumos[index];
                return GestureDetector(
                  onTap: () => _editarInsumo(index),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.inventory_2,
                        color: Colors.teal,
                      ),
                      title: Text(
                        insumo.nombre,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Tipo: ${insumo.tipo}'),
                            Text('Cantidad: ${insumo.cantidad}'),
                            Text('Fecha: ${insumo.fecha}'),
                            Text('Proveedor: ${insumo.proveedor}'),
                          ],
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() => insumos.removeAt(index));
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
