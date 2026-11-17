
class Tarea {
  final String id;
  final String titulo;
  final String descripcion;
  final bool completada;

  Tarea({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.completada,
  });

  factory Tarea.desdeMapa(
    String id,
    Map<String, dynamic> datos,
  ) {
    return Tarea(
      id: id,
      titulo: datos['titulo'] ?? '',
      descripcion: datos['descripcion'] ?? '',
      completada: datos['completada'] ?? false,
    );
  }

  Map<String, dynamic> convertirAMapa() {
    return {
      'titulo': titulo,
      'descripcion': descripcion,
      'completada': completada,
    };
  }
}
