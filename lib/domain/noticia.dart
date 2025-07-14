class Noticia {
  final String titulo;
  final String enlace;
  final String fecha;

  Noticia({required this.titulo, required this.enlace, required this.fecha});

  @override
  String toString() {
    return '📰 $titulo\n📅 $fecha\n🔗 $enlace\n';
  }
}
