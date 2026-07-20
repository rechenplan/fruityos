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

#ifndef MAP_FIXED_NOREPLACE
#define MAP_FIXED_NOREPLACE 0x100000
#endif

int main(int argc, char **argv) {
    if (argc < 2 || argc > 3) return 2;
    uint64_t expected = argc == 3 ? strtoull(argv[2], NULL, 0) : 0;
    const uintptr_t origin = UINT64_C(0x100000000);
    int fd = open(argv[1], O_RDONLY);
    if (fd < 0) { perror("open"); return 3; }
    struct stat st;
    if (fstat(fd, &st) < 0) { perror("fstat"); return 4; }
    size_t size = (size_t)st.st_size;
    size_t mapped = (size + 4095u) & ~4095u;
    void *p = mmap((void *)origin, mapped, PROT_READ|PROT_WRITE|PROT_EXEC,
                   MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED_NOREPLACE, -1, 0);
    if (p == MAP_FAILED) { perror("mmap fixed"); return 5; }
    size_t done = 0;
    while (done < size) {
        ssize_t n = read(fd, (char *)p + done, size - done);
        if (n <= 0) { perror("read"); return 6; }
        done += (size_t)n;
    }
    close(fd);
    uint64_t result;
    __asm__ volatile(
        "push %%rbx\n\t"
        "call *%1\n\t"
        "pop %%rbx"
        : "=a"(result)
        : "r"(p)
        : "rcx", "rdx", "r8", "r9", "r10", "r11", "memory", "cc");
    printf("result=%llu\n", (unsigned long long)result);
    return result == expected ? 0 : 1;
}
