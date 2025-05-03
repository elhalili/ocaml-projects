let knapsack weights values capacity = 
  let n = Array.length weights in
  let rec aux w v n c = (
    if n = 0 || c = 0 
      then 0
    else if w.(n - 1) > c 
      then aux w v (n - 1) c
    else 
      let include_item = v.(n - 1) + aux w v (n - 1) (c - w.(n - 1)) in
      let exclude_item = aux w v (n - 1) c in
      max include_item exclude_item )
  in aux weights values n capacity
