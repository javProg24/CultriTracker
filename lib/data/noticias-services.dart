import 'package:cultritracker/domain/noticia.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class NoticiasAgroService {
  final String rssUrl =
      'https://news.google.com/rss/search?q=agricultura+ecuador&hl=es-419&gl=US&ceid=US:es-419';

  Future<List<Noticia>> obtenerNoticias() async {
    final response = await http.get(Uri.parse(rssUrl));
    final noticias = <Noticia>[];

    if (response.statusCode == 200) {
      final document = XmlDocument.parse(response.body);
      final items = document.findAllElements('item');

      for (var item in items) {
        final titulo = item.getElement('title')?.text ?? 'Sin título';
        final enlace = item.getElement('link')?.text ?? '';
        final fecha = item.getElement('pubDate')?.text ?? 'Sin fecha';

        noticias.add(Noticia(titulo: titulo, enlace: enlace, fecha: fecha));
      }
    } else {
      print('Error al obtener el RSS: ${response.statusCode}');
    }

    return noticias;
  }
}
