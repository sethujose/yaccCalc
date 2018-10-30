#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include "symtable.h"

typedef struct LinkedList
{
    char varName[VARIABLE_LEN];
    double value;
    struct LinkedList *next;
} node_t;

node_t *pHead;

/*
 * Function:  SymTable_createNode 
 * ------------------
 * Creates a new node in heap
 * Assigns variable attributes to the new node
 * 
 * @parameter: varName - Variable Name
   @parameter: value - value to be assigned to the variable
 * @return: pointer to the node
 */
static node_t *SymTable_createNode(char *varName, double value)
{
    node_t *temp;
                                    
    temp = (node_t *)malloc(sizeof(node_t));
    
    if (temp == NULL)
    {
        printf("SymTable: var %s malloc failed!", varName);
        exit(EXIT_FAILURE); 
    }                        
    
    temp->next = NULL;     
    temp->value = value;                                                         
    strcpy(temp->varName, varName);
    
    return temp;
}

/*
 * Function:  SymTable_addToList 
 * ------------------
 * Adds a new node to the symbol table
 * 
 * @parameter: node - pointer to the node to be added
 * @return: void
 */
static void SymTable_addToList (node_t *node)
{
    //add the new node to the last free slot in singly linked list                                                                
    if (pHead == NULL)
    {
        pHead = node;                                                
    }
    else
    {
        node_t *cursor;
        
        cursor  = pHead;                                             
        
        while (cursor->next != NULL)
        {
            cursor = cursor->next;                                  
        }
        
        cursor->next = node;                                        
    }
}

/*
 * Function:  SymTable_createVar 
 * ------------------
 * Adds a new variable to the linkedlist based symbol table. The newly created nodes are always
 * added to the end of the singly linked list
 * 
 * @parameter: varName - Variable Name
   @parameter: value - value to be assigned to the variable
 * @return: void
 */
static void SymTable_createVar(char *varName, double value)
{
    node_t *node;
    
    node = SymTable_createNode(varName, value);
    
    SymTable_addToList(node);   
                             
}

/*
 * Function:  SymTable_getNode 
 * --------------------
 * Searches the symbol table for the specified variable
 *
 *  returns: pointer to the specified node if the node is found
 *           else returns NULL pointer
 */
static node_t * SymTable_getNode(char *varName)
{
    node_t *cursor;
    
    cursor = pHead;
    
    while (cursor != NULL)
    {
        if (strcmp(varName, cursor->varName) == 0)
        {
            break;
        }

        cursor = cursor->next;
    }
    
    return cursor;

}

/*
 * Function:  SymTable_setVal
 * ----------------------
 * This function searches for the specified variable in the symbol table
 * If the variable is found, it updates the value.
 * 
 * @parameter: varName - Variable Name
   @parameter: value - value to be assigned to the variable
 * @return: NULL if variable name is not found in symbol table,
 *          pointer to the variable node if the variable is found in symbol table
 */
static node_t * SymTable_setVal(char *varName, double value)
{   
    node_t *temp = SymTable_getNode(varName);
    
    if (temp != NULL)
    {
        temp->value = value;
    }
    
    return temp;
}

/*
 * Function:  SymTable_freeList 
 * --------------------
 * Frees up the dynamically allocated nodes 
 *
 * @return: void
 */
void SymTable_freeList(void)
{
    node_t *cursor;
    node_t *prev;
    
    prev = NULL;
    cursor = pHead;
    
    while(cursor != NULL)
    {
        prev = cursor;
        cursor = cursor->next;

        free(prev);
    }
}

/*
 * Function:  SymTable_writeVar 
 * --------------------
 * Creates a new variable if it is not in symbol table. If it is already in table, 
 * updates its value to the new value specified
 
 *  @return: void
 */
void SymTable_writeVar(char *varName, double value)
{
    if (SymTable_setVal(varName, value) == NULL)
    {
        SymTable_createVar(varName, value);
    }
}

/*
 * Function:  SymTable_readVar 
 * --------------------
 * Reads the value of the variable specified
 * 
 * If the variable is not found in symbol table, returns value 0 like in bc
 
 *  returns: the approximate value of pi obtained by suming the first n terms
 *           in the above series
 *           returns zero on error (if n is non-positive)
 */
double SymTable_readVar(char *varName)
{
    node_t *temp = SymTable_getNode(varName);
    
    if (temp != NULL)
    {
        double value;
        
        return temp->value;;
    }
    else
    {
        return 0;
    }
}

