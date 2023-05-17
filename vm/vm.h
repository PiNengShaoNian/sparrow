#ifndef _VM_VM_H
#define _VM_VM_H

#include "common.h"
#include "header_obj.h"
#include "class.h"
#include "obj_map.h"

typedef enum vmResult
{
    VM_RESULT_SUCCESS,
    VM_RESULT_ERROR
} VMResult; // 虚拟机执行结果
// 如果执行无误,可以将字符码输出到文件缓存,避免下次重新编译

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
    SymbolTable allMethodNames; //(所有)类的方法名
    Parser *curParser;          // 当前此法分析器
    ObjMap *allModules;
};

void initVM(VM *vm);

VM *newVM(void);

#endif // _VM_VM_H