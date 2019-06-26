# CSCI492Project

## Initial State

### The project takes two parameters -Path and -ProjectName. Both parameters take a string. The Path is to specify where the project is going to be created. The ProjectName is to customize the name of the project.

### Sample command: ocamlc unix.cma me.ml -o me -> links the Unix modulo
### Sample execution: ./me -ProjectName "MainRoot" -Path "foo"

### It will then create a folder structure provided by some type structure such as the following (For testing purposes, use the foo folder in this current version for the -Path, This current version does not check if either of the parameters were provided -> impemented in later versions):

```ocaml
[JustFolder(!projectName,[JustFolder("thisOtherMine", [Empty]); JustFolder("nextToo", [Empty]); JustFile(["me133.txt"; "me2.txt"; "me3.txt"; "me4.txt"])])]
```

### Where these types are defined as: 
```ocaml
type 'a folder = Empty | JustFolder of ('a * 'a folder list) | JustFile of ('a list ) | Both of ('a list * 'a folder list)
```

