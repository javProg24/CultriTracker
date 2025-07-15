import 'package:cultritracker/domain/riego.dart';
import 'package:cultritracker/presentation/page/riego/riego_formulario_page.dart';
import 'package:flutter/material.dart';

class RiegoListaPage extends StatefulWidget {
  const RiegoListaPage({super.key});

  @override
  State<RiegoListaPage> createState() => _RiegoListaPageState();
}

class _RiegoListaPageState extends State<RiegoListaPage> {
  List<Riego> riegos = [];

  void _agregarRiego() async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RiegoFormularioPage()),
    );
    if (resultado is Riego) {
      setState(() {
        riegos.add(resultado);
      });
    }
  }

  void _editarRiego(int index) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RiegoFormularioPage(riego: riegos[index]),
      ),
    );

    if (resultado == 'eliminado') {
      setState(() {
        riegos.removeAt(index);
      });
    } else if (resultado is Riego) {
      setState(() {
        riegos[index] = resultado;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 58, 137, 183),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: _agregarRiego,
      ),
      body: riegos.isEmpty
          ? const Center(
              child: Text(
                "No hay riegos registrados",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: riegos.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) {
                final riego = riegos[index];
                return GestureDetector(
                  onTap: () => _editarRiego(index),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(
                            Icons.water_drop,
                            color: Colors.blue,
                          ),
                          title: Text(
                            "Riego del ${riego.fecha}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (riego.hora != null &&
                                    riego.hora!.isNotEmpty)
                                  Text("Hora: ${riego.hora}"),
                                Text(
                                  "Cantidad de agua: ${riego.cantidadAgua} L",
                                ),
                                Text("Método de riego: ${riego.metodoRiego}"),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () =>
                              setState(() => riegos.removeAt(index)),
                          icon: Icon(Icons.delete),
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
