
sub pish_puts(str)
	local c
	while c = [str] & 255 do
		putch(c)
		str = str + 1
	end
end

sub pish_str_equal(a, b)
	while ([a] & 255) == ([b] & 255) do
		if !([a] & 255) then
			return 1
		end
		a = a + 1
		b = b + 1
	end
	return 0
end

sub pish_exec(line, argv)
	local pid, tempLine, tempArgv, c

	tempLine = line
	tempArgv = argv

	c = [tempLine] & 255
	while c != 10 && c do
		while c == 32 do
			[tempLine] = [tempLine] & (-256)
			tempLine = tempLine + 1
			c = [tempLine] & 255
		end
		if c != 10 then
			[tempArgv] = tempLine
			tempArgv = tempArgv + 8
		end
		while (c != 32) && (c != 10) && c do
			tempLine = tempLine + 1
			c = [tempLine] & 255
		end
	end
	[tempArgv] = 0
	

	pid = fork()
	if pid == 0 then
		exec([argv], argv)
		pish_puts("?")
		putch(10)
		exit()
	else
		waitpid(pid)
	end
end

sub main()
	local dirBuf, lineBuf, tempLine, argvBuf, c

	dirBuf = brk(-1)
	lineBuf = brk(dirBuf + 1024)
	argvBuf = brk(lineBuf + 1024)
	brk(argvBuf + 1024)


	while 1 do
		getcwd(dirBuf, 1024)
		pish_puts(dirBuf)
		putch([">"])
		putch(32)

		c = getch() & 255
		tempLine = lineBuf
		while c && (c != 10) do
			[tempLine] = c
			tempLine = tempLine + 1
			c = getch() & 255
		end
		[tempLine] = 0
		if pish_str_equal(lineBuf, "exit") then
			exit()
		else
			pish_exec(lineBuf, argvBuf)
		end
		
	end

end

