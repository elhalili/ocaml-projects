let () =
  let weights = [|2; 3; 4; 5|] in
  let values = [|5; 2; 8; 2|] in
  let capacity = 5 in
  let result = Tabulation.knapsack weights values capacity in
  Printf.printf "Tabluation: %d\n" result

let () =
  let weights = [|2; 3; 4; 5|] in
  let values = [|5; 2; 8; 2|] in
  let capacity = 5 in
  let result = Naive.knapsack weights values capacity in
  Printf.printf "Naive recursion: %d\n" result
