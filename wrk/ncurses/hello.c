#include <ncurses.h>

int main()
{
	int ch, ch2;
	initscr();			/* Start curses mode		  */
	printw("Hello World !!!");	/* Print Hello World  */
	refresh();			/* Print it on to the real screen */
	ch = getch();			/* Wait for user input */
	ch2 = getch();			/* Wait for user input */
	endwin();			/* End curses mode(  */

	printf("ch  = %d (0x%04X)\n", ch, ch);
	printf("ch2 = %d (0x%04X)\n", ch2, ch2);

	return 0;
}

