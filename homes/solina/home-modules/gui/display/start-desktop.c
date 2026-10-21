#include <sys/types.h>
#include <ncurses.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <pwd.h>

const char* OPTIONS[] = { "Niri", "Plasma", "Console" };
const char NUM_OPTIONS = 3;

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
					choice = 2;
				}

				break;
			case KEY_DOWN:
				choice++;

				if (choice > 2) {
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
		case 1: // Plasma
			execlp("dbus-run-session", "dbus-run-session", "startplasma-wayland", (char *)NULL);
			break;
		case 2: // Console
			break;
	}

	return 1;
}

