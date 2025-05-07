open Raylib
open Types
open Board
open Display

let () =
  init_window 300 300 "Min-Max Broo";
  set_target_fps 60;

  let board = ref empty_board in
  let current_player = ref X in

  while not (window_should_close ()) do
    begin_drawing ();
    clear_background Color.raywhite;

    draw_board !board;

    if is_mouse_button_pressed MouseButton.Left then begin
      let mouse_x = get_mouse_x () in
      let mouse_y = get_mouse_y () in
      let cell_x = mouse_x / cell_size in
      let cell_y = mouse_y / cell_size in
      if cell_x < 3 && cell_y < 3 && is_cell_empty !board cell_x cell_y then begin
        board := set_cell !board cell_x cell_y !current_player;
        current_player := other_player !current_player
      end;
    end;

    end_drawing ();
  done;

  close_window ()

