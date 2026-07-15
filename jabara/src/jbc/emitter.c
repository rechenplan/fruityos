#include "jabara.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Binding {
    const char *name;
    const char *tag;
    int slot;
    struct Binding *next;
} Binding;

typedef struct Scope {
    struct Scope *parent;
    struct Scope *next_owned;
    Binding *bindings;
    int slot_count;
    int is_global;
} Scope;

typedef struct ClosureInfo {
    const Expr *expr;
    Scope *scope;
    int label;
    struct ClosureInfo *next;
} ClosureInfo;

typedef struct Emitter {
    FILE *out;
    const Program *program;
    Scope global_scope;
    Scope *function_scopes;
    Scope *scope;
    ClosureInfo *closures;
    ClosureInfo **closure_tail;
    unsigned long label;
    unsigned long return_label;
    int failed;
} Emitter;

static void emit_expr(Emitter *emitter, const Expr *expr);
static void emit_statements(Emitter *emitter, const Stmt *statement);

static const Function *find_function(const Emitter *emitter, const char *name)
{
    const Function *function = emitter->program->functions;
    while (function != NULL) {
        if (strcmp(function->name, name) == 0) return function;
        function = function->next;
    }
    return NULL;
}

static const Record *find_record(const Emitter *emitter, const char *name)
{
    const Record *record = emitter->program->records;
    while (record != NULL) {
        if (strcmp(record->name, name) == 0) return record;
        record = record->next;
    }
    return NULL;
}

static int record_field_offset(const Record *record, const char *name)
{
    const Name *field = record->fields;
    int offset = 0;
    while (field != NULL) {
        if (strcmp(field->name, name) == 0) return offset;
        offset += 8;
        field = field->next;
    }
    return 0;
}

static const Name *find_record_field(const Record *record, const char *name)
{
    const Name *field = record->fields;
    while (field != NULL) {
        if (strcmp(field->name, name) == 0) return field;
        field = field->next;
    }
    return NULL;
}

static int record_field_count(const Record *record)
{
    const Name *field = record->fields;
    int count = 0;
    while (field != NULL) { ++count; field = field->next; }
    return count;
}

static void validate_records(Emitter *emitter)
{
    const Record *record = emitter->program->records;
    while (record != NULL) {
        const Record *other = record->next;
        const Name *field = record->fields;
        if (find_function(emitter, record->name) != NULL)
            fatal_at(record->line, 1, "record and sub have the same name");
        while (other != NULL) {
            if (strcmp(record->name, other->name) == 0)
                fatal_at(other->line, 1, "duplicate record name");
            other = other->next;
        }
        while (field != NULL) {
            if (field->tag != NULL && find_record(emitter, field->tag) == NULL)
                fatal_at(record->line, 1, "record field has an unknown tag");
            field = field->next;
        }
        record = record->next;
    }
}

static void output_error(Emitter *emitter)
{
    if (!emitter->failed) fputs("jabara: failed writing assembly\n", stderr);
    emitter->failed = 1;
}

static void put(Emitter *emitter, const char *text)
{
    if (!emitter->failed && fputs(text, emitter->out) == EOF) output_error(emitter);
}

static void line(Emitter *emitter, const char *text)
{
    put(emitter, text);
    put(emitter, "\n");
}

static unsigned long new_label(Emitter *emitter)
{
    return ++emitter->label;
}

static Binding *binding_new(const char *name, const char *tag, int slot)
{
    Binding *binding = (Binding *)xmalloc(sizeof(*binding));
    binding->name = name;
    binding->tag = tag;
    binding->slot = slot;
    binding->next = NULL;
    return binding;
}

static Binding *scope_own_binding(const Scope *scope, const char *name)
{
    Binding *binding = scope->bindings;
    while (binding != NULL) {
        if (strcmp(binding->name, name) == 0) return binding;
        binding = binding->next;
    }
    return NULL;
}

