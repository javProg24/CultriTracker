import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class UniversoPage extends StatefulWidget {
  const UniversoPage({super.key});

  @override
  State<UniversoPage> createState() => _UniversoPageState();
}

class _UniversoPageState extends State<UniversoPage> {
  late Future<RssFeed> futureFeed;

  @override
  void initState() {
    super.initState();
    futureFeed = getNews();
  }

  Future<RssFeed> getNews() async {
    final response = await http.get(
      Uri.parse(
        'https://www.eluniverso.com/arc/outboundfeeds/rss-subsection/deportes/futbol/?outputType=xml',
      ),
    );
    if (response.statusCode == 200) {
      return RssFeed.parse(response.body);
    } else {
      throw Exception('Error al cargar noticias');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias Fútbol - El Universo'),
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<RssFeed>(
        future: futureFeed,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.items == null) {
            return const Center(child: Text('No se encontraron noticias'));
          } else {
            final items = snapshot.data!.items!;
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final category =
                    (item.categories != null && item.categories!.isNotEmpty)
                    ? item.categories!.first.value
                    : 'Fútbol';
                final author = item.dc?.creator ?? 'Desconocido';
                final imageUrl = item.enclosure?.url;
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadowColor: Colors.tealAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        // Imagen
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: imageUrl != null
                              ? Image.network(
                                  imageUrl,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.grey[300],
                                  child: const Icon(
                                    Icons.image_not_supported,
                                    size: 40,
                                  ),
                                ),
                        ),
                        const SizedBox(width: 16),
                        // Texto
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                category,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.teal,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                item.title ?? 'Sin título',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Autor: $author',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
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
