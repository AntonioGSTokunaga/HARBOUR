set date to british
set epoch to 1940
set scoreboard off
//set century on

//nome do cliente
//idade do cliente
//endere‡o do cliente
//data da venda
//data da entrega

set color to 'BG/N'

clear

cCliente            := Space ( 30 )
cEndereco           := Space ( 30 )

nIdade              := 0

cNome1              := Space ( 15 )
cNome2              := Space ( 15 )
cNome3              := Space ( 15 )

cMascaraValor       := '@E 999,999.99'

nValor1             := 0
nValor2             := 0
nValor3             := 0

nQuantidade1        := 0
nQuantidade2        := 0
nQuantidade3        := 0

nDia                := Day( Date() )
nMes                := Month( Date() )
nAno                := Year( Date() )
nDiaDaSemana        := DoW( Date() )

dVenda              := CToD( '' )
dEntrega            := CToD( '' )

@ 00,00 to 20,60 double

@ 01,01 say "Nome....: "
@ 02,01 say "Idade...: "
@ 03,01 say "Endere‡o: "

@ 01,11 get cCliente  picture '@!'  valid !Empty ( cCliente )
@ 02,11 get nIdade    picture '999' valid nIdade >= 0
@ 03,11 get cEndereco picture '@!'  valid !Empty ( cEndereco )
read

@ 01,11 clear to 03,40

@ 01,07 say cCliente
@ 02,08 say nIdade
@ 03,11 say cEndereco

set color to 'RG/N+'

@ 05,01 clear to 13,44

@ 05,01 say "Produto"
@ 05,18 say "Quantidade"
@ 05,29 say "Valor"
@ 05,40 say "Total"


//Primeiro produto
@ 07,01 get cNome1  picture '@!'          valid !Empty ( cNome1 )
@ 07,18 get nQuantidade1                  valid nQuantidade1 >= 0
@ 07,29 get nValor1 picture cMascaraValor valid nValor1 >= 0
read

nTotalGeral := 0
nTotal1     := nQuantidade1 * nValor1
//se o programa n exigir todos os dados de cada produto, reaproveite o c¢digo acima
//nTotalGeral := nTotalGeral + nTotal1
nTotalGeral += nTotal1 //faz a mesma coisa que a linha anterior, mas eficaz

@ 07,01 clear to 07,44

@ 07,01 say cNome1
@ 07,18 say nQuantidade1
@ 07,29 say nValor1      picture cMascaraValor
@ 07,40 say nTotal1      picture cMascaraValor
@ 13,40 say nTotalGeral  picture cMascaraValor

//Segundo produto
@ 09,01 get cNome2  picture '@!'          valid !Empty ( cNome2 )
@ 09,18 get nQuantidade2                  valid nQuantidade2  >= 0
@ 09,29 get nValor2 picture cMascaraValor valid nValor2 >= 0
read

nTotal2     := nQuantidade2 * nValor2
nTotalGeral += nTotal2

@ 09,01 clear to 09,44
@ 13,10 clear to 13,44

@ 09,01 say cNome2
@ 09,18 say nQuantidade2
@ 09,29 say nValor2     picture cMascaraValor
@ 09,40 say nTotal2     picture cMascaraValor
@ 13,40 say nTotalGeral picture cMascaraValor

//Terceiro produto
@ 11,01 get cNome3  picture '@!'          valid !Empty ( cNome3 )
@ 11,18 get nQuantidade3                  valid nQuantidade3  >= 0
@ 11,29 get nValor3 picture cMascaraValor valid nValor3 >= 0
read

nTotal3     := nQuantidade3 * nValor3
nTotalGeral += nTotal3

@ 11,01 clear to 13,44

@ 11,01 say cNome3
@ 11,18 say nQuantidade3
@ 11,29 say nValor3     picture cMascaraValor
@ 11,40 say nTotal3     picture cMascaraValor
@ 13,40 say nTotalGeral picture cMascaraValor

set color to 'BG/N'

@ 15,01 clear to 18,59

@ 15,01 say "Data da venda..: "
@ 16,01 say "Data de entrega: "

@ 15,18 get dVenda   valid dVenda <= Date()
@ 16,18 get dEntrega valid dEntrega >= Date()
read

@ 15,18 clear to 16,25

@ 15,18 say dVenda
@ 16,18 say dEntrega

@ 01,01 clear to 20,60
//se vai usar uma informa‡ao mais de uma vez, use vari veis
//do contrario, fa‡a direto no codigo
//corrija
cCliente            := AllTrim( cCliente )
cEndereco           := AllTrim ( cEndereco )
cAnosIdade          := AllTrim( Str( nIdade ))

cNome1              := AllTrim ( cNome1 )
cNome2              := AllTrim ( cNome2 )
cNome3              := AllTrim ( cNome3 )

@ 01,01 say "Maringa, " + cDia + " do " + cMes + " de " + cAno
@ 03,01 say "Nome do Cliente: " + cCliente
@ 04,01 say "Idade..........: " + cAnosIdade
@ 05,01 say "Endere‡o.......: " + cEndereco

@ 06,01 to 06,59

@ 07,01 say "Produtos"







@ 19,01 say "Pressione alguma tecla para encerrar..."

Inkey ( 15 )

