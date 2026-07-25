# 1. Generamos un arreglo con 1 millón de números aleatorios (del 1 al 1000)
puts "Generando 1 millón de números en Ruby..."
numeros = Array.new(1_000_000) { rand(1..1000) }

puts "Iniciando ordenamiento..."

# 2. Capturamos el tiempo de inicio
tiempo_inicio = Time.now

# 3. Ejecutamos el algoritmo interno (TimSort / IntroSort)
numeros_ordenados = numeros.sort

# 4. Capturamos el tiempo final
tiempo_fin = Time.now

# 5. Calculamos la diferencia

tiempo_total = tiempo_fin - tiempo_inicio
puts "Ordenamiento finalizado."
puts "--------------------------------------------------"
puts "Tiempo de ejecución en Ruby: #{tiempo_total} segundos"
puts "--------------------------------------------------"