# Functional Programming Mini-Projects

This repository contains a collection of functional programming mini-projects developed as part of functional programming course assignment. 
Each project explores solving a classical problem using OCaml and functional programming paradigms such as recursion, and higher-order functions and so on.

## Project Overview

1. **[0-1 Knapsack](./0%5C1-knapsack/)**  
   Implements the 0-1 Knapsack problem using three approaches: naive recursion (brute-force), top-down memoization, and bottom-up tabulation.

2. **[Min-Max (Tic-Tac-Toe)](./min-max/)**  
   A functional implementation of the Tic-Tac-Toe game using the Minimax algorithm with Alpha-Beta pruning.

3. **[Traveling Salesperson Problem (TSP)](./tsp/)**  
   Solves the TSP using brute-force and also using genetic algorithm to approximate optimal routes.

## Technical Setup

Each project uses a different setup to explore more about the ocaml environment:

- **Knapsack** uses a `Makefile` for compilation.
- **Min-Max** is built with the `dune` build system and managed via `opam`.
- **TSP** is intended to be run directly using the OCaml interpreter.
