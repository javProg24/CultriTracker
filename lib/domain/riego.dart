class Riego {
  final int id;
  final String fecha;
  final String? hora;
  final int cantidadAgua;
  final String metodoRiego;

  Riego({
    required this.id,
    required this.fecha,
    this.hora,
    required this.cantidadAgua,
    required this.metodoRiego,
  });
}
