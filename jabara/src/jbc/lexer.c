#include "jabara.h"

#include <ctype.h>
#include <errno.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static char *slice(const char *source, size_t start, size_t end)
{
    size_t length = end - start;
    char *text = (char *)xmalloc(length + 1U);
    memcpy(text, source + start, length);
    text[length] = '\0';
    return text;
}

void token_dispose(Token *token)
{
    free(token->text);
    token->text = NULL;
}

static int current(const Lexer *lexer)
{
    return (unsigned char)lexer->source[lexer->position];
}

static int advance(Lexer *lexer)
{
    int c = current(lexer);
    if (c != 0) {
        ++lexer->position;
        if (c == '\n') {
            ++lexer->line;
            lexer->column = 1;
        } else {
            ++lexer->column;
        }
    }
    return c;
}

static TokenKind keyword(const char *text)
{
    struct Keyword { const char *text; TokenKind kind; };
    static const struct Keyword words[] = {
        {"local", TOK_LOCAL}, {"if", TOK_IF},
        {"then", TOK_THEN}, {"else", TOK_ELSE}, {"end", TOK_END},
        {"while", TOK_WHILE}, {"do", TOK_DO}, {"sub", TOK_SUB},
        {"return", TOK_RETURN}, {"byte", TOK_BYTE}, {"fn", TOK_FN},
        {"record", TOK_RECORD}, {"extern", TOK_EXTERN}
    };
    size_t i;
    for (i = 0U; i < sizeof(words) / sizeof(words[0]); ++i) {
        if (strcmp(text, words[i].text) == 0) return words[i].kind;
    }
    return TOK_ID;
}

static void skip_space(Lexer *lexer)
{
    for (;;) {
        while (isspace(current(lexer))) advance(lexer);
        if (current(lexer) != ';') return;
        while (current(lexer) != 0 && current(lexer) != '\n') advance(lexer);
    }
}

void lexer_init(Lexer *lexer, const char *source)
{
    memset(lexer, 0, sizeof(*lexer));
    lexer->source = source;
    lexer->line = 1;
    lexer->column = 1;
    lexer_next(lexer);
}

static void set_simple(Lexer *lexer, TokenKind kind, int width)
{
    lexer->token.kind = kind;
    while (width-- > 0) advance(lexer);
}

