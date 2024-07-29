clear

cNome    := Space( 30 )

nIdade   := 0

nLinha   := 1

cMascara := '999'

@ 00,00 to 05,49 double

@ nLinha++,01 say "Nome do nadador: "
@ nLinha--,01   say "Idade..........: "

@ nLinha,18 get cNome  picture '@!'     valid !Empty( cNome )
@ ++nLinha,18 get nIdade picture cMascara valid nIdade >= 0
read

@ nLinha,18 clear to nLinha,48
@ --nLinha,18 clear to nLinha++,48

cNome := AllTrim( cNome )

@ nLinha++,18  say cNome
@ nLinha,18 say nIdade picture cMascara

nLinha += 1

cCategoria := "VOCE NAO SE ENQUADRA NAS CATEGORIAS DISPONIVEIS"

if nIdade >= 18

   cCategoria := "VOCE E DA CATEGORIA SENIOR"

elseif nIdade >= 14

   cCategoria := "VOCE E DA CATEGORIA JUVENIL B"

elseif nIdade >= 11

   cCategoria :="VOCE E DA CATEGORIA JUVENIL A"

elseif nIdade >= 8

   cCategoria := "VOCE E DA CATEGORIA INFANTIL B"

elseif nIdade >= 5

   cCategoria := "VOCE E DA CATEGORIA INFANTIL A"

endif

@ ++nLinha,01 say cCategoria

inkey ( 15 )
