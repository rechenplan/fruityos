# yuzu

## intro

a smol system language

## requirements

* gcc
* nasm
* a 64 bit linux kernel

## components

this repository contains four pieces of software

1. byc: a bootstrapping compiler for yuzu written in c
2. zest: an assembler written in yuzu
3. yc: a yuzu compiler written in yuzu
4. libpith.asm: a standard library for x86-64 linux
5. yuzu: a script that uses all of these in conjunction to take yuzu code and produce native linux executables

## bootstrapping sequence

the build.sh script will bootstrap yuzu by performing the following operations:

1. compile byc with gcc and libpith with nasm. link with ld.
2. compile zest with byc (which will produce assembly output). assemble zest and libpith with nasm. link with ld
3. compile yc with byc and assemble yc and libpith with zest.

now we have a compiler frontend (yc), assembler (zest), library (libpith) that are togther capable of building themselves.

## yuzu grammar

non-terminals are enclosed in <>. terminals are enclosed in "". a term is a terminal, non-terminal, or concatenation of two terms. {} around a ebnf term denote that this term can be repeated 0 or more times. [] around a ebnf term denote that this term can be repeated 0 or 1 times.

	<PROGRAM>	::= { <DEFINITION> }
	
	<DEFINITION>	::= <SUB> <ID> <LPAREN> [ <ID> { <COMMA> <ID> } ] <RPAREN> { <STATEMENT> } <END>
	
	<STATEMENT>	::= <LOCAL> <ID> { <COMMA> <ID> }
			| <IF> <RVALUE> <THEN> { <STATEMENT> } [ <ELSE> { <STATEMENT> } ] <END>
			| <WHILE> <RVALUE> <DO> { <STATEMENT> } <END>
			| <RETURN> <RVALUE>
			| <RVALUE>

	<LVALUE>	::= <ID>
			| <LBRACKET> <RVALUE> <RBRACKET>

	<RVALUE>	::= <RVALUE> <BINOP> <RVALUE>
			| <LVALUE> <LPAREN> [ <RVALUE> { <COMMA> <RVALUE> } ] <RPAREN>
			| <LVALUE>
			| <LVALUE> <ASSIGN> <RVALUE>
			| <BYTE> <LVALUE>
			| <BYTE> <LVALUE> <ASSIGN> <RVALUE>
			| <UNARY> <RVALUE>
			| <LPAREN> <RVALUE> <RPAREN>
			| <CONSTANT>

	<BINOP>		::= <PLUS> | <MINUS> | <ASTERISK> | <DIVIDE> | <MODULUS>
			| <AND> | <BAND> | <OR> | <BOR> | <XOR> | <LSHIFT> | <RSHIFT>
			| <EQUAL> | <NOTEQUAL> | <GREATERTHAN> | <LESSTHAN> | <GEQ> | <LEQ>

	<UNARY>		::= <MINUS> | <NOT> | <BNOT>

	<CONSTANT>	::= <NUMBER> | <STRLIT>

## yuzu lexer notes

tokens scanned by lexer (note if a string appears as a prefix of another, then it must come after it):

	<LPAREN> 	::= "(" 
	<RPAREN> 	::= ")" 
	<LBRACKET> 	::= "[" 
	<RBRACKET> 	::= "]" 
	<COMMA> 	::= "," 
	<PLUS> 		::= "+" 
	<MINUS> 	::= "-" 
	<ASTERISK> 	::= "*" 
	<DIVIDE> 	::= "/" 
	<MODULUS> 	::= "%" 
	<BAND>		::= "&&"
	<AND> 		::= "&" 
	<BOR>		::= "||"
	<OR> 		::= "|" 
	<XOR> 		::= "^" 
	<EQUAL> 	::= "==" 
	<ASSIGN> 	::= "="
	<NOTEQUAL> 	::= "!="
	<BNOT>		::= "!"
	<NOT>		::= "~"
	<LSHIFT> 	::= "<<" 
	<LEQ> 		::= "<=" 
	<LESSTHAN> 	::= "<"
	<RSHIFT> 	::= ">>" 
	<GEQ> 		::= ">="
	<GREATERTHAN> 	::= ">"
	<BYTE>		::= "byte"
	<LOCAL>		::= "local"
	<IF>		::= "if"
	<THEN>		::= "then"
	<ELSE>		::= "else"
	<END>		::= "end"
	<WHILE>		::= "while"
	<DO>		::= "do"
	<SUB>		::= "sub"
	<RETURN>	::= "return"

	<STRLIT> 	::= "\"" { <CHAR> } "\""
	<NUMBER> 	::= <DIGIT> { <DIGIT> }
	<ID> 		::= <LOWERALPHA> { <ALPHADIGIT> }


Example code:

	sub eliminateCats(numCats)

		; this is a comment
		if numCats > 5 then numCats = numCats - 1 end
		return numCats

	end
