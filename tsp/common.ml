#use "structs.ml"

let euclidean_distance (City (x1, y1)) (City (x2, y2)) : float = 
  let dx = x1 -. x2 in
  let dy = y1 -. y2 in
  sqrt (dx *. dx +. dy *. dy)

let calc_route (Route(lst)) = 
  let hd = List.hd lst in
  let rec aux lizt acc = 
    match lizt with
      | []          -> 0.
      | xs :: []    -> (euclidean_distance acc xs) +. (euclidean_distance xs hd)
      | xs :: l     -> (euclidean_distance acc xs) +. aux l xs 
  in aux lst hd

let rt = Route ([City (1., 1.); City (2., 2.)])

let () = 
  let _ = Printf.printf "Test: %f\n" (euclidean_distance (City (1., 1.)) (City (2., 2.))) in
  Printf.printf "All routes: %f\n" (calc_route rt)
