open Raylib
open Types
open Board

let cell_size = 100
let padding = 20

let draw_board (board : board) =
  for y = 0 to 2 do
    for x = 0 to 2 do
      let px = x * cell_size in
      let py = y * cell_size in
      draw_rectangle px py cell_size cell_size Color.lightgray;
      draw_rectangle_lines px py cell_size cell_size Color.darkgray;
      
      match get_cell board x y with
      | Some X ->
          (* drawing X symbol *)
          let x1 = px + padding in
          let y1 = py + padding in
          let x2 = px + cell_size - padding in
          let y2 = py + cell_size - padding in
          draw_line x1 y1 x2 y2 Color.red;
          draw_line x1 y2 x2 y1 Color.red
      | Some O ->
          (* drawing O symbol *)
          let center_x = px + cell_size / 2 in
          let center_y = py + cell_size / 2 in
          let radius = (float_of_int cell_size /. 2.) -. float_of_int padding in
          draw_circle_lines center_x center_y radius Color.blue
      | None -> ()
    done
  done
