package main

import (
	"fmt"
	"sort"
)

func main() {
	// 1. Ordenamiento básico de un Slice (arreglo dinámico)
	numeros := []int{9, 2, 5, 1, 7, 5, 15, 9 , 20, 21, 1, 2, 3, 0}
	
	// sort.Ints modifica el slice original directamente en memoria (in-place)
	sort.Ints(numeros)
	fmt.Printf("Números ordenados: %v\n", numeros) 

	// 2. Ordenamiento de estructuras complejas (Structs)
	type Estudiante struct {
		Nombre string
		Nota   int
	}

	estudiantes := []Estudiante{
		{ "Ana",  7 },
		{  "Belen",  6 },
		{  "Francisco",  10 },
		{  "Paula",  7 },
		{  "Romina",  7 },
		{  "Jose",  5 },
		{  "Nicolas", 10 },
		{  "Carlos",  9 },
	}
	sort.Slice(estudiantes, func(i, j int) bool {
		return estudiantes[i].Nota < estudiantes[j].Nota
	})

	fmt.Printf("Estudiantes ordenados por nota: %v\n", estudiantes)
	// sort.Slice recibe el slice y una función anónima que define cómo comparar dos elementos.
	// Nota: sort.Slice usa pdqsort, por lo que NO garantiza estabilidad.
	// Si se necesitara estabilidad estricta (que Ana siempre quede antes que Belén),
	// Go requiere llamar explícitamente a otra función: sort.SliceStable()
}