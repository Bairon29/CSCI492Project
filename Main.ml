open Helperlibrary
type 'a folder = Empty | JustFolder of ('a * 'a folder list) | JustFile of ('a list * 'a list) 
exception Handler of string
let usage = "[Usage]:\t./step -Path=\"value\" -ProjectName=\"value\" -Description=\"value\" -Author=\"value\" -GitURL=\"value\"" 

let projectName = ref ""
let path = ref ""
let description = ref ""
let author = ref ""
let giturl = ref ""

let rec parserString acc index s = 
  if s.[index] = '.' && s.[index + 1] <> 'c' then
    acc
  else 
    parserString (acc ^ (Printf.sprintf "%c" s.[index])) (index + 1) s

let ensureGit s front = 
  if String.length s < 1 then
    s
  else 
    (parserString "" 0 (!giturl)) ^ front

let rec createFiles path = function
  | [], [] -> ()
  | hd::tl, hd1::tl1 -> let oc = open_out (path ^ "/" ^ hd) in 
    Printf.fprintf oc "%s" (Helperlibrary.whichFileContent hd1);
    close_out oc;
    createFiles path (tl, tl1);;

let rec build path = function
 | JustFile (h::t, h1::t1) -> createFiles path (h::t, h1::t1)
 | JustFolder(a, ls) -> 
    Unix.mkdir (path ^ "/" ^ a) 0o777;
    createFolderStructure (path ^ "/" ^ a) ls;
    
and createFolderStructure path = function
  | [] | [Empty] -> print_string "Done\n";
  | hd::tl -> build path hd;
    createFolderStructure path tl;;

let main () =
  begin
    let _ = Arg.parse Arg.[
      ("-ProjectName", Set_string projectName, "<ProjectName> set the name of your project");
      ("-Path", Set_string path, "<Path> set the path where your project will be created");
      ("-Description", Set_string description, "<Description> set a description to your project");
      ("-Author", Set_string author, "<Author> set the owner's name of this project");
      ("-GitURL", Set_string giturl, "<GitURL> set the git repository of this project")
    ] ignore usage in
    
    try
    if (!projectName) = "" || (!path) = ""  then
      raise (Handler "requires")
    else
      createFolderStructure (!path) [
        JustFolder(
          !projectName,
          [
            JustFolder("bin", [
              JustFile(["www"], ["www"])]); 
              JustFolder("public", [
                JustFolder("images", [Empty]); 
                JustFolder("javascripts", [JustFile(["mainScript.js"], ["mainScript"])]);
                JustFolder("stylesheets", [JustFile(["mainStylesheet.css"], ["mainStylesheet"])])
              ]); 
              JustFolder("routes", [JustFile(["index.js"; "users.js"], ["routes_index"; "routes_users"])]); 
              JustFolder("views", [JustFile(["error.jade"; "index.jade"; "layout.jade"], ["views_error"; "views_index"; "views_layout"])]); 
              JustFile(["app.js"], ["app"])]
        )
      ];
      Singlejson.someFun ((!path) ^ "/" ^ (!projectName) ^ "/package.json") ([
        ValueProperty(
          ["\"name\""; "\"version\""; "\"description\""; "\"main\""; "\"author\""; "\"license\""; "\"homepage\""], 
          ["\"" ^ (String.lowercase_ascii (!projectName)) ^ "\""; "\"1.0.0\"";"\"" ^ (!description)  ^ "\""; "\"app.js\""; "\"" ^ (!author)  ^ "\"";"\"ISC\""; "\"" ^ (ensureGit (!giturl) "#readme") ^ "\""]
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
            ["\"type\""; "\"url\""], ["\"git\""; "\"" ^ "git+" ^ (!giturl) ^ "\""]
            )
        ]);
        ObjectProperty("\"bugs\"", [
          ValueProperty(
            ["\"url\""], ["\"" ^ (ensureGit (!giturl) "/issues") ^ "\""]
            )
        ]);
      ]);
    with 
      | Handler ("requires") -> print_string "\nParameters -ProjectName and -Path are required\nUse the -help option for usage\n\n";
  end
  
let _ = main ();