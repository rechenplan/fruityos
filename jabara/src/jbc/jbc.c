#include "jabara.h"

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void *xmalloc(size_t size)
{
    void *pointer = malloc(size == 0U ? 1U : size);
    if (pointer == NULL) { fputs("jabara: out of memory\n", stderr); exit(EXIT_FAILURE); }
    return pointer;
}

void *xrealloc(void *pointer, size_t size)
{
    void *result = realloc(pointer, size == 0U ? 1U : size);
    if (result == NULL) { fputs("jabara: out of memory\n", stderr); exit(EXIT_FAILURE); }
    return result;
}

char *xstrdup(const char *text)
{
    size_t length = strlen(text) + 1U;
    char *copy = (char *)xmalloc(length);
    memcpy(copy, text, length);
    return copy;
}

void fatal_at(int line, int column, const char *message)
{
    fprintf(stderr, "jabara:%d:%d: %s\n", line, column, message);
    exit(EXIT_FAILURE);
}

static void append_file(char **buffer, size_t *length, size_t *capacity, const char *path)
{
    FILE *file = fopen(path, "rb");
    long file_length;
    char *file_buffer;
    size_t got;
    if (file == NULL) { fprintf(stderr, "jabara: cannot open %s: %s\n", path, strerror(errno)); exit(EXIT_FAILURE); }
    if (fseek(file, 0L, SEEK_END) != 0 || (file_length = ftell(file)) < 0L ||
        fseek(file, 0L, SEEK_SET) != 0) {
        fprintf(stderr, "jabara: cannot read %s\n", path); exit(EXIT_FAILURE);
    }
    file_buffer = (char *)xmalloc((size_t)file_length);
    got = fread(file_buffer, 1U, (size_t)file_length, file);
    if (got != (size_t)file_length || fclose(file) != 0) {
        fprintf(stderr, "jabara: cannot read %s\n", path); exit(EXIT_FAILURE);
    }
    if (*length + got + 2U > *capacity) {
        *capacity = (*length + got + 2U) * 2U;
        *buffer = (char *)xrealloc(*buffer, *capacity);
    }
    memcpy(*buffer + *length, file_buffer, got);
    *length += got;
    (*buffer)[(*length)++] = '\n';
    (*buffer)[*length] = '\0';
    free(file_buffer);
}

int main(int argc, char **argv)
{
    char *source;
    Program *program;
    int status;
    int i;
    size_t length = 0U;
    size_t capacity = 1U;
    if (argc < 3) {
        fprintf(stderr, "usage: %s input.jabara [input.jabara ...] output.asm\n", argv[0]);
        return EXIT_FAILURE;
    }
    source = (char *)xmalloc(capacity);
    source[0] = '\0';
    for (i = 1; i < argc - 1; ++i)
        append_file(&source, &length, &capacity, argv[i]);
    program = parse_program(source);
    status = emit_program(program, argv[argc - 1]);
    program_dispose(program);
    free(source);
    return status == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
}