static void scope_add(Emitter *emitter, Scope *scope, const char *name,
                      const char *tag, int line_number)
{
    Binding **tail;
    Binding *binding;
    if (scope_own_binding(scope, name) != NULL) return;
    if (tag != NULL && find_record(emitter, tag) == NULL)
        fatal_at(line_number, 1, "variable has an unknown tag");
    binding = binding_new(name, tag, scope->is_global ? 0 : ++scope->slot_count);
    tail = &scope->bindings;
    while (*tail != NULL) tail = &(*tail)->next;
    *tail = binding;
}

static void collect_locals(Emitter *emitter, Scope *scope, const Stmt *statement)
{
    while (statement != NULL) {
        if (statement->kind == ST_LOCAL) {
            Name *name = statement->names;
            while (name != NULL) {
                scope_add(emitter, scope, name->name, name->tag, statement->line);
                name = name->next;
            }
        }
        if (statement->kind == ST_IF) {
            collect_locals(emitter, scope, statement->body);
            collect_locals(emitter, scope, statement->else_body);
        } else if (statement->kind == ST_WHILE) {
            collect_locals(emitter, scope, statement->body);
        }
        statement = statement->next;
    }
}

static Binding *scope_find(Scope *scope, const char *name, int *depth, Scope **owner)
{
    int level = 0;
    while (scope != NULL) {
        Binding *binding = scope_own_binding(scope, name);
        if (binding != NULL) {
            *depth = level;
            *owner = scope;
            return binding;
        }
        if (!scope->is_global) ++level;
        scope = scope->parent;
    }
    return NULL;
}

static const Record *expr_record_type(Emitter *emitter, const Expr *expr)
{
    if (expr->kind == EX_NAME) {
        int depth;
        Scope *owner;
        Binding *binding = scope_find(emitter->scope, expr->text, &depth, &owner);
        if (binding != NULL && binding->tag != NULL)
            return find_record(emitter, binding->tag);
    } else if (expr->kind == EX_CALL && expr->left->kind == EX_NAME) {
        int depth;
        Scope *owner;
        if (scope_find(emitter->scope, expr->left->text, &depth, &owner) == NULL)
            return find_record(emitter, expr->left->text);
    } else if (expr->kind == EX_MEMBER) {
        const Record *record = expr_record_type(emitter, expr->left);
        if (record != NULL) {
            const Name *field = find_record_field(record, expr->text);
            if (field == NULL) fatal_at(expr->line, 1, "tagged record has no such field");
            if (field->tag != NULL) return find_record(emitter, field->tag);
        }
    } else if (expr->kind == EX_ASSIGN) {
        return expr_record_type(emitter, expr->right);
    }
    return NULL;
}

static void bindings_dispose(Binding *binding)
{
    while (binding != NULL) {
        Binding *next = binding->next;
        free(binding);
        binding = next;
    }
}

static int call_is_direct(Emitter *emitter, const Expr *callee)
{
    int depth;
    Scope *owner;
    if (callee->kind != EX_NAME) return 0;
    if (scope_find(emitter->scope, callee->text, &depth, &owner) != NULL) return 0;
    return find_function(emitter, callee->text) != NULL;
}

static int name_is_bound(Emitter *emitter, const char *name)
{
    int depth;
    Scope *owner;
    return scope_find(emitter->scope, name, &depth, &owner) != NULL;
}

static int call_is_record_constructor(Emitter *emitter, const Expr *callee)
{
    return callee->kind == EX_NAME && !name_is_bound(emitter, callee->text) &&
           find_record(emitter, callee->text) != NULL;
}

static void emit_name_address(Emitter *emitter, const char *name)
{
    int depth;
    Scope *owner;
    Binding *binding = scope_find(emitter->scope, name, &depth, &owner);
    int i;
    if (binding == NULL) {
        fprintf(emitter->out, "\tlea\trax, [rel %s]\n", name);
        return;
    }
    if (owner->is_global) {
        fprintf(emitter->out, "\tlea\trax, [rel __jabara_global_%s]\n", name);
        return;
    }
    line(emitter, "\tmov\trax, [rbp - 8]");
    for (i = 0; i < depth; ++i) line(emitter, "\tmov\trax, [rax]");
    fprintf(emitter->out, "\tadd\trax, %d\n", binding->slot * 8);
}

