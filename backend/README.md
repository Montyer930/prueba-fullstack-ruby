# prueba-fullstack-ruby
Prueba técnica Fullstack con Ruby (Backend y Frontend)

## Servicio REST del backend
El backend expone un endpoint `GET /cliente` implementado con Sinatra. El servicio
recibe dos parámetros obligatorios: `tipo` (solo valores `C` ó `P`) y `numero`.
Según la combinación recibida, responde con la información básica del cliente:

- Primer y segundo nombre
- Primer y segundo apellido
- Teléfono
- Dirección
- Ciudad de residencia

El servicio devuelve códigos HTTP adecuados para cada escenario: `200` cuando el
cliente existe, `400` si los parámetros faltan o son inválidos, `404` si el
cliente no está registrado y `500` ante errores inesperados.

## Cómo ejecutar el backend
1. Instala las dependencias desde la carpeta `backend`:
   ```bash
   bundle install
   ```
2. Inicia el servidor Sinatra:
   ```bash
   bundle exec ruby app.rb
   ```
3. Realiza una consulta con `curl` (ejemplo cliente tipo C):
   ```bash
   curl "http://localhost:4567/cliente?tipo=C&numero=55588899"
   ```

Actualiza el número de documento en la URL para consultar el cliente de tipo
`P` (`PX1234567`).

### Pruebas con Postman
- **Método**: `GET`
- **URL**: `http://localhost:4567/cliente`
- **Parámetros (Params)**:
  - `tipo`: `C`
  - `numero`: `55588899`

Duplica la petición en Postman para probar el documento del cliente tipo `P`
(`PX1234567`). Cambia el valor de `tipo` a `P` y el de `numero` al documento
correspondiente. Postman mostrará las respuestas JSON y los códigos de estado
HTTP (`200`, `400`, `404` o `500`) según la combinación enviada.
