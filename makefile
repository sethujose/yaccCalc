calc: lex.yy.c y.tab.c
	gcc lex.yy.c y.tab.c symtable.c -lm -o calc

lex.yy.c: y.tab.c calc.l
	lex calc.l

y.tab.c: calc.y
	yacc -d calc.y

clean: 
	rm -rf lex.yy.c y.tab.c y.tab.h calc

