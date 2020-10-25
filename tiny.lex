NAME		([a-zA-Z])[a-zA-Z0-9_]*
NUMBER      [0-9]+
QCHAR       \'.\'
COMMENT		\/{2}.*

%{
#include <stdio.h>
#include "symbols.h"

void count();
%}

%%
"//"            { printf("Comment: "); comment(); }

"int"           { count(); return(INT); }
"return"        { count(); return(RETURN); }
"}"             { count(); return(RBRACE); }
";"             { count(); return(SEMICOLON); }
"*"             { count(); return(TIMES); }
"write"         { count(); return(WRITE); }
"!"             { count(); return(NOT); }
"if"            { count(); return(IF); }
"("             { count(); return(LPAR); }
"["             { count(); return(LBRACK); }
","             { count(); return(COMMA); }
"/"             { count(); return(DIVIDE); }
"read"          { count(); return(READ); }
"length"        { count(); return(LENGTH); }
"else"          { count(); return(ELSE); }
")"             { count(); return(RPAR); }
"]"             { count(); return(RBRACK); }
">"             { count(); return(GREATER); }
"while"         { count(); return(WHILE); }
"!="            { count(); return(NEQUAL); }
"{"             { count(); return(LBRACE); }
"char"          { count(); return(CHAR); }
"<"             { count(); return(LESS); }

"+"             { count(); return(PLUS); }
"=="            { count(); return(EQUAL); }
"="             { count(); return(ASSIGN); }
"-"             { count(); return(MINUS); }

{NAME}			{ count(); return(NAME); }
{NUMBER}		{ count(); return(CONSTANT); }
{QCHAR}			{ count(); return(CONSTANT); }

[ \t\v\n\f]		{ count(); }
.				{ printf("The character is not valid"); }

%%

yywrap()
{
	return(1);
}

comment()
{
	char c;

loop:
	while ((c = input()) != '\n' && c != 0)
		putchar(c);
}

int column = 0;

void count()
{
	int i;

	for (i = 0; yytext[i] != '\0'; i++)
		if (yytext[i] == '\n')
			column = 0;
		else if (yytext[i] == '\t')
			column += 8 - (column % 8);
		else
			column++;

	ECHO;
}
