#include "lexer.h"
#include "parser.h"

extern char* tokens[];
extern void error(char* missing);
extern void* allocMemory(int size);
extern void freeMemory(void* mem);

static int stringLength(char* str) {
	int length = 0;
	while (*str) { str++; length++; }
	return length;
}

astnode_t* createNode(int type) {
	astnode_t* node = (astnode_t*) allocMemory(sizeof(astnode_t));
	node->type = type;
	node->token = 0;
	node->value = 0;
	node->kid = 0;
	node->sibling = 0;
	return node;
}

void destroyNode(astnode_t* node) {
	if (!node) return;
	destroyNode(node->kid);
	destroyNode(node->sibling);
	freeMemory(node->value);
	freeMemory(node);
}

void appendKid(astnode_t* node, astnode_t* kid) {
	astnode_t* kidList = node->kid;
	if (!kidList) {
		node->kid = kid;
	}
	else {
		while (kidList->sibling) {
			kidList = kidList->sibling;
		}
		kidList->sibling = kid;
	}
}

static int parseLvalue(char** lvalue, int expected, astnode_t* parent);

static int accept(char** buffer, int token, astnode_t *parent) {
	int read, i;
	char out[256];
	astnode_t* leafNode = createNode(AST_LEAF);
	if (token == nextToken(*buffer, &read, out)) {
		leafNode->token = token;
		if (token == TOKEN_STRING || token == TOKEN_ID || token == TOKEN_NUMBER) {
			leafNode->value = allocMemory(stringLength(out) + 1);
			for (i = 0; i < stringLength(out); i++)
				leafNode->value[i] = out[i];
			leafNode->value[i] = 0;
		}
		appendKid(parent, leafNode);
		*buffer += read;
		return 1;
	}
	return 0;
}

static int expect(char** buffer, int token, astnode_t *parent) {
	if (accept(buffer, token, parent)) {
		return 1;
	}
	if (token == TOKEN_STRING) {
		error("string");
	} else if (token == TOKEN_ID) {
		error("identifier");
	} else if (token == TOKEN_NUMBER) {
		error("number");
	} else {
		error(tokens[token]);
	}
}

static int parseConstant(char** op, int expected, astnode_t *parent) {
	astnode_t* conNode = createNode(AST_CONSTANT);
	int r = accept(op, TOKEN_NUMBER, conNode) || accept(op, TOKEN_STRING, conNode);
	if (expected && !r) {
		error("constant");
	}
	if (r) appendKid(parent, conNode); else destroyNode(conNode);
	return r;
}

static int parseUnary(char** op, int expected, astnode_t* parent) {
	astnode_t* unNode = createNode(AST_UNARY);
	int r = accept(op, TOKEN_MINUS, unNode) || accept(op, TOKEN_NOT, unNode) || accept(op, TOKEN_BNOT, unNode);
	if (expected && !r) {
		destroyNode(unNode);
		error("unary");
	}
	if (r) appendKid(parent, unNode); else destroyNode(unNode);
	return r;
}

static int parseBinary(char** op, int expected, astnode_t* parent) {
	astnode_t* binNode = createNode(AST_BINOP);
	int r = accept(op, TOKEN_PLUS, binNode)
		|| accept(op, TOKEN_MINUS, binNode)
		|| accept(op, TOKEN_ASTERISK, binNode)
		|| accept(op, TOKEN_DIVIDE, binNode)
		|| accept(op, TOKEN_MODULUS, binNode)
		|| accept(op, TOKEN_AND, binNode)
		|| accept(op, TOKEN_BAND, binNode)
		|| accept(op, TOKEN_OR, binNode)
		|| accept(op, TOKEN_BOR, binNode)
		|| accept(op, TOKEN_XOR, binNode)
		|| accept(op, TOKEN_RSHIFT, binNode)
		|| accept(op, TOKEN_EQUAL, binNode)
		|| accept(op, TOKEN_NOTEQUAL, binNode)
		|| accept(op, TOKEN_GEQ, binNode)
		|| accept(op, TOKEN_LEQ, binNode)
		|| accept(op, TOKEN_GREATERTHAN, binNode)
		|| accept(op, TOKEN_LESSTHAN, binNode);
	if (expected && !r) {
		destroyNode(binNode);
		error("binary");
	}
	if (r) appendKid(parent, binNode); else destroyNode(binNode);
	return r;
}

