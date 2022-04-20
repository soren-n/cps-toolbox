type ('key, 'value) t

val empty : ('key, 'value) t
val size : ('key, 'value) t -> int
val fold : ('key, 'value) t -> 'r -> ('key -> 'value -> 'r -> 'r) -> 'r
val map : ('a -> 'b) -> ('key, 'a) t -> ('key, 'b) t
val contains : 'key Order.total -> 'key  -> ('key, 'value) t
  -> (unit -> 'r) -> (unit -> 'r) -> 'r
val insert : 'key Order.total -> 'key -> 'value -> ('key, 'value) t
  -> ('key, 'value) t
val remove : 'key Order.total -> 'key -> ('key, 'value) t
  -> ('key, 'value) t
val lookup : 'key Order.total -> 'key -> ('key, 'value) t
  -> (unit -> 'r) -> ('value -> 'r) -> 'r
val lookup_unsafe : 'key Order.total -> 'key -> ('key, 'value) t
  -> 'value
val entries : ('key, 'value) t -> ('key * 'value) list
val keys : ('key, 'value) t -> 'key list
val values : ('key, 'value) t -> 'value list
val from_entries : ('key * 'value) list -> ('key, 'value) t