static void emit_lvalue_address(Emitter *emitter, const Expr *expr)
{
    if (expr->kind == EX_BYTE) expr = expr->left;
    if (expr->kind == EX_NAME) {
        emit_name_address(emitter, expr->text);
    } else if (expr->kind == EX_DEREF) {
        emit_expr(emitter, expr->left);
    } else if (expr->kind == EX_MEMBER) {
        const Record *record = expr_record_type(emitter, expr->left);
        const Name *field;
        int offset;
        if (record == NULL)
            fatal_at(expr->line, 1, "member access requires a record tag");
        field = find_record_field(record, expr->text);
        if (field == NULL) fatal_at(expr->line, 1, "tagged record has no such field");
        offset = record_field_offset(record, expr->text);
        emit_expr(emitter, expr->left);
        if (offset != 0)
            fprintf(emitter->out, "\tadd\trax, %d\n", offset);
    } else {
        fatal_at(expr->line, 1, "expression is not assignable");
    }
}

static void emit_comparison(Emitter *emitter, const char *instruction)
{
    line(emitter, "\txor\trdx, rdx");
    line(emitter, "\tcmp\trax, rdi");
    fprintf(emitter->out, "\t%s\tdl\n", instruction);
    line(emitter, "\tmov\trax, rdx");
}

static void emit_binary(Emitter *emitter, const Expr *expr)
{
    emit_expr(emitter, expr->right);
    line(emitter, "\tpush\trax");
    emit_expr(emitter, expr->left);
    line(emitter, "\tpop\trdi");
    switch (expr->op) {
    case TOK_PLUS: line(emitter, "\tadd\trax, rdi"); break;
    case TOK_MINUS: line(emitter, "\tsub\trax, rdi"); break;
    case TOK_STAR: line(emitter, "\timul\trax, rdi"); break;
    case TOK_SLASH:
        line(emitter, "\txor\trdx, rdx"); line(emitter, "\tdiv\trdi"); break;
    case TOK_PERCENT:
        line(emitter, "\txor\trdx, rdx"); line(emitter, "\tdiv\trdi");
        line(emitter, "\tmov\trax, rdx"); break;
    case TOK_AMP: line(emitter, "\tand\trax, rdi"); break;
    case TOK_PIPE: line(emitter, "\tor\trax, rdi"); break;
    case TOK_XOR: line(emitter, "\txor\trax, rdi"); break;
    case TOK_SHL: line(emitter, "\tmov\trcx, rdi"); line(emitter, "\tshl\trax, cl"); break;
    case TOK_SHR: line(emitter, "\tmov\trcx, rdi"); line(emitter, "\tshr\trax, cl"); break;
    case TOK_AND:
        line(emitter, "\ttest\trax, rax"); line(emitter, "\tsetnz\tal");
        line(emitter, "\tmovzx\trax, al"); line(emitter, "\ttest\trdi, rdi");
        line(emitter, "\tsetnz\tdil"); line(emitter, "\tmovzx\trdi, dil");
        line(emitter, "\tand\trax, rdi"); break;
    case TOK_OR:
        line(emitter, "\ttest\trax, rax"); line(emitter, "\tsetnz\tal");
        line(emitter, "\tmovzx\trax, al"); line(emitter, "\ttest\trdi, rdi");
        line(emitter, "\tsetnz\tdil"); line(emitter, "\tmovzx\trdi, dil");
        line(emitter, "\tor\trax, rdi"); break;
    case TOK_EQ: emit_comparison(emitter, "sete"); break;
    case TOK_NE: emit_comparison(emitter, "setne"); break;
    case TOK_LT: emit_comparison(emitter, "setl"); break;
    case TOK_LE: emit_comparison(emitter, "setle"); break;
    case TOK_GT: emit_comparison(emitter, "setg"); break;
    case TOK_GE: emit_comparison(emitter, "setge"); break;
    default: fatal_at(expr->line, 1, "unsupported binary operator");
    }
}

