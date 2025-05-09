open Types



let check_winner_of (board : board) (player : player) : bool =
  let matrix = Array.of_list (List.map Array.of_list board) in

  let diag1 = matrix.(0).(0) = Some player &&
              matrix.(1).(1) = Some player &&
              matrix.(2).(2) = Some player in
  let diag2 = matrix.(0).(2) = Some player &&
              matrix.(1).(1) = Some player &&
              matrix.(2).(0) = Some player in

  let row_win =
    Array.exists (fun row ->
      Array.for_all (fun cell -> cell = Some player) row
    ) matrix
  in

  let col_win =
    Array.exists (fun i ->
      matrix.(0).(i) = Some player &&
      matrix.(1).(i) = Some player &&
      matrix.(2).(i) = Some player
    ) [|0; 1; 2|]
  in

  diag1 || diag2 || row_win || col_win
