# LexYacc
### 词法分析器生成脚本
[lexer.l](https://github.com/easyfuck/LexYacc/blob/master/lexer.l)
### 语法分析器生成脚本
[parser.y](https://github.com/easyfuck/LexYacc/blob/master/parser.y)

### 词法脚本基本格式
simple.l
```lex
%{
//这里可以直接写c语言代码
%}

正则表达式宏定义

%%

字段匹配处理

%%

C语言代码区

```
由两个百分号（%%）来分隔三个段，第一段用于定，第二段用于处理字段匹配，第三段用于函数代码。
例子:
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

