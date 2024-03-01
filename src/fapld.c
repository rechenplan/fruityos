#include <fcntl.h>
#include <sys/mman.h>
#include <stdio.h>

int main(int argc, char** argv) {
	printf("%d\n", O_RDONLY);
	printf("%d\n", 1024 * 1024 * 2);
	printf("%d\n", 1024 * 1024);
	printf("%d\n", PROT_EXEC | PROT_READ | PROT_WRITE);
	printf("%d\n", MAP_PRIVATE | MAP_ANONYMOUS);
	printf("fd\n");
	printf("0\n");
	printf("%d\n", MAP_FAILED);
}
