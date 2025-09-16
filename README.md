# prueba-fullstack-ruby
Prueba técnica Fullstack con Ruby (Backend y Frontend)

## Visión general
- **Backend**: API REST en Ruby con Sinatra que expone información de clientes.
- **Frontend**: Aplicación React/Vite que consume los datos y presenta la interfaz.
- **Ejercicios**: Scripts y microservicios Ruby resueltos como parte de la prueba.

## Estructura del proyecto

```
prueba-fullstack-ruby/
|-- backend/
|   |-- app.rb
|   |-- Gemfile
|   |-- Gemfile.lock
|   `-- README.md
|-- ejercicios/
|   |-- datos.txt
|   |-- ejercicio1.rb
|   |-- ejercicio2.rb
|   |-- ejercicio3.rb
|   |-- ejercicio4/
|   |   |-- app.rb
|   |   |-- Gemfile
|   |   `-- Gemfile.lock
|   `-- README.md
|-- frontend/
|   |-- index.html
|   |-- package.json
|   |-- package-lock.json
|   |-- src/
|   |-- vite.config.js
|   |-- README.md
|   `-- node_modules/
|-- LICENSE
`-- README.md
```

## Requisitos previos
- Ruby 3.x (probado con Ruby 3.1.2p20) y Bundler instalado globalmente.
- Node.js 18+ y npm 9+ para el frontend.
- cURL o Postman para probar servicios HTTP.

## Instalación
- Clona el repositorio y posiciona la terminal en `prueba-fullstack-ruby/`.
- Backend: `cd backend && bundle install`.
- Frontend: `cd frontend && npm install`.
- Ejercicio 4: `cd ejercicios/ejercicio4 && bundle install`.

## Ejecución rápida
- Backend: `cd backend && bundle exec ruby app.rb` (Sinatra en `http://localhost:4567`).
- Frontend: `cd frontend && npm run dev` (en `http://localhost:5173`).
- Ejercicios CLI: ejecuta los scripts desde `ejercicios/` como se describe en su README.

## Pruebas y validaciones
- Backend: consultas manuales con `curl` o Postman (ver README específico).
- Frontend: guía de pruebas manuales disponible en `frontend/README.md`.

## Documentación adicional
- `backend/README.md`: detalles del servicio Sinatra, endpoints y ejemplos.
- `frontend/README.md`: guía de ejecución, componentes clave y pruebas manuales.
- `ejercicios/README.md`: instrucciones para cada ejercicio Ruby.
