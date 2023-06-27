mkdir bin
gcc src/lexer.c src/testers/lexer_tester.c -o bin/lexer_tester
gcc src/lexer.c src/parser.c src/testers/parser_tester.c -o bin/parser_tester
gcc src/lexer.c src/parser.c src/emitter.c -o bin/emitter_tester

