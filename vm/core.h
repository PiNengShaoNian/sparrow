#ifndef _VM_CORE_H
#define _VM_CORE_H

#include "vm.h"

extern char *rootDir;
char *readFile(const char *sourceFile);
VMResult executeModule(VM *vm, Value moduleName, const char *moduleCode);
void buildCore(VM *vm);
int getIndexFromSymbolTable(SymbolTable *table, const char *symbol, uint32_t length);
int addSymbol(VM *vm, SymbolTable *table, const char *symbol, uint32_t length);

#endif // _VM_CORE_H