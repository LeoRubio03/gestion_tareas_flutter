
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

  // Consultar tareas ordenadas por fecha de creación
  Stream<List<Tarea>> obtenerTareas() {
    return _tareas
        .orderBy('fechaCreacion', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((documento) {
        return Tarea.desdeMapa(
          documento.id,
          documento.data(),
        );
      }).toList();
    });
  }

  // Comprobar si ya existe una tarea con el mismo título
  Future<bool> existeTitulo(
    String titulo, {
    String? excluirId,
  }) async {
    final resultado = await _tareas
        .where('titulo', isEqualTo: titulo.trim())
        .get();

    return resultado.docs.any(
      (documento) => documento.id != excluirId,
    );
  }

  // Crear una tarea
  Future<void> crearTarea(
    String titulo,
    String descripcion,
  ) async {
    final tituloLimpio = titulo.trim();

    if (await existeTitulo(tituloLimpio)) {
      throw StateError('Ya existe una tarea con ese título');
    }

    await _tareas.add({
      'titulo': tituloLimpio,
      'descripcion': descripcion.trim(),
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
    final tituloLimpio = titulo.trim();

    if (await existeTitulo(
      tituloLimpio,
      excluirId: id,
    )) {
      throw StateError('Ya existe una tarea con ese título');
    }

    await _tareas.doc(id).update({
      'titulo': tituloLimpio,
      'descripcion': descripcion.trim(),
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
