import 'package:cultritracker/data/noticias-services.dart';
import 'package:cultritracker/domain/noticia.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NoticiaListaPage extends StatefulWidget {
  const NoticiaListaPage({super.key});

  @override
  State<NoticiaListaPage> createState() => _NoticiaListaPageState();
}

class _NoticiaListaPageState extends State<NoticiaListaPage> {
  List<Noticia> noticias = [];
  final NoticiasAgroService _servicio = NoticiasAgroService();

  @override
  void initState() {
    super.initState();
    _cargarNoticias();
  }

  Future<void> _cargarNoticias() async {
    final data = await _servicio.obtenerNoticias();
    setState(() {
      noticias = data;
    });
  }

  void _abrirEnlace(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo abrir el enlace')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias Agrícolas'),
        backgroundColor: const Color.fromARGB(255, 58, 137, 183),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false, // elimina botón de retroceso
      ),
      body: noticias.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: noticias.length,
              itemBuilder: (context, index) {
                final noticia = noticias[index];
                return GestureDetector(
                  onTap: () => _abrirEnlace(noticia.enlace),
                  child: Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.article, color: Colors.green),
                      title: Text(
                        noticia.titulo,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            noticia.fecha,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      trailing: const Icon(
                        Icons.open_in_new,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
