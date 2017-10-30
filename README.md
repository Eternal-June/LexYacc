# LexYacc
### 需要具备以下基础知识
[Yacc 与 Lex 快速入门](https://www.ibm.com/developerworks/cn/linux/sdk/lex/)
### 词法分析器生成脚本
[lexer.l](https://github.com/easyfuck/LexYacc/blob/master/lexer.l)
### 语法分析器生成脚本
[parser.y](https://github.com/easyfuck/LexYacc/blob/master/parser.y)

### 词法脚本基本格式
```lex
%{
C语言代码区，一般用于头文件引入，宏定义，变量定义，函数声明
%}

正则表达式宏定义

%%

字段匹配处理

%%

C语言代码区

```
由两个百分号（%%）来分隔三个段，第一段用于定，第二段用于处理字段匹配，第三段用于函数代码。
以下是一个用于打印出所有整数的词法分析器例子:
```lex
%{
#include <stdio.h>
%}

NUM [0-9]+

%%

{NUM} {printf("%s\n", yytext);}
.      {}
"\n"   {return 0;}

%%

int main(void)
{
    yylex();
    return 0;
}
```

