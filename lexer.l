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
"+"		{CopyText(); return '+';}
"-"		{CopyText(); return '-';}
"*"		{CopyText(); return '*';}
"/"		{CopyText(); return '/';}
"%"		{CopyText(); return '%';}
"("		{CopyText(); return '(';}
")"		{CopyText(); return ')';}
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
