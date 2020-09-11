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

FILE=		ExampleLexer.java      parser.java    sym.java \
				ExampleLexerTest.java

run: basicTerminals.txt

basicTerminals.txt: all
		$(JAVA) -cp $(CP) ExampleLexerTest basicTerminals.txt > out.txt
		cat -n out.txt

all: ExampleLexer.java parser.java $(FILE:java=class)

clean:
		rm -f *.class *~ *.bak ExampleLexer.java parser.java sym.java

ExampleLexer.java: exampleGrammar.jflex
		$(JFLEX) exampleGrammar.jflex

parser.java: exampleTokens.cup
		$(CUP) -interface < exampleTokens.cup

parserD.java: exampleTokens.cup
		$(CUP) -interface -dump < exampleTokens.cup
