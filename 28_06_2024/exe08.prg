clear

nProdutoA   := 10.00
nProdutoB   := 5.25
nProdutoC   := 20.00
nQuantidadeA := 0
nQuantidadeB := 0
nQuantidadeC := 0
cMascara    := '@E 9,999,999,999.99'

@ 01,01 say "Quantidade de produtos A: "
@ 02,01 say "Quantidade de produtos B: "
@ 03,01 say "Quantidade de produtos C: "

@ 01,27 get nQuantidadeA
@ 02,27 get nQuantidadeB
@ 03,27 get nQuantidadeC
read

nSomaA := nProdutoA * nQuantidadeA
nSomaB := nProdutoB * nQuantidadeB
nSomaC := nProdutoC * nQuantidadeC
ntotal := nSomaA + nSomaB + nSomaC


