#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>

int main(int argc, char **argv) {
    const uintptr_t origin = 0x10000;
    int fd;
    struct stat st;
    void *image;

    if (argc != 2) return 2;
    fd = open(argv[1], O_RDONLY);
    if (fd < 0 || fstat(fd, &st) < 0) return 3;
    image = mmap((void *)origin, (size_t)st.st_size,
                 PROT_READ | PROT_WRITE | PROT_EXEC,
                 MAP_PRIVATE | MAP_FIXED, fd, 0);
    if (image == MAP_FAILED) {
        fprintf(stderr, "mmap: %s\n", strerror(errno));
        return 4;
    }
    close(fd);
    return ((int (*)(void))origin)() == 42 ? 0 : 1;
}
