# CSCI492Project

### The project takes multiple parameters -Path -ProjectName -Description -Author -GitURL. All parameters take a string. The Path is to specify where the project is going to be created. The ProjectName is to customize the name of the project. The Description is to describe the current project. The Author is the creator of the project and finally GitURL is URL for the github repositpry where the project is going to be maintain

### Sample command: ocamlc unix.cma singlejson.ml helperlibrary.ml main.ml -o main -> links the Unix modulo
### Sample execution: ./main -Path="./foo" -Description="jjjjj" -ProjectName="myBackEnd" -GitURL="https://github.com/Bairon29/favorite_twitches.git" -Author="Bairon"

### It will then create a folder structure provided by some type struture along with its respective files

```ocaml
[JustFolder(!projectName,[JustFolder("thisOtherMine", [Empty]); JustFolder("nextToo", [Empty]); JustFile(["me133.txt"; "me2.txt"; "me3.txt"; "me4.txt"])])]
```

### Where these types are defined as: 
```ocaml
type 'a folder = Empty | JustFolder of ('a * 'a folder list) | JustFile of ('a list ) | Both of ('a list * 'a folder list)
```
## To run the program simply run: make execute

## If you like to see the NodeJS project running, you will need to have NodeJS installed. After installing NodeJS, go into the root folder of the NodeJS folder and run the following commands:
    npm install
    npm start
## Then on your browser go to http://localhost:3000/

