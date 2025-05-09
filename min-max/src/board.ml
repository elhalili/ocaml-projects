open Types

let empty_board : board =
  List.init 3 (fun _ -> List.init 3 (fun _ -> None))

let get_cell board x y =
  List.nth (List.nth board y) x

let is_cell_empty board x y =
  match get_cell board x y with
  | None -> true
  | _ -> false

let set_cell board x y player : board =
  List.mapi (fun row_i row ->
    List.mapi (fun col_i cell ->
      if row_i = y && col_i = x then Some player else cell
    ) row
  ) board
