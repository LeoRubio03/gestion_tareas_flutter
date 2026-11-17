
import 'package:flutter/material.dart';

import '../models/tarea.dart';
import '../services/auth_service.dart';
import '../services/tarea_service.dart';
import 'tarea_form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final tareaService = TareaService();

  late final Stream<List<Tarea>> tareasStream;

  @override
  void initState() {
    super.initState();
    tareasStream = tareaService.obtenerTareas();
  }

  Future<void> eliminar(Tarea tarea) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar tarea'),
        content: Text(
          '¿Deseas eliminar "${tarea.titulo}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmar != true) return;

    try {
      await tareaService.eliminarTarea(tarea.id);
    } catch (e) {
      mostrarError('No se pudo eliminar la tarea');
    }
  }

  void mostrarError(String mensaje) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis tareas'),
        actions: [
          IconButton(
            tooltip: 'Cerrar sesión',
            icon: const Icon(Icons.logout),
            onPressed: () async {
              try {
                await AuthService().cerrarSesion();
              } catch (e) {
                mostrarError('No se pudo cerrar sesión');
              }
            },
          ),
        ],
      ),

      body: StreamBuilder<List<Tarea>>(
        stream: tareasStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Error al cargar las tareas',
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final tareas = snapshot.data!;

          if (tareas.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.inbox_outlined,
                    size: 85,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Aún no tienes tareas',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Presiona + para crear una tarea',
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: tareas.length,
            itemBuilder: (context, index) {
              final tarea = tareas[index];

              return Card(
                child: ListTile(
                  leading: Checkbox(
                    value: tarea.completada,
                    onChanged: (valor) async {
                      try {
                        await tareaService.cambiarEstado(
                          tarea.id,
                          valor ?? false,
                        );
                      } catch (e) {
                        mostrarError(
                          'No se pudo actualizar la tarea',
                        );
                      }
                    },
                  ),

                  title: Text(
                    tarea.titulo,
                    style: TextStyle(
                      decoration: tarea.completada
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),

                  subtitle: Text(tarea.descripcion),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TareaFormScreen(
                          tarea: tarea,
                        ),
                      ),
                    );
                  },

                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                    onPressed: () => eliminar(tarea),
                  ),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        tooltip: 'Crear tarea',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const TareaFormScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
