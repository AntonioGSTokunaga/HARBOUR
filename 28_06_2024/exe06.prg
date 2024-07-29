clear

nNota1 := 0
nNota2 := 0
nNota3 := 0

@ 01,00 say "Nota 1: "
@ 03,00 say "Nota 2: "
@ 05,00 say "Nota 3: "

@ 01,09 get nNota1
@ 03,09 get nNota2
@ 05,09 get nNota3
 read

nMedia := (nNota1+nNota2+nNota3)/3

@ 07,00 say "Media: "
@ 07,08 say nMedia

