#ifdef DEBUG

#include <stdio.h>
#include "debug.h"
#include "vm.h"
#include "core.h"
#include <string.h>

// 在fnDebug中绑定函数名
void bindDebugFnName(VM *vm, FnDebug *fnDebug,
                     const char *name, uint32_t length)
{
  ASSERT(fnDebug->fnName == NULL, "debug.name has bound!");
  fnDebug->fnName = ALLOCATE_ARRAY(vm, char, length + 1);
  memcpy(fnDebug->fnName, name, length);
  fnDebug->fnName[length] = '\0';
  ASSERT(fnDebug->file == NULL, "debug.file has bound!");
  fnDebug->file = vm->curParser ? vm->curParser->file : NULL;
}

// 打印栈
void dumpStack(ObjThread *thread)
{
  printf("(thread %p) stack:%p, esp:%p, slots:%ld ",
         thread, thread->stack, thread->esp, thread->esp - thread->stack);
  Value *slot = thread->stack;
  while (slot < thread->esp)
  {
    dumpValue(*slot);
    printf(" | ");
    slot++;
  }
  printf("\n");
}

// 打印对象
static void dumpObject(ObjHeader *obj)
{
  switch (obj->type)
  {
  case OT_CLASS:
    printf("[class %s %p]", ((Class *)obj)->name->value.start, obj);
    break;
  case OT_CLOSURE:
    printf("[closure %p]", obj);
    break;
  case OT_THREAD:
    printf("[thread %p]", obj);
    break;
  case OT_FUNCTION:
    printf("[fn %p]", obj);
    break;
  case OT_INSTANCE:
    printf("[instance %p]", obj);
    break;
  case OT_LIST:
    printf("[list %p]", obj);
    break;
  case OT_MAP:
    printf("[map %p]", obj);
    break;
  case OT_MODULE:
    printf("[module %p]", obj);
    break;
  case OT_RANGE:
    printf("[range %p]", obj);
    break;
  case OT_STRING:
    printf("\"%s\"", ((ObjString *)obj)->value.start);
    break;
  case OT_UPVALUE:
    printf("[upvalue %p]", obj);
    break;
  default:
    printf("[unknown object %d]", obj->type);
    break;
  }
}

// 打印value
void dumpValue(Value value)
{
  switch (value.type)
  {
  case VT_FALSE:
    printf("false");
    break;
  case VT_NULL:
    printf("null");
    break;
  case VT_NUM:
    printf("%.14g", VALUE_TO_NUM(value));
    break;
  case VT_TRUE:
    printf("true");
    break;
  case VT_OBJ:
    dumpObject(VALUE_TO_OBJ(value));
    break;
  case VT_UNDEFINED:
    NOT_REACHED();
  }
}

