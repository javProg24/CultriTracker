import 'package:cultritracker/domain/parcela.dart';
import 'package:flutter/material.dart';

import 'parcela_formulario_page.dart';

class ParcelaListaPage extends StatefulWidget {
  const ParcelaListaPage({super.key});

  @override
  State<ParcelaListaPage> createState() => _ParcelaListaPageState();
}

class _ParcelaListaPageState extends State<ParcelaListaPage> {
  List<Parcela> parcelas = [];

  void _agregarParcela() async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ParcelaFormularioPage()),
    );
    if (resultado is Parcela) {
      setState(() {
        parcelas.add(resultado);
      });
    }
  }

  void _editarParcela(int index) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ParcelaFormularioPage(parcela: parcelas[index]),
      ),
    );

    if (resultado == 'eliminado') {
      setState(() {
        parcelas.removeAt(index);
      });
    } else if (resultado is Parcela) {
      setState(() {
        parcelas[index] = resultado;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 58, 137, 183),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: _agregarParcela,
      ),
      body: parcelas.isEmpty
          ? const Center(
              child: Text(
                "No hay parcelas registradas",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: parcelas.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) {
                final parcela = parcelas[index];
                return GestureDetector(
                  onTap: () => _editarParcela(index),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.landscape, color: Colors.green),
                      title: Text(
                        parcela.nombre,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tamaño: ${parcela.tamano} ha'),
                          Text('Cultivo: ${parcela.cultivo}'),
                          Text(
                            'Cantidad de cultivos: ${parcela.cantidadCultivo}',
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () {
                          setState(() {
                            parcelas.removeAt(index);
                          });
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
