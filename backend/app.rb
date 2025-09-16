# frozen_string_literal: true

require 'sinatra'
require 'json'

CLIENTS = [
  {
    document_type: 'CC',
    document_number: '1012345678',
    first_name: 'Laura',
    last_name: 'Perez',
    email: 'laura.perez@example.com',
    phone: '6014567890',
    address: 'Calle 123 #45-67',
    city: 'barrancabermeja'
  },
    {
    document_type: 'CC',
    document_number: '1018491737',
    first_name: 'yerson',
    last_name: 'Montes',
    email: 'yerson.montes@example.com',
    phone: '3197318001',
    address: 'Calle 123 #45-67',
    city: 'Bogota'
  },
  {
    document_type: 'pp',
    document_number: '9256781234',
    first_name: 'Andres',
    last_name: 'Rodriguez',
    email: 'andres.rodriguez@example.com',
    phone: '3004567788',
    address: 'Carrera 7 #89-10',
    city: 'Medellin'
  },
  {
    document_type: 'PP',
    document_number: '4567890123',
    first_name: 'Sara',
    last_name: 'Lopez',
    email: 'sara.lopez@example.com',
    phone: '5719876543',
    address: 'Avenida Central 99',
    city: 'Cartagena'
  }
].freeze

ALLOWED_DOCUMENT_TYPES = CLIENTS.map { |client| client[:document_type] }.uniq.freeze

set :bind, ENV.fetch('APP_HOST', '0.0.0.0')
set :port, ENV.fetch('APP_PORT', 4567)

before do
  content_type :json
  response.headers['Access-Control-Allow-Origin'] = ENV.fetch('ALLOWED_ORIGINS', '*')
  response.headers['Access-Control-Allow-Methods'] = 'GET,OPTIONS'
  response.headers['Access-Control-Allow-Headers'] = 'Content-Type,Accept'
end

helpers do
  def normalize_document_type(value)
    value.to_s.strip.upcase
  end

  def fetch_client(document_type, document_number)
    type = normalize_document_type(document_type)
    number = document_number.to_s.strip
    CLIENTS.find do |client|
      client[:document_type] == type && client[:document_number] == number
    end
  end

  def client_payload(client)
    {
      documentType: client[:document_type],
      documentNumber: client[:document_number],
      firstName: client[:first_name],
      lastName: client[:last_name],
      email: client[:email],
      phone: client[:phone],
      address: client[:address],
      city: client[:city]
    }
  end

  def extract_document_params(params)
    type = params['tipo'] || params['documentType']
    number = params['numero'] || params['documentNumber']
    [type&.strip, number&.strip]
  end
end

get '/cliente' do
  tipo, numero = extract_document_params(params)

  if tipo.to_s.empty? || numero.to_s.empty?
    status 400
    return({ error: 'Tipo y número de documento son obligatorios' }.to_json)
  end

  normalized_type = normalize_document_type(tipo)

  unless ALLOWED_DOCUMENT_TYPES.include?(normalized_type)
    status 400
    return({ error: "Tipo de documento inválido. Solo se permiten: #{ALLOWED_DOCUMENT_TYPES.join(', ')}" }.to_json)
  end

  cliente = fetch_client(normalized_type, numero)

  if cliente
    status 200
    client_payload(cliente).to_json
  else
    status 404
    { error: 'Cliente no encontrado' }.to_json
  end
rescue StandardError => e
  status 500
  { error: 'Error interno del servidor', detalle: e.message }.to_json
end

options '*' do
  204
end

get '/clientes' do
  CLIENTS.map { |client| client_payload(client) }.to_json
rescue StandardError => e
  status 500
  { error: 'Error interno del servidor', detalle: e.message }.to_json
end

get '/clientes/:document_type/:document_number' do
  tipo = params['document_type']
  numero = params['document_number']

  cliente = fetch_client(tipo, numero)

  if cliente
    status 200
    client_payload(cliente).to_json
  else
    status 404
    { error: 'Cliente no encontrado' }.to_json
  end
rescue StandardError => e
  status 500
  { error: 'Error interno del servidor', detalle: e.message }.to_json
end
