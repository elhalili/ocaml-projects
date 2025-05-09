open Types
open Common
open Board

let winning_score = 10
let losing_score = -10
let draw_score = 0

let rec minimax board player current_player depth =
  if check_winner_of board player then winning_score - depth
  else if check_winner_of board (other_player player) then losing_score + depth
  else if List.for_all (fun row -> List.for_all (fun cell -> cell <> None) row) board then draw_score
  else
    let is_maximizing = (current_player = player) in
    let init_value = if is_maximizing then min_int else max_int in
    
    let rec evaluate_moves x y best_val =
      if y > 2 then best_val
      else if x > 2 then evaluate_moves 0 (y + 1) best_val
      else if not (is_cell_empty board x y) then evaluate_moves (x + 1) y best_val
      else
        let new_board = set_cell board x y current_player in
        let value = minimax new_board player (other_player current_player) (depth + 1) in
        let new_best = if is_maximizing then max best_val value else min best_val value in
        evaluate_moves (x + 1) y new_best
    in
    evaluate_moves 0 0 init_value

let rec alphabeta board player current_player depth alpha beta =
  if check_winner_of board player then winning_score - depth
  else if check_winner_of board (other_player player) then losing_score + depth
  else if List.for_all (fun row -> List.for_all (fun cell -> cell <> None) row) board then draw_score
  else
    let is_maximizing = (current_player = player) in
    let init_value = if is_maximizing then min_int else max_int in
    
    let rec evaluate_moves x y best_val alpha beta =
      if y > 2 then best_val
      else if x > 2 then evaluate_moves 0 (y + 1) best_val alpha beta
      else if not (is_cell_empty board x y) then evaluate_moves (x + 1) y best_val alpha beta
      else
        let new_board = set_cell board x y current_player in
        let value = alphabeta new_board player (other_player current_player) (depth + 1) alpha beta in
        let new_best, new_alpha, new_beta = 
          if is_maximizing then
            (max best_val value, max alpha value, beta)
          else
            (min best_val value, alpha, min beta value)
        in
        if new_alpha >= new_beta then new_best
        else evaluate_moves (x + 1) y new_best new_alpha new_beta
    in
    evaluate_moves 0 0 init_value alpha beta

let find_best_move_minimax board player =
  let rec search x y best_score best_move =
    if y > 2 then best_move
    else if x > 2 then search 0 (y + 1) best_score best_move
    else if not (is_cell_empty board x y) then search (x + 1) y best_score best_move
    else
      let new_board = set_cell board x y player in
      let move_score = minimax new_board player (other_player player) 0 in
      if move_score > best_score then
        search (x + 1) y move_score (Some (x, y))
      else
        search (x + 1) y best_score best_move
  in
  search 0 0 min_int None

let find_best_move_alphabeta board player =
  let rec search x y best_score best_move alpha beta =
    if y > 2 then best_move
    else if x > 2 then search 0 (y + 1) best_score best_move alpha beta
    else if not (is_cell_empty board x y) then search (x + 1) y best_score best_move alpha beta
    else
      let new_board = set_cell board x y player in
      let move_score = alphabeta new_board player (other_player player) 0 alpha beta in
      if move_score > best_score then
        search (x + 1) y move_score (Some (x, y)) (max alpha move_score) beta
      else
        search (x + 1) y best_score best_move alpha beta
  in
  search 0 0 min_int None min_int max_int
