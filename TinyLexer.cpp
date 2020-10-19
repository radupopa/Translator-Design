// TinyLexer.cpp : This file contains the 'main' function. Program execution begins and ends there.

#include <stdio.h>
#include "symbols.h"
#include <errno.h>

extern FILE* yyin;
extern int yylex(void);
const char* lexUnits[] = { "END",
							"INT",
							"RETURN",
							"RBRACE",
							"SEMICOLON",
							"TIMES",
							"WRITE",
							"NOT",
							"IF",
							"LPAR",
							"LBRACK",
							"COMMA",
							"DIVIDE",
							"READ",
							"LENGTH",
							"ELSE",
							"RPAR",
							"RBRACK",
							"PLUS",
							"EQUAL",
							"GREATER",
							"WHILE",
							"NEQUAL",
							"LBRACE",
							"ASSIGN",
							"MINUS",
							"CHAR",
							"LESS",
							"END_OF_INSTRUCTION" };

int main()
{
	int tokenValue = 0;
	yyin = fopen("input.csrc", "rt");
	if (yyin != NULL)
	{
		while ((tokenValue = yylex()) != END)
		{
			printf(" -> TOKEN ID: %d; Token Value: %s \n", tokenValue, lexUnits[tokenValue]);
		}
	}
	else
	{
		printf("Fisierul de intrare nu poate fi deschis. Erorare: %d", errno);
	}


}

