%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern int yylex(void);
extern FILE *yyin;
extern int linea;
void yyerror(const char *s);
int errores = 0;

/* ---------- Tabla de simbolos ---------- */
#define MAXTS 1000
char *TS[MAXTS];
int nTS = 0;
int buscar(const char *id){ for(int i=0;i<nTS;i++) if(!strcmp(TS[i],id)) return 1; return 0; }
void colocar(const char *id){ if(nTS<MAXTS) TS[nTS++] = strdup(id); }

void generar(const char *co,const char *a,const char *b,const char *c){
    printf("%s %s,%s,%s\n", co, a, b, c);
}

/* ---------- Rutinas semanticas ---------- */
void declarar(const char *id){                 /* #declarar: da de alta la variable */
    if(!buscar(id)){ colocar(id); generar("Declara", id, "Entera", ""); }
}
void usar(const char *id){                     /* #chequear_uso: error semantico */
    if(!buscar(id)){
        printf("Error semantico (linea %d): la variable '%s' se usa sin haber sido declarada\n", linea, id);
        errores++;
    }
}
char *genInfijo(const char *a,const char *op,const char *b){   /* #gen_infijo */
    static int numTemp = 1;
    char *temp = malloc(32);
    sprintf(temp, "Temp&%d", numTemp++);
    declarar(temp);
    generar(!strcmp(op,"+") ? "Sumar" : "Restar", a, b, temp);
    return temp;
}
void asignar(const char *izq,const char *der){ generar("Almacena", der, izq, ""); }  /* #asignar */
void leerId(const char *id){ generar("Read", id, "Entera", ""); }                    /* #leer_id */
void escribirExp(const char *e){ generar("Write", e, "Entera", ""); }               /* #escribir_exp */
void terminar(void){ generar("Detiene", "", "", ""); }                                /* #terminar */
%}
%define parse.error verbose
%union { char *cadena; }
%token INICIO FIN LEER ESCRIBIR ASIGNACION PYCOMA COMA SUMA RESTA PARENIZQUIERDO PARENDERECHO FDT
%token <cadena> ID CONSTANTE
%type  <cadena> expresion primaria operadorAditivo
%start objetivo
%%
objetivo: programa FDT                      { terminar(); } ;
programa: INICIO listaSentencias FIN ;
listaSentencias: listaSentencias sentencia | sentencia ;
sentencia:
    ID ASIGNACION expresion PYCOMA          { declarar($1); asignar($1,$3); }
  | LEER PARENIZQUIERDO listaIdentificadores PARENDERECHO PYCOMA
  | ESCRIBIR PARENIZQUIERDO listaExpresiones PARENDERECHO PYCOMA
  | error PYCOMA                            { yyerrok; }
  ;
listaIdentificadores:
    ID                                      { declarar($1); leerId($1); }
  | listaIdentificadores COMA ID            { declarar($3); leerId($3); }
  ;
listaExpresiones:
    expresion                               { escribirExp($1); }
  | listaExpresiones COMA expresion         { escribirExp($3); }
  ;
expresion:
    primaria
  | expresion operadorAditivo primaria      { $$ = genInfijo($1,$2,$3); }
  ;
primaria:
    ID                                      { usar($1); $$ = $1; }
  | CONSTANTE
  | PARENIZQUIERDO expresion PARENDERECHO   { $$ = $2; }
  ;
operadorAditivo: SUMA { $$ = "+"; } | RESTA { $$ = "-"; } ;
%%
void yyerror(const char *s){
    printf("Error sintactico (linea %d): %s\n", linea, s);
    errores++;
}
int main(int argc,char *argv[]){
    if(argc==2){ yyin = fopen(argv[1],"r"); if(!yyin){ printf("No se pudo abrir %s\n",argv[1]); return 1; } }
    yyparse();
    if(errores==0) printf("\n>> Compilacion exitosa\n"); else printf("\n>> Compilacion con %d error(es)\n", errores);
    return errores!=0;
}
