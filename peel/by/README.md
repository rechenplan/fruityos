# by bootstrap compiler

by is a bootstrap compiler for the y;uzu language. yuzu is inspired by lua and the b programming language. specifically, the version of the b programming language presented at https://web.archive.org/web/20150611114427/https://www.bell-labs.com/usr/dmr/www/kbman.pdf. this directory will be the home of the yuzu bootstrapping compiler. the yuzu bootstrapping compiler will be written in c, with a later rewrite of the yuzu compiler written in yuzu planned down the road.

## parser notes

### grammar

non-terminals are enclosed in <>. terminals are enclosed in "". a term is a terminal, non-terminal, or concatenation of two terms. {} around a ebnf term denote that this term can be repeated 0 or more times. [] around a ebnf term denote that this term can be repeated 0 or 1 times.

	<PROGRAM>	::= { <DEFINITION> }
	
	<DEFINITION>	::= <DEF> <NAME> <LPAREN> [ <NAME> { <COMMA> <NAME> } ] <RPAREN> { <STATEMENT> } <END>
	
	<STATEMENT>	::= <LOCAL> <NAME> [ <LBRACKET> <NUMBER> <RBRACKET> ] { <COMMA> <NAME> [ <LBRACKET> <NUMBER> <RBRACKET> ] }
			| <IF> <RVALUE> <THEN> { <STATEMENT> } [ <ELSE> { <STATEMENT> } ] <END>
			| <WHILE> <RVALUE> <DO> { <STATEMENT> } <END>
			| <RETURN> <RVALUE>
			| <LVALUE> <ASSIGN> <RVALUE>
			| <RVALUE> <LPAREN> [ <RVALUELIST> ] <RPAREN>
	
	<LVALUE>	::= <NAME> <LBRACKET> <RVALUE> <RBRACKET>
			| <NAME>
			| <DEREF> <RVALUE>

	<RVALUELIST>	::= <RVALUE> { <COMMA> <RVALUE> }

	<RVALUE>	::= <NAME> <LBRACKET> <RVALUE> <RBRACKET>
			| <NAME> <LPAREN> [ <RVALUELIST> ] <RPAREN>
			| <NAME>
			| <DEREF> <NAME>
			| <REF> <NAME>
			| <CONSTANT>
			| <LPAREN> <RVALUE> <BINARY> <RVALUE> <RPAREN>
			| <UNARY> <RVALUE>

	<BINARY>	::= <PLUS>
			| <MINUS>
			| <MULTIPLY>
			| <DIVIDE>
			| <MODULUS>
			| <AND>
			| <BAND>
			| <OR>
			| <BOR>
			| <XOR>
			| <LSHIFT>
			| <RSHIFT>
			| <EQUAL>
			| <NOTEQUAL>
			| <GREATERTHAN>
			| <LESSTHAN>
			| <GEQ>
			| <LEQ>

	<UNARY>		::= <MINUS> | <NOT> | <BNOT>

	<CONSTANT>	::= <NUMBER> | <STRLIT>

## lexer notes

tokens scanned by lexer (note if a string appears as a prefix of another, then it must come after it):

	<LPAREN> 	::= "(" 
	<RPAREN> 	::= ")" 
	<LBRACKET> 	::= "[" 
	<RBRACKET> 	::= "]" 
	<COMMA> 	::= "," 
	<ASSIGN> 	::= ":=" 
	<PLUS> 		::= "+" 
	<MINUS> 	::= "-" 
	<MULTIPLY> 	::= "*" 
	<DIVIDE> 	::= "/" 
	<MODULUS> 	::= "%" 
	<BAND>		::= "&&"
	<AND> 		::= "&" 
	<BOR>		::= "||"
	<OR> 		::= "|" 
	<XOR> 		::= "^" 
	<EQUAL> 	::= "==" 
	<NOTEQUAL> 	::= "!="
	<BNOT>		::= "!"
	<NOT>		::= "~"
	<LSHIFT> 	::= "<<" 
	<LEQ> 		::= "<=" 
	<LESSTHAN> 	::= "<"
	<RSHIFT> 	::= ">>" 
	<GEQ> 		::= ">="
	<GREATERTHAN> 	::= ">"
	<LOCAL>		::= "LOCAL"
	<IF>		::= "IF"
	<THEN>		::= "THEN"
	<ELSE>		::= "ELSE"
	<END>		::= "END"
	<WHILE>		::= "WHILE"
	<DO>		::= "DO"
	<DEF>		::= "DEF"
	<DEREF>		::= "DEREF"
	<REF>		::= "REF"
	<RETURN>	::= "RETURN"

	<STRLIT> 	::= "\"" { <CHAR> } "\""
	<NUMBER> 	::= <DIGIT> { <DIGIT> }
	<NAME> 		::= <LOWERALPHA> { <ALPHADIGIT> }


Example code:

	DEF eliminateCats(numCats)

		{ this will eliminate cats }
		IF numCats > 5 THEN numCats := ( numCats - 1 ) END
		RETURN numCats

	END

## intermediate language

More thoughts to come
