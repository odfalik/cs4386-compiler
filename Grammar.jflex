import java_cup.runtime.*;


%%
/*-*
 * LEXICAL FUNCTIONS:
 */

%cup
%line
%column
%unicode
%class Lexer
 
%{

    /**
    * Return a new Symbol with the given token id, and with the current line and
    * column numbers.
    */
    Symbol newSym(int tokenId) {
        return new Symbol(tokenId, yyline, yycolumn);
    }

    /**
    * Return a new Symbol with the given token id, the current line and column
    * numbers, and the given token value.  The value is used for tokens such as
    * identifiers and numbers.
    */
    Symbol newSym(int tokenId, Object value) {
        return new Symbol(tokenId, yyline, yycolumn, value);
    }

%}


/*-*
 * PATTERN DEFINITIONS:
 */

tab             = \\t
newline		    = \\n
slash           = \\
letter          = [A-Za-z]
digit           = [0-9]
id              = {letter}({letter}|{digit})*
intlit	        = {digit}+
inlinecomment   = {slash}{slash}.*\n
whitespace      = [ \n\r\t]
// comment_text    = ([^*/\n]|[^*\n]"/"[^*\n]|[^/\n]"*"[^/\n]|"*"[^/\n]|"/"[^*\n])+



%%
/**
 * LEXICAL RULES:
 */
read                { return newSym(sym.READ, "read"); }
print		        { return newSym(sym.PRINT, "print"); }
if		            { return newSym(sym.IF, "if"); }

"*"                 { return newSym(sym.MULT, "*"); }
"+"                 { return newSym(sym.PLUS, "+"); }
"-"                 { return newSym(sym.MINUS, "-"); }
"/"                 { return newSym(sym.DIVIDE, "/"); }
"="                 { return newSym(sym.ASSN, "="); }
";"                 { return newSym(sym.SEMI, ";"); }
var		            { return newSym(sym.VAR, "var"); }
{id}                { return newSym(sym.ID, yytext()); }
{intlit}            { return newSym(sym.INTLIT, new Integer(yytext())); }
{inlinecomment}     { /* For this stand-alone lexer, print out comments. */}
{whitespace}        { /* Ignore whitespace. */ }
// .                   { System.out.println("Illegal char, '" + yytext() + "' line: " + yyline + ", column: " + yychar); } 

