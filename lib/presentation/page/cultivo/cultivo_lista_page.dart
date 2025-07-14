import 'package:cultritracker/domain/cultivo.dart';
import 'package:cultritracker/presentation/page/cultivo/cultivo_formulario_page.dart';
import 'package:flutter/material.dart';

class CultivoListaPage extends StatefulWidget {
  const CultivoListaPage({super.key});

  @override
  State<CultivoListaPage> createState() => _CultivoListaPageState();
}

class _CultivoListaPageState extends State<CultivoListaPage> {
  List<Cultivo> cultivos = [];

  void _agregarCultivo() async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CultivoFormularioPage()),
    );
    if (resultado is Cultivo) {
      setState(() {
        cultivos.add(resultado);
      });
    }
  }

  void _editarCultivo(int index) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CultivoFormularioPage(cultivo: cultivos[index]),
      ),
    );

    if (resultado == 'eliminado') {
      setState(() {
        cultivos.removeAt(index);
      });
    } else if (resultado is Cultivo) {
      setState(() {
        cultivos[index] = resultado;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Cultivos"),
        backgroundColor: const Color.fromARGB(255, 58, 137, 183),
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 58, 137, 183),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: _agregarCultivo,
      ),
      body: cultivos.isEmpty
          ? const Center(
              child: Text(
                "No hay cultivos registrados",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: cultivos.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) {
                final cultivo = cultivos[index];
                return GestureDetector(
                  onTap: () => _editarCultivo(index),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.eco, color: Colors.green),
                          title: Text(
                            cultivo.nombre,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Tipo: ${cultivo.tipo}"),
                                Text(
                                  "Fecha de siembra: ${cultivo.fechaSiembra}",
                                ),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () =>
                              setState(() => cultivos.removeAt(index)),
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
