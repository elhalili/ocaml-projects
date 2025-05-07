(* encoding *)
#use "structs.ml" 
#use "common.ml"
let magic_land = [City (1., 2.); City (2., 2.3); City(3., 1.); City (4., 2.3); City (1., 1.2)]

(* initial population *)
 let knuth_shuffle a =
  let n = List.length a in
  let a = Array.of_list a in
  for i = n - 1 downto 1 do
    let k = Random.int (i+1) in
    let x = a.(k) in
    a.(k) <- a.(i);
    a.(i) <- x
  done;
  Array.to_list a

let generate_population cities n = 
  let population = [] in
  let rec aux pop m = 
    if m == 0 then pop
    else aux (pop @ [knuth_shuffle cities]) (m - 1)
  in aux population n

(* fitness *)
let fitness cities = 1. /. calc_route cities

(* parent selection *)
let top_n_parent lst n = 
  let f route = ((fitness route), route) in
  let mapped_lst = List.map f lst in
  let cmp (a, b) (c, d) = if a < c then 1 else -1  in    
  let sorted_mapped_lst = List.sort cmp mapped_lst in
  let rec extract lizt acc m = 
    if m == 0 then acc
    else 
      match lizt with
        | (a, b) :: xs -> extract xs (acc @ [b]) (m - 1)
        | [] -> acc
  in extract sorted_mapped_lst [] n

(* crossover *)
let cycle_crossover parent1 parent2 =
  let len = List.length parent1 in
  let parent1_arr = Array.of_list parent1 in
  let parent2_arr = Array.of_list parent2 in
  let child = Array.make len (List.hd parent1) in
  let visited = Array.make len false in

  let rec find_index city arr =
    let rec aux i =
      if i >= Array.length arr then failwith "City not found"
      else if arr.(i) = city then i
      else aux (i + 1)
    in aux 0
  in

  let rec build_cycle idx cycle =
    if visited.(idx) then cycle
    else begin
      visited.(idx) <- true;
      let next_city = parent2_arr.(idx) in
      let next_idx = find_index next_city parent1_arr in
      build_cycle next_idx (idx :: cycle)
    end
  in

  let cycle_indices = List.rev (build_cycle 0 []) in

  List.iter (fun i -> child.(i) <- parent1_arr.(i)) cycle_indices;

  for i = 0 to len - 1 do
    if not (List.mem i cycle_indices) then
      child.(i) <- parent2_arr.(i)
  done;

  Array.to_list child

(* crossover using cycle Crossover *)
let crossover parents =
  match parents with
  | [p1; p2] -> cycle_crossover p1 p2
  | _ -> failwith "Expected two parents"

(* mutation *)
let mutate rate route =
  if Random.float 1.0 > rate then route else
  let len = List.length route in
  if len < 2 then route else
  let idx1 = Random.int len in
  let idx2 = Random.int len in
  if idx1 = idx2 then route else
  let arr = Array.of_list route in
  let tmp = arr.(idx1) in
  arr.(idx1) <- arr.(idx2);
  arr.(idx2) <- tmp;
  Array.to_list arr

let rec make_pairs lst =
  match lst with
  | p1 :: p2 :: rest -> (p1, p2) :: make_pairs rest
  | [] -> []
  | _ -> failwith "Odd number of parents - expected pairs"

let crossover_and_mutate mutation_rate parents =
  if (List.length parents) mod 2 <> 0 then
    failwith "Number of parents must be even";

  let parent_pairs = make_pairs parents in
  List.map (fun (p1, p2) ->
    let child = cycle_crossover p1 p2 in
    mutate mutation_rate child
  ) parent_pairs

let list_sub lst start len =
  let rec take i acc = function
    | [] -> List.rev acc
    | x::xs ->
        if i >= start + len then List.rev acc
        else if i >= start then take (i+1) (x::acc) xs
        else take (i+1) acc xs
  in
  take 0 [] lst

(* replacement & elitism *)
let next_generation elite_count population_size old_population children =
  if elite_count > population_size then
    failwith "Elite count cannot be more than population size";

  let elites = top_n_parent old_population elite_count in
  let needed = population_size - elite_count in

  let new_generation =
    if List.length children >= needed then
      elites @ (list_sub children 0 needed)
    else
      let extra = generate_population (List.hd old_population) (needed - List.length children) in
      elites @ children @ extra
  in
  new_generation

(* example *)
let () = 
  Random.self_init ();
  let population_size = 10 in
  let elite_count = 2 in
  let parent_count = 6 in
  let generations = 10 in
  let mutation_rate = 0.2 in
  let rec evolve gen pop =
    if gen = 0 then pop
    else
      let parents = top_n_parent pop parent_count in
      let children = crossover_and_mutate mutation_rate parents in
      let next_gen = next_generation elite_count population_size pop children in
      evolve (gen - 1) next_gen
  in
  let initial_pop = generate_population magic_land population_size in
  let final_pop = evolve generations initial_pop in
  let best = top_n_parent final_pop 1 in
  let f lst  = 
    let _ = Printf.printf "short reached distance: %f\n" (calc_route lst)  in
    let g (City (x, y)) = 
      Printf.printf "City x: %f, y: %f\n" x y
    in List.iter g lst 
  in
  let _ = List.iter f best in
  ()
