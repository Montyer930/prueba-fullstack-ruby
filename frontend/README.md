# Frontend - Consulta de clientes

Aplicacion en React que consulta informacion basica de clientes almacenada en un archivo JSON y muestra un resumen con Bootstrap.

## Requisitos

- Node.js 18 o superior
- npm 9 o superior

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
- `src/data/clients.json`: Fuente estatica de informacion de clientes.
- `src/utils/formatters.js`: Utilidad para aplicar separadores de miles.

## Personalizacion

- Agrega o edita clientes en `src/data/clients.json` respetando los campos existentes.
- Ajusta estilos globales en `src/main.css` o agrega clases auxiliares en los componentes.
