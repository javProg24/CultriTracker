import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class CultivoPage extends StatelessWidget {
  const CultivoPage({super.key});
  Future<List<dynamic>> leerCultivoJson() async {
    final String respuesta = await rootBundle.loadString(
      'assets/json/cultivo.json',
    );
    return json.decode(respuesta);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cultivo')),
      backgroundColor: Colors.grey[200],
      body: FutureBuilder(
        future: leerCultivoJson(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar datos'));
          } else {
            var cultivos = snapshot.data as List;
            return ListView.builder(
              itemCount: cultivos.length,
              itemBuilder: (context, index) {
                var cultivo = cultivos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cultivo['nombre'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Tipo:${cultivo['tipo']}'),
                        const SizedBox(height: 4),
                        Text('Fecha de siembra: ${cultivo['fechaSiembra']}'),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
