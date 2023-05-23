#ifndef _VM_VM_H
#define _VM_VM_H

#include "common.h"
#include "header_obj.h"
#include "class.h"
#include "obj_map.h"
#include "obj_thread.h"

// 为定义在opcode.inc中的操作码加上前缀"OPCODE_"
#define OPCODE_SLOTS(opcode, effect) OPCODE_##opcode,
typedef enum
{
#include "opcode.inc"
} OpCode;
#undef OPCODE_SLOTS

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
    Class *nullClass;
    Class *boolClass;
    Class *numClass;
    Class *objectClass;
    Class *classOfClass;
    uint32_t allocatedBytes; // 累计已分配的内存量
    ObjHeader *allObjects;
    SymbolTable allMethodNames; //(所有)类的方法名
    Parser *curParser;          // 当前此法分析器
    ObjMap *allModules;
    ObjThread *curThread; // 当前正在执行的线程
};

void initVM(VM *vm);

VM *newVM(void);

void ensureStack(VM *vm, ObjThread *objThread, uint32_t neededSlots);

VMResult executeInstruction(VM *vm, register ObjThread *curThread);

#endif // _VM_VM_H