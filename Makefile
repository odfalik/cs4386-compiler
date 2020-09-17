JAVA=java
JAVAC=javac
JFLEX=$(JAVA) -jar jflex-1.8.2/lib/jflex-full-1.8.2.jar
CUPJAR=./java-cup-11b.jar
CUP=$(JAVA) -jar $(CUPJAR)
CP=.:$(CUPJAR)

default: run

.SUFFIXES: $(SUFFIXES) .class .java

.java.class:
				$(JAVAC) -cp $(CP) $*.java

FILE=		Lexer.java      parser.java    sym.java \
				LexerTest.java

run: code.txt

code.txt: all
		$(JAVA) -cp $(CP) LexerTest code.txt > out.txt
		cat -n out.txt

basicTerminals.txt: all
		$(JAVA) -cp $(CP) LexerTest basicTerminals.txt > out.txt
		cat -n out.txt

basicRegex.txt: all
		$(JAVA) -cp $(CP) LexerTest basicRegex.txt > out.txt
		cat -n out.txt

basicFails.txt: all
		$(JAVA) -cp $(CP) LexerTest basicFails.txt > out.txt
		cat -n out.txt

all: Lexer.java parser.java $(FILE:java=class)

clean:
		rm -f *.class *~ *.bak Lexer.java parser.java sym.java

Lexer.java: Grammar.jflex
		$(JFLEX) Grammar.jflex

parser.java: Grammar.cup
		$(CUP) -interface < Grammar.cup

parserD.java: Grammar.cup
		$(CUP) -interface -dump < Grammar.cup
