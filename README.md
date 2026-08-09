# Snake Game AI — Autonomous Pathfinding in C

## Overview

This repository contains a terminal-based Snake game implemented in C with autonomous pathfinding and screensaver-style behavior. The project keeps the original terminal presentation and gameplay loop while adding planning logic for autopilot modes and alternate path-search strategies.

The implementation is centered on a classic board-based Snake game with:

- manual play and arcade difficulty
- autopilot pathfinding
- screensaver loop behavior
- configurable board geometry and rendering style
- obstacle generation and wraparound behavior

## Attribution / Origin

This repository is based on the original `sssnake` project by Angel A. Jumbo and retains its MIT license and attribution. The code in this repository extends that base with autonomous navigation logic, path-selection heuristics, and the current project documentation.

The original project remains the source of the gameplay structure and terminal rendering model, while this repository adds the current AI/pathfinding implementation and the GitHub-facing documentation.

## Features

The following features are confirmed by the current source tree:

- manual Snake gameplay in normal mode
- arcade mode with fixed board size and increasing speed when food is eaten
- autopilot mode that navigates toward food automatically
- screensaver mode that restarts after a collision or dead-end loop
- configurable board dimensions via `-x` and `-y`
- speed adjustment via `-s`
- random junk/obstacle placement via `-j`
- score display via `-z`
- multiple rendering styles: `fancy`, `full`, `ascii`, and `dots`
- optional wraparound/teleport mode via `-t`
- pathfinding using A* and BFS, with a second heuristic variant

## Pathfinding

### A*

The A* implementation lives in `autopilot.c` and is exposed through `a_star_search`. It uses:

- a grid-backed occupancy map (`XYMap`)
- a min-heap priority queue (`MinHeap`)
- a `Cell` structure that stores `parent_i`, `parent_j`, `f`, `g`, and `h`
- parent-path reconstruction to recover the route back to the origin
- body-aware validation to avoid stepping into the snake's own body
- wraparound support when teleporting is enabled

The cost model is based on cumulative path cost `g` plus heuristic cost `h`, and the selected node is always the lowest `f = g + h` candidate from the priority queue.

### BFS

The repository also includes a breadth-first search implementation via `breadth_first_search`. This alternative does not use a heuristic; it explores the board in layers and records parent pointers so the route can be reconstructed.

### Heuristics

Two heuristic functions are present in the code:

- `calculate_h_value`: Manhattan-style distance with optional wraparound-aware handling
- `calculate_h_value_fixed`: an alternative heuristic that adds a turn penalty to prefer straighter movement in some cases

The selected path-search algorithm is changed through `set_short_path_algorithm`, which allows the project to swap among A*, BFS, and the fixed-heuristic A* variant.

## Autonomous Navigation

Autonomous movement is integrated into the main game loop in `main.c`.

When the game is started in autopilot or screensaver mode, the program:

1. builds or refreshes a path toward the current food target
2. validates the route against the current snake body and board state
3. uses `update_position_autopilot` to drive the head along the chosen path
4. falls back to the current direction when a path cannot be found
5. regenerates a route after eating food or when the state changes

The `try_hard` function validates whether a route is safe and can extend or adjust it when the straightforward path is not reliable.

## Game Modes

The code confirms these modes:

- Normal: manual movement through keyboard input
- Arcade: fixed-size board, score display, and increased speed after eating
- Autopilot: snake follows computed routes to food automatically
- Screensaver: autoplay loop that restarts after a collision or dead-end condition

## Board Mechanics

The board and gameplay mechanics are implemented by the following verified features:

- configurable width and height with `-x` and `-y`
- speed tuning with `-s`
- random junk blocks via `-j`
- multiple rendering styles via `-l`
- wraparound movement via `-t`
- score overlay via `-z`
- wall constraints and collision detection via the board occupancy map

## Data Structures

The implementation uses the following confirmed structures:

- `MinHeap` for the A* priority queue
- `Stack` for path reconstruction and route traversal
- `Queue` for BFS traversal
- `List` as a generic linked-list container
- doubly linked `SnakePart` nodes for the snake body
- `XYMap` as the board occupancy grid
- `Cell` as A* state bookkeeping for parent and cost values

## Build

Clone the repository and build it from the project root:

```bash
git clone https://github.com/svarunmr/Snake_Game_AI.git
cd Snake_Game_AI
make
```

The supported Makefile targets in the current source are:

```bash
make
make debug
make clean
make install
make uninstall
```

The project expects a Unix-like terminal environment and the bundled termbox headers in the repository. The build is terminal-oriented and is not designed for a non-console environment.

## Usage

Display help:

```bash
./snakeai -h
```

Manual play:

```bash
./snakeai
```

Autopilot example:

```bash
./snakeai -m autopilot -s 15 -j 10
```

Screensaver example:

```bash
./snakeai -m screensaver -s 15 -z -x 8 -y 8 --try-hard 1
```

Example with BFS pathfinding:

```bash
./snakeai -m autopilot --short-path=bfs -x 30 -y 20
```

## Controls

### Normal / Arcade

- `W`, `A`, `S`, `D` or arrow keys: move
- `H`, `J`, `K`, `L`: Vim-style movement controls
- `Space`: pause
- `Q`: quit

### Autopilot / Screensaver

- `+` / `-`: increase or decrease speed
- `Space`: pause
- `Q`: quit

### Screensaver

- any non-`+`, non-`-`, non-space key quits the loop

## Configuration

The command-line options verified in the current code are:

- `-m, --mode` — `normal`, `arcade`, `autopilot`, `screensaver`
- `-l, --look` — `fancy`, `full`, `ascii`, `dots`
- `-s, --speed` — speed from 1 to 20
- `-x, --maxX` — board width
- `-y, --maxY` — board height
- `-j, --junk` — obstacle density
- `-z, --score` — show current snake length
- `-t, --teleport` — wraparound movement
- `--try-hard` — autopilot/screensaver difficulty modes
- `--short-path` — `astar`, `bfs`, or `asfixed`

## Project Structure

The repository contains the following key files:

- `main.c` — program entry point and CLI handling
- `autopilot.c` / `autopilot.h` — pathfinding and autopilot logic
- `snake.c` / `snake.h` — snake state, movement, and food logic
- `draw.c` / `draw.h` — terminal rendering and visual styles
- `xymap.c` / `xymap.h` — board occupancy map
- `structs.c` / `structs.h` — linked-list, stack, queue, and heap structures
- `termbox.h` — terminal I/O definitions
- `docs/snake.game.ai1.md` and `docs/snake.game.ai.1` — manpage sources
- `LICENSE` — original MIT license retained for the fork

## Future Improvements

Potential future work is limited to non-breaking improvements such as:

- better portability for non-POSIX terminals
- cleaning compiler warnings where practical
- improving documentation around gameplay and pathfinding behavior

This project should continue to be understood as a C systems-programming exercise in Snake gameplay plus pathfinding algorithms, not as a machine-learning or AI-model project.

## License

This project remains under the original MIT license in `LICENSE`, and the original attribution is preserved as required for the derivative work.
