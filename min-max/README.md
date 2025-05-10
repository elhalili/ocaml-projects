# Tic-Tac-Toe – Minimax and Alpha-Beta Pruning in OCaml

This project implements a graphical Tic-Tac-Toe game using OCaml and the Raylib graphics library. The AI opponent uses two algorithms:

- **Minimax** – a backtracking-style search extended for optimization  
- **Alpha-Beta Pruning** – an enhancement that prunes unpromising branches

## Overview

The human player (`X`) competes against the AI (`O`) on a 3×3 board.  
The UI is rendered with Raylib; use the mouse to place your moves and keyboard to restart.

## Algorithms

### Minimax as Backtracking for Optimization

Minimax can be seen as a specialized form of backtracking:

1. **Backtracking** explores all decision branches to find a valid solution.  
2. **Minimax** also explores the full game tree, but assigns a score to each terminal state:
   - Win for AI: `+10 − depth`
   - Loss for AI: `−10 + depth`
   - Draw: `0`

At each node, the algorithm “backs up” the scores:
- The **maximizer** (AI) chooses the child with the highest score.
- The **minimizer** (human) chooses the child with the lowest score.

This yields the optimal move under perfect play.

### Alpha-Beta Pruning

Alpha-Beta Pruning enhances Minimax by carrying two parameters:
- **α (alpha)**: the best score the maximizer can guarantee so far
- **β (beta)**: the best score the minimizer can guarantee so far

When exploring a node:
- If the current branch cannot improve upon α or β (i.e. α ≥ β), it is **pruned**—skipped entirely—to avoid wasted computation.  
- This significantly reduces the number of nodes evaluated, making the AI faster without changing its decisions.

## Project Structure

- `types.ml`      – Definitions of `player`, `board`, `game_phase`, and `algorithm`
- `board.ml`      – Board representation and cell operations
- `common.ml`     – Game logic (win/draw detection)
- `minmax.ml`     – Implementation of Minimax and Alpha-Beta Pruning
- `display.ml`    – Drawing the board and symbols using Raylib
- `main.ml`       – Main game loop, menu, and state management
- `dune`          – OCaml project configuration

## Dependencies

- **Raylib (C library)**: see [Raylib](https://github.com/raysan5/raylib/)
- **OCaml Raylib bindings**: install via Opam; see [raylib-ocaml](https://github.com/tjammer/raylib-ocaml)

## Running the Game

```bash
dune build
dune exec ./src/main.exe
````

Upon launch, press:

* **1** to play against the pure Minimax AI
* **2** to play against the Alpha-Beta Pruning AI

Click to place your `X`, watch the AI respond, and press **R** to restart after a game ends.

## Demo
Here is a demo for the game:

![Watch Demo](../assets/minmax-demo.mp4)


