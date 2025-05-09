type player = X | O
type cell = player option
type board = cell list list
type algorithm = Minimax | AlphaBeta
type game_phase = Menu | Playing | GameOver

let other_player = function
  | X -> O
  | O -> X

let string_of_player = function
  | X -> "X"
  | O -> "O"
