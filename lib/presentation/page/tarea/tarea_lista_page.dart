import 'package:cultritracker/domain/tareas.dart';
import 'package:cultritracker/presentation/page/tarea/tarea_formulario_page.dart';
import 'package:flutter/material.dart';

class TareasListaPage extends StatefulWidget {
  const TareasListaPage({super.key});

  @override
  State<TareasListaPage> createState() => _TareasListaPageState();
}

class _TareasListaPageState extends State<TareasListaPage> {
  List<Tareas> tareas = [];

  void _agregarTarea() async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TareasFormularioPage()),
    );
    if (resultado is Tareas) {
      setState(() {
        tareas.add(resultado);
      });
    }
  }

  void _editarTarea(int index) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TareasFormularioPage(tarea: tareas[index]),
      ),
    );

    if (resultado == 'eliminado') {
      setState(() {
        tareas.removeAt(index);
      });
    } else if (resultado is Tareas) {
      setState(() {
        tareas[index] = resultado;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Tareas"),
        backgroundColor: const Color.fromARGB(255, 58, 137, 183),
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 58, 137, 183),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: _agregarTarea,
      ),
      body: tareas.isEmpty
          ? const Center(
              child: Text(
                "No hay tareas registradas",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: tareas.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) {
                final tarea = tareas[index];
                return GestureDetector(
                  onTap: () => _editarTarea(index),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.task, color: Colors.indigo),
                      title: Text(
                        tarea.tipoActividad,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Descripción: ${tarea.descripcion}"),
                          Text("Estado: ${tarea.estado}"),
                          Text("Fecha: ${tarea.fecha}"),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () {
                          setState(() {
                            tareas.removeAt(index);
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
