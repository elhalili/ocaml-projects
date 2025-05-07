open Raylib
open Types
open Board

let cell_size = 100

let draw_board (board : board) =
  for y = 0 to 2 do
    for x = 0 to 2 do
      let px = x * cell_size in
      let py = y * cell_size in
      match get_cell board x y with
      | Some X -> draw_rectangle px py cell_size cell_size Color.red
      | Some O -> draw_rectangle px py cell_size cell_size Color.blue
      | None -> draw_rectangle px py cell_size cell_size Color.lightgray
    done
  done

