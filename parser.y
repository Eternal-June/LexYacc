%{
#include <math.h>
#include <stdio.h>
extern "C" int yylex(void);
extern "C" void yyerror(const char*);
%}

%union
{
	struct
	{
		double value;
		char text[256];
	};
}

%type <double> NUM
%token NUM ADD MIN MUL DIV MOD LP RP
%left ADD MIN
%left MUL DIV MOD

%%

program:
		statement
		;
statement:
		expression { printf("=%f\n", $<value>1);}
		;
expression:
		NUM	{$<value>$ = strtod($<text>1, 0);}
		|
		LP expression RP {$<value>$ = $<value>2;}
		|
		expression ADD expression  {$<value>$ = $<value>1 + $<value>3;}
		|
		expression MIN expression  {$<value>$ = $<value>1 - $<value>3;}
		|
		expression MUL expression  {$<value>$ = $<value>1 * $<value>3;}
		|
		expression DIV expression  {$<value>$ = $<value>1 / $<value>3;}
		|
		expression MOD expression  {$<value>$ = fmod($<value>1, $<value>3);}
		;

%%

void yyerror(const char *p)
{
	printf("%s\n", p ? p : __func__);
}

#ifdef TEST_PARSER
int main(int argc, char **argv)
{
	yyparse();
	return 0;
}
#endif//TEST_PARSER