static void emit_direct_call(Emitter *emitter, const Expr *expr)
{
    size_t i;
    if (expr->argument_count > 8191U)
        fatal_at(expr->line, 1, "calls support at most 8191 arguments");
    for (i = 0U; i < expr->argument_count; ++i) {
        emit_expr(emitter, expr->arguments[i]);
        line(emitter, "\tpush\trax");
    }
    fprintf(emitter->out, "\tcall\t%s\n", expr->left->text);
}

static void emit_closure_call(Emitter *emitter, const Expr *expr)
{
    size_t i;
    size_t count = expr->argument_count;
    emit_expr(emitter, expr->left);
    line(emitter, "\tpush\trax");
    for (i = 0U; i < count; ++i) {
        emit_expr(emitter, expr->arguments[i]);
        line(emitter, "\tpush\trax");
    }
    if (count == 0U) {
        line(emitter, "\tmov\trax, [rsp]");
        line(emitter, "\txor\tedx, edx");
        line(emitter, "\tmov\trcx, [rax + 8]");
        line(emitter, "\tpush\trcx");
        line(emitter, "\tpush\trdx");
        line(emitter, "\tcall\t[rax]");
    } else {
        for (i = 0U; i < count; ++i) {
            if (i == 0U)
                fprintf(emitter->out, "\tmov\trax, [rsp + %lu]\n",
                        (unsigned long)(count * 8U));
            fprintf(emitter->out, "\tmov\trdx, [rsp + %lu]\n",
                    (unsigned long)((count - 1U - i) * 8U));
            line(emitter, "\tmov\trcx, [rax + 8]");
            line(emitter, "\tpush\trcx");
            line(emitter, "\tpush\trdx");
            line(emitter, "\tcall\t[rax]");
        }
    }
    fprintf(emitter->out, "\tadd\trsp, %lu\n", (unsigned long)((count + 1U) * 8U));
}

static Scope *new_closure_scope(Emitter *emitter, const Expr *expr, int label_number)
{
    Scope *scope = (Scope *)xmalloc(sizeof(*scope));
    ClosureInfo *info = (ClosureInfo *)xmalloc(sizeof(*info));
    memset(scope, 0, sizeof(*scope));
    scope->parent = emitter->scope;
    scope_add(emitter, scope, expr->text, expr->tag, expr->line);
    collect_locals(emitter, scope, expr->body);
    info->expr = expr;
    info->scope = scope;
    info->label = label_number;
    info->next = NULL;
    *emitter->closure_tail = info;
    emitter->closure_tail = &info->next;
    return scope;
}

static void emit_closure_value(Emitter *emitter, const Expr *expr)
{
    int label_number = (int)new_label(emitter);
    (void)new_closure_scope(emitter, expr, label_number);
    fprintf(emitter->out, "\tlea\trax, [rel __jabara_closure_%d]\n", label_number);
    line(emitter, "\tpush\trax");
    if (emitter->scope->is_global) line(emitter, "\txor\trax, rax");
    else line(emitter, "\tmov\trax, [rbp - 8]");
    line(emitter, "\tpush\trax");
    line(emitter, "\tpush\t16");
    line(emitter, "\tcall\t__jabara_alloc");
    line(emitter, "\tpop\trdx");
    line(emitter, "\tpop\trcx");
    line(emitter, "\tmov\t[rax], rcx");
    line(emitter, "\tmov\t[rax + 8], rdx");
}

static void emit_string(Emitter *emitter, const char *text)
{
    unsigned long data_label = new_label(emitter);
    const unsigned char *p = (const unsigned char *)text;
    fprintf(emitter->out, "\tjmp\t__jabara_string_after_%lu\n", data_label);
    fprintf(emitter->out, "__jabara_string_%lu: db ", data_label);
    if (*p == 0U) put(emitter, "0");
    while (*p != 0U) {
        fprintf(emitter->out, "%u,", (unsigned int)*p++);
        if (*p == 0U) put(emitter, "0");
    }
    put(emitter, "\n");
    fprintf(emitter->out, "__jabara_string_after_%lu:\n", data_label);
    fprintf(emitter->out, "\tlea\trax, [rel __jabara_string_%lu]\n", data_label);
}

