require 'sinatra'
require 'json'

# Información quemada
CLIENTES = [
  {
    tipo: 'C',
    numero: '12345678',
    primer_nombre: 'Juan',
    segundo_nombre: 'Carlos',
    primer_apellido: 'Pérez',
    segundo_apellido: 'Gómez',
    telefono: '3101234567',
    direccion: 'Calle 123 #45-67',
    ciudad: 'Bogotá'
  },
  {
    tipo: 'P',
    numero: '987654321',
    primer_nombre: 'Ana',
    segundo_nombre: 'Lucía',
    primer_apellido: 'Martínez',
    segundo_apellido: 'Rodríguez',
    telefono: '3117654321',
    direccion: 'Carrera 45 #67-89',
    ciudad: 'Medellín'
  }
]

get '/cliente' do
  content_type :json

  begin
    tipo = params['tipo']
    numero = params['numero']

    # Validaciones de entrada
    if tipo.nil? || numero.nil?
      status 400
      return { error: 'Tipo y número de documento son obligatorios' }.to_json
    end

    unless ['C', 'P'].include?(tipo)
      status 400
      return { error: 'Tipo de documento inválido. Solo se permiten C o P' }.to_json
    end

    cliente = CLIENTES.find { |c| c[:tipo] == tipo && c[:numero] == numero }

    if cliente
      status 200
      return cliente.to_json
    else
      status 404
      return { error: 'Cliente no encontrado' }.to_json
    end
  rescue => e
    status 500
    return { error: 'Error interno del servidor', detalle: e.message }.to_json
  end
end