void lexer_next(Lexer *lexer)
{
    size_t start;
    int line;
    int column;
    int c;
    token_dispose(&lexer->token);
    skip_space(lexer);
    start = lexer->position;
    line = lexer->line;
    column = lexer->column;
    lexer->token.line = line;
    lexer->token.column = column;
    lexer->token.number = 0L;
    c = current(lexer);
    if (c == 0) { lexer->token.kind = TOK_EOF; return; }
    if (isalpha(c) || c == '_') {
        do { advance(lexer); } while (isalnum(current(lexer)) || current(lexer) == '_');
        lexer->token.text = slice(lexer->source, start, lexer->position);
        if (strcmp(lexer->token.text, "var") == 0)
            fatal_at(line, column, "var has been removed; use local");
        if (strcmp(lexer->token.text, "lambda") == 0)
            fatal_at(line, column, "lambda has been removed; use fn");
        lexer->token.kind = keyword(lexer->token.text);
        return;
    }
    if (isdigit(c)) {
        char *end;
        do { advance(lexer); } while (isdigit(current(lexer)));
        lexer->token.text = slice(lexer->source, start, lexer->position);
        errno = 0;
        lexer->token.number = strtol(lexer->token.text, &end, 10);
        if (errno == ERANGE || *end != '\0') fatal_at(line, column, "invalid number");
        lexer->token.kind = TOK_NUMBER;
        return;
    }
    if (c == '"') {
        char *text;
        size_t length = 0U;
        size_t capacity = 16U;
        advance(lexer);
        text = (char *)xmalloc(capacity);
        while (current(lexer) != 0 && current(lexer) != '"') {
            int value = advance(lexer);
            if (value == '\n') fatal_at(line, column, "unterminated string");
            if (value == '\\') {
                value = advance(lexer);
                if (value == 'n') value = '\n';
                else if (value == 'r') value = '\r';
                else if (value == 't') value = '\t';
                else if (value != '\\' && value != '"')
                    fatal_at(lexer->line, lexer->column, "invalid string escape");
            }
            if (length + 1U >= capacity) {
                capacity *= 2U;
                text = (char *)xrealloc(text, capacity);
            }
            text[length++] = (char)value;
        }
        if (current(lexer) != '"') fatal_at(line, column, "unterminated string");
        advance(lexer);
        text[length] = '\0';
        lexer->token.text = text;
        lexer->token.kind = TOK_STRING;
        return;
    }
    switch (c) {
    case '(': set_simple(lexer, TOK_LPAREN, 1); return;
    case ')': set_simple(lexer, TOK_RPAREN, 1); return;
    case '[': set_simple(lexer, TOK_LBRACKET, 1); return;
    case ']': set_simple(lexer, TOK_RBRACKET, 1); return;
    case ',': set_simple(lexer, TOK_COMMA, 1); return;
    case '.': set_simple(lexer, TOK_DOT, 1); return;
    case ':': set_simple(lexer, TOK_COLON, 1); return;
    case '+': set_simple(lexer, TOK_PLUS, 1); return;
    case '-': set_simple(lexer, TOK_MINUS, 1); return;
    case '*': set_simple(lexer, TOK_STAR, 1); return;
    case '/': set_simple(lexer, TOK_SLASH, 1); return;
    case '%': set_simple(lexer, TOK_PERCENT, 1); return;
    case '^': set_simple(lexer, TOK_XOR, 1); return;
    case '&': set_simple(lexer, lexer->source[start + 1U] == '&' ? TOK_AND : TOK_AMP,
                         lexer->source[start + 1U] == '&' ? 2 : 1); return;
    case '|': set_simple(lexer, lexer->source[start + 1U] == '|' ? TOK_OR : TOK_PIPE,
                         lexer->source[start + 1U] == '|' ? 2 : 1); return;
    case '=': set_simple(lexer, lexer->source[start + 1U] == '=' ? TOK_EQ : TOK_ASSIGN,
                         lexer->source[start + 1U] == '=' ? 2 : 1); return;
    case '!': set_simple(lexer, lexer->source[start + 1U] == '=' ? TOK_NE : TOK_NOT,
                         lexer->source[start + 1U] == '=' ? 2 : 1); return;
    case '~': set_simple(lexer, TOK_BNOT, 1); return;
    case '<':
        if (lexer->source[start + 1U] == '<') set_simple(lexer, TOK_SHL, 2);
        else if (lexer->source[start + 1U] == '=') set_simple(lexer, TOK_LE, 2);
        else set_simple(lexer, TOK_LT, 1);
        return;
    case '>':
        if (lexer->source[start + 1U] == '>') set_simple(lexer, TOK_SHR, 2);
        else if (lexer->source[start + 1U] == '=') set_simple(lexer, TOK_GE, 2);
        else set_simple(lexer, TOK_GT, 1);
        return;
    default: fatal_at(line, column, "invalid character");
    }
}

const char *token_name(TokenKind kind)
{
    static const char *const names[] = {
        "end of file", "identifier", "number", "string", "(", ")", "[", "]", ",", ".", ":",
        "+", "-", "*", "/", "%", "&", "&&", "|", "||", "^", "==", "=", "!=",
        "~", "!", "<<", "<=", "<", ">>", ">=", ">", "local", "if", "then",
        "else", "end", "while", "do", "sub", "return", "byte", "fn", "record", "extern"
    };
    if ((size_t)kind >= sizeof(names) / sizeof(names[0])) return "token";
    return names[kind];
}
