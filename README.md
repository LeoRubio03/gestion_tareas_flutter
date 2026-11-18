# Gestión de Tareas Flutter

## Descripción del proyecto

Gestión de Tareas Flutter es una aplicación desarrollada con Flutter y Dart que permite a los usuarios administrar sus tareas personales mediante una interfaz sencilla.

La aplicación utiliza Firebase Authentication para el registro e inicio de sesión de usuarios y Cloud Firestore para almacenar las tareas en la nube.

Este proyecto fue desarrollado como parte de la práctica de integración y pruebas de la Semana 16.

## Tecnologías utilizadas

- Flutter y Dart
- Firebase Authentication
- Cloud Firestore
- Visual Studio Code
- Git y GitHub

## Funcionalidades principales

- Registro de nuevos usuarios.
- Inicio y cierre de sesión.
- Creación de tareas con título y descripción.
- Visualización de tareas ordenadas por fecha de creación.
- Edición de tareas existentes.
- Marcado de tareas como completadas.
- Eliminación de tareas.
- Validación de campos obligatorios.
- Validación para evitar títulos duplicados.


## Requisitos para ejecutar el proyecto

- Tener instalado Flutter SDK.
- Tener instalado Visual Studio Code o Android Studio.
- Contar con un emulador o dispositivo compatible.
- Tener acceso a un proyecto Firebase configurado.

## Instalación y ejecución

1. Clonar el repositorio:

```bash
git clone https://github.com/LeoRubio03/gestion_tareas_flutter.git
```

2. Acceder a la carpeta:

```bash
cd gestion_tareas_flutter
```

3. Instalar las dependencias:

```bash
flutter pub get
```

4. Configurar Firebase para el entorno correspondiente mediante FlutterFire CLI.

5. Ejecutar la aplicación:

```bash
flutter run
```

## Pruebas del proyecto

Se implementaron pruebas unitarias y pruebas de widgets para comprobar el funcionamiento de componentes de la aplicación.

Para ejecutar las pruebas automatizadas:

```bash
flutter test
```

Para analizar el código:

```bash
flutter analyze
```

También se realizaron pruebas manuales de las funcionalidades principales.

## Registro de incidencias

Durante el desarrollo y las pruebas se identificaron y corrigieron tres incidencias:

| ID | Incidencia | Estado |
|---|---|---|
| INC-01 | Las tareas no se mostraban en orden cronológico | Resuelto |
| INC-02 | Se permitían descripciones vacías | Resuelto |
| INC-03 | Se permitían títulos duplicados | Resuelto |

## Evidencias

Las evidencias del proyecto se encuentran en la carpeta `docs/evidencias/`.

Incluyen capturas de Firebase Authentication y Cloud Firestore, así como las evidencias adicionales de las pruebas del proyecto.

## Control de versiones

El proyecto utiliza Git y GitHub para registrar los cambios realizados durante su desarrollo.

Se trabajó con la rama principal `main` y la rama `semana16-integracion` para la integración y las pruebas.

## Repositorio

https://github.com/LeoRubio03/gestion_tareas_flutter

## Conclusión

El desarrollo de esta aplicación permitió poner en práctica la integración de Flutter con Firebase, la administración de datos, las pruebas de software y el control de versiones mediante GitHub.

La identificación y corrección de incidencias contribuyó a mejorar el funcionamiento y la confiabilidad de la aplicación.