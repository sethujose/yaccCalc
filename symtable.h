#ifndef SYMTABLE_H
#define SYMTABLE_H

#include <stdbool.h>
#define VARIABLE_LEN  32

extern void SymTable_freeList(void);
extern void SymTable_writeVar(char *varName, double value);
extern double SymTable_readVar(char *varName);

#endif //SYMTABLE_H
