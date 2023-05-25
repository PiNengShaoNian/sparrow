#ifdef DEBUG

#include <stdio.h>
#include "debug.h"
#include "vm.h"
#include <string.h>

void bindDebugFnName(UNUSED VM *vm, UNUSED FnDebug *fnDebug,
                     UNUSED const char *name, UNUSED uint32_t length) {}

#endif // DEBUG