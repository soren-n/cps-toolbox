type t =
  | EQ
  | LT
  | GT

type 'a total =
  'a -> 'a -> t

val int : int total
val string : string total
