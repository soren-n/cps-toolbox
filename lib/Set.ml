open Functional

type 'a t = 'a AVL.t

let empty = AVL.null
let is_empty set = (AVL.get_count set) = 0
let is_member = AVL.is_member
let get_member = AVL.get_member

let get_member_unsafe order items=
  AVL.get_member order items
    (fun () -> assert false (* Invariant *))
    identity

let size = AVL.get_count
let add = AVL.insert
let remove = AVL.remove
let to_list = AVL.to_list
let from_list = AVL.from_list

let fold items empty_case item_case =
  AVL.to_list items |> fun items1 ->
  List.fold items1 empty_case item_case

let map func items =
  AVL.to_list items |> fun items1 ->
  List.map func items1 |> fun items2 ->
  AVL.from_list items2

let union order xs ys =
  let open Order in
  let _cont k x xs = k (x :: xs) in
  let rec _visit xs ys return =
    match xs, ys with
    | [], _ -> return ys
    | _, [] -> return xs
    | x :: xs1, y :: ys1 ->
      match order x y with
      | EQ -> _visit xs1 ys1 (_cont return x)
      | LT -> _visit xs1 ys (_cont return x)
      | GT -> _visit xs ys1 (_cont return y)
  in
  to_list xs |> fun xs1 ->
  to_list ys |> fun ys1 ->
  _visit xs1 ys1 from_list

let difference order xs ys =
  let open Order in
  let _cont k x xs = k (x :: xs) in
  let rec _visit xs ys return =
    match xs, ys with
    | [], _ -> return []
    | _, [] -> return xs
    | x :: xs1, y :: ys1 ->
      match order x y with
      | EQ -> _visit xs1 ys1 return
      | LT -> _visit xs1 ys (_cont return x)
      | GT -> _visit xs ys1 return
  in
  to_list xs |> fun xs1 ->
  to_list ys |> fun ys1 ->
  _visit xs1 ys1 from_list

let intersection order xs ys =
  let open Order in
  let _cont k x xs = k (x :: xs) in
  let rec _visit xs ys return =
    match xs, ys with
    | [], _ | _, [] -> return []
    | x :: xs1, y :: ys1 ->
      match order x y with
      | EQ -> _visit xs1 ys1 (_cont return x)
      | LT -> _visit xs1 ys return
      | GT -> _visit xs ys1 return
  in
  to_list xs |> fun xs1 ->
  to_list ys |> fun ys1 ->
  _visit xs1 ys1 from_list

let has_intersection order xs ys fail return =
  let open Order in
  let rec _visit xs ys =
    match xs, ys with
    | [], _ | _, [] -> fail ()
    | x :: xs1, y :: ys1 ->
      match order x y with
      | EQ -> return ()
      | LT -> _visit xs1 ys
      | GT -> _visit xs ys1
  in
  to_list xs |> fun xs1 ->
  to_list ys |> fun ys1 ->
  _visit xs1 ys1

let first values fail return = AVL.get_leftmost values fail return
let first_unsafe values =
  AVL.get_leftmost values
    (fun () -> assert false)
    identity

let last values fail return = AVL.get_rightmost values fail return
let last_unsafe values =
  AVL.get_rightmost values
    (fun () -> assert false)
    identity

let order item_order left right =
  let open Order in
  let rec _visit left right =
    match left, right with
    | [], [] -> EQ
    | [], _ -> LT
    | _, [] -> GT
    | l :: left1, r :: right1 ->
      match item_order l r with
      | EQ -> _visit left1 right1
      | LT -> LT
      | GT -> GT
  in
  to_list left |> fun left1 ->
  to_list right |> fun right1 ->
  _visit left1 right1
