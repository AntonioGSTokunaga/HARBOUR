   set date to british
set epoch to 1940
set scoreboard off
//set century on

//nome do cliente
//idade do cliente
//endere‡o do cliente
//data da venda
//data da entrega

set color to 'W/B'

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

@ 01,11 say AllTrim( cCliente )
@ 02,11 say AllTrim( Str( nIdade ) )
@ 03,11 say AllTrim( cEndereco )

//set color to 'RG/N+'

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

@ 07,01 say AllTrim( cNome1 )
@ 07,18 say AllTrim( Str( nQuantidade1 ) )
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

@ 09,01 say AllTrim( cNome2 )
@ 09,18 say AllTrim( Str( nQuantidade2 ) )
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

@ 11,01 say AllTrim( cNome3 )
@ 11,18 say AllTrim( Str( nQuantidade3 ) )
@ 11,29 say nValor3     picture cMascaraValor
@ 11,40 say nTotal3     picture cMascaraValor
@ 13,40 say nTotalGeral picture cMascaraValor

//set color to 'BG/N'

@ 15,01 clear to 18,59

@ 15,01 say "Data da venda..: "
@ 16,01 say "Data de entrega: "

@ 15,18 get dVenda   valid dVenda <= Date()
@ 16,18 get dEntrega valid dEntrega >= Date()
read

@ 15,18 clear to 16,25

@ 15,18 say dVenda
@ 16,18 say dEntrega

@ 01,01 clear to 19,59
//se vai usar uma informa‡ao mais de uma vez, use vari veis
//do contrario, fa‡a direto no codigo
//corrija


nDia         := Day( dVenda )
nMes         := Month( dVenda )
nAno         := Year( dVenda )
nDiaDaSemana := DoW( dVenda )

cNome1       := AllTrim ( cNome1 )
cNome2       := AllTrim ( cNome2 )
cNome3       := AllTrim ( cNome3 )


cMes := 'janeiro'

if nMes = 12
   cMes := 'dezembro'
elseif nMes = 11
   cMes := 'novembro'
elseif nMes = 10
   cMes := 'outubro'
elseif nMes = 09
   cMes := 'setembro'
elseif nMes = 08
   cMes := 'agosto'
elseif nMes = 07
   cMes := 'julho'
elseif nMes = 06
   cMes := 'junho'
elseif nMes = 05
   cMes :='maio'
elseif nMes = 04
   cMes := 'abril'
elseif nMes = 03
   cMes := 'mar‡o'
elseif nMes = 02
   cMes := 'fevereiro'
//else//if nMes = 01
  // cMes := 'janeiro'
endif


cDiaDaSemana := 'Domingo'

if nDiaDaSemana = 7
   cDiaDaSemana := 'Sabado'
elseif nDiaDaSemana = 6
   cDiaDaSemana := 'Sexta-feira'
elseif nDiaDaSemana = 5
   cDiaDaSemana := 'Quinta-feira'
elseif nDiaDaSemana = 4
   cDiaDaSemana := 'Quarta-feira'
elseif nDiaDaSemana = 3
   cDiaDaSemana := 'Ter‡a-feira'
elseif nDiaDaSemana = 2
   cDiaDaSemana := 'Segunda-fera'
//elseif nDiaDaSemana = 1
  // cDiaDaSemana := 'Domingo'
endif

@ 01,01 say "Maringa, " + AllTrim( Str( nDia ) ) + " de " + cMes + " de " + AllTrim( Str( nAno ) )
@ 02,01 say cDiaDaSemana
@ 04,01 say "Nome do Cliente: " + AllTrim( cCliente )
@ 05,01 say "Idade..........: " + AllTrim( Str( nIdade ) )
@ 06,01 say "Endere‡o.......: " + AllTrim( cEndereco )

@ 07,01 to 07,59

@ 08,01 say "Produtos"







@ 19,01 say "Pressione alguma tecla para encerrar..."

Inkey( 15 )

