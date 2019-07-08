execute: singlejson.ml helperlibrary.ml main.ml
	ocamlc unix.cma singlejson.ml helperlibrary.ml main.ml -o main

clean:
	-rm -r main  *.o *.cmo *.cmx *.mli *.cmi
	-rm -r singlejson *.o *.cmo *.cmx *.mli *.cmi
	-rm -r helperlibrary *.o *.cmo *.cmx *.mli *.cmi