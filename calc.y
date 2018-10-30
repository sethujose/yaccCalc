%{
void yyerror (char *s);
int yylex();
#include <stdio.h>     
#include <stdlib.h>
#include <math.h>
#include "symtable.h"
#include <string.h>

double Calc_ReadVar(char *symbol);
void Calc_WriteVar(char *symbol, double val);
%}

//Grammar specifications
%union {double num; char *id; int EOL; int rel_op;}         
%start statements
%token quit
%token <EOL> eol
%token <num> number
%token <id> identifier
%token <rel_op> REL_EQ_EQ REL_LT_EQ REL_GT_EQ REL_NT_EQ
%type <num> statements statement expression term exponent factor  assignment parentheses uminus

//associatvity specifiers
%left REL_EQ_EQ REL_LT_EQ REL_GT_EQ REL_NT_EQ
%right '='
%left '+' '-'
%left '*' '/'
%right '^'
%nonassoc UMINUS

%%

//Grammar
statements   		:   statement eol			            {printf("=> %g\n-> ", $1);}
		                | statements statement eol		    {printf("=> %g\n-> ", $2);}
		                | statements quit eol               {SymTable_freeList(); exit(EXIT_SUCCESS);}
		                | quit eol                          {SymTable_freeList(); exit(EXIT_SUCCESS); }
       		            ;
        
statement 	        :   statement REL_EQ_EQ assignment  	{$$ = ($1 == $3)? 1 : 0;}
		                | statement REL_NT_EQ assignment  	{$$ = ($1 != $3)? 1 : 0;}
		                | statement REL_LT_EQ assignment  	{$$ = ($1 <= $3)? 1 : 0;}
		                | statement REL_GT_EQ assignment  	{$$ = ($1 >= $3)? 1 : 0;}
		                | statement '<' assignment  	    {$$ = ($1 < $3)? 1 : 0;}
		                | statement '>' assignment  	    {$$ = ($1 > $3)? 1 : 0;}
        	            | assignment                  	    {$$ = $1;}
        	            ;
   
assignment 	        :   identifier '=' assignment  		    {$$ = $3; Calc_WriteVar($1,$3);}
            	        | expression               		    {$$ = $1;}
		                ;
			
expression 	   	    :   term                  	            {$$ = $1;}
   	    	            | expression '+' term         		{$$ = $1 + $3;}
       		            | expression '-' term               {$$ = $1 - $3;}
       		            ;
       		            
term   		        :   term '*' exponent       	        {$$ = $1 * $3;}
        	            | term '/' exponent        	        {$$ = $1 / $3;}
        	            | exponent                 	        {$$ = $1;}
       		            ;
       		            
exponent  		    :   uminus '^' exponent	  	            {$$ = pow($1 , $3);}
       		            | uminus	                	    {$$ = $1;}
       		            ;
       		            
uminus	  	        :   '-' parentheses	 %prec UMINUS       {$$ = -$2;}
		                | parentheses 	         	        {$$ = $1;}
	                    ;
	                    
parentheses  	    :   '(' statement ')'       	        {$$ = $2; }
		                | factor          		            {$$ = $1;}
	                    ;
	                    
factor  	        :   number                	            {$$ = $1;}
		                | identifier			            {$$ = Calc_ReadVar($1);} 
	                    ;

%%                     
//C functions

double Calc_ReadVar(char *symbol)
{	
    //extract the variable name from the expression
    char *string = strtok(symbol, " =+-*/><!^()\n");
	
	return SymTable_readVar(string);	
}

void Calc_WriteVar(char *symbol, double val)
{
    //extract the variable name from the expression
    char *string = strtok(symbol, " =+-*/><!^()\n");

    SymTable_writeVar(string, val);
}

int main (void) 
{	
    //print the first enter prompt
	printf("-> ");

	return yyparse ( );
}

void yyerror (char *s) 
{
    fprintf (stderr, " %s\n", s);
} 

