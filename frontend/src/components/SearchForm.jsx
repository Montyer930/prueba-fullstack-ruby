import { useEffect, useState } from 'react';
import { formatDocumentNumber } from '../utils/formatters.js';

const DOCUMENT_OPTIONS = [
  { value: 'CC', label: 'Cedula de ciudadania' },
  { value: 'PP', label: 'Pasaporte' },
];

function SearchForm({ onSearch, feedbackMessage, initialQuery, isLoading }) {
  const [documentType, setDocumentType] = useState(initialQuery?.documentType ?? '');
  const [documentNumber, setDocumentNumber] = useState(initialQuery?.documentNumber ?? '');
  const [numberTouched, setNumberTouched] = useState(false);

  useEffect(() => {
    setDocumentType(initialQuery?.documentType ?? '');
    setDocumentNumber(initialQuery?.documentNumber ?? '');
    setNumberTouched(false);
  }, [initialQuery?.documentType, initialQuery?.documentNumber]);

  const isNumberValid = documentNumber.length >= 8 && documentNumber.length <= 11;
  const isFormValid = documentType !== '' && isNumberValid;
  const isButtonEnabled = isFormValid && !isLoading;

  const handleNumberChange = (event) => {
    const digitsOnly = event.target.value.replace(/\D/g, '');
    setDocumentNumber(digitsOnly.slice(0, 11));
  };

  const handleSubmit = (event) => {
    event.preventDefault();
    setNumberTouched(true);

    if (!isFormValid || isLoading) {
      return;
    }

    onSearch({
      documentType,
      documentNumber,
    });
  };

  const numberValidationMessage = !isNumberValid && numberTouched
    ? 'Ingresa un numero de documento entre 8 y 11 digitos.'
    : '';

  const formattedNumber = formatDocumentNumber(documentNumber);
  const buttonStyles = {
    backgroundColor: isButtonEnabled ? '#1652f0' : '#cdd3e1',
    borderColor: 'transparent',
    color: isButtonEnabled ? '#fff' : '#6c7686',
  };

  return (
    <div className="min-vh-100 d-flex align-items-center justify-content-center px-3">
      <div className="card shadow-sm w-100" style={{ maxWidth: '460px' }}>
        <div className="card-body p-4">
          <h1 className="h4 text-center mb-4">Consulta de cliente</h1>
          <form onSubmit={handleSubmit} noValidate>
            <div className="mb-3">
              <label htmlFor="documentType" className="form-label">Tipo de documento</label>
              <select
                id="documentType"
                className="form-select"
                value={documentType}
                onChange={(event) => setDocumentType(event.target.value)}
              >
                <option value="" disabled>Selecciona una opcion</option>
                {DOCUMENT_OPTIONS.map((option) => (
                  <option key={option.value} value={option.value}>
                    {option.label}
                  </option>
                ))}
              </select>
            </div>

            <div className="mb-2">
              <label htmlFor="documentNumber" className="form-label">Numero de documento</label>
              <input
                id="documentNumber"
                className={`form-control${numberValidationMessage ? ' is-invalid' : ''}`}
                inputMode="numeric"
                pattern="[0-9]*"
                value={formattedNumber}
                onChange={handleNumberChange}
                onBlur={() => setNumberTouched(true)}
                placeholder="Ingresa el numero"
              />
              {numberValidationMessage && (
                <div className="invalid-feedback">
                  {numberValidationMessage}
                </div>
              )}
            </div>

            <div className="form-text mb-3 text-muted">
              Solo se permiten numeros. Incluye entre 8 y 11 digitos.
            </div>

            {feedbackMessage && (
              <div className="alert alert-warning py-2" role="alert">
                {feedbackMessage}
              </div>
            )}

            <button
              type="submit"
              className="btn w-100 fw-semibold"
              disabled={!isButtonEnabled}
              style={buttonStyles}
            >
              {isLoading ? 'Buscando...' : 'Buscar'}
            </button>
          </form>
        </div>
      </div>
    </div>
  );
}

export default SearchForm;
