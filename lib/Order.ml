type t =
  | EQ
  | LT
  | GT

type 'a total =
  'a -> 'a -> t

let _total left right =
  if left = right then EQ else
  if left < right then LT else
  GT

let int = _total
let string = _total
