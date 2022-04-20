type 'a t
val empty : 'a t
val is_empty : 'a t -> bool
val is_member : 'a Order.total -> 'a -> 'a t -> (unit -> 'r) -> (unit -> 'r) -> 'r
val get_member : int -> 'a t -> (unit -> 'r) -> ('a -> 'r) -> 'r
val get_member_unsafe : int -> 'a t -> 'a
val size : 'a t -> int
val add : 'a Order.total -> 'a -> 'a t -> 'a t
val remove : 'a Order.total -> 'a -> 'a t -> 'a t
val to_list : 'a t -> 'a list
val from_list : 'a list -> 'a t
val fold : 'a t -> 'r -> ('a -> 'r -> 'r) -> 'r
val map : ('a -> 'b) -> 'a t -> 'b t
val union : 'a Order.total -> 'a t -> 'a t -> 'a t
val difference : 'a Order.total -> 'a t -> 'a t -> 'a t
val intersection : 'a Order.total -> 'a t -> 'a t -> 'a t
val has_intersection : 'a Order.total -> 'a t -> 'a t
  -> (unit -> 'r) -> (unit -> 'r) -> 'r
val first : 'a t -> (unit -> 'r) -> ('a -> 'r) -> 'r
val first_unsafe : 'a t -> 'a
val last : 'a t -> (unit -> 'r) -> ('a -> 'r) -> 'r
val last_unsafe : 'a t -> 'a
val order : ('a -> 'a -> Order.t) -> 'a t -> 'a t -> Order.t
