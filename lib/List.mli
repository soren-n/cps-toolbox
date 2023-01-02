val nil : 'a list
val cons : 'a -> 'a list -> 'a list
val length : 'a list -> int
val fold : 'a list -> 'r -> ('a -> 'r -> 'r) -> 'r
val fold_rev : 'a list -> 'r -> ('a -> 'r -> 'r) -> 'r
val get : int -> 'a list -> (unit -> 'r) -> ('a -> 'r) -> 'r
val iter : 'a list -> ('a -> unit) -> unit
val init : int -> 'a -> 'a list
val map : ('a -> 'b) -> 'a list -> 'b list
val conc : 'a list -> 'a list -> 'a list
val flatten : 'a list list -> 'a list
val zip : 'a list -> 'b list ->
  (unit -> 'r) -> (('a * 'b) list -> 'r) -> 'r
val select : 'a Order.total -> int -> 'a list -> 'a
val sort : 'a Order.total -> 'a list -> 'a list
val sort_unique : 'a Order.total -> 'a list -> 'a list
