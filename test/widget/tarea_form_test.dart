
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gestion_tareas_flutter/screens/tarea_form_screen.dart';
import 'package:gestion_tareas_flutter/services/tarea_service.dart';

// Servicio falso para no guardar datos en Firebase
class FakeTareaService extends TareaService {
  bool guardarFueLlamado = false;
  String? tituloGuardado;

  @override
  Future<void> crearTarea(
    String titulo,
    String descripcion,
  ) async {
    guardarFueLlamado = true;
    tituloGuardado = titulo;
  }
}

void main() {
  testWidgets(
    'No permite crear una tarea con título vacío',
    (WidgetTester tester) async {
      final fake = FakeTareaService();

      await tester.pumpWidget(
        MaterialApp(
          home: TareaFormScreen(servicio: fake),
        ),
      );

      await tester.tap(find.text('Crear tarea'));
      await tester.pump();

      expect(
        find.text('El título es obligatorio'),
        findsOneWidget,
      );

      expect(fake.guardarFueLlamado, false);
    },
  );

  testWidgets(
    'Permite guardar una tarea con título válido',
    (WidgetTester tester) async {
      final fake = FakeTareaService();

      await tester.pumpWidget(
        MaterialApp(
          home: TareaFormScreen(servicio: fake),
        ),
      );

      await tester.enterText(
        find.byType(TextFormField).first,
        'Estudiar Flutter',
      );

      await tester.tap(find.text('Crear tarea'));
      await tester.pumpAndSettle();

      expect(fake.guardarFueLlamado, true);
      expect(fake.tituloGuardado, 'Estudiar Flutter');
    },
  );
}
