clear

nValor1  := 0
nValor2  := 0
cMascara := '@E 9,999,999,999.99'

@ 00,00 to 11,38

@ 01,01 say "Insira o primeiro numero: "
@ 02,01 say "Insira o segundo numero: "

@ 01,28 get nValor1 //o comando get p/ valores numericos da 10 espa‡os brancos
@ 02,28 get nValor2
read

nSoma          := nValor1 + nValor2
nSubtracao     := nValor1 - nValor2
nMultiplicacao := nValor1 * nValor2
nDivisao       := nValor1 / nValor2

@ 04,01 say "Calculando os valores..."
@ 05,01 say "Soma: "
@ 05,17 say nSoma             picture cMascara
@ 06,01 say "Subtracao: "
@ 06,17 say nSubtracao        picture cMascara
@ 07,01 say "Multiplicacao: "
@ 07,17 say nMultiplicacao    picture cMascara
@ 08,01 say "Divisao: "
@ 08,17 say nDivisao          picture cMascara
@ 10,01 say "Pressione alguma tecla para sair..."

Inkey( 0 )
