# peel

peel is a userland suite written in yuzu. to test the user environment under linux, clone the yuzu repository and the peel repository side by side. then run ./build.sh in the yuzu repository. then run ./start.sh in the peel repository. once the pish shell has loaded, type build.pish to build all userland utilities in this self-hosted environent. check loc.txt for an automatically generated list of line counts. you'll find the following utilities in this repository:

	src/concat:	concatenates files
	src/copy:	copies files
	src/del:	deletes files
	src/dir:	directory listing
	src/echo:	echo to console
	src/jar:	archive utility
	src/juicer:	compressor / decompressor
	src/mkdir:	create a directory
	src/move:	move a file
	src/pish:	shell
	src/read:	read file and output to console
	src/rmdir:	remove a directory
	src/write:	write to a file from the console

