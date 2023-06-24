#include "pith.h"

auto_t main() {
	auto_t c, fd, fd2;
	fd = open("./test.txt", READ);
	seek(fd, 1, 0);
	fd2 = creat("./test2.txt");
	while (read(fd, &c, 1) > 0) {
		write(fd2, &c, 1);
	}
	close(fd);
	close(fd2);
	exit();
}
