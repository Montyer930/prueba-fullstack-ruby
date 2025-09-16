# frozen_string_literal: true

require 'sinatra'
require 'json'

CLIENTS = [
  {
    tipo: 'C',
    numero: '55588899',
    primer_nombre: 'Pedro',
    segundo_nombre: 'Andrés',
    primer_apellido: 'Ramírez',
    segundo_apellido: 'Quintero',
    telefono: '3005558899',
    direccion: 'Avenida 10 #20-30',
    ciudad: 'Cali'
  },
  {
    tipo: 'P',
    numero: 'PX1234567',
    primer_nombre: 'Laura',
    segundo_nombre: 'María',
    primer_apellido: 'Suárez',
    segundo_apellido: 'Valencia',
    telefono: '3129988776',
    direccion: 'Calle 8 #12-45',
    ciudad: 'Barranquilla'
  }
].freeze

before do
  content_type :json
end

helpers do
  def fetch_client(tipo, numero)
    CLIENTS.find { |cliente| cliente[:tipo] == tipo && cliente[:numero] == numero }
  end
end

get '/cliente' do
  tipo = params['tipo']&.strip
  numero = params['numero']&.strip

  if tipo.to_s.empty? || numero.to_s.empty?
    status 400
    return({ error: 'Tipo y número de documento son obligatorios' }.to_json)
  end

  unless %w[C P].include?(tipo)
    status 400
    return({ error: 'Tipo de documento inválido. Solo se permiten C o P' }.to_json)
  end

  cliente = fetch_client(tipo, numero)

  if cliente
    status 200
    cliente.to_json
  else
    status 404
    { error: 'Cliente no encontrado' }.to_json
  end
rescue StandardError => e
  status 500
  { error: 'Error interno del servidor', detalle: e.message }.to_json
end
