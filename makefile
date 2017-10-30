CC:=g++
LEX:=lex
YACC:=yacc

all: parser lexer 

lexer: lexer.cpp lexer.h
	$(CC) -DTEST_LEXER $+ -o $@

parser: parser.cpp parser.h lexer.cpp lexer.h
	$(CC) -DTEST_PARSER $+ -o $@

lexer.cpp: lexer.l
	$(LEX) -o $@ --header-file=lexer.h $+

lexer.h: lexer.l
	$(LEX) -o $@ --header-file=lexer.h $+

parser.cpp: parser.y
	$(YACC) -o $@ --defines=parser.h $+

parser.h: parser.y
	$(YACC) -o $@ --defines=parser.h $+

clean:
	@rm -v lexer parser *.swp *.cpp *.h -rf
