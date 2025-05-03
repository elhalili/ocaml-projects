let () =
  let weights = [|2; 3; 4; 5|] in
  let values = [|5; 2; 8; 2|] in
  let capacity = 5 in
  let result = Tabulation.knapsack weights values capacity in
  Printf.printf "Maximum value: %d\n" result
