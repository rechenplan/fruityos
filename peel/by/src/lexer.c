#include "lexer.h"

/* a list of all valid yuzu tokens */
char* tokens[] = {"(",")","[","]",",","+","-","*","/","%","&&","&","||","|","^","==","=","!=","!","~","<<","<=",
	"<",">>",">=",">","LOCAL","IF","THEN","ELSE","END","WHILE","DO","DEF","RETURN"};

/* check character classes */
static int isDigit(char c) { return (c >= '0' && c <= '9'); }
static int isQuote(char c) { return (c == '"'); }
static int isNameChar(char c) { return (c >= 'a' && c <= 'z') || (c == '_'); }
static int isNextNameChar(char c) { return isNameChar(c) || (c >= 'A' && c <= 'Z') || isDigit(c); }
static int isSkipable(char c) { return c == '\t' || c == ' ' || c == '\n' || c == '\r' || c == '{' || c == '}'; }

/* compute string length */
static int stringLength(char* str) {
	int length = 0;
	while (*str) { str++; length++; }
	return length;
}

/* returns non-zero if a is a prefix of b, zero otherwise */
static int isPrefix(char* a, char* b) {
	int ret = 1;
	while (*a == *b && *a && *b) {
		a++;
		b++;
	}
	if (*a) {
		ret = 0;
	}
	return ret;
}

/* returns symbol index */
int nextToken(char* buffer, int* consumed /* out */, char* outBuf) {

	int i = 0, symbol = -1, inComment = 0, read = 0;
	int numTokens = sizeof(tokens) / sizeof(tokens[0]);

	/* skip whitespace and comments */
	while (*buffer && (isSkipable(*buffer) || inComment)) {
		if (inComment) {
			inComment = (*buffer != '}');
		}
		else {
			inComment = (*buffer == '{');
		}
		buffer++;
		read++;
	}

	/* is a token in the tokens array a prefix? */
	for (i = 0; i < numTokens; i++) {
		if (isPrefix(tokens[i], buffer)) {
			read += stringLength(tokens[i]);
			symbol = i;
			break;
		}
	}

	if (symbol == -1) {
		/* string */
		if (isQuote(*buffer) && *buffer) {
			symbol = TOKEN_STRING;
			do {
				*outBuf = *buffer;
				outBuf++;
				buffer++;
				read++;
			} while(!isQuote(*buffer) && *buffer);
			*outBuf = *buffer;
			outBuf++;
			buffer++;
			read++;
		/* number */
		} else if (isDigit(*buffer) && *buffer) {
			symbol = TOKEN_NUMBER;
			do {
				*outBuf = *buffer;
				outBuf++;
				buffer++;
				read++;
			} while(isDigit(*buffer) && *buffer);
		/* name */
		} else if (isNameChar(*buffer) && *buffer) {
			symbol = TOKEN_ID;
			do {
				*outBuf = *buffer;
				outBuf++;
				buffer++;
				read++;
			} while(isNextNameChar(*buffer) && *buffer);
		}
	}
	*outBuf = 0;
	*consumed = read;
	return symbol;
}
