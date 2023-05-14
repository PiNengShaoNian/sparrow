#ifndef _PARSER_PARSER_H
#define _PARSER_PARSER_H

#include "common.h"

typedef struct
{
    uint32_t lineNo;
} Token;

struct parser
{
    const char *file;
    Token preToken;
};

#endif // _PARSER_PARSER_H