# byc bootstrap compiler

byc is a bootstrap compiler for the yuzu language written in c. yuzu is inspired by lua and the b programming language. specifically, the version of the b programming language presented at https://web.archive.org/web/20150611114427/https://www.bell-labs.com/usr/dmr/www/kbman.pdf. this directory will be the home of the yuzu bootstrapping compiler. the yuzu bootstrapping compiler will be written in c, with a later rewrite of the yuzu compiler written in yuzu planned down the road. byc outputs nasm style assembly.

## usage

	bin/byc test.yuzu > test.asm

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

## intermediate language

byc compiles to nasm style assembly
