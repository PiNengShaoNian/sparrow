#include <stdlib.h>
#include "vm.h"
#include "utils.h"
#include "core.h"

// 初始化虚拟机
void initVM(VM *vm)
{
    vm->allocatedBytes = 0;
    vm->allObjects = NULL;
    vm->curParser = NULL;
    StringBufferInit(&vm->allMethodNames);
    vm->allModules = newObjMap(vm);
}

VM *newVM()
{
    VM *vm = (VM *)malloc(sizeof(VM));
    if (vm == NULL)
        MEM_ERROR("allocate VM failed!");

    initVM(vm);
    buildCore(vm);
    return vm;
}