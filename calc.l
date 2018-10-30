%{
#include "y.tab.h"
#include "symtable.h"
#include <string.h>

void yyerror (char *s);
int yylex();
%}
%%
"quit"                      {return quit;}
[a-z]+  		            {yylval.id = yytext; return identifier;}
[1-9][0-9]*\.[0-9]*         {yylval.num = atof(yytext); return number;}
[0]?\.[1-9][0-9]*           {yylval.num = atof(yytext); return number;}
[0-9]+                      {yylval.num = atof(yytext); return number;}
                          
[ \t]                       ;
[\n]			            {yylval.EOL = 1; return eol;}
(==)                        {return REL_EQ_EQ;}
(<=)                        {return REL_LT_EQ;}
(>=)                        {return REL_GT_EQ;}
(!=)                        {return REL_NT_EQ;}
[-+=;*/^!<>]           	    {return yytext[0];}
[()]                        {return yytext[0];}
.                           {ECHO; yyerror ("unexpected character");}
%%
int yywrap (void) {return 1;}

