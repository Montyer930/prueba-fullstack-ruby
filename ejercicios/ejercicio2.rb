# frozen_string_literal: true

# Representa un empleado con reglas sencillas para calcular el impuesto.
class Empleado
  attr_reader :nombre, :edad, :salario

  def initialize(nombre:, edad:, salario:)
    @nombre = nombre
    @edad = edad
    @salario = salario
  end

  # Calcula el impuesto del empleado según su salario bruto.
  def impuesto
    tasa = salario > 3000 ? 0.10 : 0.05
    (salario * tasa).round(2)
  end
end

if $PROGRAM_NAME == __FILE__
  unless ARGV.length == 3
    warn 'Uso: ruby ejercicio2.rb NOMBRE EDAD SALARIO'
    exit 1
  end

  nombre, edad_raw, salario_raw = ARGV

  empleado = Empleado.new(
    nombre: nombre,
    edad: Integer(edad_raw),
    salario: Float(salario_raw)
  )

  puts "Impuesto a pagar por #{empleado.nombre}: $#{format('%.2f', empleado.impuesto)}"
end
