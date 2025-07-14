import 'package:cultritracker/domain/cultivo.dart';
import 'package:cultritracker/domain/insumo.dart';
import 'package:cultritracker/domain/parcela.dart';
import 'package:cultritracker/domain/riego.dart';
import 'package:cultritracker/domain/tareas.dart';
import 'package:cultritracker/presentation/page/cultivo/cultivo_lista_page.dart';
import 'package:cultritracker/presentation/page/insumo/insumo_lista_page.dart';
import 'package:cultritracker/presentation/page/parcela/parcela_lista_page.dart';
import 'package:cultritracker/presentation/page/riego/riego_lista_page.dart';
import 'package:cultritracker/presentation/page/tarea/tarea_lista_page.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  final List<Cultivo> cultivos;
  final List<Riego> riegos;
  final List<Insumo> insumos;
  final List<Parcela> parcelas;
  final List<Tareas> tareas;

  const DashboardPage({
    super.key,
    required this.cultivos,
    required this.riegos,
    required this.insumos,
    required this.parcelas,
    required this.tareas,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late List<Cultivo> cultivos;
  late List<Riego> riegos;
  late List<Insumo> insumos;
  late List<Parcela> parcelas;
  late List<Tareas> tareas;

  @override
  void initState() {
    super.initState();
    cultivos = widget.cultivos;
    riegos = widget.riegos;
    insumos = widget.insumos;
    parcelas = widget.parcelas;
    tareas = widget.tareas;
  }

  Widget _crearCard({
    required String titulo,
    required String valor,
    required VoidCallback onVerTodo,
    IconData icono = Icons.info,
    Color color = Colors.teal,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icono, color: color, size: 24),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    titulo,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              valor,
              style: const TextStyle(fontSize: 14),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onVerTodo,
                child: const Text('Ver todo'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ultimoCultivo = cultivos.isNotEmpty ? cultivos.last : null;
    final ultimoRiego = riegos.isNotEmpty ? riegos.last : null;
    final ultimoInsumo = insumos.isNotEmpty ? insumos.last : null;
    final ultimaParcela = parcelas.isNotEmpty ? parcelas.last : null;
    final ultimaTarea = tareas.isNotEmpty ? tareas.last : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel de Control'),
        backgroundColor: const Color.fromARGB(255, 58, 137, 183),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              children: [
                _crearCard(
                  titulo: 'Último Cultivo',
                  valor: ultimoCultivo != null
                      ? '${ultimoCultivo.nombre} - ${ultimoCultivo.fechaSiembra}'
                      : 'No registrado',
                  icono: Icons.eco,
                  onVerTodo: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CultivoListaPage(),
                      ),
                    );
                  },
                ),
                _crearCard(
                  titulo: 'Último Riego',
                  valor: ultimoRiego != null
                      ? '${ultimoRiego.fecha} - ${ultimoRiego.metodoRiego}'
                      : 'No registrado',
                  icono: Icons.water_drop,
                  onVerTodo: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RiegoListaPage()),
                    );
                  },
                ),
                _crearCard(
                  titulo: 'Último Insumo',
                  valor: ultimoInsumo != null
                      ? '${ultimoInsumo.nombre} - ${ultimoInsumo.fecha}'
                      : 'No registrado',
                  icono: Icons.inventory,
                  onVerTodo: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const InsumoListaPage(),
                      ),
                    );
                  },
                ),
                _crearCard(
                  titulo: 'Última Parcela',
                  valor: ultimaParcela != null
                      ? '${ultimaParcela.nombre} - ${ultimaParcela.tamano} Ha'
                      : 'No registrado',
                  icono: Icons.terrain,
                  onVerTodo: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ParcelaListaPage(),
                      ),
                    );
                  },
                ),
                GridTile(
                  child: SizedBox(
                    height: 100,
                    child: _crearCard(
                      titulo: 'Última Tarea',
                      valor: ultimaTarea != null
                          ? '${ultimaTarea.tipoActividad} - ${ultimaTarea.fecha} - ${ultimaTarea.estado}'
                          : 'No registrado',
                      icono: Icons.task,
                      color: Colors.orange,
                      onVerTodo: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const TareasListaPage(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
