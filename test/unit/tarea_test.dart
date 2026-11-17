
import 'package:flutter_test/flutter_test.dart';
import 'package:gestion_tareas_flutter/models/tarea.dart';

void main() {
  group('Pruebas del modelo Tarea', () {
    test('Convierte correctamente un mapa en una tarea', () {
      final datos = {
        'titulo': 'Estudiar Flutter',
        'descripcion': 'Preparar actividad de pruebas',
        'completada': false,
      };

      final tarea = Tarea.desdeMapa('tarea001', datos);

      expect(tarea.id, 'tarea001');
      expect(tarea.titulo, 'Estudiar Flutter');
      expect(tarea.descripcion, 'Preparar actividad de pruebas');
      expect(tarea.completada, false);
    });

    test('Convierte correctamente una tarea en mapa', () {
      final tarea = Tarea(
        id: 'tarea002',
        titulo: 'Estudiar Firebase',
        descripcion: 'Practicar Firestore',
        completada: true,
      );

      final resultado = tarea.convertirAMapa();

      expect(resultado['titulo'], 'Estudiar Firebase');
      expect(resultado['descripcion'], 'Practicar Firestore');
      expect(resultado['completada'], true);
    });
  });
}
