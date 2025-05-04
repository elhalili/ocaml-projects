let knapsack weights values capacity = 
  let n = Array.length weights in
  let memo = Hashtbl.create ((capacity + 1) * (n + 1)) in
  let rec aux n c =
    if Hashtbl.mem memo (n, c) then
      Hashtbl.find memo (n, c)
    else
      let result =
        if n = 0 || c = 0 then 0
        else if weights.(n - 1) > c then
          aux (n - 1) c
        else
          let include_item = values.(n - 1) + aux (n - 1) (c - weights.(n - 1)) in
          let exclude_item = aux (n - 1) c in
          max include_item exclude_item
      in
      Hashtbl.add memo (n, c) result;
      result
  in
  aux n capacity
