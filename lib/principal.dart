import 'package:cultritracker/page/cultivo.dart';
import 'package:cultritracker/page/insumo.dart';
import 'package:cultritracker/page/parcela.dart';
import 'package:cultritracker/page/riego.dart';
import 'package:cultritracker/page/tarea.dart';
import 'package:cultritracker/page/usuario.dart';
import 'package:cultritracker/utils/icons.dart';
import 'package:flutter/material.dart';

class MyPrincipalPage extends StatefulWidget {
  const MyPrincipalPage({super.key});
  @override
  State<StatefulWidget> createState() => _MyPrincipalPage();
}

class _MyPrincipalPage extends State<MyPrincipalPage> {
  int currentPageIndex = 0;
  final List<Widget> _paginas = [
    CultivoPage(),
    InsumoPage(),
    ParcelaPage(),
    RiegoPage(),
    TareaPage(),
    UsuarioPage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _paginas[currentPageIndex],
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
