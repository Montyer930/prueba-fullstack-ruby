const API_BASE_URL = import.meta.env.VITE_API_URL ?? 'http://localhost:4567';
const GENERIC_ERROR_MESSAGE = 'No pudimos completar la consulta. Intenta nuevamente en unos minutos.';

async function safeParseJson(response) {
  try {
    return await response.json();
  } catch (error) {
    return null;
  }
}

export async function fetchClient({ documentType, documentNumber }) {
  const url = new URL('/cliente', API_BASE_URL);
  url.searchParams.set('documentType', documentType);
  url.searchParams.set('documentNumber', documentNumber);

  let response;

  try {
    response = await fetch(url.toString(), {
      headers: {
        Accept: 'application/json',
      },
    });
  } catch (error) {
    throw new Error('No se pudo conectar con el servicio. Verifica que el backend esté en ejecución.');
  }

  const payload = await safeParseJson(response);
  const errorMessage = payload?.error || GENERIC_ERROR_MESSAGE;

  if (response.ok) {
    return {
      status: response.status,
      data: payload,
      errorMessage: null,
    };
  }

  if (response.status === 404) {
    return {
      status: response.status,
      data: null,
      errorMessage,
    };
  }

  throw new Error(errorMessage);
}
