#include "lexer.h"

extern char* tokens[];
extern void error(char* missing);

static int parseLvalue(char** lvalue, int expected);

static int accept(char** buffer, int token) {
	int read;
	char out[256];
	if (token == nextToken(*buffer, &read, out)) {
		*buffer += read;
		return 1;
	}
	return 0;
}

static int expect(char** buffer, int token) {
	if (accept(buffer, token)) {
		return 1;
	}
	error(tokens[token]);
}

static int parseConstant(char** op, int expected) {
	int r = accept(op, TOKEN_NUMBER) || accept(op, TOKEN_STRING);
	if (expected && !r) {
		error("constant");
	}
	return r;
}

static int parseUnary(char** op, int expected) {
	int r = accept(op, TOKEN_MINUS) || accept(op, TOKEN_NOT) || accept(op, TOKEN_BNOT);
	if (expected && !r) {
		error("unary");
	}
	return r;
}

static int parseBinary(char** op, int expected) {
	int r = accept(op, TOKEN_PLUS) || accept(op, TOKEN_MINUS) || accept(op, TOKEN_ASTERISK) || accept(op, TOKEN_DIVIDE)
		|| accept(op, TOKEN_MODULUS) || accept(op, TOKEN_AND) || accept(op, TOKEN_BAND) || accept(op, TOKEN_OR)
		|| accept(op, TOKEN_BOR) || accept(op, TOKEN_XOR) || accept(op, TOKEN_RSHIFT) || accept(op, TOKEN_EQUAL) 
		|| accept(op, TOKEN_NOTEQUAL) || accept(op, TOKEN_GEQ) || accept(op, TOKEN_LEQ) || accept(op, TOKEN_GREATERTHAN)
		|| accept(op, TOKEN_LESSTHAN);
	if (expected && !r) {
		error("binary");
	}
	return r;
}

static int parseRvalue(char** rvalue, int expected) {
	if (parseLvalue(rvalue, 0)) {
		if (accept(rvalue, TOKEN_LPAREN)) {
			while (parseRvalue(rvalue, 0));
			expect(rvalue, TOKEN_RPAREN);
		}
		else if (accept(rvalue, TOKEN_ASSIGN)) {
			parseRvalue(rvalue, 1);
		}
		else {
			// just an lvalue
		}
	}
	else if (parseUnary(rvalue, 0)) {
		parseRvalue(rvalue, 1);
	}
	else if (accept(rvalue, TOKEN_LPAREN)) {
		parseRvalue(rvalue, 1);
		if (parseBinary(rvalue, 0)) {
			parseRvalue(rvalue, 1);
			expect(rvalue, TOKEN_RPAREN);
		}
		else if (accept(rvalue, TOKEN_RPAREN)) {
		}
		else if (expected) {
			error("rvalue");
		}
	}
	else if (parseConstant(rvalue, 0)) {
	}
	else if (expected) {
		error("rvalue");
	}
	else {
		return 0;
	}
	return 1;
}


static int parseLvalue(char** lvalue, int expected) {
	if (accept(lvalue, TOKEN_ID)) {
	}
	else if (accept(lvalue, TOKEN_LBRACKET)) {
		parseRvalue(lvalue, 1);
		expect(lvalue, TOKEN_RBRACKET);
	}
	else if (expected) {
		error("lvalue");
	}
	else {
		return 0;
	}
	return 1;
}

static int parseStatement(char** state, int expected) {
	if (accept(state, TOKEN_LOCAL)) {
		expect(state, TOKEN_ID);
		while (accept(state, TOKEN_COMMA)) {
			expect(state, TOKEN_ID);
		}
	}
	else if (accept(state, TOKEN_IF)) {
		parseRvalue(state, 1);
		expect(state, TOKEN_THEN);
		while (parseStatement(state, 0));
		if (accept(state, TOKEN_ELSE)) {
			while (parseStatement(state, 0));
		}
		expect(state, TOKEN_END);
	}
	else if (accept(state, TOKEN_WHILE)) {
		parseRvalue(state, 1);
		expect(state, TOKEN_DO);
		while (parseStatement(state, 0));
		expect(state, TOKEN_END);
	}
	else if (accept(state, TOKEN_RETURN)) {
		parseRvalue(state, 1);
	}
	else if (parseRvalue(state, 0)) {
	}
	else if (expected) {
		error("statement");
	}
	else {
		return 0;
	}
	return 1;
}

static int parseDefinition(char** def, int expected) {
	if (accept(def, TOKEN_DEF)) {
		expect(def, TOKEN_ID);
		expect(def, TOKEN_LPAREN);
		if (accept(def, TOKEN_ID)) {
			while (accept(def, TOKEN_COMMA)) {
				expect(def, TOKEN_ID);
			}
		}
		expect(def, TOKEN_RPAREN);
		while (parseStatement(def, 0));
		expect(def, TOKEN_END);
	} else if (expected) {
		error("definition");
	}
	else {
		return 0;
	}
	return 1;
}

int parseProgram(char** program) {
	while (parseDefinition(program, 0));
	return 1;
}
