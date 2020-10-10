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
    return new Symbol(type, yyline, yycolumn, yytext());
  }

  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
  }

  private void illegal(int line, long col) {
    System.out.format("ILLEGAL %2s, %-8s %-10s\n", line+1, col, yytext());
  }
%}

tab                 = \\t
newline		          = \\n
slash               = \\
letter              = [A-Za-z]
digit               = [0-9]
id                  = {letter}({letter}|{digit})*
comment             = \\\\.*((\r\n)|\n)
multilinecomment    = \\\*~\*\\
whitespace          = [ \n\r\t]


%%


class               { return symbol(sym.CLASS); }
final               { return symbol(sym.FINAL); }
void                { return symbol(sym.VOID); }

int                 { return symbol(sym.INT); }
char                { return symbol(sym.CHAR); }
bool                { return symbol(sym.BOOL); }
float               { return symbol(sym.FLOAT); }

if		              { return symbol(sym.IF); }
else		            { return symbol(sym.ELSE); }
while		            { return symbol(sym.WHILE); }
read		            { return symbol(sym.READ); }
print		            { return symbol(sym.PRINT); }
printline		        { return symbol(sym.PRINTLN); }
return		          { return symbol(sym.RETURN); }

"("                 { return symbol(sym.PAREN_O); }
")"                 { return symbol(sym.PAREN_C); }
"["                 { return symbol(sym.BRACKET_O); }
"]"                 { return symbol(sym.BRACKET_C); }
"{"                 { return symbol(sym.CURLY_BRACKET_O); }
"}"                 { return symbol(sym.CURLY_BRACKET_C); }

";"                 { return symbol(sym.SEMI); }
","                 { return symbol(sym.COMMA); }
"?"                 { return symbol(sym.QUESTION); }
":"                 { return symbol(sym.COLON); }

"="                 { return symbol(sym.ASSN); }

"*"                 { return symbol(sym.MULT); }
"/"                 { return symbol(sym.DIVIDE); }
"+"                 { return symbol(sym.PLUS); }
"-"                 { return symbol(sym.MINUS); }
"<"                 { return symbol(sym.LT); }
">"                 { return symbol(sym.GT); }
"<="                { return symbol(sym.LTE); }
">="                { return symbol(sym.GTE); }
"=="                { return symbol(sym.EQ); }
"<>"                { return symbol(sym.NEQ); }
"||"                { return symbol(sym.OR); }
"&&"                { return symbol(sym.AND); }
"~"                 { return symbol(sym.NOT); }

"++"                { return symbol(sym.INC); }
"--"                { return symbol(sym.DEC); }

true                { return symbol(sym.TRUE); }
false               { return symbol(sym.FALSE); }

{id}                { return symbol(sym.ID); }
{digit}+            { return symbol(sym.INTLIT, new Integer(yytext())); }

\'[^\'\\]\'         { return symbol(sym.CHARLIT); }
\"                  { yybegin(STRING); }
{digit}+\.{digit}+  { return symbol(sym.FLOATLIT, new Double(yytext())); }

{comment}           |
{multilinecomment}  { }
{whitespace}+       { }

[^]                 { illegal(yyline, yychar); }

{charlit}           { return newSym(sym.CHARLIT, yytext()); }
{stringlit}	        { return newSym(sym.STRINGLIT, yytext()); }
{inlinecomment}     { /* For this stand-alone lexer, print out comments. */}
{blockcomment}	    { /* For this stand-alone lexer, print out comments. */}
{whitespace}        { /* Ignore whitespace. */ }
.                   { System.out.println("Illegal char, '" + yytext() +
                    "' line: " + yyline + ", column: " + yychar); } 