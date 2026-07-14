#include "jabara.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Parser { Lexer lexer; } Parser;

static Expr *parse_expression(Parser *parser);
static Stmt *parse_statements(Parser *parser, int stop_else);

static int accept(Parser *parser, TokenKind kind)
{
    if (parser->lexer.token.kind != kind) return 0;
    lexer_next(&parser->lexer);
    return 1;
}

static void expect(Parser *parser, TokenKind kind)
{
    char message[128];
    if (accept(parser, kind)) return;
    sprintf(message, "expected %s, found %s", token_name(kind),
            token_name(parser->lexer.token.kind));
    fatal_at(parser->lexer.token.line, parser->lexer.token.column, message);
}

static char *take_text(Parser *parser)
{
    char *text;
    if (parser->lexer.token.kind != TOK_ID)
        fatal_at(parser->lexer.token.line, parser->lexer.token.column, "expected identifier");
    text = xstrdup(parser->lexer.token.text);
    lexer_next(&parser->lexer);
    return text;
}

static Expr *new_expr(ExprKind kind, int line)
{
    Expr *expr = (Expr *)xmalloc(sizeof(*expr));
    memset(expr, 0, sizeof(*expr));
    expr->kind = kind;
    expr->line = line;
    return expr;
}

static Stmt *new_stmt(StmtKind kind, int line)
{
    Stmt *stmt = (Stmt *)xmalloc(sizeof(*stmt));
    memset(stmt, 0, sizeof(*stmt));
    stmt->kind = kind;
    stmt->line = line;
    return stmt;
}

static Name *new_name(char *text)
{
    Name *name = (Name *)xmalloc(sizeof(*name));
    memset(name, 0, sizeof(*name));
    name->name = text;
    return name;
}

static void parse_optional_tag(Parser *parser, char **tag)
{
    if (accept(parser, TOK_COLON)) *tag = take_text(parser);
}

static Name *parse_name(Parser *parser)
{
    Name *name = new_name(take_text(parser));
    parse_optional_tag(parser, &name->tag);
    return name;
}

static Expr *parse_primary(Parser *parser)
{
    Token *token = &parser->lexer.token;
    int line = token->line;
    Expr *expr;
    if (token->kind == TOK_NUMBER) {
        expr = new_expr(EX_NUMBER, line);
        expr->number = token->number;
        lexer_next(&parser->lexer);
    } else if (token->kind == TOK_STRING) {
        expr = new_expr(EX_STRING, line);
        expr->text = xstrdup(token->text);
        lexer_next(&parser->lexer);
    } else if (token->kind == TOK_ID) {
        expr = new_expr(EX_NAME, line);
        expr->text = take_text(parser);
    } else if (accept(parser, TOK_LBRACKET)) {
        expr = new_expr(EX_DEREF, line);
        expr->left = parse_expression(parser);
        expect(parser, TOK_RBRACKET);
    } else if (accept(parser, TOK_LPAREN)) {
        expr = parse_expression(parser);
        expect(parser, TOK_RPAREN);
    } else if (accept(parser, TOK_FN)) {
        expr = new_expr(EX_LAMBDA, line);
        expr->text = take_text(parser);
        parse_optional_tag(parser, &expr->tag);
        expect(parser, TOK_DO);
        expr->body = parse_statements(parser, 0);
        expect(parser, TOK_END);
    } else {
        fatal_at(token->line, token->column, "expected expression");
        return NULL;
    }
    for (;;) {
        if (accept(parser, TOK_LPAREN)) {
            Expr *call = new_expr(EX_CALL, line);
            call->left = expr;
            if (parser->lexer.token.kind != TOK_RPAREN) {
                do {
                    call->arguments = (Expr **)xrealloc(call->arguments,
                        (call->argument_count + 1U) * sizeof(call->arguments[0]));
                    call->arguments[call->argument_count++] = parse_expression(parser);
                } while (accept(parser, TOK_COMMA));
            }
            expect(parser, TOK_RPAREN);
            expr = call;
        } else if (accept(parser, TOK_DOT)) {
            Expr *member = new_expr(EX_MEMBER, line);
            member->left = expr;
            member->text = take_text(parser);
            expr = member;
        } else {
            break;
        }
    }
    return expr;
}

