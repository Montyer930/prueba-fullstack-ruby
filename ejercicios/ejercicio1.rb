# frozen_string_literal: true

# Devuelve el número que más se repite en un arreglo de enteros.
# En caso de empate se retorna el menor de los números con mayor frecuencia.
def numero_mas_repetido(numeros)
  raise ArgumentError, 'El arreglo no puede estar vacío' if numeros.empty?

  frecuencias = numeros.each_with_object(Hash.new(0)) do |numero, contador|
    contador[numero] += 1
  end

  frecuencias.max_by { |numero, frecuencia| [frecuencia, -numero] }.first
end

if $PROGRAM_NAME == __FILE__
  if ARGV.empty?
    warn 'Uso: ruby ejercicio1.rb num1 num2 num3 ...'
    exit 1
  end

  numeros = ARGV.map do |valor|
    Integer(valor)
  rescue ArgumentError
    warn "\"#{valor}\" no es un número entero válido"
    exit 1
  end

  puts numero_mas_repetido(numeros)
end
