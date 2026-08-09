PREFIX = /usr/local
MANDIR = $(PREFIX)/share/man

snakeai: main.c autopilot.c xymap.c structs.c snake.c draw.c
	$(CC) -w main.c autopilot.c xymap.c structs.c snake.c draw.c -o snakeai

debug: main.c autopilot.c xymap.c structs.c snake.c draw.c
	$(CC) -w -Wall -g main.c autopilot.c xymap.c structs.c snake.c draw.c -o snakeai

.PHONY: genman
genman:
	pandoc ./docs/snake.game.ai1.md -s -t man -o ./docs/snake.game.ai.1

.PHONY: clean
clean:
	$(RM) snakeai

.PHONY: install
install: snakeai
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	mkdir -p $(DESTDIR)$(MANDIR)/man1
	install -m 755 snakeai $(DESTDIR)$(PREFIX)/bin/snakeai
	install -m 644 ./docs/snake.game.ai.1 $(DESTDIR)$(MANDIR)/man1/snakeai.1

.PHONY: uninstall
uninstall:
	$(RM) $(DESTDIR)$(PREFIX)/bin/snakeai
	$(RM) $(DESTDIR)$(MANDIR)/man1/snakeai.1
