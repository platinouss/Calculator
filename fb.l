%option noyywrap nodefault yylineno
%{
# include "fb.h"
# include "fb.tab.h"
%}

EXP	([Ee][-+]?[0-9]+)

%%
"+" |
"-" |
"*" |
"/" |
"=" |
"|" |
"," |
";" |
"(" |
")"     { return yytext[0]; }

">"     { yylval.fn = 1; return CMP; }
"<"     { yylval.fn = 2; return CMP; }
"<>"    { yylval.fn = 3; return CMP; }
"=="    { yylval.fn = 4; return CMP; }
">="    { yylval.fn = 5; return CMP; }
"<="    { yylval.fn = 6; return CMP; }


"if"    { return IF; }
"then"  { return THEN; }
"else"  { return ELSE; }
"while" { return WHILE; }
"do"    { return DO; }
"let"   { NULL; }
"var"   { NULL; }
"int"   { NULL; }
"run"   { return EOL; }

"sqrt"  { yylval.fn = B_sqrt; return FUNC; }
"exp"   { yylval.fn = B_exp; return FUNC; }
"log"   { yylval.fn = B_log; return FUNC; }
"print" { yylval.fn = B_print; return FUNC; }

"debug"[0-9]+ { debug = atoi(&yytext[5]); printf("debug set to %d\n", debug); }

"let"[a-zA-Z][a-zA-Z0-9]*  { NULL; yylval.s = lookup(yytext); return NAME; }
"int"[a-zA-Z][a-zA-Z0-9]*  { NULL; yylval.s = lookup(yytext); return NAME; }
"var"[a-zA-Z][a-zA-Z0-9]*  { NULL; yylval.s = lookup(yytext); return NAME; }

[a-zA-Z][a-zA-Z0-9]*  { yylval.s = lookup(yytext); return NAME; }

[0-9]+"."[0-9]*{EXP}? |
"."?[0-9]+{EXP}? { yylval.d = atof(yytext); return NUMBER; }

"//".*  
[ \t]   
\\\n    printf("c> ");
"\n"    { NULL; }
.	{ yyerror("Mystery character %c\n", *yytext); }
%%