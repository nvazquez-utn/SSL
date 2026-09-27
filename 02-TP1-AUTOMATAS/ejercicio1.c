#include <stdio.h>

int TT[8][8] = {
    /* 0 */ { 1,  3,  2,  2,  7,  7,  0,  7},
    /* 1 */ { 7,  2,  2,  2,  7,  7,  7,  7},
    /* 2 */ { 7,  2,  2,  2,  7,  7,  0,  7},
    /* 3 */ { 7,  6,  6,  7,  4,  7,  0,  7},
    /* 4 */ { 7,  5,  5,  5,  7,  5,  7,  7},
    /* 5 */ { 7,  5,  5,  5,  7,  5,  0,  7},
    /* 6 */ { 7,  6,  6,  7,  7,  7,  0,  7},
    /* 7 */ { 7,  7,  7,  7,  7,  7,  0,  7},
};

int columna(char c) {
    if (c == '+' || c == '-'){
        return 0;
    } else if (c == '0'){
        return 1;
    } else if ( c >= '1' && c <= '7' ) {
        return 2;
    } else if ( c >= '8' && c <= '9' ) {
        return 3;
    } else if ( c == 'x' || c == 'X' ) {
        return 4;
    } else if ( c >= 'a' && c <= 'f' || c >= 'A' && c <= 'F' ) {
        return 5;
    } else if ( c == '@' ) {
        return 6;
    }  else {
        return 7;
    }
}

int caracterAEnteroSeguro(char c) {
    if (c >= '0' && c <= '9') {
        return c - '0';
    }
    return -1; // Retorna un código de error si el carácter no es numérico
}

void analizarCadena(char* cadena) {
    int estado_actual = 0;
    int estado_anterior = 0;
    int cant_decimales = 0, cant_octales = 0, cant_hexadecimales = 0, errores = 0;

    int i = 0;
    while (cadena[i] != '\0') {
        char c = cadena[i];
        int col = columna(c);
        
        estado_anterior = estado_actual;
        estado_actual = TT[estado_actual][col];

        if (c == '@') {
            if (estado_anterior == 2) cant_decimales++;
            else if (estado_anterior == 3 || estado_anterior == 6) cant_octales++;
            else if (estado_anterior == 5) cant_hexadecimales++;
            else if (estado_anterior != 0) {
                errores++;
                printf("Error lexico detectado antes de la posicion %d\n", i);
            }
        }
        i++;
    }

    if (estado_actual == 2) cant_decimales++;
    else if (estado_actual == 3 || estado_actual == 6) cant_octales++;
    else if (estado_actual == 5) cant_hexadecimales++;
    else if (estado_actual != 0) {
        errores++;
        printf("Error lexico al final de la cadena principal\n");
    }

    printf("\n--- RESULTADOS EJERCICIO 1 ---\n");
    printf("Decimales: %d\n", cant_decimales);
    printf("Octales: %d\n", cant_octales);
    printf("Hexadecimales: %d\n", cant_hexadecimales);
    printf("Errores lexicos: %d\n", errores);
}

int main() {
char cadenaPrueba[] = "123@-45@012@0x1A@89a@+78@0XF1";
    printf("Analizando cadena: %s\n", cadenaPrueba);
    analizarCadena(cadenaPrueba);
    
printf("\n--- RESULTADOS EJERCICIO 2 ---\n");
    char charNum = '7';
    int numConvertido = caracterAEnteroSeguro(charNum);
    printf("El caracter '%c' convertido a entero es: %d\n", charNum, numConvertido);

    return 0;
}