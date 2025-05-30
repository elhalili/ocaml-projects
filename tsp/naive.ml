#use "structs.ml"
#use "common.ml"

let magic_land = [City (1., 2.); City (2., 2.3); City(3., 1.); City (4., 2.3); City (1., 1.2)]

let rec insert_everywhere x = function
  | [] -> [[x]]
  | hd :: tl -> (x :: hd :: tl) :: List.map (fun l -> hd :: l) (insert_everywhere x tl)

let rec permutations lst =
  match lst with
  | [] -> [[]]
  | hd :: tl ->
List.flatten (List.map (insert_everywhere hd) (permutations tl))

let tsp_naive cities =
  match cities with
  | [] | [_] -> cities
  | start :: rest ->
    let perms = permutations rest in
    let routes = List.map (fun p -> start :: p) perms in
    List.fold_left
      (fun best r ->
         if calc_route r < calc_route best then r else best)
      (List.hd routes)
  (List.tl routes)

let () =
  let best_path = tsp_naive magic_land in
  let shortest_distance = calc_route best_path in
  let _ = Printf.printf "Shortest distance: %f\n" shortest_distance in
  let f (City (x, y)) =
    Printf.printf "City x: %f, y: %f\n" x y
  in List.iter f best_path
  
