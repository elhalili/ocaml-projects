
# 0/1 Knapsack Problem – Functional Programming Approach

This project implements the **0/1 Knapsack problem** using OCaml, demonstrating three classical approaches:

- **Naive recursion (Brute-force)**
- **Top-down memoization**
- **Bottom-up tabulation**


## Problem Overview

The **0/1 Knapsack problem** is a combinatorial optimization problem.  
Given:

- A set of `n` items
- Each item `i` has a weight `w[i]` and a value `v[i]`
- A knapsack with a maximum capacity `C`

The goal is to determine the maximum value achievable by selecting items such that:

- Each item is either included or not (`0-1`)
- The total weight does not exceed `C`


## Why Use Dynamic Programming?

The naive recursive approach explores all subsets, resulting in **exponential time complexity**:  
`O(2^n)`

Dynamic programming improves this drastically by **avoiding repeated subproblem evaluations**, reducing complexity to `O(n × C)`.


## DP Recurrence Relation

Let `dp[i][c]` be the maximum value that can be obtained using the first `i` items and a remaining capacity `c`.

```text
dp[0][c] = 0                                 // Base case: no items
dp[i][c] = dp[i-1][c]                        // If weight[i-1] > c (can't include item)
         = max(dp[i-1][c], 
               dp[i-1][c - weight[i-1]] + value[i-1])  // Otherwise, choose to include or exclude
````


## Example

Input:

```ocaml
let weights = [|2; 3; 4; 5|]
let values  = [|5; 2; 8; 2|]
let capacity = 5
```

Best selection:

* Item 2 → weight **4 < 5**, values **8**


## Files

* `main.ml` – Runs all three approaches and displays their results
* `naive.ml` – Simple recursive solution
* `memoization.ml` – Memoized recursive solution
* `tabulation.ml` – Bottom-up DP
* `Makefile` – Build and clean commands


## How to Run

### Prerequisites

* OCaml installed (`ocamlc`)
* GNU `make`

### Build and Execute

```bash
cd 0\\1-knapsack
make
./build/main
make clean
```



