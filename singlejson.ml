type 'a json = Empty | ValueProperty of ('a list * 'a list) | ObjectProperty of ('a * 'a json list) 

let rec indenting acc index =
  if index = 0 then
    acc
  else 
    indenting ( acc ^ "\t") (index - 1)

let rec listOfProperties ls1 ls2 indentLevel = 
  match ls1, ls2 with
  | [], [] -> ""
  | h1::[], h2::[] -> (indenting "" indentLevel) ^ (h1 ^ ": " ^ h2 ) 
  | h1::t1, h2::t2 -> (indenting "" indentLevel) ^ (h1 ^ ": " ^ h2 ^ ",\n") ^ (listOfProperties t1 t2 indentLevel)

let rec arrayWords words indentLevel = function
  | [] -> words
  | h::[] -> (indenting "" indentLevel) ^ words ^ (indenting "" indentLevel) ^ h ^ "\n" ^ (indenting "" (indentLevel - 1)) ^ "]"
  | h::t -> arrayWords (words ^ (indenting "" indentLevel) ^ h ^ ",\n") indentLevel t
(* let buildJsonFile stringBuilder jsonStructure = 
  let rec helperBuilder stringBuilder indentLevel = function
    | Empty -> stringBuilder
    | ValueProperty(k, v) -> helperBuilder (stringBuilder ^ (listOfProperties k v indentLevel)) indentLevel Empty
    | ObjectProperty(n, jList) -> helperBuilder (stringBuilder ^ "\n" ^ (indenting "" indentLevel) ^ n ^ ": {\n") (indentLevel + 1) jList
  in 
  helperBuilder stringBuilder 1 jsonStructure

let starterBuilder jsonStructure = 
  let rec startHelper stringBuilder = function
  | [] -> stringBuilder
  | h::t -> startHelper (buildJsonFile stringBuilder h) t
  in
  startHelper "" jsonStructure *)
  (* | ArrayProperty(n, h::t) ->  buildJsonFile (stringBuilder ^ (arrayWords (",\n" ^ (indenting "" indentLevel) ^ n ^ ": [\n") (indentLevel + 1) (h::t) )) indentLevel Empty *)
let rec buildJsonFile stringBuilder indentLevel = function
  | Empty -> stringBuilder
  | ValueProperty(k, v) -> buildJsonFile (stringBuilder ^ (listOfProperties k v indentLevel)) indentLevel Empty
  | ObjectProperty(n, jList) -> let s = starterBuilder (stringBuilder ^ ",\n" ^ (indenting "" indentLevel) ^ n ^ ": {\n") (indentLevel + 1) jList in
    buildJsonFile (s ^ ( "\n" ^ indenting "" indentLevel) ^ "}") indentLevel Empty

and starterBuilder stringBuilder indentLevel  = function
  | [] -> stringBuilder
  | h::t -> starterBuilder (buildJsonFile stringBuilder indentLevel h) indentLevel t
  

let someFun path jsonStructure = 
  begin let oc = open_out path in    (* create or truncate file, return channel *)
    Printf.fprintf oc "%s\n" ("{\n" ^ (starterBuilder "" 1 jsonStructure) ^ "\n}");   (* write something *)   
    close_out oc;
  end


(* let _ = someFun "./foo/testjson.json" ([
  ValueProperty(
    ["\"name\""; "\"version\""; "\"description\""; "\"main\""; "\"author\""; "\"license\""; "\"homepage\""], 
    ["\"val\""; "\"val1\"";"\"val\""; "\"val1\""; "\"val1\"";"\"val\""; "\"val1\""]
    );
  ObjectProperty("\"scripts\"", [
    ValueProperty(
      ["\"start\""], ["\"node ./bin/www\""]
      )
  ]);
  ObjectProperty("\"dependencies\"", [
    ValueProperty(
      ["\"cookie-parser\""; "\"debug\""; "\"express\""; "\"http-errors\""; "\"jade\""; "\"morgan\""], 
      ["\"*\""; "\"*\""; "\"*\""; "\"*\""; "\"*\""; "\"*\""]
      )
  ]);
  ObjectProperty("\"repository\"", [
    ValueProperty(
      ["\"type\""; "\"url\""], ["\"git\""; "\"git+https://github.com/Bairon29/favorite_twitches.git\""]
      )
  ]);
  ArrayProperty("\"keywords\"",[
    "\"lots\""; "\"messs\""
  ]);
  ObjectProperty("\"bugs\"", [
    ValueProperty(
      ["\"url\""], ["\"https://github.com/Bairon29/favorite_twitches/issues\""]
      )
  ]);
]); *)

