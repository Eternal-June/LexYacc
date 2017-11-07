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
%token NUM
%token '+'
%token '-'
%token '*'
%token '/'
%token '%'
%token '('
%token ')'
%left '+'  '-'
%left '*'  '/'  '%'

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
		'(' expression ')' {$<value>$ = $<value>2;}
		|
		expression '+' expression  {$<value>$ = $<value>1 + $<value>3;}
		|
		expression '-' expression  {$<value>$ = $<value>1 - $<value>3;}
		|
		expression '*' expression  {$<value>$ = $<value>1 * $<value>3;}
		|
		expression '/' expression  {$<value>$ = $<value>1 / $<value>3;}
		|
		expression '%' expression  {$<value>$ = fmod($<value>1, $<value>3);}
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
