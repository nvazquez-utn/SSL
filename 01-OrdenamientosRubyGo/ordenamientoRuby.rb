# 1. Ordenamiento básico de un arreglo de primitivos
numeros = [9, 2, 5, 1, 7, 5, 15, 9 , 20, 21, 1, 2, 3, 0]

numeros_ordenados = numeros.sort
puts "Números ordenados: #{numeros_ordenados}" 

# 2. Ordenamiento de estructuras complejas (Hashes)
estudiantes = [
{ nombre: "Carlos", nota: 9 },
{ nombre: "Ana", nota: 7 },
{ nombre: "Belen", nota: 6 },
{ nombre: "Francisco", nota: 10 },
{ nombre: "Paula", nota: 7 },
{ nombre: "Romina", nota: 7 },
{ nombre: "Jose", nota: 5 },
{ nombre: "Nicolas", nota: 10 },
]

# Al ser un algoritmo estable, Las mantendrán su orden original entre ellas.
estudiantes_por_nota = estudiantes.sort_by { |estudiante| estudiante[:nota] }

puts "Estudiantes ordenados por nota:"
pp estudiantes_por_nota

