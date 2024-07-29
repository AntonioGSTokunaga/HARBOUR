clear

cMascara := '@E 99.99'
nNota1   := 0
nNota2   := 0
nNota3   := 0

@ 00,00 to 10,30

@ 01,01 say "Nota 1: "
@ 03,01 say "Nota 2: "
@ 05,01 say "Nota 3: "

@ 01,09 get nNota1 picture cMascara valid nNota1 >= 0 .and. nNota1 <= 10
@ 03,09 get nNota2 picture cMascara valid nNota2 >= 0 .and. nNota2 <= 10
@ 05,09 get nNota3 picture cMascara valid nNota3 >= 0 .and. nNota3 <= 10
read

nMedia := (nNota1+nNota2+nNota3)/3

@ 07,01 say "Media: "
@ 07,08 say nMedia picture cMascara
@ 09,01 say "Tecle algo para encerrar..."

Inkey ( 0 )
