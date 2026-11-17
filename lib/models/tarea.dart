
import 'package:cloud_firestore/cloud_firestore.dart';

class Tarea {
  final String id;
  final String titulo;
  final String descripcion;
  final bool completada;
  final DateTime fechaCreacion;

  Tarea({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.completada,
    DateTime? fechaCreacion,
  }) : fechaCreacion = fechaCreacion ?? DateTime.now();

  factory Tarea.desdeMapa(
    String id,
    Map<String, dynamic> datos,
  ) {
    final fecha = datos['fechaCreacion'];

    return Tarea(
      id: id,
      titulo: datos['titulo'] ?? '',
      descripcion: datos['descripcion'] ?? '',
      completada: datos['completada'] ?? false,
      fechaCreacion: fecha is Timestamp
          ? fecha.toDate()
          : fecha is DateTime
              ? fecha
              : DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  Map<String, dynamic> convertirAMapa() {
    return {
      'titulo': titulo,
      'descripcion': descripcion,
      'completada': completada,
      'fechaCreacion': Timestamp.fromDate(fechaCreacion),
    };
  }
}
