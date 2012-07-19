
all: hello testnonblock testraw testwindow testpanel testpanel2 testform

hello: hello.c
	gcc -o $@ $^ -lncurses

testnonblock: testnonblock.c
	gcc -o $@ $^ -lncurses

testraw: testraw.c
	gcc -o $@ $^ -lncurses

testwindow: testwindow.c
	gcc -o $@ $^ -lncurses

testpanel: testpanel.c
	gcc -o $@ $^ -lncurses -lpanel

testpanel2: testpanel2.c
	gcc -o $@ $^ -lncurses -lpanel

testform: testform.c
	gcc -o $@ $^ -lncurses -lform

.PHONY: all clean

clean:
	rm -f hello testnonblock testraw testwindow testpanel testpanel2 testform
