type ('key, 'value) _entry =
  | Peek of 'key
  | Bind of 'key * 'value

type ('key, 'value) t = ('key, 'value) _entry AVL.t

let _entry_peek key = Peek key

let _entry_bind key value = Bind (key, value)

let _entry_key entry =
  match entry with
  | Peek key -> key
  | Bind (key, _) -> key

let _entry_value entry fail return =
  match entry with
  | Peek _ -> fail ()
  | Bind (_, value) -> return value

let _entry_value_unsafe entry =
  match entry with
  | Peek _ -> assert false (* Invariant *)
  | Bind (_, value) -> value

let _entry_order key_order left right =
  key_order (_entry_key left) (_entry_key right)

let empty = AVL.null
let size = AVL.get_count

let case key_order map empty_case bind_case =
  _entry_order key_order |> fun bind_order ->
  AVL.get_leftmost map (fun () -> empty_case) @@ fun bind ->
  AVL.remove bind_order bind map |> fun map1 ->
  match bind with
  | Peek _ -> assert false (* Invariant *)
  | Bind (key, value) ->
    bind_case key value map1

let fold map empty_case bind_case =
  AVL.to_list map |> fun map1 ->
  List.fold map1 empty_case @@ fun bind result ->
  match bind with
  | Peek _ -> assert false (* Invariant *)
  | Bind (key, value) ->
    bind_case key value result

let map func map =
  AVL.map
    (fun bind ->
      match bind with
      | Peek _ -> assert false (* Invariant *)
      | Bind (key, value) ->
        _entry_bind key (func value))
        map

let contains key_order key map fail return =
  AVL.is_member (_entry_order key_order) (_entry_peek key) map fail return

let insert key_order key value map =
  AVL.insert (_entry_order key_order) (_entry_bind key value) map

let remove key_order key map =
  AVL.remove (_entry_order key_order) (_entry_peek key) map

let lookup order key map fail return =
  let open Order in
  let rec _visit tree =
    match tree with
    | AVL.Null -> fail ()
    | AVL.Node (_, _, entry, left, right) ->
      begin match order key (_entry_key entry) with
      | EQ -> _entry_value entry fail return
      | LT -> _visit left
      | GT -> _visit right
      end
  in
  _visit map

let lookup_unsafe order key map =
  let open Order in
  let rec _visit tree =
    match tree with
    | AVL.Null -> assert false (* Invariant *)
    | AVL.Node (_, _, entry, left, right) ->
      match order key (_entry_key entry) with
      | EQ -> _entry_value_unsafe entry
      | LT -> _visit left
      | GT -> _visit right
  in
  _visit map

let entries map =
  fold map [] @@ fun key value key_values ->
  (key, value) :: key_values

let keys map =
  fold map [] @@ fun key _value result ->
  key :: result

let values map =
  fold map [] @@ fun _key value result ->
  value :: result

let from_entries entries =
  let _to_entry (key, value) = _entry_bind key value in
  List.map _to_entry entries |> AVL.from_list