static Expr *parse_unary(Parser *parser)
{
    TokenKind kind = parser->lexer.token.kind;
    int line = parser->lexer.token.line;
    Expr *expr;
    if (kind == TOK_MINUS || kind == TOK_NOT || kind == TOK_BNOT) {
        lexer_next(&parser->lexer);
        expr = new_expr(EX_UNARY, line);
        expr->op = kind;
        expr->left = parse_unary(parser);
        return expr;
    }
    if (accept(parser, TOK_BYTE)) {
        expr = new_expr(EX_BYTE, line);
        expr->left = parse_unary(parser);
        return expr;
    }
    return parse_primary(parser);
}

static int is_binary(TokenKind kind)
{
    return kind >= TOK_PLUS && kind <= TOK_GT && kind != TOK_ASSIGN &&
           kind != TOK_BNOT && kind != TOK_NOT;
}

/* Yuzu gives all binary operators one precedence and associates left. */
static Expr *parse_binary(Parser *parser)
{
    Expr *left = parse_unary(parser);
    while (is_binary(parser->lexer.token.kind)) {
        TokenKind op = parser->lexer.token.kind;
        Expr *binary = new_expr(EX_BINARY, parser->lexer.token.line);
        lexer_next(&parser->lexer);
        binary->op = op;
        binary->left = left;
        binary->right = parse_unary(parser);
        left = binary;
    }
    return left;
}

static int is_lvalue(const Expr *expr)
{
    return expr->kind == EX_NAME || expr->kind == EX_DEREF || expr->kind == EX_MEMBER ||
           (expr->kind == EX_BYTE && expr->left != NULL &&
            (expr->left->kind == EX_NAME || expr->left->kind == EX_DEREF ||
             expr->left->kind == EX_MEMBER));
}

static Expr *parse_expression(Parser *parser)
{
    Expr *left = parse_binary(parser);
    if (accept(parser, TOK_ASSIGN)) {
        Expr *assign;
        if (!is_lvalue(left)) fatal_at(left->line, 1, "assignment requires an lvalue");
        assign = new_expr(EX_ASSIGN, left->line);
        assign->left = left;
        assign->right = parse_expression(parser);
        return assign;
    }
    return left;
}

static Stmt *parse_statement(Parser *parser)
{
    int line = parser->lexer.token.line;
    Stmt *stmt;
    if (parser->lexer.token.kind == TOK_LOCAL) {
        Name **tail;
        lexer_next(&parser->lexer);
        stmt = new_stmt(ST_LOCAL, line);
        tail = &stmt->names;
        do {
            Name *name = parse_name(parser);
            if (accept(parser, TOK_ASSIGN)) name->initializer = parse_expression(parser);
            *tail = name;
            tail = &name->next;
        } while (accept(parser, TOK_COMMA));
        return stmt;
    }
    if (accept(parser, TOK_IF)) {
        stmt = new_stmt(ST_IF, line);
        stmt->expr = parse_expression(parser);
        expect(parser, TOK_THEN);
        stmt->body = parse_statements(parser, 1);
        if (accept(parser, TOK_ELSE)) stmt->else_body = parse_statements(parser, 0);
        expect(parser, TOK_END);
        return stmt;
    }
    if (accept(parser, TOK_WHILE)) {
        stmt = new_stmt(ST_WHILE, line);
        stmt->expr = parse_expression(parser);
        expect(parser, TOK_DO);
        stmt->body = parse_statements(parser, 0);
        expect(parser, TOK_END);
        return stmt;
    }
    if (accept(parser, TOK_RETURN)) {
        stmt = new_stmt(ST_RETURN, line);
        stmt->expr = parse_expression(parser);
        return stmt;
    }
    stmt = new_stmt(ST_EXPR, line);
    stmt->expr = parse_expression(parser);
    return stmt;
}

static Stmt *parse_statements(Parser *parser, int stop_else)
{
    Stmt *head = NULL;
    Stmt **tail = &head;
    while (parser->lexer.token.kind != TOK_EOF && parser->lexer.token.kind != TOK_END &&
           !(stop_else && parser->lexer.token.kind == TOK_ELSE)) {
        Stmt *stmt;
        if (parser->lexer.token.kind == TOK_SUB || parser->lexer.token.kind == TOK_RECORD ||
            parser->lexer.token.kind == TOK_EXTERN)
            fatal_at(parser->lexer.token.line, parser->lexer.token.column,
                     "declaration is only allowed at program scope");
        stmt = parse_statement(parser);
        *tail = stmt;
        tail = &stmt->next;
    }
    return head;
}

