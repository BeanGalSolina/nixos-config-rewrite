#include <sys/types.h>
#include <ncurses.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <pwd.h>

const char* OPTIONS[] = { "Niri", "Console" };
const char NUM_OPTIONS = 2;

int main() {
	initscr();
	noecho();
	cbreak();
	curs_set(0);
	keypad(stdscr, TRUE);

	char choice = 0;
	bool chosen = false;
	while (!chosen) {
		move(1, 0);
		printw("  Choose init program:\n");

		for (int i = 0; i < NUM_OPTIONS; i++) {
			if (i == choice) {
				printw("  > ");
			} else {
				printw("    ");
			}

			printw("%s\n", OPTIONS[i]);
		}

		refresh();


		int ch = getch();
		switch (ch) {
			case KEY_UP:
				choice--;
				
				if (choice < 0) {
					choice = NUM_OPTIONS - 1;
				}

				break;
			case KEY_DOWN:
				choice++;

				if (choice > (NUM_OPTIONS - 1)) {
					choice = 0;
				}

				break;
			case 10:
				chosen = true;
				break;
		}
	}
	
	endwin();

	switch (choice) {
		case 0: // Niri
			execlp("niri-session", "niri-session", (char*) NULL);
			break;
		case 1: // Console
			break;
	}

	return 1;
}

