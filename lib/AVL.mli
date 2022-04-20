type 'a t =
  | Null
  | Node of int * int * 'a * 'a t * 'a t

val null : 'a t
val node : int -> int -> 'a -> 'a t -> 'a t -> 'a t
val fold : 'a t -> 'r -> (int -> int -> 'a -> 'r -> 'r -> 'r) -> 'r
val map : ('a -> 'b) -> 'a t -> 'b t
val get_count : 'a t -> int
val get_height : 'a t -> int
val insert : 'a Order.total -> 'a -> 'a t -> 'a t
val remove : 'a Order.total -> 'a -> 'a t -> 'a t
val is_member :
  'a Order.total -> 'a -> 'a t ->
  (unit -> 'r) -> (unit -> 'r) -> 'r
val get_member : int -> 'a t -> (unit -> 'r) -> ('a -> 'r) -> 'r
val get_leftmost : 'a t -> (unit -> 'r) -> ('a -> 'r) -> 'r
val get_rightmost : 'a t -> (unit -> 'r) -> ('a -> 'r) -> 'r
val to_list : 'a t -> 'a list
val from_list : 'a list -> 'a t
