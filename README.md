# Calculator

This is the implementation of an interactive calculator using lex and yacc. Calculator is ready to accept expressions to evaluate when "->" is displayed on a new line. Calculator accepts only one 
expression at a time, evaluates it and then prints the result in the next line following a "=>" symbol. The input should be entered in infix notation. The expression shall contain variables, numbers and operators. The user shall quit the calculator by typing "quit" at the prompt.

- Variables: 
Variables are user defined and shall contain only lower case alphabets (a - z). By default, a variable is set to have a maximum of 32 characters. This can be tuned as required by adjusting VARIABLE_LEN in the symtable.h file. If a variable is not assigned any value, it will be initialized as 0.
- Numbers: Numbers shall be decimal or digits
- Operands 

The operands in their increasing order of precedence are as follows:
REL_OP: == <= >= != > <     (left associative)
ASSIGN_OP: =                (right associative)
ARITH_OP: + -               (left associative) 
MUL_OP: * /                 (left associative)
EXPONENT: ^                 (right associative)
UNARY -                     (nonassociative)

# Files
- calc.l: This file contains the lex regular expression to detect input from user. 
- calc.y: This file contains the grammar specification and processing involved in the yacc bottom up parser
- symtable.c: This file contains a singly linked list implementation of a symbol table used by the calculator to store variables and their values. The memory for variables are dynamically allocated when they are declared by the user. They are freed when the "quit" command is issued by the user.

# Preqrequisites
To build the module, following tools are needed:
- gcc
- bison 
- flex
This calculator was developed using gcc (7.3.0), bison ( 3.0.4), flex (2.6.4)

# Build
To clean build the calculator, the following commands can be used:

make clean
make 

# Run
Calculator can be run by executing the output file calc as follows:

./calc