static void emit_record_constructor(Emitter *emitter, const Expr *expr)
{
    const Record *record = find_record(emitter, expr->left->text);
    int fields;
    int i;
    if (expr->argument_count != 0U)
        fatal_at(expr->line, 1, "record constructors take no arguments");
    fields = record_field_count(record);
    fprintf(emitter->out, "\tpush\t%d\n", (fields == 0 ? 1 : fields) * 8);
    line(emitter, "\tcall\t__jabara_alloc");
    for (i = 0; i < fields; ++i)
        fprintf(emitter->out, "\tmov\tqword [rax + %d], 0\n", i * 8);
}

static void emit_expr(Emitter *emitter, const Expr *expr)
{
    switch (expr->kind) {
    case EX_NUMBER: fprintf(emitter->out, "\tmov\trax, %ld\n", expr->number); break;
    case EX_STRING: emit_string(emitter, expr->text); break;
    case EX_NAME:
        {
            int depth;
            Scope *owner;
            if (scope_find(emitter->scope, expr->text, &depth, &owner) == NULL) {
                if (find_function(emitter, expr->text) != NULL)
                    fatal_at(expr->line, 1, "sub cannot be used as a value; wrap it in fn");
                else
                    fprintf(emitter->out, "\tlea\trax, [rel %s]\n", expr->text);
            } else {
                emit_name_address(emitter, expr->text);
                line(emitter, "\tmov\trax, [rax]");
            }
        }
        break;
    case EX_DEREF:
        emit_expr(emitter, expr->left); line(emitter, "\tmov\trax, [rax]"); break;
    case EX_MEMBER:
        emit_lvalue_address(emitter, expr); line(emitter, "\tmov\trax, [rax]"); break;
    case EX_BYTE:
        emit_lvalue_address(emitter, expr->left); line(emitter, "\tmovzx\trax, byte [rax]"); break;
    case EX_UNARY:
        emit_expr(emitter, expr->left);
        if (expr->op == TOK_MINUS) line(emitter, "\tneg\trax");
        else if (expr->op == TOK_BNOT) line(emitter, "\tnot\trax");
        else { line(emitter, "\ttest\trax, rax"); line(emitter, "\tsetz\tal"); line(emitter, "\tmovzx\trax, al"); }
        break;
    case EX_BINARY: emit_binary(emitter, expr); break;
    case EX_ASSIGN:
        emit_lvalue_address(emitter, expr->left);
        line(emitter, "\tpush\trax");
        emit_expr(emitter, expr->right);
        line(emitter, "\tpop\trdi");
        if (expr->left->kind == EX_BYTE) line(emitter, "\tmov\t[rdi], al");
        else line(emitter, "\tmov\t[rdi], rax");
        break;
    case EX_CALL:
        if (call_is_record_constructor(emitter, expr->left))
            emit_record_constructor(emitter, expr);
        else if (call_is_direct(emitter, expr->left)) emit_direct_call(emitter, expr);
        else {
            if (expr->left->kind == EX_NAME && !name_is_bound(emitter, expr->left->text))
                fatal_at(expr->line, 1, "call to undeclared sub");
            emit_closure_call(emitter, expr);
        }
        break;
    case EX_CLOSURE: emit_closure_value(emitter, expr); break;
    }
}

static void emit_local_initializers(Emitter *emitter, const Name *name)
{
    while (name != NULL) {
        if (name->initializer != NULL) {
            emit_name_address(emitter, name->name);
            line(emitter, "\tpush\trax");
            emit_expr(emitter, name->initializer);
            line(emitter, "\tpop\trdi");
            line(emitter, "\tmov\t[rdi], rax");
        }
        name = name->next;
    }
}

