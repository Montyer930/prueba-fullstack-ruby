# frozen_string_literal: true

require 'sinatra'
require 'json'

set :bind, '0.0.0.0'
set :show_exceptions, false
set :productos, []
set :productos_secuencia, 0

before do
  content_type :json
end

helpers do
  def productos
    settings.productos
  end

  def siguiente_id
    settings.productos_secuencia = settings.productos_secuencia + 1
  end

  def encontrar_producto(id)
    productos.find { |producto| producto[:id] == id }
  end

  def parsear_json
    request.body.rewind
    cuerpo = request.body.read
    return {} if cuerpo.strip.empty?

    JSON.parse(cuerpo)
  rescue JSON::ParserError
    halt 400, { error: 'JSON inválido' }.to_json
  end

  def validar_payload!(payload, parcial: false)
    unless payload.is_a?(Hash)
      halt 400, { error: 'El cuerpo debe ser un objeto JSON' }.to_json
    end

    datos = payload.transform_keys { |clave| clave.to_sym }

    unless parcial
      faltantes = %i[nombre precio stock].reject { |campo| datos.key?(campo) }
      halt 400, { error: 'Faltan campos obligatorios', campos: faltantes }.to_json if faltantes.any?
    end

    if datos.key?(:precio)
      datos[:precio] = Float(datos[:precio])
    end

    if datos.key?(:stock)
      datos[:stock] = Integer(datos[:stock])
    end

    datos
  rescue ArgumentError, TypeError => e
    halt 400, { error: e.message }.to_json
  end
end

get '/productos' do
  productos.to_json
end

get '/productos/:id' do
  producto = encontrar_producto(params[:id].to_i)
  halt 404, { error: 'Producto no encontrado' }.to_json unless producto

  producto.to_json
end

post '/productos' do
  payload = parsear_json
  datos = validar_payload!(payload)

  producto = {
    id: siguiente_id,
    nombre: datos[:nombre],
    precio: datos[:precio],
    stock: datos[:stock]
  }

  productos << producto

  status 201
  producto.to_json
end

put '/productos/:id' do
  producto = encontrar_producto(params[:id].to_i)
  halt 404, { error: 'Producto no encontrado' }.to_json unless producto

  payload = parsear_json
  datos = validar_payload!(payload, parcial: true)

  producto[:nombre] = datos[:nombre] if datos.key?(:nombre)
  producto[:precio] = datos[:precio] if datos.key?(:precio)
  producto[:stock] = datos[:stock] if datos.key?(:stock)

  producto.to_json
end

delete '/productos/:id' do
  producto = encontrar_producto(params[:id].to_i)
  halt 404, { error: 'Producto no encontrado' }.to_json unless producto

  productos.delete(producto)
  status 204
  body nil
end

error do
  status 500
  { error: 'Error interno del servidor' }.to_json
end

not_found do
  { error: 'Recurso no encontrado' }.to_json
end
