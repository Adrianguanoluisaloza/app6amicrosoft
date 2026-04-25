# App6AMicrosoft

Aplicacion movil desarrollada en Flutter y conectada a una API PHP para consultar y mostrar tablas del sistema.

## Descripcion del proyecto

Este proyecto permite visualizar informacion de las tablas sexo, persona, direccion, telefono y estado civil desde una interfaz movil moderna.

## Creacion del proyecto

- Frontend: aplicacion creada en Flutter (Dart), organizada por capas en modelos, repositorio, pantallas y widgets.
- Backend: API desarrollada en PHP para exponer los datos de cada tabla mediante endpoints.
- Integracion: la app consume la API por parametro table y renderiza los resultados por modulo.

## API PHP

- Repositorio API PHP: [OCULTO POR SEGURIDAD]
- Infraestructura de despliegue: VPS privado
- Base API: [OCULTO POR SEGURIDAD]
- Endpoint Sexo: [OCULTO POR SEGURIDAD]
- Endpoint Persona: [OCULTO POR SEGURIDAD]
- Endpoint Direccion: [OCULTO POR SEGURIDAD]
- Endpoint Telefono: [OCULTO POR SEGURIDAD]
- Endpoint Estado Civil: [OCULTO POR SEGURIDAD]

Nota: las direcciones reales del backend se manejan de forma privada y no se publican en documentación pública.

## Nota didáctica sobre `api_repository.dart`

Por solicitud del profesor, el consumo de API usado en ejecución se movió directamente a `lib/main.dart` para mostrar una estructura más básica en clase.

El archivo `lib/data/api_repository.dart` permanece en el repositorio como referencia de buenas prácticas (separación de responsabilidades y reutilización), pero está desconectado del flujo runtime de la app.

No se requieren cambios en el backend PHP: la app sigue usando los mismos endpoints (`sexo`, `persona`, `telefono`, `direccion`, `estadocivil`) y el mismo comportamiento para el usuario final.

## Contribuciones

| Integrante | Tabla modificada |
|---|---|
| Tadeo Ballesteros | Personas — diseño con avatar de iniciales y chips de color |
| Adrian Guanoluisa | Sexo — mejora visual de tarjetas, iconografia y estilo moderno |
| David Corozo | Estado civil — modificación de la tabla a color verde |
| Franco Herrera Alex | Teléfono — interfaz minimalista en color verde |
| Rocio Alvarado | Direccion — modificación de colores en la tabla |

## Cambios Recientes

- **Rocio Alvarado**: Modificación del color de la tabla de direcciones a verde para mantener consistencia con las otras tablas. Eliminación de tokens de acceso accidentales en archivos de prueba para seguridad.
