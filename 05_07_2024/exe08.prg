clear

nProdutoA    := 10.00
nProdutoB    := 5.25
nProdutoC    := 20.00
nQuantidadeA := 0
nQuantidadeB := 0
nQuantidadeC := 0
cMascara     := '@E 9,999,999,999.99'
//cInteiro     := '9999999999'

@ 00,00 to 20,40

@ 01,01 say "---------------------------------------"
@ 02,01 say "                MERCADO                "
@ 03,01 say "---------------------------------------"
@ 04,01 say "-----------(P R O D U T O S)-----------"
@ 05,01 say "A: RS 10,00                            "
@ 06,01 say "B: RS 5,25                             "
@ 07,01 say "C: RS 20,00                            "
@ 08,01 say "---------------------------------------"
@ 09,01 say "Quantidade de produtos A: "
@ 10,01 say "Quantidade de produtos B: "
@ 11,01 say "Quantidade de produtos C: "
@ 12,01 say "---------------------------------------"

@ 09,28 get nQuantidadeA /*picture cInteiro*/ valid nQuantidadeA >= 0
@ 10,28 get nQuantidadeB /*picture cInteiro*/ valid nQuantidadeB >= 0
@ 11,28 get nQuantidadeC /*picture cInteiro*/ valid nQuantidadeC >= 0
read

nSomaA := nProdutoA * nQuantidadeA
nSomaB := nProdutoB * nQuantidadeB
nSomaC := nProdutoC * nQuantidadeC
nTotal := nSomaA + nSomaB + nSomaC

@ 13,01 say "Valor total A: "
@ 14,01 say "Valor total B: "
@ 15,01 say "Valor total C: "
@ 13,16 say nSomaA picture cMascara
@ 14,16 say nSomaB picture cMascara
@ 15,16 say nSomaC picture cMascara
@ 16,01 say "---------------------------------------"
@ 17,01 say "Custo total:   "
@ 17,16 say nTotal picture cMascara
@ 19,01 say "Tecle algo para encerrar..."

Inkey ( 10 )




