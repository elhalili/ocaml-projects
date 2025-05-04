let () =
  let weights = [|2; 3; 4; 5|] in
  let values = [|5; 2; 8; 2|] in
  let capacity = 5 in

  let naive = Naive.knapsack weights values capacity in
  let _ =
    Printf.printf "Naive recursion: %d\n" naive in

  let tabulation = Tabulation.knapsack weights values capacity in
  let _ = 
    Printf.printf "Tabluation: %d\n" tabulation in
  
  let memoization = Memoization.knapsack weights values capacity in
  let _ = 
    Printf.printf "Memoization: %d\n" memoization in
    ()
