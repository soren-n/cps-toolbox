let none = None
let some x = Some x

let value x fail return =
  match x with
  | Some x' -> return x'
  | None -> fail ()

let value_unsafe x =
  match x with
  | Some x' -> x'
  | None -> assert false

let map f x =
  match x with
  | Some x' -> Some (f x')
  | _ -> None

let map2 f x y =
  match x, y with
  | Some x', Some y' -> Some (f x' y')
  | _, _ -> None
