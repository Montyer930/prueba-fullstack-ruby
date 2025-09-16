# Frontend - Consulta de clientes

Aplicacion en React que consulta informacion basica de clientes consumiendo el servicio Sinatra del backend y presenta un resumen con Bootstrap.

## Requisitos

- Node.js 18 o superior
- npm 9 o superior

## Variables de entorno

Crea un archivo `.env` en la carpeta `frontend` si deseas personalizar la URL del backend:

```
VITE_API_URL=http://localhost:4567
```

Si no defines la variable, la aplicacion usara `http://localhost:4567` por defecto.

## Ejecucion en modo desarrollo

```bash
cd frontend
npm install
npm run dev
```

Vite abrira la aplicacion en `http://localhost:5173/` (puedes copiar el enlace que aparezca en la terminal).

## Estructura destacada

- `src/components/SearchForm.jsx`: Pantalla de busqueda con validaciones y formato del numero de documento.
- `src/components/SummaryView.jsx`: Pantalla de resumen con los datos del cliente y boton para volver.
- `src/utils/api.js`: Funciones para consumir el endpoint `GET /cliente` del backend.
- `src/utils/formatters.js`: Utilidad para aplicar separadores de miles.

## Pruebas manuales paso a paso

1. Asegurate de que el backend este activo en `http://localhost:4567` (o el valor de `VITE_API_URL`).
2. Inicia el entorno de desarrollo con `npm run dev` y abre el enlace que entrega Vite.
3. Verifica que el boton "Buscar" aparezca inactivo al cargar la pantalla inicial.
4. Selecciona un tipo de documento y digita un numero con menos de 8 caracteres para confirmar que el campo se marca como invalido y el boton sigue deshabilitado.
5. Completa un numero valido (entre 8 y 11 digitos) y comprueba que el texto se formatea con separadores de miles y el boton se habilita.
6. Presiona "Buscar" con una combinacion registrada en el backend y valida que la pantalla de resumen muestre los datos recibidos.
7. Usa el boton "Volver" para regresar al formulario y confirma que conserva la ultima consulta.
8. Repite la busqueda con una combinacion no existente para revisar que se muestre el mensaje de alerta entregado por la API.
