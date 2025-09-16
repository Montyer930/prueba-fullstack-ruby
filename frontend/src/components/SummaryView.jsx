import { formatDocumentNumber } from '../utils/formatters.js';

const DOCUMENT_LABELS = {
  CC: 'Cedula de ciudadania',
  PP: 'Pasaporte',
};

function SummaryView({ client, onBack }) {
  if (!client) {
    return null;
  }

  const {
    documentType,
    documentNumber,
    firstName,
    lastName,
    email,
    phone,
    address,
    city,
  } = client;

  return (
    <div className="min-vh-100 d-flex align-items-center justify-content-center px-3">
      <div className="card shadow-sm w-100" style={{ maxWidth: '640px' }}>
        <div className="card-body p-4">
          <div className="d-flex justify-content-between align-items-center mb-4">
            <h1 className="h4 mb-0">Resumen del cliente</h1>
            <span className="badge text-bg-light text-primary border border-primary fw-semibold">
              {DOCUMENT_LABELS[documentType] ?? documentType}
            </span>
          </div>

          <div className="row g-3 mb-4">
            <div className="col-md-6">
              <div className="text-muted text-uppercase small">Numero de documento</div>
              <div className="fw-semibold">{formatDocumentNumber(documentNumber)}</div>
            </div>
            <div className="col-md-6">
              <div className="text-muted text-uppercase small">Nombre completo</div>
              <div className="fw-semibold">{firstName} {lastName}</div>
            </div>
            <div className="col-md-6">
              <div className="text-muted text-uppercase small">Correo</div>
              <div className="fw-semibold">{email}</div>
            </div>
            <div className="col-md-6">
              <div className="text-muted text-uppercase small">Telefono</div>
              <div className="fw-semibold">{phone}</div>
            </div>
            <div className="col-12">
              <div className="text-muted text-uppercase small">Direccion</div>
              <div className="fw-semibold">{address}</div>
            </div>
            <div className="col-md-6">
              <div className="text-muted text-uppercase small">Ciudad</div>
              <div className="fw-semibold">{city}</div>
            </div>
          </div>

          <button type="button" className="btn btn-outline-primary w-100" onClick={onBack}>
            Volver
          </button>
        </div>
      </div>
    </div>
  );
}

export default SummaryView;
