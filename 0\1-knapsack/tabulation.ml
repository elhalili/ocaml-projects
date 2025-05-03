let knapsack weights values capacity =
  let n = Array.length weights in
  let dp = Array.make_matrix (n + 1) (capacity + 1) 0 in
  for i = 1 to n do
    for w = 0 to capacity do
      if weights.(i - 1) <= w then
        dp.(i).(w) <- max dp.(i - 1).(w) (dp.(i - 1).(w - weights.(i - 1)) + values.(i - 1))
      else
        dp.(i).(w) <- dp.(i - 1).(w)
    done
  done;
  dp.(n).(capacity)
