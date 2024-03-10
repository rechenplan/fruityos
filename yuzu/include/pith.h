#ifndef PITH_H
#define PITH_H

#define STDIN	0
#define STDOUT	1
#define STDERR	2

#define READ	0
#define WRITE	1

typedef	char*	auto_t;
extern	int	creat	(char* string);
extern	int	open	(char* string, int mode);
extern	int	read	(int file, char* buffer, int count);
extern	int	write	(int file, char* buffer, int count);
extern	void	close	(int file);
extern	int	seek	(int file, int offset, int pointer);
extern	int	getch	();
extern	void	putch	(int c);
extern	int	fgetch	(int fd);
extern	void	fputch	(int fd, int c);
extern	void*	brk	(void* addr);
extern	void	exit	(int);
extern	void	getcwd	(char* buffer, int size);
extern	void	exec	(char* path, char* argv);
extern	int	fork	();
#endif
