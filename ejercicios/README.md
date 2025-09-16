# Ejercicios Ruby

> Requerimientos generales: Ruby 3.x y Bundler instalado.

## Ejercicio 1 — Número más repetido

1. Posiciónate en `ejercicios/`.
2. Ejecuta el script pasando los números como argumentos:

```bash
ruby ejercicio1.rb 1 2 3 2 4 2 5
```

3. El script imprime el número que más se repite; ante un empate devuelve el menor. Si el arreglo queda vacío o algún valor no es entero, mostrará un mensaje de error y finalizará.

## Ejercicio 2 — Clase `Empleado`

1. Desde `ejercicios/`, ejecuta el script con nombre, edad y salario:

```bash
ruby ejercicio2.rb "Ana Pérez" 30 3500
```

2. El programa crea un `Empleado`, calcula el impuesto (10% cuando el salario es mayor a 3000, de lo contrario 5%) y muestra el resultado formateado con dos decimales.

## Ejercicio 3 — Conteo de líneas

1. Asegúrate de tener `datos.txt` en el directorio `ejercicios/` o indica una ruta personalizada.
2. Ejecuta:

```bash
ruby ejercicio3.rb
```

   - Opcional: `ruby ejercicio3.rb ruta/al/datos.txt ruta/al/resultado.txt`

3. El script cuenta las líneas del archivo indicado, escribe el resultado en `resultado.txt` (o en el archivo de salida entregado) e imprime en consola la ruta del archivo generado.

## Ejercicio 4 — API REST con Sinatra

1. Instala dependencias y levanta el servidor:

```bash
cd ejercicio4
bundle install
bundle exec ruby app.rb
```

2. La API queda disponible en `http://localhost:4567`. Los datos se almacenan en memoria.
3. Endpoints disponibles:
   - `GET /productos` — lista todos los productos.
   - `GET /productos/:id` — retorna el producto indicado o 404.
   - `POST /productos` — crea un producto (body JSON con `nombre`, `precio`, `stock`).
   - `PUT /productos/:id` — actualiza parcialmente los campos enviados.
   - `DELETE /productos/:id` — elimina el producto.

### Ejemplos con `curl`

```bash
# Listar productos
curl -s http://localhost:4567/productos

# Crear producto
curl -s -H 'Content-Type: application/json' -d '{"nombre":"Laptop","precio":1200.5,"stock":10}' http://localhost:4567/productos

# Obtener producto con id 1
curl -s http://localhost:4567/productos/1

# Actualizar precio y stock
curl -s -X PUT -H 'Content-Type: application/json' -d '{"precio":1500,"stock":8}' http://localhost:4567/productos/1

# Eliminar producto
curl -s -X DELETE http://localhost:4567/productos/1
```

### Configuración sugerida en Postman

1. Crea una colección y define una variable `baseUrl` con el valor `http://localhost:4567`.
2. Agrega las siguientes solicitudes usando la variable para mantener consistencia:

   **GET /productos**
   - Método: GET
   - URL: `localhost:4567/productos`
   - Body: ninguno

   **POST /productos**
   - Método: POST
   - URL: `localhost:4567/productos`
   - Headers: `Content-Type: application/json`
   - Body (raw/JSON): `{"nombre":"Laptop","precio":1200.5,"stock":10}`

   **GET /productos/1**
   - Método: GET
   - URL: `localhost:4567/productos/1`
   - Body: ninguno

   **PUT /productos/1**
   - Método: PUT
   - URL: `localhost:4567/productos/1`
   - Headers: `Content-Type: application/json`
   - Body (raw/JSON): `{"precio":1500,"stock":8}`

   **DELETE /productos/1**
   - Método: DELETE
   - URL: `localhost:4567/productos/1`
   - Body: ninguno

Con esta colección podrás ejecutar y validar rápidamente todas las operaciones CRUD.
