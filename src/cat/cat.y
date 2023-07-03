
{

  usage: cat file [ file ]

  print the contents of file(s) to stdout

}

sub malloc(size)
	local ptr
	ptr = brk(-1)
	brk(ptr + size)
	return ptr
end

sub puts(strPtr)
	local c
	while c = [strPtr] & 255 do
		putch(c)
		strPtr = strPtr + 1
	end
	return 0
end

sub nextarg(strPtr)
	local c
	while c = [strPtr] & 255 do
		strPtr = strPtr + 1
	end
	return strPtr + 1
end

sub main(argc, argv)
	local fd, bufPtr
	if argc < 2 then
		puts("usage: cat file { file }")
		putch(10)
		exit()
	end
	bufPtr = malloc(1)
	while argc > 1 do
		argv = nextarg(argv)
		fd = open(argv, 0)
		if fd > 0 then
			while read(fd, bufPtr, 1) > 0 do
				putch([bufPtr] & 255)
			end
			close(fd)
		end
		argc = argc - 1
	end
	putch(0) { 0 indicates end of stream }
	return 0
end