static void emit_statements(Emitter *emitter, const Stmt *statement)
{
    while (statement != NULL) {
        if (statement->kind == ST_LOCAL) {
            emit_local_initializers(emitter, statement->names);
        } else if (statement->kind == ST_EXPR) {
            emit_expr(emitter, statement->expr);
        } else if (statement->kind == ST_RETURN) {
            emit_expr(emitter, statement->expr);
            fprintf(emitter->out, "\tjmp\t__jabara_return_%lu\n", emitter->return_label);
        } else if (statement->kind == ST_IF) {
            unsigned long otherwise = new_label(emitter);
            unsigned long done = new_label(emitter);
            emit_expr(emitter, statement->expr);
            line(emitter, "\ttest\trax, rax");
            fprintf(emitter->out, "\tjz\t__jabara_label_%lu\n", otherwise);
            emit_statements(emitter, statement->body);
            fprintf(emitter->out, "\tjmp\t__jabara_label_%lu\n", done);
            fprintf(emitter->out, "__jabara_label_%lu:\n", otherwise);
            emit_statements(emitter, statement->else_body);
            fprintf(emitter->out, "__jabara_label_%lu:\n", done);
        } else if (statement->kind == ST_WHILE) {
            unsigned long again = new_label(emitter);
            unsigned long done = new_label(emitter);
            fprintf(emitter->out, "__jabara_label_%lu:\n", again);
            emit_expr(emitter, statement->expr);
            line(emitter, "\ttest\trax, rax");
            fprintf(emitter->out, "\tjz\t__jabara_label_%lu\n", done);
            emit_statements(emitter, statement->body);
            fprintf(emitter->out, "\tjmp\t__jabara_label_%lu\n", again);
            fprintf(emitter->out, "__jabara_label_%lu:\n", done);
        }
        statement = statement->next;
    }
}

static void emit_zero_environment(Emitter *emitter, int slots)
{
    int i;
    line(emitter, "\tmov\tqword [rax], 0");
    for (i = 1; i <= slots; ++i)
        fprintf(emitter->out, "\tmov\tqword [rax + %d], 0\n", i * 8);
}

static void emit_stack_return(Emitter *emitter, size_t argument_count)
{
    line(emitter, "\tdb\t201");
    if (argument_count == 0U) {
        line(emitter, "\tret");
    } else {
        line(emitter, "\tdb\t194");
        fprintf(emitter->out, "\tdw\t%lu\n",
                (unsigned long)(argument_count * 8U));
    }
}

static void emit_function(Emitter *emitter, const Function *function)
{
    Scope *scope;
    const Name *parameter;
    int parameter_count = 0;
    int i;
    int environment_size;
    int frame_size;
    unsigned long saved_return = emitter->return_label;
    scope = (Scope *)xmalloc(sizeof(*scope));
    memset(scope, 0, sizeof(*scope));
    scope->parent = &emitter->global_scope;
    scope->next_owned = emitter->function_scopes;
    emitter->function_scopes = scope;
    parameter = function->parameters;
    while (parameter != NULL) {
        scope_add(emitter, scope, parameter->name, parameter->tag, function->line);
        ++parameter_count;
        parameter = parameter->next;
    }
    if (parameter_count > 8191)
        fatal_at(function->line, 1, "sub supports at most 8191 parameters");
    collect_locals(emitter, scope, function->body);
    emitter->scope = scope;
    emitter->return_label = new_label(emitter);
    environment_size = ((scope->slot_count + 1) * 8 + 15) & -16;
    frame_size = 16 + environment_size;
    fprintf(emitter->out, "\nglobal %s\n%s:\n", function->name, function->name);
    line(emitter, "\tpush\trbp");
    line(emitter, "\tmov\trbp, rsp");
    fprintf(emitter->out, "\tsub\trsp, %d\n", frame_size);
    fprintf(emitter->out, "\tlea\trax, [rbp - %d]\n", frame_size);
    line(emitter, "\tmov\t[rbp - 8], rax");
    emit_zero_environment(emitter, scope->slot_count);
    for (i = 0; i < parameter_count; ++i) {
        fprintf(emitter->out, "\tmov\trdx, [rbp + %d]\n",
                (parameter_count - i + 1) * 8);
        fprintf(emitter->out, "\tmov\t[rax + %d], rdx\n", (i + 1) * 8);
    }
    if (strcmp(function->name, "main") == 0) emit_statements(emitter, emitter->program->statements);
    emit_statements(emitter, function->body);
    line(emitter, "\txor\trax, rax");
    fprintf(emitter->out, "__jabara_return_%lu:\n", emitter->return_label);
    emit_stack_return(emitter, (size_t)parameter_count);
    emitter->return_label = saved_return;
    emitter->scope = &emitter->global_scope;
}

