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

static char *read_file(const char *path)
{
    FILE *file = fopen(path, "rb");
    long length;
    char *buffer;
    size_t got;
    if (file == NULL) { fprintf(stderr, "jabara: cannot open %s: %s\n", path, strerror(errno)); exit(EXIT_FAILURE); }
    if (fseek(file, 0L, SEEK_END) != 0 || (length = ftell(file)) < 0L ||
        fseek(file, 0L, SEEK_SET) != 0) {
        fprintf(stderr, "jabara: cannot read %s\n", path); exit(EXIT_FAILURE);
    }
    buffer = (char *)xmalloc((size_t)length + 1U);
    got = fread(buffer, 1U, (size_t)length, file);
    if (got != (size_t)length || fclose(file) != 0) {
        fprintf(stderr, "jabara: cannot read %s\n", path); exit(EXIT_FAILURE);
    }
    buffer[got] = '\0';
    return buffer;
}

int main(int argc, char **argv)
{
    char *source;
    Program *program;
    int status;
    if (argc != 3) {
        fprintf(stderr, "usage: %s input.jabara output.asm\n", argv[0]);
        return EXIT_FAILURE;
    }
    source = read_file(argv[1]);
    program = parse_program(source);
    status = emit_program(program, argv[2]);
    program_dispose(program);
    free(source);
    return status == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
}
