clear

nValor1  := 0
nValor2  := 0
cMascara := '@E 9,999,999,999.99'

@ 00,00 say "Insira o primeiro numero: "
@ 01,00 say "Insira o segundo numero: "

@ 00,27 get nValor1 //o comando get p/ valores numericos da 10 espa‡os brancos
@ 01,27 get nValor2
read

nSoma          := nValor1 + nValor2
nSubtracao     := nValor1 - nValor2
nMultiplicacao := nValor1 * nValor2
nDivisao       := nValor1 / nValor2

@ 03,00 say "Calculando os valores..."
@ 04,00 say "Soma: "
@ 04,16 say nSoma picture cMascara
@ 05,00 say "Subtracao: "
@ 05,16 say nSubtracao picture cMascara
@ 06,00 say "Multiplicacao: "
@ 06,16 say nMultiplicacao picture cMascara
@ 07,00 say "Divisao: "
@ 07,16 say nDivisao picture cMascara