static void emit_closure_function(Emitter *emitter, ClosureInfo *info)
{
    Scope *saved_scope = emitter->scope;
    unsigned long saved_return = emitter->return_label;
    emitter->scope = info->scope;
    emitter->return_label = new_label(emitter);
    fprintf(emitter->out, "\n__jabara_closure_%d:\n", info->label);
    line(emitter, "\tpush\trbp");
    line(emitter, "\tmov\trbp, rsp");
    line(emitter, "\tsub\trsp, 16");
    fprintf(emitter->out, "\tpush\t%d\n", (info->scope->slot_count + 1) * 8);
    line(emitter, "\tcall\t__jabara_alloc");
    line(emitter, "\tmov\t[rbp - 8], rax");
    emit_zero_environment(emitter, info->scope->slot_count);
    line(emitter, "\tmov\trdx, [rbp + 24]");
    line(emitter, "\tmov\t[rax], rdx");
    line(emitter, "\tmov\trdx, [rbp + 16]");
    line(emitter, "\tmov\t[rax + 8], rdx");
    emit_statements(emitter, info->expr->body);
    line(emitter, "\txor\trax, rax");
    fprintf(emitter->out, "__jabara_return_%lu:\n", emitter->return_label);
    emit_stack_return(emitter, 2U);
    emitter->return_label = saved_return;
    emitter->scope = saved_scope;
}

int emit_program(const Program *program, const char *output_path)
{
    Emitter emitter;
    const Function *function;
    ClosureInfo *closure;
    FILE *out = fopen(output_path, "w");
    if (out == NULL) { fprintf(stderr, "jabara: cannot create %s\n", output_path); return -1; }
    memset(&emitter, 0, sizeof(emitter));
    emitter.out = out;
    emitter.program = program;
    emitter.global_scope.is_global = 1;
    emitter.scope = &emitter.global_scope;
    emitter.closure_tail = &emitter.closures;
    validate_records(&emitter);
    collect_locals(&emitter, &emitter.global_scope, program->statements);
    line(&emitter, "; generated by the jabara bootstrap compiler");
    line(&emitter, "bits 64");
    function = program->functions;
    while (function != NULL) {
        if (!function->is_extern) emit_function(&emitter, function);
        function = function->next;
    }
    closure = emitter.closures;
    while (closure != NULL) {
        emit_closure_function(&emitter, closure);
        closure = closure->next;
    }
    line(&emitter, "\nalign 8");
    {
        Binding *binding = emitter.global_scope.bindings;
        while (binding != NULL) {
            fprintf(out, "__jabara_global_%s: dq 0\n", binding->name);
            binding = binding->next;
        }
    }
    if (fclose(out) != 0) emitter.failed = 1;
    closure = emitter.closures;
    while (closure != NULL) {
        ClosureInfo *next = closure->next;
        bindings_dispose(closure->scope->bindings);
        free(closure->scope);
        free(closure);
        closure = next;
    }
    bindings_dispose(emitter.global_scope.bindings);
    while (emitter.function_scopes != NULL) {
        Scope *next = emitter.function_scopes->next_owned;
        bindings_dispose(emitter.function_scopes->bindings);
        free(emitter.function_scopes);
        emitter.function_scopes = next;
    }
    return emitter.failed ? -1 : 0;
}
