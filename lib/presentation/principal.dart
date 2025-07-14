import 'package:cultritracker/core/utils/icons.dart';
import 'package:cultritracker/presentation/page/cultivo/cultivo_lista_page.dart';
import 'package:cultritracker/presentation/page/insumo/insumo_lista_page.dart';
import 'package:cultritracker/presentation/page/parcela/parcela_lista_page.dart';
import 'package:cultritracker/presentation/page/riego/riego_lista_page.dart';
import 'package:cultritracker/presentation/page/tarea/tarea_lista_page.dart';
import 'package:flutter/material.dart';

class MyPrincipalPage extends StatefulWidget {
  const MyPrincipalPage({super.key});
  @override
  State<StatefulWidget> createState() => _MyPrincipalPage();
}

class _MyPrincipalPage extends State<MyPrincipalPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            IconButton(
              onPressed: () => _onItemTapped(5),
              icon: MyIcons.usuarioPNG(),
            ),
          ],
        ),
      ),
    );
  }
}
