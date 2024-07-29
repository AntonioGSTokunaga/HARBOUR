clear

/*nValorX := 2
nValorY := 3

//Escrever o n£mero antes da string faz com q n haja espa‡o vazio de 10 colunas
//Fazendo com que a string ocupe o espa‡o em branco do n£mero

@ 00,03 say nValorX //a coordenada coluna(03)+10 espa‡os = 13 espa‡os
@ 00,00 say "Valor de X: "//A string possui 12 caracteres

@ 02,03 say nValorY
@ 02,00 say "Valor de Y: "

@ 04,20 say nValorX * nValorY//20 + 10 = 30 espa‡os
@ 04,00 say "O produto de X e Y e igual a "//Esta string possui 29 caracteres

//O espa‡o conta como um caractere*/

nValorX  := 0
nValorY  := 0
cMascara := '@E 9,999,999,999.99'

@ 01,01 say "Insira o primeiro valor: "
@ 02,01 say "Insira o segundo valor: "

@ 01,27 get nValorX
@ 02,27 get nValorY
 read

nProduto := nValorX * nValorY

@ 04,01 say "Calculando o produto dos valores..."
@ 05,01 say "Resultado: "
@ 05,12 say nProduto picture cMascara


