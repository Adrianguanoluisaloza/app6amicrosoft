# App6AMicrosoft

Aplicacion movil desarrollada en Flutter y conectada a una API PHP para consultar y mostrar tablas del sistema.

## Descripcion del proyecto

Este proyecto permite visualizar informacion de las tablas sexo, persona, direccion, telefono y estado civil desde una interfaz movil moderna.

## Creacion del proyecto

- Frontend: aplicacion creada en Flutter (Dart), organizada por capas en modelos, repositorio, pantallas y widgets.
- Backend: API desarrollada en PHP para exponer los datos de cada tabla mediante endpoints.
- Integracion: la app consume la API por parametro table y renderiza los resultados por modulo.

## API PHP

- Base API (VPS): http://134.209.126.53/phpapi/api.php
- Endpoint Sexo: http://134.209.126.53/phpapi/api.php?table=sexo
- Endpoint Persona: http://134.209.126.53/phpapi.php?table=persona
- Endpoint Direccion: http://134.209.126.53/phpapi.php?table=direccion
- Endpoint Telefono: http://134.209.126.53/phpapi.php?table=telefono
- Endpoint Estado Civil: http://134.209.126.53/phpapi.php?table=estadocivil

## Contribuciones

| Integrante | Tabla modificada |
|---|---|
| Tadeo Ballesteros | Personas — diseño con avatar de iniciales y chips de color |
| Adrian Guanoluisa | Sexo — mejora visual de tarjetas, iconografia y estilo moderno |
| David Corozo | Estado civil — modificación de la tabla a color verde |
| Franco Herrera Alex | Teléfono — interfaz minimalista en color verde |
