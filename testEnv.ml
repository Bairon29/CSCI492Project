let explode s =
  let rec expl i l =
    if i < 0 then l else
    expl (i - 1) (s.[i] :: l) in
  expl (String.length s - 1) [];;

  let stringChecker s =
    let a = Printf.sprintf "%c" s.[2] in
    print_string a

let rec parserString acc index s = 
  if s.[index] = '.' then
    acc
  else 
    parserString (acc ^ (Printf.sprintf "%c" s.[index])) (index + 1) s