// 打印一条指令
static int dumpOneInstruction(VM *vm, ObjFn *fn, int i, int *lastLine)
{
  int start = i;
  uint8_t *bytecode = fn->instrStream.datas;
  OpCode opCode = (OpCode)bytecode[i];

  int lineNo = fn->debug->lineNo.datas[i];

  if (lastLine == NULL || *lastLine != lineNo)
  {
    printf("%4d:", lineNo); // 输出源码行号
    if (lastLine != NULL)
    {
      *lastLine = lineNo;
    }
  }
  else
  {
    // 不用输出源码行了,还是输出的lastLine行的指令流,空出行号的位置即可
    printf("     ");
  }

  printf(" %04d  ", i++); // 输出指令流中的位置

#define READ_BYTE() (bytecode[i++])
#define READ_SHORT() (i += 2, (bytecode[i - 2] << 8) | bytecode[i - 1])

#define BYTE_INSTRUCTION(name)              \
  printf("%-16s %5d\n", name, READ_BYTE()); \
  break;

  switch (opCode)
  {
  case OPCODE_LOAD_CONSTANT:
  {
    int constant = READ_SHORT();
    printf("%-16s %5d '", "LOAD_CONSTANT", constant);
    dumpValue(fn->constants.datas[constant]);
    printf("'\n");
    break;
  }

  case OPCODE_PUSH_NULL:
    printf("PUSH_NULL\n");
    break;
  case OPCODE_PUSH_FALSE:
    printf("PUSH_FALSE\n");
    break;
  case OPCODE_PUSH_TRUE:
    printf("PUSH_TRUE\n");
    break;

  case OPCODE_LOAD_LOCAL_VAR:
    BYTE_INSTRUCTION("LOAD_LOCAL_VAR");
  case OPCODE_STORE_LOCAL_VAR:
    BYTE_INSTRUCTION("STORE_LOCAL_VAR");
  case OPCODE_LOAD_UPVALUE:
    BYTE_INSTRUCTION("LOAD_UPVALUE");
  case OPCODE_STORE_UPVALUE:
    BYTE_INSTRUCTION("STORE_UPVALUE");

  case OPCODE_LOAD_MODULE_VAR:
  {
    int slot = READ_SHORT();
    printf("%-16s %5d '%s'\n", "LOAD_MODULE_VAR", slot,
           fn->module->moduleVarName.datas[slot].str);
    break;
  }

  case OPCODE_STORE_MODULE_VAR:
  {
    int slot = READ_SHORT();
    printf("%-16s %5d '%s'\n", "STORE_MODULE_VAR", slot,
           fn->module->moduleVarName.datas[slot].str);
    break;
  }

  case OPCODE_LOAD_THIS_FIELD:
    BYTE_INSTRUCTION("LOAD_THIS_FIELD");
  case OPCODE_STORE_THIS_FIELD:
    BYTE_INSTRUCTION("STORE_THIS_FIELD");
  case OPCODE_LOAD_FIELD:
    BYTE_INSTRUCTION("LOAD_FIELD");
  case OPCODE_STORE_FIELD:
    BYTE_INSTRUCTION("STORE_FIELD");

  case OPCODE_POP:
    printf("POP\n");
    break;
  case OPCODE_LOAD1:
    printf("LOAD1\n");
    break;
  case OPCODE_DUP1:
  case OPCODE_DUP2:
  case OPCODE_DUP3:
  case OPCODE_DUP4:
  case OPCODE_DUP5:
  case OPCODE_DUP6:
  case OPCODE_DUP7:
  case OPCODE_DUP8:
  case OPCODE_DUP9:
  case OPCODE_DUP10:
  case OPCODE_DUP11:
  case OPCODE_DUP12:
  case OPCODE_DUP13:
  case OPCODE_DUP14:
  case OPCODE_DUP15:
  case OPCODE_DUP16:
  {
    int n = bytecode[i - 1] - OPCODE_DUP1 + 1;
    printf("DUP%d\n", n);
    break;
  }

  case OPCODE_CALL0:
  case OPCODE_CALL1:
  case OPCODE_CALL2:
  case OPCODE_CALL3:
  case OPCODE_CALL4:
  case OPCODE_CALL5:
  case OPCODE_CALL6:
  case OPCODE_CALL7:
  case OPCODE_CALL8:
  case OPCODE_CALL9:
  case OPCODE_CALL10:
  case OPCODE_CALL11:
  case OPCODE_CALL12:
  case OPCODE_CALL13:
  case OPCODE_CALL14:
  case OPCODE_CALL15:
  case OPCODE_CALL16:
  {
    int numArgs = bytecode[i - 1] - OPCODE_CALL0;
    int symbol = READ_SHORT();
    printf("CALL%-11d %5d '%s'\n", numArgs, symbol,
           vm->allMethodNames.datas[symbol].str);
    break;
  }

  case OPCODE_SUPER0:
  case OPCODE_SUPER1:
  case OPCODE_SUPER2:
  case OPCODE_SUPER3:
  case OPCODE_SUPER4:
  case OPCODE_SUPER5:
  case OPCODE_SUPER6:
  case OPCODE_SUPER7:
  case OPCODE_SUPER8:
  case OPCODE_SUPER9:
  case OPCODE_SUPER10:
  case OPCODE_SUPER11:
  case OPCODE_SUPER12:
  case OPCODE_SUPER13:
  case OPCODE_SUPER14:
  case OPCODE_SUPER15:
  case OPCODE_SUPER16:
  {
    int numArgs = bytecode[i - 1] - OPCODE_SUPER0;
    int symbol = READ_SHORT();
    int superclass = READ_SHORT();
    printf("SUPER%-10d %5d '%s' %5d\n", numArgs, symbol,
           vm->allMethodNames.datas[symbol].str, superclass);
    break;
  }

  case OPCODE_JUMP:
  {
    int offset = READ_SHORT();
    printf("%-16s offset:%-5d abs:%d\n", "JUMP", offset, i + offset);
    break;
  }

  case OPCODE_LOOP:
  {
    int offset = READ_SHORT();
    printf("%-16s offset:%-5d abs:%d\n", "LOOP", offset, i - offset);
    break;
  }

  case OPCODE_JUMP_IF_FALSE:
  {
    int offset = READ_SHORT();
    printf("%-16s offset:%-5d abs:%d\n", "JUMP_IF_FALSE", offset, i + offset);
    break;
  }

  case OPCODE_AND:
  {
    int offset = READ_SHORT();
    printf("%-16s offset:%-5d abs:%d\n", "AND", offset, i + offset);
    break;
  }

  case OPCODE_OR:
  {
    int offset = READ_SHORT();
    printf("%-16s offset:%-5d abs:%d\n", "OR", offset, i + offset);
    break;
  }

  case OPCODE_CLOSE_UPVALUE:
    printf("CLOSE_UPVALUE\n");
    break;

  case OPCODE_RETURN:
    printf("RETURN\n");
    break;

  case OPCODE_CREATE_CLOSURE:
  {
    int constant = READ_SHORT();
    printf("%-16s %5d ", "CREATE_CLOSURE", constant);
    dumpValue(fn->constants.datas[constant]);
    printf(" ");
    ObjFn *loadedFn = VALUE_TO_OBJFN(fn->constants.datas[constant]);
    uint32_t j;
    for (j = 0; j < loadedFn->upvalueNum; j++)
    {
      int isLocal = READ_BYTE();
      int index = READ_BYTE();
      if (j > 0)
        printf(", ");
      printf("%s %d", isLocal ? "local" : "upvalue", index);
    }
    printf("\n");
    break;
  }

  case OPCODE_CONSTRUCT:
    printf("CONSTRUCT\n");
    break;

  case OPCODE_CREATE_CLASS:
  {
    int numFields = READ_BYTE();
    printf("%-16s %5d fields\n", "CREATE_CLASS", numFields);
    break;
  }

  case OPCODE_INSTANCE_METHOD:
  {
    int symbol = READ_SHORT();
    printf("%-16s %5d '%s'\n", "INSTANCE_METHOD", symbol,
           vm->allMethodNames.datas[symbol].str);
    break;
  }

  case OPCODE_STATIC_METHOD:
  {
    int symbol = READ_SHORT();
    printf("%-16s %5d '%s'\n", "STATIC_METHOD", symbol,
           vm->allMethodNames.datas[symbol].str);
    break;
  }

  case OPCODE_END:
    printf("END\n");
    break;

  default:
    printf("UKNOWN! [%d]\n", bytecode[i - 1]);
    break;
  }

  // 返回指令占用的字节数
  if (opCode == OPCODE_END)
  {
    return -1;
  }
  return i - start;

#undef READ_BYTE
#undef READ_SHORT
}

