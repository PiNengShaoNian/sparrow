#ifndef _VM_VM_H
#define _VM_VM_H

#include "common.h"
#include "header_obj.h"

struct vm
{
    Class *stringClass;
    Class *fnClass;
    Class *listClass;
    Class *rangeClass;
    Class *mapClass;
    Class *threadClass;
    uint32_t allocatedBytes; // 累计已分配的内存量
    ObjHeader *allObjects;
    Parser *curParser; // 当前此法分析器
};

void initVM(VM *vm);

VM *newVM(void);

#endif // _VM_VM_H