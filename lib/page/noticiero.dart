import 'package:flutter/material.dart';
import 'package:cultritracker/page/universo.dart';
import 'package:cultritracker/page/noticias.dart';

class NoticieroPage extends StatefulWidget {
  const NoticieroPage({super.key});

  @override
  State<NoticieroPage> createState() => _NoticieroPageState();
}

class _NoticieroPageState extends State<NoticieroPage> {
  Widget? _paginaSeleccionada;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticiero'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _paginaSeleccionada = const NoticiasPage(); // Comercio
              });
            },
            child: const Text('Comercio'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _paginaSeleccionada = const UniversoPage(); // Universo
              });
            },
            child: const Text('Universo'),
          ),
          const SizedBox(height: 20),
          Expanded(
            child:
                _paginaSeleccionada ??
                const Center(child: Text("Selecciona una fuente")),
          ),
        ],
      ),
    );
  }
}
