clear
cNome1  := Space ( 15 )
cNome2  := Space ( 15 )
cNome3  := Space ( 15 )
nValor1 := 0
nValor2 := 0
nValor3 := 0
nQtde1  := 0
nQtde2  := 0
nQtde3  := 0
cMascaraValor   := '@E 999,999.99'

@ 00,00 to 30,60 double

@ 01,01 say "Produto"
@ 01,18 say "Quantidade"
@ 01,29 say "Valor"
@ 01,40 say "Total"

//Primeiro produto
@ 03,01 get cNome1  picture '@!'          valid !Empty ( cNome1 )
@ 03,18 get nQtde1                        valid nQtde1  >= 0
@ 03,29 get nValor1 picture cMascaraValor valid nValor1 >= 0
read

nTotalGeral := 0
nTotal1     := nQtde1 * nValor1
//se o programa n exigir todos os dados de cada produto, reaproveite o c¢digo acima
//nTotalGeral := nTotalGeral + nTotal1
nTotalGeral += nTotal1 //faz a mesma coisa que a linha anterior, mas eficaz

@ 03,01 clear to 03,44

@ 03,01 say cNome1
@ 03,18 say nQtde1
@ 03,29 say nValor1     picture cMascaraValor
@ 03,40 say nTotal1     picture cMascaraValor
@ 09,40 say nTotalGeral picture cMascaraValor

//Segundo produto
@ 05,01 get cNome2  picture '@!'          valid !Empty ( cNome2 )
@ 05,18 get nQtde2                        valid nQtde2  >= 0
@ 05,29 get nValor2 picture cMascaraValor valid nValor2 >= 0
read

nTotal2     := nQtde2 * nValor2
nTotalGeral += nTotal2

@ 05,01 clear to 05,44
@ 09,10 clear to 09,44

@ 05,01 say cNome2
@ 05,18 say nQtde2
@ 05,29 say nValor2     picture cMascaraValor
@ 05,40 say nTotal2     picture cMascaraValor
@ 09,40 say nTotalGeral picture cMascaraValor

//Terceiro produto
@ 07,01 get cNome3  picture '@!'          valid !Empty ( cNome3 )
@ 07,18 get nQtde3                        valid nQtde3  >= 0
@ 07,29 get nValor3 picture cMascaraValor valid nValor3 >= 0
read

nTotal3     := nQtde3 * nValor3
nTotalGeral += nTotal3

@ 07,01 clear to 09,44

@ 07,01 say cNome3
@ 07,18 say nQtde3
@ 07,29 say nValor3     picture cMascaraValor
@ 07,40 say nTotal3     picture cMascaraValor
@ 09,40 say nTotalGeral picture cMascaraValor
@ 12,01 say "Pressione alguma tecla para encerrar..."

Inkey ( 15 )
