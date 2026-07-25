// ordenamiento_tiempo.go
package main

import (
	"fmt"
	"math/rand"
	"sort"
	"time"
)

func main() {
	fmt.Println("Generando 1 millón de números en Go...")

	// 1. Generamos un Slice con 1 millón de números aleatorios
	numeros := make([]int, 1000000)
	for i := 0; i < 1000000; i++ {
		numeros[i] = rand.Intn(1000) // Números del 0 al 999
	}

	fmt.Println("Iniciando ordenamiento...")

	// 2. Capturamos el tiempo de inicio
	tiempoInicio := time.Now()

	// 3. Ejecutamos el algoritmo interno (pdqsort)
	sort.Ints(numeros)
	fmt.Printf("Números ordenados: %v\n", numeros) 
	// 4. Calculamos el tiempo transcurrido
	tiempoTotal := time.Since(tiempoInicio)

	fmt.Println("Ordenamiento finalizado.")
	fmt.Println("--------------------------------------------------")
	// Usamos %v para imprimir el tiempo formateado automáticamente (ej. 15.4ms)
	fmt.Printf("Tiempo de ejecución en Go: %v\n", tiempoTotal)
	fmt.Println("--------------------------------------------------")
}
