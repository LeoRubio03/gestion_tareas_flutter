
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/tarea.dart';

class TareaService {
  FirebaseFirestore get _firestore =>
    FirebaseFirestore.instance;
  String get _usuarioId {
    final usuario = FirebaseAuth.instance.currentUser;

    if (usuario == null) {
      throw StateError('No hay un usuario autenticado');
    }

    return usuario.uid;
  }

  CollectionReference<Map<String, dynamic>> get _tareas {
    return _firestore
        .collection('users')
        .doc(_usuarioId)
        .collection('tasks');
  }

  // Consultar tareas en tiempo real
  Stream<List<Tarea>> obtenerTareas() {
    return _tareas.snapshots().map((snapshot) {
      return snapshot.docs.map((documento) {
        return Tarea.desdeMapa(
          documento.id,
          documento.data(),
        );
      }).toList();
    });
  }

  // Crear una tarea
  Future<void> crearTarea(
    String titulo,
    String descripcion,
  ) async {
    await _tareas.add({
      'titulo': titulo,
      'descripcion': descripcion,
      'completada': false,
      'fechaCreacion': FieldValue.serverTimestamp(),
    });
  }

  // Editar una tarea
  Future<void> editarTarea(
    String id,
    String titulo,
    String descripcion,
  ) async {
    await _tareas.doc(id).update({
      'titulo': titulo,
      'descripcion': descripcion,
    });
  }

  // Cambiar el estado de una tarea
  Future<void> cambiarEstado(
    String id,
    bool completada,
  ) async {
    await _tareas.doc(id).update({
      'completada': completada,
    });
  }

  // Eliminar una tarea
  Future<void> eliminarTarea(String id) async {
    await _tareas.doc(id).delete();
  }
}