// 打印指令
void dumpInstructions(VM *vm, ObjFn *fn)
{
  if (fn->module->name == NULL)
    return;

  printf("module:[%s]\tfunction:[%s]\n",
         fn->module->name == NULL ? "<core>" : fn->module->name->value.start,
         fn->debug->fnName);

  int i = 0;
  int lastLine = -1;
  while (true)
  {
    int offset = dumpOneInstruction(vm, fn, i, &lastLine);
    if (offset == -1)
      break;
    i += offset;
  }
  printf("\n");
}

static int startsWith(const char *str, const char *pattern)
{
  size_t strLength = strlen(str);
  size_t patternLength = strlen(pattern);

  // 如果模式长度大于字符串长度，返回0
  if (patternLength > strLength)
    return 0;

  // 使用strncmp函数比较前patternLength个字符
  if (strncmp(str, pattern, patternLength) == 0)
    return 1; // 匹配成功，返回1

  return 0; // 匹配失败，返回0
}

static int endsWith(const char *str, const char *pattern)
{
  size_t strLength = strlen(str);
  size_t patternLength = strlen(pattern);

  // 如果模式长度大于字符串长度，返回0
  if (patternLength > strLength)
    return 0;

  // 比较字符串后patternLength个字符
  if (strncmp(str + strLength - patternLength, pattern, patternLength) == 0)
    return 1; // 匹配成功，返回1

  return 0; // 匹配失败，返回0
}

void dumpCallStack(ObjThread *curThread)
{
#define INSTR_LINENO \
  (curFrame->closure->fn->debug->lineNo.datas[ip - curFrame->closure->fn->instrStream.datas - 1])
#define INSTR_FN_NAME \
  (curFrame->closure->fn->debug->fnName)
#define INSTR_FILE_NAME \
  (curFrame->closure->fn->debug->file)

  char buf[512];

  for (int i = curThread->usedFrameNum - 1; i >= 0; i--)
  {
    Frame *curFrame = &curThread->frames[i];
    uint8_t *ip = curFrame->ip;
    const char *fnName = INSTR_FN_NAME;
    const char *file = INSTR_FILE_NAME;
    int rootDirLen = rootDir ? strlen(rootDir) : 0;
    int fileLen = strlen(file);
    int bufLen = 0;

    if (fnName && fnName[0] == '(') // 在顶层执行的，没有具体的函数名
      fnName = "";

    if (!rootDir || (rootDir && startsWith(file, rootDir))) // 已经包含前缀了,或者没有根目录直接跳过
    {
      memmove(buf, file, fileLen);
      buf[fileLen] = '\0';
      bufLen = fileLen;
    }
    else
    {
      memmove(buf, rootDir, rootDirLen);
      memmove(buf + rootDirLen, file, fileLen);
      buf[rootDirLen + fileLen] = '\0';
      bufLen = rootDirLen + fileLen;
    }

    if (!endsWith(buf, ".sp"))
    {
      memmove(buf + bufLen, ".sp", 3);
      buf[bufLen + 3] = '\0';
    }

    buf[511] = '\0';

    // ip表示当前执行中指令的下一条指令的起始地址，在这个基础上减去1就是当前指令的末尾
    // 去除该处byte所对应的行号即可

    if (strlen(fnName) == 0)
      printf("    at %s:%d\n", buf, INSTR_LINENO);
    else
      printf("    at %s (%s:%d)\n", fnName, buf, INSTR_LINENO);
  }
  fflush(stdout);
}

#endif // DEBUG