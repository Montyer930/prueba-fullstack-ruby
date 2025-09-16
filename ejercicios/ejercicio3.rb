# frozen_string_literal: true

# Lee un archivo de texto y guarda en otro archivo la cantidad de líneas encontradas.
input_file = ARGV[0] || 'datos.txt'
output_file = ARGV[1] || 'resultado.txt'

unless File.exist?(input_file)
  warn "No se encontró el archivo de entrada: #{input_file}"
  exit 1
end

lineas = 0
File.foreach(input_file) { |_linea| lineas += 1 }

mensaje = "El archivo #{File.basename(input_file)} tiene #{lineas} línea#{lineas == 1 ? '' : 's'}."
File.write(output_file, mensaje + "\n")

puts "Resultado guardado en #{output_file}"
