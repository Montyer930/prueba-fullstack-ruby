export function formatDocumentNumber(digits) {
  if (!digits) {
    return '';
  }

  return digits.replace(/\D/g, '').replace(/\B(?=(\d{3})+(?!\d))/g, '.');
}
