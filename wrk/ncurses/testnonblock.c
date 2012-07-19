#include <stdio.h>
#include <ncurses.h>

int main()
{
	int ch = 0;
	initscr();			/* Start curses mode		  */
	nodelay(stdscr, TRUE);
	printw("Hello World !!!");	/* Print Hello World  */
	refresh();			/* Print it on to the real screen */
	while (55 != ch) {
		ch = getch();			/* Wait for user input */
		if (ERR == ch) {
			mvprintw(0, 0, "...", ch);
		} else {
			mvprintw(0, 0, "ch = %d", ch);
		}
	}

	endwin();			/* End curses mode(  */

	printf("ch = %d\n", ch);

	return 0;
}

