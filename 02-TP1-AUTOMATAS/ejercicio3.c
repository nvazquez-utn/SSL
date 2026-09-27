#include <stdio.h>
#include <ctype.h>

// --- FUNCIONES AUXILIARES PREVIAS ---
int caracterAEntero(char c) {
    if (c >= '0' && c <= '9') {
        return c - '0';
    }
    return -1; 
}

// --- 1. MATRIZ Y VALIDACIÓN (EL AFD) ---
// Columnas: 0: Dígito, 1: Operador, 2: Fin (\0), 3: Otro
int TT_Ej3[4][4] = {
    /* 0 */ { 1, 3, 3, 3 },
    /* 1 */ { 1, 2, 9, 3 }, // '9' representa el estado de aceptación final
    /* 2 */ { 1, 3, 3, 3 },
    /* 3 */ { 3, 3, 3, 3 }  // Estado de error
};

int columnaEj3(char c) {
    if (isdigit(c)) return 0;
    if (c == '+' || c == '-' || c == '*') return 1;
    if (c == '\0') return 2;
    return 3;
}

int esOperacionValida(char* cadena) {
    int estado_actual = 0;
    int i = 0;
    
    while (1) {
        char c = cadena[i];
        int col = columnaEj3(c);
        
        estado_actual = TT_Ej3[estado_actual][col];
        
        if (estado_actual == 9) return 1; // Aceptada formalmente por el AFD
        if (estado_actual == 3) return 0; // Rechazada por error léxico/sintáctico
        
        i++;
    }
}

// --- 2. EVALUACIÓN Y PRECEDENCIA ---
void calcularOperacion(char* cadena) {
    // Primero, el autómata valida que la cadena pertenezca al lenguaje
    if (!esOperacionValida(cadena)) {
        printf("Error: La operacion '%s' no es valida o no pertenece al lenguaje.\n", cadena);
        return;
    }

    int pila[100];
    int tope = -1;
    char operador_previo = '+';
    int num_actual = 0;
    
    int i = 0;
    while (cadena[i] != '\0') {
        char c = cadena[i];
        
        // Armamos el número si tiene más de un dígito
        if (isdigit(c)) {
            num_actual = (num_actual * 10) + caracterAEntero(c);
        }
        
        // Si encontramos un operador o llegamos al último dígito de la cadena
        if ((!isdigit(c) && c != ' ') || cadena[i+1] == '\0') {
            if (operador_previo == '+') {
                pila[++tope] = num_actual;
            } else if (operador_previo == '-') {
                pila[++tope] = -num_actual; // Apilamos el negativo
            } else if (operador_previo == '*') {
                // Resolución de precedencia: sacamos el anterior, multiplicamos y devolvemos a la pila
                pila[tope] = pila[tope] * num_actual; 
            }
            operador_previo = c;
            num_actual = 0;
        }
        i++;
    }
    
    // Sumamos todos los valores que quedaron en la pila
    int resultado = 0;
    for (int j = 0; j <= tope; j++) {
        resultado += pila[j];
    }
    
    printf("El resultado de '%s' es: %d\n", cadena, resultado);
}

// --- BLOQUE PRINCIPAL PARA PROBAR ---
int main() {
    printf("--- PRUEBAS EJERCICIO 3 ---\n");
    
    // Caso de éxito del enunciado
    char op1[] = "3+4*7+3-5"; 
    calcularOperacion(op1);
    
    // Otros casos de éxito
    char op2[] = "10*2-5*3+1"; 
    calcularOperacion(op2);
    
    // Casos de falla (deben ser atajados por el autómata)
    char opError1[] = "3++4"; // Dos operadores seguidos
    calcularOperacion(opError1);
    
    char opError2[] = "*5+2"; // Empieza con operador
    calcularOperacion(opError2);
    
    char opError3[] = "4+5-"; // Termina con operador
    calcularOperacion(opError3);

    return 0;
}