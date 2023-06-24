# by bootstrap compiler

by is a bootstrap compiler for the yuzu language. yuzu is inspired by the B programming language. specifically, the version of the B programming language presented at https://web.archive.org/web/20150611114427/https://www.bell-labs.com/usr/dmr/www/kbman.pdf. this directory will be the home of the yuzu bootstrapping compiler. the yuzu bootstrapping compiler will be written in C, with a later rewrite of the yuzu compiler written in yuzu planned down the road.

## lexer notes

A yuzu token is what?

## parser notes

### grammar

Non-terminals are enclosed in <>. Terminals are enclosed in "". A term is a terminal, non-terminal, or concatenation of two terms. {} around a ebnf term denote that this term can be repeated 0 or more times. [] around a ebnf term denote that this term can be repeated 0 or 1 times. Between all terms is an implicit { <WS> } with the exception of the definitions of <NAME> and <CONSTANT>. <WS> denotes white space, <ALPHA> denotes alphabetic characters, and <NUM> denotes numeric characters.

	<PROGRAM>	::= { <DEFINITION> }
	
	<DEFINITION>	::= <NAME> "(" [ <NAMELIST> ] ")" <STATEMENT>
	
	<STATEMENT>	::= "var" <WS> <NAME> ";"
			| "extern" <WS> <NAME> ";"
			| "return" <WS> <RVALUE> ] ";"
			| "if" "(" <RVALUE> ")" [ "else" <STATEMENT> ]
			| "while" "(" <RVALUE> ")" <STATEMENT>
			| <RVALUE> ";"
			| "{" { STATEMENT } "}"
	
	<RVALUE>	::= "(" <RVALUE> ")"
			| <LVALUE>
			| <CONSTANT>
			| <LVALUE> <ASSIGN> <RVALUE>
			| <RVALUE> <BINARY> <RVALUE>
			| <UNARY> <RVALUE>
			| "&" <LVALUE>
			| <RVALUE> "(" [ <RVALUELIST> ] ")"

	<RVALUELIST>	::= <RVALUE> { "," <RVALUE> }

	<LVALUE>	::= <NAME>
			| "*" <RVALUE>
			| <RVALUE> "[" <RVALUE> "]"

	<ASSIGN>	::= [ <BINARY> ] "="

	<BINARY>	::=  "+" 
			| "-" 
			| "/" 
			| "%" 
			| "&" 
			| "|" 
			| "^" 
			| ">>" 
			| "<<" 
			| "==" 
			| "!=" 
			| ">" 
			| "<" 
			| ">=" 
			| "<="

	<UNARY>		::= "-" | "!"

	<NAME>		::= <ALPHA> { <ALPHANUM> }

	<NAMELIST>	::= <NAME> { "," <NAME> }

	<CONSTANT>	::= <NUM> { <NUM> }
			| "\"" { <CHAR> } "\""

	<ALPHANUM>	::= <ALPHA> | <NUM>

## intermediate language

More thoughts to come
