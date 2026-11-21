%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "micro.tab.h"
int linea = 1;
extern int errores;
%}
%option noyywrap
LETRA   [a-zA-Z]
DIGITO  [0-9]
%%
"inicio"                        { return INICIO; }
"fin"                           { return FIN; }
"leer"                          { return LEER; }
"escribir"                      { return ESCRIBIR; }
{LETRA}({LETRA}|{DIGITO})*      { if (yyleng > 32) {
                                      printf("Error lexico (linea %d): el identificador '%s' supera los 32 caracteres\n", linea, yytext);
                                      errores++;
                                  }
                                  yylval.cadena = strdup(yytext); return ID; }
{DIGITO}+                       { yylval.cadena = strdup(yytext); return CONSTANTE; }
":="                            { return ASIGNACION; }
";"                             { return PYCOMA; }
","                             { return COMA; }
"("                             { return PARENIZQUIERDO; }
")"                             { return PARENDERECHO; }
"+"                             { return SUMA; }
"-"                             { return RESTA; }
":"                             { printf("Error lexico (linea %d): se encontro ':' solo, ¿quisiste escribir ':='?\n", linea); errores++; }
[ \t\r]+                        { /* se ignoran los blancos */ }
\n                              { linea++; }
<<EOF>>                         { static int enviado = 0;
                                  if (!enviado) { enviado = 1; return FDT; }
                                  return 0; }
.                               { printf("Error lexico (linea %d): el caracter '%s' no pertenece al lenguaje Micro\n", linea, yytext); errores++; }
%%
