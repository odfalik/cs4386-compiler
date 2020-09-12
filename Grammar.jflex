import java_cup.runtime.*;

%%

%public
%cup
%line
%column
%unicode
%class Lexer
 
%{
  StringBuffer string = new StringBuffer();

  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }

  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
  }
%}


tab                 = \\t
newline		        = \\n
slash               = \\
letter              = [A-Za-z]
digit               = [0-9]
id                  = {letter}({letter}|{digit})*
intlit	            = {digit}+
floatlit            = {digit}+ \. {digit}+
inlinecomment       = {slash}{slash}.*\n
whitespace          = [ \n\r\t]


char                = [^\'\\\n\r] | {escchar}
strcontents         = ([^\"\\\n\r] | {escchar})*
escchar             = \\[ntbrf\\\'\"]

%%

class               { return symbol(sym.CLASS, "class"); }
final               { return symbol(sym.FINAL, "final"); }
void                { return symbol(sym.VOID, "void"); }

int                 { return symbol(sym.INT, "int"); }
char                { return symbol(sym.CHAR, "char"); }
bool                { return symbol(sym.BOOL, "bool"); }
float               { return symbol(sym.FLOAT, "float"); }

if		            { return symbol(sym.IF, "if"); }
else		        { return symbol(sym.ELSE, "else"); }
while		        { return symbol(sym.WHILE, "while"); }
read		        { return symbol(sym.READ, "read"); }
print		        { return symbol(sym.PRINT, "print"); }
printline		    { return symbol(sym.PRINTLN, "println"); }
return		        { return symbol(sym.RETURN, "return"); }

"("                 { return symbol(sym.PAREN_O, "("); }
")"                 { return symbol(sym.PAREN_C, ")"); }
"["                 { return symbol(sym.BRACKET_O, "["); }
"]"                 { return symbol(sym.BRACKET_C, "]"); }
"{"                 { return symbol(sym.CURLY_BRACKET_O, "{"); }
"}"                 { return symbol(sym.CURLY_BRACKET_C, "}"); }

";"                 { return symbol(sym.SEMI, ";"); }
","                 { return symbol(sym.COMMA, ","); }
"?"                 { return symbol(sym.QUESTION, "?"); }
":"                 { return symbol(sym.COLON, ":"); }

"="                 { return symbol(sym.ASSN, "="); }

"*"                 { return symbol(sym.MULT, "*"); }
"/"                 { return symbol(sym.DIVIDE, "/"); }
"+"                 { return symbol(sym.PLUS, "+"); }
"-"                 { return symbol(sym.MINUS, "-"); }
"<"                 { return symbol(sym.LT, "<"); }
">"                 { return symbol(sym.GT, ">"); }
"<="                { return symbol(sym.LTE, "<="); }
">="                { return symbol(sym.GTE, ">="); }
"=="                { return symbol(sym.EQ, "=="); }
"<>"                { return symbol(sym.NEQ, "<>"); }
"||"                { return symbol(sym.OR, "||"); }
"&&"                { return symbol(sym.AND, "&&"); }
"~"                 { return symbol(sym.NOT, "~"); }

"++"                { return symbol(sym.INC, "++"); }
"--"                { return symbol(sym.DEC, "--"); }

true                { return symbol(sym.TRUE, "true"); }
false               { return symbol(sym.FALSE, "false"); }

{id}                { return symbol(sym.ID, yytext()); }
{intlit}            { return symbol(sym.INTLIT, new Integer(yytext())); }


\'{char}\'          { return symbol(sym.CHARLIT); }
\"{strcontents}*\"  { return symbol(sym.STRLIT); }
{floatlit}          { return symbol(sym.FLOATLIT); }
