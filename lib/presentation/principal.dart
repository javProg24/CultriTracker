import 'package:cultritracker/core/utils/icons.dart';
import 'package:cultritracker/presentation/page/cultivo/cultivo_lista_page.dart';
import 'package:cultritracker/presentation/page/insumo/insumo_lista_page.dart';
import 'package:cultritracker/presentation/page/noticias/noticias_lista_page.dart';
import 'package:cultritracker/presentation/page/parcela/parcela_lista_page.dart';
import 'package:cultritracker/presentation/page/riego/riego_lista_page.dart';
import 'package:cultritracker/presentation/page/tarea/tarea_lista_page.dart';
import 'package:flutter/material.dart';

class MyPrincipalPage extends StatefulWidget {
  const MyPrincipalPage({super.key});

  @override
  State<MyPrincipalPage> createState() => _MyPrincipalPageState();
}

class _MyPrincipalPageState extends State<MyPrincipalPage> {
  // todo tu código aquí...
  int _currentPageIndex = 0;

  final List<Widget> _paginas = [
    CultivoListaPage(),
    InsumoListaPage(),
    ParcelaListaPage(),
    RiegoListaPage(),
    TareasListaPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  void _seleccionarMenu(String opcion) {
    switch (opcion) {
      case 'noticias':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NoticiaListaPage()),
        );
        break;
      case 'acerca':
        showAboutDialog(
          context: context,
          applicationName: 'CultriTracker',
          applicationVersion: '1.0',
          applicationIcon: const Icon(Icons.agriculture),
          children: const [
            Text('Aplicación para gestión agrícola.'),
            Text(
              'Desarrollado por:\nJosé Malavé.\nFelix Tomalá\nMarcos Falconí\nJean Romero\nSteven Falquez',
            ),
          ],
        );
        break;
      case 'contacto':
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Contacto'),
            content: const Text(
              '¿Tienes dudas o sugerencias?\n\n'
              'Escríbenos a:\nsoporte@cultritracker.ec',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cerrar'),
              ),
            ],
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CultriTracker"),
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 58, 137, 183),
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            onSelected: _seleccionarMenu,
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(value: 'noticias', child: Text('Noticias')),
              const PopupMenuItem(value: 'acerca', child: Text('Acerca de')),
              const PopupMenuItem(
                value: 'contacto',
                child: Text('Contacto'),
              ), // ← nuevo
            ],
          ),
        ],
      ),
      body: _paginas[_currentPageIndex],
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: MyIcons.cultivoPNG(),
              onPressed: () => _onItemTapped(0),
            ),
            IconButton(
              onPressed: () => _onItemTapped(1),
              icon: MyIcons.insumoPNG(),
            ),
            IconButton(
              onPressed: () => _onItemTapped(2),
              icon: MyIcons.tierraPNG(),
            ),
            IconButton(
              onPressed: () => _onItemTapped(3),
              icon: MyIcons.cuboPNG(),
            ),
            IconButton(
              onPressed: () => _onItemTapped(4),
              icon: MyIcons.libroPNG(),
            ),
          ],
        ),
      ),
    );
  }
}
