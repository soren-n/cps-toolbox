open Functional

let zero = 0
let succ n = n + 1

let fold i n zero_case succ_case =
  if n <= i then zero_case else
  let rec _visit n return =
    match n with
    | 0 -> return zero_case
    | _ -> _visit (n - 1) (return <== (succ_case n))
  in
  _visit (n - i) identity