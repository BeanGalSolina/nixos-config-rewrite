#include <sys/types.h>
#include <ncurses.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <pwd.h>

typedef struct {
	char* name;
	char** command;
} WindowManager;

const WindowManager OPTIONS[] = { 
	{ .name = "Niri", .command = (char *[]) {"niri-session", NULL} },
	{ .name = "XFCE", .command = (char *[]) {"dbus-run-session", "startxfce4", NULL} },
	{ .name = "Console", .command = NULL }
};
const char NUM_OPTIONS = sizeof(OPTIONS) / sizeof(OPTIONS[0]);

int main() {
	initscr();
	noecho();
	cbreak();
	curs_set(0);
	keypad(stdscr, TRUE);

	int choice = 0;
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

			printw("%s\n", OPTIONS[i].name);
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

				if (choice > NUM_OPTIONS - 1) {
					choice = 0;
				}

				break;
			case 10:
				chosen = true;
				break;
		}
	}
	
	endwin();

	if (OPTIONS[choice].command != NULL) {
		execvp(OPTIONS[choice].command[0], OPTIONS[choice].command);
	}

	return 0;
}