static Function *parse_function(Parser *parser, int is_extern)
{
    Function *function = (Function *)xmalloc(sizeof(*function));
    Name **tail = &function->parameters;
    memset(function, 0, sizeof(*function));
    function->line = parser->lexer.token.line;
    function->is_extern = is_extern;
    if (is_extern) expect(parser, TOK_EXTERN);
    expect(parser, TOK_SUB);
    function->name = take_text(parser);
    expect(parser, TOK_LPAREN);
    if (parser->lexer.token.kind != TOK_RPAREN) {
        do {
            Name *parameter = parse_name(parser);
            *tail = parameter;
            tail = &parameter->next;
        } while (accept(parser, TOK_COMMA));
    }
    expect(parser, TOK_RPAREN);
    if (!is_extern) {
        function->body = parse_statements(parser, 0);
        expect(parser, TOK_END);
    }
    return function;
}

static Record *parse_record(Parser *parser)
{
    Record *record = (Record *)xmalloc(sizeof(*record));
    Name **tail;
    memset(record, 0, sizeof(*record));
    record->line = parser->lexer.token.line;
    expect(parser, TOK_RECORD);
    record->name = take_text(parser);
    tail = &record->fields;
    do {
        Name *field;
        Name *existing;
        field = parse_name(parser);
        existing = record->fields;
        while (existing != NULL) {
            if (strcmp(existing->name, field->name) == 0)
                fatal_at(record->line, 1, "duplicate record field");
            existing = existing->next;
        }
        *tail = field;
        tail = &field->next;
    } while (accept(parser, TOK_COMMA));
    return record;
}

Program *parse_program(const char *source)
{
    Parser parser;
    Program *program = (Program *)xmalloc(sizeof(*program));
    Record **record_tail = &program->records;
    Function **function_tail = &program->functions;
    Stmt **statement_tail = &program->statements;
    memset(program, 0, sizeof(*program));
    lexer_init(&parser.lexer, source);
    while (parser.lexer.token.kind != TOK_EOF) {
        if (parser.lexer.token.kind == TOK_RECORD) {
            Record *record = parse_record(&parser);
            *record_tail = record;
            record_tail = &record->next;
        } else if (parser.lexer.token.kind == TOK_SUB ||
                   parser.lexer.token.kind == TOK_EXTERN) {
            Function *function = parse_function(&parser,
                parser.lexer.token.kind == TOK_EXTERN);
            *function_tail = function;
            function_tail = &function->next;
        } else {
            Stmt *statement = parse_statement(&parser);
            *statement_tail = statement;
            statement_tail = &statement->next;
        }
    }
    token_dispose(&parser.lexer.token);
    return program;
}

static void stmt_dispose(Stmt *stmt);

static void expr_dispose(Expr *expr)
{
    size_t i;
    if (expr == NULL) return;
    free(expr->text);
    free(expr->tag);
    expr_dispose(expr->left);
    expr_dispose(expr->right);
    for (i = 0U; i < expr->argument_count; ++i) expr_dispose(expr->arguments[i]);
    free(expr->arguments);
    stmt_dispose(expr->body);
    free(expr);
}

static void stmt_dispose(Stmt *stmt)
{
    while (stmt != NULL) {
        Stmt *next = stmt->next;
        Name *name = stmt->names;
        while (name != NULL) {
            Name *name_next = name->next;
            free(name->name);
            free(name->tag);
            expr_dispose(name->initializer);
            free(name);
            name = name_next;
        }
        expr_dispose(stmt->expr);
        stmt_dispose(stmt->body);
        stmt_dispose(stmt->else_body);
        free(stmt);
        stmt = next;
    }
}

void program_dispose(Program *program)
{
    Record *record;
    Function *function;
    if (program == NULL) return;
    record = program->records;
    while (record != NULL) {
        Record *next = record->next;
        Name *field = record->fields;
        while (field != NULL) {
            Name *field_next = field->next;
            free(field->name);
            free(field->tag);
            free(field);
            field = field_next;
        }
        free(record->name);
        free(record);
        record = next;
    }
    function = program->functions;
    while (function != NULL) {
        Function *next = function->next;
        Name *name = function->parameters;
        while (name != NULL) {
            Name *nn = name->next;
            free(name->name);
            free(name->tag);
            free(name);
            name = nn;
        }
        free(function->name);
        stmt_dispose(function->body);
        free(function);
        function = next;
    }
    stmt_dispose(program->statements);
    free(program);
}