static int parseRvalue(char** rvalue, int expected, int leftRecursive, astnode_t *parent) {
	int r = 1;
	astnode_t* rNode = createNode(AST_RVALUE);
	if (!leftRecursive) {
		rNode->subType = -1;
		r = parseRvalue(rvalue, expected, 1, rNode);
		if (parseBinary(rvalue, 0, rNode)) {
			rNode->subType = RVALUE_BINOP;
			parseRvalue(rvalue, 1, 0, rNode);
		}
	}
	else {
		if (parseLvalue(rvalue, 0, rNode)) {
			rNode->subType = RVALUE_LVALUE;
			if (accept(rvalue, TOKEN_LPAREN, rNode)) {
				rNode->subType = RVALUE_FUNCTION_CALL;
				parseRvalue(rvalue, 0, 0, rNode);
				while (accept(rvalue, TOKEN_COMMA, rNode)) {
					parseRvalue(rvalue, 1, 0, rNode);
				}
				expect(rvalue, TOKEN_RPAREN, rNode);
			}
			else if (accept(rvalue, TOKEN_ASSIGN, rNode)) {
				rNode->subType = RVALUE_ASSIGN;
				parseRvalue(rvalue, 1, 0, rNode);
			}
		}
		else if (parseUnary(rvalue, 0, rNode)) {
			rNode->subType = RVALUE_UNARY;
			parseRvalue(rvalue, 1, 0, rNode);
		}
		else if (accept(rvalue, TOKEN_LPAREN, rNode)) {
			rNode->subType = RVALUE_PARENS;
			parseRvalue(rvalue, 1, 0, rNode);
			expect(rvalue, TOKEN_RPAREN, rNode);
		}
		else if (parseConstant(rvalue, 0, rNode)) {
			rNode->subType = RVALUE_CONSTANT;
		}
		else if (expected) {
			destroyNode(rNode);
			error("rvalue");
		}
		else {
			r = 0;
		}
	}
	if (r) appendKid(parent, rNode); else destroyNode(rNode);
	return r;
}


static int parseLvalue(char** lvalue, int expected, astnode_t *parent) {
	astnode_t* lNode = createNode(AST_LVALUE);
	if (accept(lvalue, TOKEN_ID, lNode)) {
		lNode->subType = LVALUE_ID;
	}
	else if (accept(lvalue, TOKEN_LBRACKET, lNode)) {
		lNode->subType = LVALUE_INDIRECTION;
		parseRvalue(lvalue, 1, 0, lNode);
		expect(lvalue, TOKEN_RBRACKET, lNode);
	}
	else if (expected) {
		destroyNode(lNode);
		error("lvalue");
	}
	else {
		destroyNode(lNode);
		return 0;
	}
	appendKid(parent, lNode);
	return 1;
}

static int parseStatement(char** state, int expected, astnode_t* parent) {
	astnode_t* stateNode = createNode(AST_STATEMENT);
	if (accept(state, TOKEN_LOCAL, stateNode)) {
		stateNode->subType = STATEMENT_LOCAL;
		expect(state, TOKEN_ID, stateNode);
		while (accept(state, TOKEN_COMMA, stateNode)) {
			expect(state, TOKEN_ID, stateNode);
		}
	}
	else if (accept(state, TOKEN_IF, stateNode)) {
		stateNode->subType = STATEMENT_IF;
		parseRvalue(state, 1, 0, stateNode);
		expect(state, TOKEN_THEN, stateNode);
		while (parseStatement(state, 0, stateNode));
		if (accept(state, TOKEN_ELSE, stateNode)) {
			while (parseStatement(state, 0, stateNode));
		}
		expect(state, TOKEN_END, stateNode);
	}
	else if (accept(state, TOKEN_WHILE, stateNode)) {
		stateNode->subType = STATEMENT_WHILE;
		parseRvalue(state, 1, 0, stateNode);
		expect(state, TOKEN_DO, stateNode);
		while (parseStatement(state, 0, stateNode));
		expect(state, TOKEN_END, stateNode);
	}
	else if (accept(state, TOKEN_RETURN, stateNode)) {
		stateNode->subType = STATEMENT_RETURN;
		parseRvalue(state, 1, 0, stateNode);
	}
	else if (parseRvalue(state, 0, 0, stateNode)) {
		stateNode->subType = STATEMENT_RVALUE;
	}
	else if (expected) {
		destroyNode(stateNode);
		error("statement");
	}
	else {
		destroyNode(stateNode);
		return 0;
	}
	appendKid(parent, stateNode);
	return 1;
}

static int parseDefinition(char** def, int expected, astnode_t* parent) {
	astnode_t* defNode = createNode(AST_DEFINITION);
	if (accept(def, TOKEN_DEF, defNode)) {
		expect(def, TOKEN_ID, defNode);
		expect(def, TOKEN_LPAREN, defNode);
		if (accept(def, TOKEN_ID, defNode)) {
			while (accept(def, TOKEN_COMMA, defNode)) {
				expect(def, TOKEN_ID, defNode);
			}
		}
		expect(def, TOKEN_RPAREN, defNode);
		while (parseStatement(def, 0, defNode));
		expect(def, TOKEN_END, defNode);
	} else if (expected) {
		destroyNode(defNode);
		error("definition");
	}
	else {
		destroyNode(defNode);
		return 0;
	}
	appendKid(parent, defNode);
	return 1;
}

astnode_t* parseProgram(char** program) {
	astnode_t* progNode = createNode(AST_PROGRAM);
	while (parseDefinition(program, 0, progNode));
	return progNode;
}
