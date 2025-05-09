open Raylib
open Types
open Board
open Display
open Common
open Minmax

(* X is the user and O is the computer *)
let () =
  init_window 300 400 "Min-Max broo";
  set_target_fps 60;

  let game_phase = ref Menu in
  let algorithm = ref None in
  let board = ref empty_board in
  let current_player = ref X in
  let winner = ref None in

  while not (window_should_close ()) do
    begin_drawing ();
    clear_background Color.raywhite;
    begin
    match !game_phase with
    | Menu ->
        draw_text "Choose AI Algorithm:" 50 50 20 Color.darkgray;
        draw_text "1. Minimax (Slower)" 50 100 20 Color.darkgray;
        draw_text "2. Alpha-Beta (Faster)" 50 150 20 Color.darkgray;
        
        if is_key_pressed Key.One then (
          algorithm := Some Minimax;
          game_phase := Playing
        );
        if is_key_pressed Key.Two then (
          algorithm := Some AlphaBeta;
          game_phase := Playing
        )

    | Playing ->
        draw_board !board;
        
        if !winner = None then begin
          match !current_player with
          | X ->
              if is_mouse_button_pressed MouseButton.Left then begin
                let mouse_x = get_mouse_x () in
                let mouse_y = get_mouse_y () in
                let cell_x = mouse_x / cell_size in
                let cell_y = mouse_y / cell_size in
                
                if cell_x < 3 && cell_y < 3 && is_cell_empty !board cell_x cell_y then begin
                  board := set_cell !board cell_x cell_y X;
                  if check_winner_of !board X then winner := Some X
                  else if List.for_all (fun row -> List.for_all (fun cell -> cell <> None) row) !board then
                    game_phase := GameOver
                  else
                    current_player := O
                end
              end
              
          | O ->
              let best_move = match !algorithm with
                | Some Minimax -> find_best_move_minimax !board O
                | Some AlphaBeta -> find_best_move_alphabeta !board O
                | None -> failwith "No algorithm selected"
              in
              match best_move with
              | Some (x, y) ->
                  board := set_cell !board x y O;
                  if check_winner_of !board O then winner := Some O
                  else if List.for_all (fun row -> List.for_all (fun cell -> cell <> None) row) !board then
                    game_phase := GameOver
                  else
                    current_player := X
              | None -> game_phase := GameOver
        end;
        
        if !winner <> None then game_phase := GameOver;

        begin
          match !winner with
          | Some p ->
              draw_text (Printf.sprintf "%s wins!" (string_of_player p))
                50 350 20 (if p = X then Color.red else Color.blue)
          | None ->
              draw_text (Printf.sprintf "%s's turn" (string_of_player !current_player)) 
                10 310 20 Color.darkgray
        end;

    | GameOver ->
        draw_board !board;
        let message, color = match !winner with
          | Some X -> ("You win! (X)", Color.red)
          | Some O -> ("AI wins! (O)", Color.blue)
          | None -> ("Game ended in draw!", Color.darkgray)
        in
        draw_text message 50 310 20 color;
        draw_text "Press R to restart" 50 350 20 Color.darkgray;
        
        if is_key_pressed Key.R then begin
          board := empty_board;
          current_player := X;
          winner := None;
          game_phase := Menu
        end;
      end;
    
    end_drawing ()
  done;

  close_window ()
