type 'a folder = Empty | JustFolder of ('a * 'a folder list) | JustFile of ('a list ) | Both of ('a list * 'a folder list)



let usage = "[Usage]:\t./step -projectName value"

let projectName = ref ""

let rec createFiles path = function
  | [] -> ()
  | hd::tl -> let oc = open_out (path ^ "/" ^ hd) in close_out oc;
    createFiles path tl;;
  (* let a = Unix.openfile hd [Unix.O_CREAT; Unix.O_RDWR] in 
  () *)
    (* make_filename (hd::tl) *)
    (* createFiles path tl;; *)

let rec build path = function
 | JustFile (h::t) -> createFiles path (h::t)
 | JustFolder(a, ls) -> 
    Unix.mkdir (path ^ "/" ^ a) 0o777;
    createFolderStructure (path ^ "/" ^ a) ls;
    (* createFolderStructure (path ^ "/" ^ a) ls *)
and createFolderStructure path = function
  | [] | [Empty] -> print_string "Done\n";
  | hd::tl -> build path hd;
    createFolderStructure path tl;;


(* let findFolder f = 
  match f with
  | Empty -> print_string "Empty\n"
  | JustFolder (x, Empty) -> print_string x
  | JustFile (h::t) -> print_string h;; *)

let pr h =
  Unix.mkdir "./foo" 0o777; 
  (* Unix.chmod "./foo" 0o1000; *)
  Printf.printf "hmnnn: %s\n" h;;

let main () =
  begin
    let aa = Arg.parse Arg.[
      ("-projectName", Set_string projectName, "<projectName> set Name")
    ] ignore usage in
    (* pr (!height); *)
    (* findFolder (JustFile(["me"])); *)
    createFolderStructure "./foo" [JustFolder(!projectName,[JustFolder("thisOtherMine", [Empty]); JustFolder("nextToo", [Empty]); JustFile(["me133.txt"; "me2.txt"; "me3.txt"; "me4.txt"])])];
    (* createFiles "./foo" ["mmmmm.txt"] *)
  end
  (* [JustFile(["me133.txt"; "me2.txt"; "me3.txt"; "me4.txt"])]; *)
  
let _ = main ();