#include "utils.h"
#include "vm.h"
#include "parser.h"
#include "gc.h"
#include <stdarg.h>
#if DEBUG
#include "debug.h"
#endif

// 内存管理3种功能
//     1 申请内存
//     2 修改空间大小
//     3 释放内存
void *memManager(VM *vm, void *ptr, uint32_t oldSize, uint32_t newSize)
{
    // 累计系统分配的总内存
    vm->allocatedBytes += newSize - oldSize;

    // 避免了realloc(NULL, 0)定义新地址，此地址不能被释放
    if (newSize == 0)
    {
        free(ptr);
        return NULL;
    }

    // 在分配内存时若达到了GC触发的阀值则启动垃圾回收
    if (newSize > 0 && vm->allocatedBytes > vm->config.nextGC)
        startGC(vm);

    return realloc(ptr, newSize);
}

// 找出大于等于v最近的2次幂，(如果一个数是二的幂那么在它的所有位中只有一个位为1)
uint32_t ceilToPowerOf2(uint32_t v)
{
    v += (v == 0); // 修复当v等于0时结果为0的边界情况
    v--;

    // 将最高有效位(为1的位)的右侧全部置为1
    v |= v >> 1;
    v |= v >> 2;
    v |= v >> 4;
    v |= v >> 8;
    v |= v >> 16;

    // 此时最高有效位和它的右侧全部位1，在加1就会形成一个二的幂
    v++;
    return v;
}

DEFINE_BUFFER_METHOD(String)
DEFINE_BUFFER_METHOD(Int)
DEFINE_BUFFER_METHOD(Char)
DEFINE_BUFFER_METHOD(Byte)

void symbolTableClear(VM *vm, SymbolTable *buffer)
{
    uint32_t idx = 0;
    while (idx < buffer->count)
    {
        memManager(vm, buffer->datas[idx++].str, 0, 0);
    }
    StringBufferClear(vm, buffer);
}

// 通用报错函数
void errorReport(void *parser, void *curThread, ErrorType errorType,
                 const char *fmt, ...)
{
    char buffer[DEFAULT_BUFFER_SIZE] = {'\0'};
    va_list ap;
    va_start(ap, fmt);
    vsnprintf(buffer, DEFAULT_BUFFER_SIZE, fmt, ap);
    va_end(ap);

    switch (errorType)
    {
    case ERROR_IO:
    case ERROR_MEM:
        fprintf(stderr, "%s:%d In functions %s():%s\n", __FILE__, __LINE__, __func__, buffer);
        break;
    case ERROR_LEX:
    case ERROR_COMPILE:
        ASSERT(parser != NULL, "parser is null!");
        fprintf(stderr, "%s:%d \"%s\"\n", ((Parser *)parser)->file, ((Parser *)parser)->preToken.lineNo, buffer);
        break;
    case ERROR_RUNTIME:
        fprintf(stderr, "Error: %s\n", buffer);
#ifdef DEBUG
        dumpCallStack(curThread);
#endif
        break;
    default:
        NOT_REACHED();
    }
    exit(1);
}