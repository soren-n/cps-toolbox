val none : 'a option
val some : 'a -> 'a option
val value : 'a option -> (unit -> 'r) -> ('a -> 'r) -> 'r
val value_unsafe : 'a option -> 'a
val map : ('a -> 'b) -> 'a option -> 'b option
val map2 : ('a -> 'b -> 'c) -> 'a option -> 'b option -> 'c option
