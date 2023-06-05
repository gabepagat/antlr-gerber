# Set variables
ANTLR4=antlr
GRUN=grun

# Install
install:
	$(ANTLR4) -Dlanguage=Python3 GerberLexer.g4
	$(ANTLR4) -Dlanguage=Python3 GerberParser.g4

	mkdir -p ./parser
	install *.py ./parser

# Clean
clean:
	rm -rf *.java
	rm -rf *.class
	rm -rf *.interp
	rm -rf *.tokens
	rm -rf less
	rm -rf .antlr
	rm -rf *.js
	rm -rf *.ts
	rm -rf *.cs
	rm -rf *.py
	rm -rf parser

# Gui
gui:
	$(ANTLR4) GerberLexer.g4
	$(ANTLR4) GerberParser.g4
	javac *.java
	$(GRUN) Gerber gerber -gui -tree ./test.gbr

# Tokens
tokens:
	$(ANTLR4) GerberLexer.g4
	$(ANTLR4) GerberParser.g4
	javac *.java
	$(GRUN) Gerber gerber -tokens -tree ./test.gbr
