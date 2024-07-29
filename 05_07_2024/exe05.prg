clear

nValorX := 7
nValorY := 9

@ 00,03 say nValorX
@ 00,00 say "Valor de X:"

@ 02,03 say nValorY
@ 02,00 say "Valor de Y:"

//Invertendo os dados das vari veis
nAlter  := nValorX
nValorX := nValorY
nValorY := nAlter

@ 04,00 say "Invertendo os valores..."

@ 06,08 say nValorX
@ 06,00 say "Novo valor de X:"

@ 08,08 say nValorY
@ 08,00 say "Novo valor de Y:"

