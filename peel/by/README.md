# by bootstrap compiler

by is a bootstrap compiler for the y;uzu language. yuzu is inspired by lua and the b programming language. specifically, the version of the b programming language presented at https://web.archive.org/web/20150611114427/https://www.bell-labs.com/usr/dmr/www/kbman.pdf. this directory will be the home of the yuzu bootstrapping compiler. the yuzu bootstrapping compiler will be written in c, with a later rewrite of the yuzu compiler written in yuzu planned down the road.

## lexer notes

### reserved keywords

	local, return, if, then, else, while, do, end, deref, ref

## parser notes

### grammar

non-terminals are enclosed in <>. terminals are enclosed in "". a term is a terminal, non-terminal, or concatenation of two terms. {} around a ebnf term denote that this term can be repeated 0 or more times. [] around a ebnf term denote that this term can be repeated 0 or 1 times. Between all terms is an implicit { `<WS>` } with the exception of the definitions of `<NAME>` and `<CONSTANT>`. `<WS>` denotes white space, `<ALPHA>` denotes alphabetic characters, and `<NUM>` denotes numeric characters.

	<PROGRAM>	::= { <DEFINITION> }
	
	<DEFINITION>	::= <NAME> <LPAREN> [ <NAME> { <COMMA> <NAME> } ] <RPAREN> { <STATEMENT> } <END>
	
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
			| <OR>
			| <XOR>
			| <LSHIFT>
			| <RSHIFT>
			| <EQUAL>
			| <NOTEQUAL>
			| <GREATERTHAN>
			| <LESSTHAN>
			| <GEQ>
			| <LEQ>

	<UNARY>		::= <MINUS> | <NOT>

	<CONSTANT>	::= <NUMBER> | <STRLIT>

Tokens scanned by lexer (*):

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
	<AND> 		::= "&" 
	<OR> 		::= "|" 
	<XOR> 		::= "^" 
	<EQUAL> 	::= "==" 
	<NOTEQUAL> 	::= "~=" 
	<NOT> 		::= "~" 
	<LESSTHAN> 	::= "<" 
	<LSHIFT> 	::= "<<" 
	<LEQ> 		::= "<=" 
	<GREATERTHAN> 	::= ">" 
	<RSHIFT> 	::= ">>" 
	<GEQ> 		::= ">="

	<LOCAL>		::= "local"
	<RETURN>	::= "return"
	<IF>		::= "if"
	<THEN>		::= "then"
	<ELSE>		::= "else"
	<WHILE>		::= "while"
	<DO>		::= "do"
	<END>		::= "end"
	<DEREF>		::= "deref"
	<REF>		::= "ref"


	<STRLIT> 	::= <QUOTE> { <CHAR> } <QUOTE>
	<NAME> 		::= <ALPHA> { <ALPHADIGIT> }
	<NUMBER> 	::= <DIGIT> { <DIGIT> }


## intermediate language

More thoughts to come
