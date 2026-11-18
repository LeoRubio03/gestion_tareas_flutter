# Registro de pruebas manuales: Gestión de Tareas

**Proyecto:** `gestion_tareas_flutter`  
**Rama de trabajo:** `semana16-integracion`  
**Entorno:** Flutter ejecutado en Google Chrome (`flutter run -d chrome`)  
**Servicios incluidos:** Firebase Authentication y Cloud Firestore  
**Resultado:** 10 casos ejecutados, 10 aprobados, 0 fallidos.  
**Evidencia:** 11 capturas manuales, guardadas localmente en `docs/evidencias/capturas-aplicacion/` según reporte del ejecutor.

## Flujos críticos cubiertos

1. Registro, inicio y cierre de sesión (CP-02, CP-03).
2. Validación de credenciales incorrectas (CP-04, caso negativo).
3. Creación y consulta persistente de tareas (CP-05, CP-06, CP-07).
4. Edición y cambio de estado de tareas (CP-08, CP-09).
5. Eliminación de tareas con confirmación (CP-10).

> **Nota:** Estos flujos se infieren de las funcionalidades implementadas. Deben cotejarse con el mapa de flujos críticos del equipo cuando se elabore.

## Casos ejecutados

| ID | Módulo o funcionalidad | Descripción de la prueba | Datos de entrada | Resultado esperado | Resultado obtenido | Estado | Error identificado | Corrección aplicada | Evidencia |
|---|---|---|---|---|---|---|---|---|---|
| CP-01 | Arranque | Abrir la aplicación en Chrome | `flutter run -d chrome` | Mostrar pantalla de acceso utilizable | Apareció «Gestión de Tareas» correctamente | Aprobado | Ninguno reportado | No aplica | `CP-01_inicio_aplicacion.png` |
| CP-02 | Autenticación | Registrar usuario nuevo | Correo no registrado y contraseña válida (valores omitidos por privacidad) | Crear cuenta y entrar a pantalla principal | Apareció «Mis tareas» y «Aún no tienes tareas» | Aprobado | Ninguno reportado | No aplica | `CP-02_registro_usuario.png` |
| CP-03 | Autenticación | Cerrar sesión y volver a ingresar | Credenciales válidas del usuario de prueba | Permitir inicio de sesión y mostrar «Mis tareas» | Cerró sesión, volvió a iniciar y mostró «Mis tareas» | Aprobado | Ninguno reportado | No aplica | `CP-03_inicio_sesion_correcto.png` |
| CP-04 | Autenticación | Intentar entrar con contraseña incorrecta (negativa) | Correo registrado y contraseña incorrecta | Rechazar acceso y mostrar mensaje de error | Se rechazó acceso y apareció mensaje de credenciales incorrectas | Aprobado | Ninguno reportado | No aplica | `CP-04_inicio_sesion_incorrecto.png` |
| CP-05 | Navegación | Abrir formulario de nueva tarea | Pulsar botón `+` en «Mis tareas» | Mostrar título, descripción y botón «Crear tarea» | Se mostró «Nueva tarea» con los campos y botón previstos | Aprobado | Ninguno reportado | No aplica | `CP-05_formulario_nueva_tarea.png` |
| CP-06 | Firestore / tareas | Crear una tarea | Título «Estudiar Flutter»; descripción «Repasar los conceptos de Flutter y Firebase para la evaluación.» | Guardar y mostrar tarea en lista | Apareció la tarea creada en «Mis tareas» | Aprobado | Ninguno reportado | No aplica | `CP-06_creacion_tarea.png` |
| CP-07 | Firestore / tareas | Consultar tarea después de reiniciar aplicación | Reiniciar, iniciar sesión y consultar tarea de CP-06 | Mantener tarea y estado pendiente | La tarea continuó visible y sin completar | Aprobado | Ninguno reportado | No aplica | `CP-07_consulta_tareas.png` |
| CP-08 | Firestore / tareas | Editar título y descripción de tarea | Título «Estudiar Flutter y Firebase»; descripción «Repasar Flutter, Firebase Authentication y Cloud Firestore para la evaluación.» | Actualizar datos y volver a «Mis tareas» | Se actualizaron los datos y regresó a «Mis tareas» | Aprobado | Ninguno reportado | No aplica | `CP-08_edicion_tarea.png` |
| CP-09 | Firestore / tareas | Marcar tarea como completada | Pulsar checkbox de la tarea editada | Actualizar estado a completada | La tarea cambió a completada al pulsar checkbox | Aprobado | Ninguno reportado | No aplica | `CP-09_tarea_completada.png` |
| CP-10 | Firestore / tareas | Eliminar tarea con confirmación | Pulsar papelera y confirmar «Eliminar» | Solicitar confirmación y retirar tarea de la lista | Se mostró confirmación; tras aceptarla, desapareció de la lista | Aprobado | Ninguno reportado | No aplica | `CP-10_confirmacion_eliminacion.png`; `CP-10_tarea_eliminada.png` |

## Pruebas automatizadas y análisis estático

- **Ejecución inicial de `flutter test`:** 3 pruebas aprobadas y 1 fallida. La prueba de widget intentaba guardar una tarea sin completar la descripción obligatoria.
- **Corrección verificada:** se agregó una descripción válida a `test/widget/tarea_form_test.dart`. Segunda ejecución de `flutter test`: **4 pruebas aprobadas** (`All tests passed!`).
- **`flutter analyze`:** `No issues found! (ran in 1.7s)`.
- **Incidencia vinculada:** `INC-001`, error en el código de prueba, corregido y verificado. Registrar detalles y commit en `04-registro-incidencias.md`.
- **Evidencia automatizada:** agregar capturas o salidas de consola a `docs/evidencias/pruebas-y-analisis/`.
