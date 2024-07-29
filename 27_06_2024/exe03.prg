clear

nValorX := 2
nValorY := 3

//Escrever o n£mero antes da string faz com q n haja espa‡o vazio de 10 colunas
//Fazendo com que a string ocupe o espa‡o em branco do n£mero

@ 00,03 say nValorX //a coordenada coluna(03)+10 espa‡os = 13 espa‡os
@ 00,00 say "Valor de X: "//A string possui 12 caracteres

@ 02,03 say nValorY
@ 02,00 say "Valor de Y: "

@ 04,20 say nValorX * nValorY//20 + 10 = 30 espa‡os
@ 04,00 say "O produto de X e Y e igual a "//Esta string possui 29 caracteres

//O espa‡o conta como um caractere

