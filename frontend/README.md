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

## Pruebas manuales paso a paso

1. Inicia el entorno de desarrollo con `npm run dev` y abre el enlace que entrega Vite.
2. Verifica que el boton "Buscar" aparezca inactivo al cargar la pantalla inicial.
3. Selecciona un tipo de documento y digita un numero con menos de 8 caracteres para confirmar que el campo se marca como invalido y el boton sigue deshabilitado.
4. Completa un numero valido (entre 8 y 11 digitos) y comprueba que el texto se formatea con separadores de miles y el boton se habilita.
5. Presiona "Buscar" con una combinacion registrada en `src/data/clients.json` y valida que la pantalla de resumen muestre todos los datos almacenados.
6. Usa el boton "Volver" para regresar al formulario y confirma que conserva la ultima consulta.
7. Repite la busqueda con una combinacion no existente para revisar que se muestre el mensaje de alerta y permanezcas en la pantalla de busqueda.

## Personalizacion

- Agrega o edita clientes en `src/data/clients.json` respetando los campos existentes.
