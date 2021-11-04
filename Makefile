all:	  fb

fb:	fb.l fb.y fb.h fbfunc.c
	bison -d fb.y && \
	flex -ofb.lex.c fb.l && \
	cc -g -o $@ fb.tab.c fb.lex.c fbfunc.c -lm

clean:
	rm -f fb fb \
	fb.lex.c fb.tab.h fb.tab.c fb.tab.c fb.tab.h fb.lex.c