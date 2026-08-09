# Snake_Game_AI

A terminal-based snake game written in C with AI/autopilot and screensaver modes.

This project is a fork of the classic `snakeai` game and keeps the original terminal aesthetic while adding a configurable AI-driven gameplay loop and a polished README for the current repository.

## Features

- Classic snake gameplay in the terminal
- Normal and arcade modes
- Autopilot mode that guides the snake to food automatically
- Screensaver mode that restarts after death
- Multiple visual styles: `fancy`, `full`, `ascii`, and `dots`
- Adjustable board size, speed, teleport behavior, and junk density
- Pathfinding options with `A*`, BFS, and a tuned A\* variant
- Keyboard controls using `wasd`, `hjkl`, and arrow keys

## Requirements

This project is designed for Unix-like terminal environments and uses standard C plus the bundled termbox headers in the repository.

- GCC
- Make
- POSIX-style terminal environment

No external package install is required beyond the compiler toolchain.

## Installation

```bash
git clone https://github.com/svarunmr/Snake_Game_AI.git
cd "snake game ai"
make
```

Optional system-wide install:

```bash
sudo make install
```

To remove the built binary:

```bash
make clean
```

## Quick start

Display the built-in help and options:

```bash
./snakeai -h
```

Play manually:

```bash
./snakeai
```

Start autopilot mode:

```bash
./snakeai -m autopilot -s 15 -j 10
```

Run the screensaver mode:

```bash
./snakeai -m screensaver -s 15 -z -x 8 -y 8 --try-hard 1
```

## Controls

### Normal / Arcade

- `WASD`, `HJKL`, or arrow keys: move
- `Space`: pause
- `Q`: quit

### Autopilot / Screensaver

- `+` / `-`: increase or decrease speed
- `Space`: pause
- `Q`: quit
- Any other key in screensaver mode: quit

## Game options

Common examples:

```bash
./snakeai -m normal -l ascii -s 10
./snakeai -m arcade -z -t
./snakeai -m autopilot --short-path=bfs -x 30 -y 20
./snakeai -m screensaver --try-hard 2 -j 5
```

Main CLI options include:

- `-m, --mode`: `normal`, `arcade`, `autopilot`, `screensaver`
- `-l, --look`: `fancy`, `full`, `ascii`, `dots`
- `-s, --speed`: game speed from 1 to 20
- `-x, --maxX`: board width
- `-y, --maxY`: board height
- `-j, --junk`: junk density from 1 to 10
- `-z, --score`: show the current snake size
- `-t, --teleport`: wrap through borders
- `--try-hard`: AI difficulty setting for autopilot/screensaver modes
- `--short-path`: pathfinding algorithm (`astar`, `bfs`, `asfixed`)

## Notes

- The program relies on terminal input and rendering, so it is best run in a real terminal and not inside a basic text-only environment.
- If you want to tune the game behavior, the main entry point is in `main.c` and the autonomous movement logic is in `autopilot.c`.

## License

This project is distributed under the terms of the repository license in the root of the project.

## Credits

Original project inspiration and core gameplay logic come from the `snakeai` terminal game by Angel Jumbo, adapted and maintained in this repository for current use.
