%{
#include <string.h>
#include "parser.h"
#ifdef TEST_LEXER
#define CopyText()	
#else
#define CopyText()	strcpy(yylval.text, yytext)
#endif
extern  char *yytext;
extern "C" int yylex(void);
extern "C" int yywrap(void);
%}

NUM [0-9]+([.][0-9]+)?

%%

{NUM}	{CopyText(); return NUM;}
"+"		{CopyText(); return ADD;}
"-"		{CopyText(); return MIN;}
"*"		{CopyText(); return MUL;}
"/"		{CopyText(); return DIV;}
"%"		{CopyText(); return MOD;}
"("		{CopyText(); return LP;}
")"		{CopyText(); return RP;}
"\n"	{return 0;}
.		{}

%%


int yywrap(void)
{
	return 1;
}

#ifdef TEST_LEXER

int main(void)
{
	yylex();
	return 0;
}

#endif//TEST_LEXER
