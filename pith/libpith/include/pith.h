#ifndef PITH_H
#define PITH_H

#define STDIN	0
#define STDOUT	1
#define STDERR	2

#define READ	0
#define WRITE	1

typedef	char*	auto_t;
extern	auto_t	creat	(auto_t string);
extern	auto_t	open	(auto_t string, auto_t mode);
extern	auto_t	read	(auto_t file, auto_t buffer, auto_t count);
extern	auto_t	write	(auto_t file, auto_t buffer, auto_t count);
extern	auto_t	close	(auto_t file);
extern	auto_t	seek	(auto_t file, auto_t offset, auto_t pointer);
extern	auto_t	getch	();
extern	auto_t	putch	(auto_t c);
extern	auto_t	brk	(auto_t addr);
extern	auto_t	exit	();

#endif
