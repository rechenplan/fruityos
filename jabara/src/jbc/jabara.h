#ifndef JABARA_H
#define JABARA_H

#include <stddef.h>

typedef enum TokenKind {
    TOK_EOF = 0, TOK_ID, TOK_NUMBER, TOK_STRING,
    TOK_LPAREN, TOK_RPAREN, TOK_LBRACKET, TOK_RBRACKET, TOK_COMMA, TOK_DOT,
    TOK_COLON,
    TOK_PLUS, TOK_MINUS, TOK_STAR, TOK_SLASH, TOK_PERCENT,
    TOK_AMP, TOK_AND, TOK_PIPE, TOK_OR, TOK_XOR, TOK_EQ, TOK_ASSIGN,
    TOK_NE, TOK_BNOT, TOK_NOT, TOK_SHL, TOK_LE, TOK_LT, TOK_SHR,
    TOK_GE, TOK_GT,
    TOK_LOCAL, TOK_IF, TOK_THEN, TOK_ELSE, TOK_END,
    TOK_WHILE, TOK_DO, TOK_SUB, TOK_RETURN, TOK_BYTE, TOK_FN, TOK_RECORD,
    TOK_EXTERN
} TokenKind;

typedef struct Token {
    TokenKind kind;
    char *text;
    long number;
    int line;
    int column;
} Token;

typedef struct Lexer {
    const char *source;
    size_t position;
    int line;
    int column;
    Token token;
} Lexer;

typedef enum ExprKind {
    EX_NUMBER, EX_STRING, EX_NAME, EX_DEREF, EX_BYTE, EX_UNARY,
    EX_BINARY, EX_ASSIGN, EX_CALL, EX_CLOSURE, EX_MEMBER
} ExprKind;

typedef enum StmtKind {
    ST_LOCAL, ST_IF, ST_WHILE, ST_RETURN, ST_EXPR
} StmtKind;

typedef struct Expr Expr;
typedef struct Stmt Stmt;
typedef struct Name Name;
typedef struct Function Function;
typedef struct Record Record;

struct Name {
    char *name;
    char *tag;
    Expr *initializer;
    Name *next;
};

struct Expr {
    ExprKind kind;
    int line;
    char *text;
    char *tag;
    long number;
    TokenKind op;
    Expr *left;
    Expr *right;
    Expr **arguments;
    size_t argument_count;
    Stmt *body;
};

struct Stmt {
    StmtKind kind;
    int line;
    Name *names;
    Expr *expr;
    Stmt *body;
    Stmt *else_body;
    Stmt *next;
};

struct Function {
    char *name;
    Name *parameters;
    Stmt *body;
    int line;
    int is_extern;
    int pith_defined;
    Function *next;
};

struct Record {
    char *name;
    Name *fields;
    int line;
    Record *next;
};

typedef struct Program {
    Record *records;
    Function *functions;
    Stmt *statements;
} Program;

void lexer_init(Lexer *lexer, const char *source);
void lexer_next(Lexer *lexer);
void token_dispose(Token *token);
const char *token_name(TokenKind kind);

Program *parse_program(const char *source);
void program_dispose(Program *program);
int emit_program(const Program *program, const char *output_path);

void *xmalloc(size_t size);
void *xrealloc(void *pointer, size_t size);
char *xstrdup(const char *text);
void fatal_at(int line, int column, const char *message);

#endif
