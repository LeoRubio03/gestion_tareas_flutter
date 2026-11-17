
import 'package:flutter/material.dart';

import '../models/tarea.dart';
import '../services/tarea_service.dart';

class TareaFormScreen extends StatefulWidget {
  final Tarea? tarea;
  final TareaService? servicio;

  const TareaFormScreen({
    super.key,
    this.tarea,
    this.servicio,
  });

  @override
  State<TareaFormScreen> createState() =>
      _TareaFormScreenState();
}

class _TareaFormScreenState extends State<TareaFormScreen> {
  final formulario = GlobalKey<FormState>();
  final tituloController = TextEditingController();
  final descripcionController = TextEditingController();

  late final TareaService tareaService;

  bool guardando = false;

  @override
  void initState() {
    super.initState();

    tareaService = widget.servicio ?? TareaService();

    if (widget.tarea != null) {
      tituloController.text = widget.tarea!.titulo;
      descripcionController.text = widget.tarea!.descripcion;
    }
  }

  @override
  void dispose() {
    tituloController.dispose();
    descripcionController.dispose();
    super.dispose();
  }

  Future<void> guardarTarea() async {
    if (!formulario.currentState!.validate()) return;

    setState(() => guardando = true);

    try {
      final titulo = tituloController.text.trim();
      final descripcion = descripcionController.text.trim();

      if (widget.tarea == null) {
        await tareaService.crearTarea(
          titulo,
          descripcion,
        );
      } else {
        await tareaService.editarTarea(
          widget.tarea!.id,
          titulo,
          descripcion,
        );
      }

      if (!mounted) return;

      Navigator.pop(context);
    } on StateError catch (e) {
      if (!mounted) return;

      final mensaje = e.message == 'Ya existe una tarea con ese título'
          ? 'Ya existe una tarea con ese título'
          : 'Error al guardar la tarea';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(mensaje),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al guardar la tarea'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => guardando = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final editando = widget.tarea != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          editando ? 'Editar tarea' : 'Nueva tarea',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formulario,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.assignment,
                size: 75,
                color: Colors.indigo,
              ),

              const SizedBox(height: 25),

              // CAMPO DEL TITULO
              TextFormField(
                controller: tituloController,
                maxLength: 80,
                decoration: const InputDecoration(
                  labelText: 'Título de la tarea',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'El título es obligatorio';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              // CAMPO DE DESCRIPCION
              // CORRECCION INC-02
              TextFormField(
                controller: descripcionController,
                maxLines: 4,
                maxLength: 500,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'La descripción es obligatoria';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 25),

              // BOTON PARA GUARDAR O EDITAR
              ElevatedButton.icon(
                onPressed: guardando ? null : guardarTarea,
                icon: const Icon(Icons.save),
                label: Text(
                  guardando
                      ? 'Guardando...'
                      : editando
                          ? 'Guardar cambios'
                          : 'Crear tarea',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
