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


tab             = \\t
newline		    = \\n
slash           = \\
letter          = [A-Za-z]
digit           = [0-9]
id              = {letter}({letter}|{digit})*
intlit	        = {digit}+
inlinecomment   = {slash}{slash}.*\n
whitespace      = [ \n\r\t]

%%
/**
 * LEXICAL RULES:
 */
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

read                { return symbol(sym.READ, "read"); }
print		        { return symbol(sym.PRINT, "print"); }

"*"                 { return symbol(sym.MULT, "*"); }
"+"                 { return symbol(sym.PLUS, "+"); }
"-"                 { return symbol(sym.MINUS, "-"); }
"/"                 { return symbol(sym.DIVIDE, "/"); }
"="                 { return symbol(sym.ASSN, "="); }
";"                 { return symbol(sym.SEMI, ";"); }
var		            { return symbol(sym.VAR, "var"); }
{id}                { return symbol(sym.ID, yytext()); }
{intlit}            { return symbol(sym.INTLIT, new Integer(yytext())); }
{inlinecomment}     { /* For this stand-alone lexer, print out comments. */}
{whitespace}        { /* Ignore whitespace. */ }
// .                   { System.out.println("Illegal char, '" + yytext() + "' line: " + yyline + ", column: " + yychar); } 

