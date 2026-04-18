# app6amicrosoft

Aplicacion movil Flutter conectada a una API PHP para consultar tablas del sistema.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Creacion del proyecto

- Frontend: aplicacion creada en Flutter (Dart) con estructura por capas para pantallas, widgets, modelos y repositorio de datos.
- Backend: API en PHP para exponer datos de tablas como sexo, persona, direccion, telefono y estado civil.
- Integracion: la app consume la API por parametro de tabla y renderiza los resultados en cada seccion.

## API PHP (links)

- Base API (VPS): http://134.209.126.53/phpapi/api.php
- Endpoint Sexo: http://134.209.126.53/phpapi/api.php?table=sexo
- Endpoint Persona: http://134.209.126.53/phpapi/api.php?table=persona
- Endpoint Direccion: http://134.209.126.53/phpapi/api.php?table=direccion
- Endpoint Telefono: http://134.209.126.53/phpapi/api.php?table=telefono
- Endpoint Estado Civil: http://134.209.126.53/phpapi/api.php?table=estadocivil

Referencias adicionales:

- https://educaysoft.org/whatsapp6a/app/controllers/SexoController.php?action=api
- https://educaysoft.org/whatsapp6a/app/controllers/PersonaController.php?action=api
- https://educaysoft.org/whatsapp6a/app/controllers/DireccionController.php?action=api
- https://educaysoft.org/whatsapp6a/app/controllers/TelefonoController.php?action=api
- https://educaysoft.org/whatsapp6a/app/controllers/EstadocivilController.php?action=api

## Contribuciones

| Integrante | Tabla modificada |
|---|---|
| Tadeo Ballesteros | Personas — diseño con avatar de iniciales y chips de color |
| Adrian Guanoluisa | Sexo — mejora visual de tarjetas, iconografia y estilo moderno |