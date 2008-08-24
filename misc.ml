#load "nums.cma"
open Big_int

let print_list f l =
  print_char '[';
  match l with
    [] -> ()
  | hd :: tl -> begin
    print_string (f hd);
    List.iter (fun x -> print_string (", " ^ (f x))) tl
  end;
  print_char ']'

let print_int_list l =
  print_list string_of_int l

let prime_factors n =
  let rec loop i n factors =
    if gt_big_int i (sqrt_big_int n) then n :: factors
    else if eq_big_int (mod_big_int n i) zero_big_int then loop i (div_big_int n i) (i :: factors)
    else loop (succ_big_int i) n factors in
  loop (big_int_of_int 2) n []

let ( <<- ) a b x = a (b x)

module IntSet = Set.Make(struct type t = big_int let compare = compare_big_int end)

let rec lremove i l =
  match l with
    [] -> failwith "lremove out of bounds"
  | hd :: tl ->
      if i = 0 then (hd, tl)
      else lremove (pred i) tl

let combinations f l =
  let rec aux n l acc =
    if n = 0 then f acc
    else
      for i = 0 to List.length l - 1 do
        let elt, l2 = lremove i l in
        aux (pred n) l2 (elt :: acc)
      done in
  for i = 1 to List.length l do
    aux i l []
  done

let prod l =
  List.fold_left mult_big_int unit_big_int l

let divisors n =
  let factors = (prime_factors n)
  and set = ref (IntSet.singleton unit_big_int) in
  combinations (fun x -> set := IntSet.add (prod x) !set) factors;
  !set

let num_divisors n =
  IntSet.cardinal (divisors n)
