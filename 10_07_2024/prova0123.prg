//Antonio Gabriel Satoshi Tokunaga

set date to british
set epoch to 1940
set scoreboard off
//set century on

set color to W/B

clear

cNome           := Space( 30 )
cCurso          := Space( 30 )

dDataNascimento := CToD( '' )


nSerie          := 0
nAnoLetivo      := Year( Date() )
nMensalidade    := 0

nNota1          := 0
nNota2          := 0
nNota3          := 0
nNota4          := 0

nFaltas1        := 0
nFaltas2        := 0
nFaltas3        := 0
nFaltas4        := 0

cMascaraNota    := '@E 99.9'
cMascaraFaltas  := '99'

@ 00,00 to 24,79

@ 01,01 say 'Colegio Fulano de Tal'
@ 02,01 say 'Endere‡o: Rua dos bobos - Nø 0'
@ 03,01 say 'Dire‡Æo: Cicrano Anonimo'
@ 04,01 say 'Fone: (00) 0000-0000'

@ 06,01 say 'Aluno...............: '
@ 07,01 say 'Data de nascimento..: '
@ 08,01 say 'Curso...............: '
@ 09,01 say 'Serie...............: '
@ 10,01 say 'Ano letivo..........: '
@ 11,01 say 'Valor da mensalidade: '

@ 06,23 get cNome             picture '@!'           valid !Empty( cNome )
@ 07,23 get dDataNascimento                          valid dDataNascimento < Date()
@ 08,23 get cCurso            picture '@!'           valid !Empty( cCurso )
@ 09,23 get nSerie            picture '9'            valid nSerie > 0
@ 10,23 get nAnoLetivo        picture '9999'
@ 11,23 get nMensalidade      picture '@E 99,999.99' valid nMensalidade >= 0
read


@ 06,23 clear to 11,78

@ 06,23 say AllTrim( cNome )
@ 07,23 say dDataNascimento
@ 08,23 say AllTrim( cCurso )
@ 09,23 say AllTrim(Str( nSerie ) ) + 'ø'
@ 10,23 say AllTrim(Str( nAnoLetivo ) )
@ 11,23 say AllTrim(Str( nMensalidade ) )


cExatas  := 'Exatas'
cHumanas := 'Humanas'
cLetras  := 'Letras'
cArtes   := 'Artes'

@ 13,01 say 'Insira suas notas e numero de faltas:'
@ 14,12 say 'BIM 1'
@ 14,26 say 'BIM 2'
@ 14,40 say 'BIM 3'
@ 14,54 say 'BIM 4'
@ 15,01 say 'DISCIPLINA'
@ 17,01 say cExatas
@ 19,01 say cHumanas
@ 21,01 say cLetras
@ 23,01 say cArtes

@ 15,12 say 'NOTA'
@ 15,19 say 'FALTAS'
@ 15,26 say 'NOTA'
@ 15,33 say 'FALTAS'
@ 15,40 say 'NOTA'
@ 15,47 say 'FALTAS'
@ 15,54 say 'NOTA'
@ 15,61 say 'FALTAS'

@ 17,12 get nNota1    picture cMascaraNota
@ 17,19 get nFaltas1  picture cMascaraFaltas
@ 17,26 get nNota2    picture cMascaraNota
@ 17,33 get nFaltas2  picture cMascaraFaltas
@ 17,40 get nNota3    picture cMascaraNota
@ 17,47 get nFaltas3  picture cMascaraFaltas
@ 17,54 get nNota4    picture cMascaraNota
@ 17,61 get nFaltas4  picture cMascaraFaltas
read

@ 17,12 say AllTrim( Str( nNota1 ) )
@ 17,19 say AllTrim( Str( nFaltas1 ) )
@ 17,26 say AllTrim( Str( nNota2 ) )
@ 17,33 say AllTrim( Str( nFaltas2 ) )
@ 17,40 say AllTrim( Str( nNota3 ) )
@ 17,47 say AllTrim( Str( nFaltas3 ) )
@ 17,54 say AllTrim( Str( nNota4 ) )
@ 17,61 say AllTrim( Str( nFaltas4 ) )


nMedia1         := ( nNota1 + nNota2 + nNota3 + nNota4 )/4
nTotalFaltas1   := nFaltas1 + nFaltas2 + nFaltas3 + nFaltas4

@ 19,12 get nNota1    picture cMascaraNota
@ 19,19 get nFaltas1  picture cMascaraFaltas
@ 19,26 get nNota2    picture cMascaraNota
@ 19,33 get nFaltas2  picture cMascaraFaltas
@ 19,40 get nNota3    picture cMascaraNota
@ 19,47 get nFaltas3  picture cMascaraFaltas
@ 19,54 get nNota4    picture cMascaraNota
@ 19,61 get nFaltas4  picture cMascaraFaltas
read

@ 19,12 say AllTrim( Str( nNota1 ) )
@ 19,19 say AllTrim( Str( nFaltas1 ) )
@ 19,26 say AllTrim( Str( nNota2 ) )
@ 19,33 say AllTrim( Str( nFaltas2 ) )
@ 19,40 say AllTrim( Str( nNota3 ) )
@ 19,47 say AllTrim( Str( nFaltas3 ) )
@ 19,54 say AllTrim( Str( nNota4 ) )
@ 19,61 say AllTrim( Str( nFaltas4 ) )


nMedia2         := ( nNota1 + nNota2 + nNota3 + nNota4 )/4
nTotalFaltas2   := nFaltas1 + nFaltas2 + nFaltas3 + nFaltas4


@ 21,12 get nNota1    picture cMascaraNota
@ 21,19 get nFaltas1  picture cMascaraFaltas
@ 21,26 get nNota2    picture cMascaraNota
@ 21,33 get nFaltas2  picture cMascaraFaltas
@ 21,40 get nNota3    picture cMascaraNota
@ 21,47 get nFaltas3  picture cMascaraFaltas
@ 21,54 get nNota4    picture cMascaraNota
@ 21,61 get nFaltas4  picture cMascaraFaltas
read

@ 21,12 say AllTrim( Str( nNota1 ) )
@ 21,19 say AllTrim( Str( nFaltas1 ) )
@ 21,26 say AllTrim( Str( nNota2 ) )
@ 21,33 say AllTrim( Str( nFaltas2 ) )
@ 21,40 say AllTrim( Str( nNota3 ) )
@ 21,47 say AllTrim( Str( nFaltas3 ) )
@ 21,54 say AllTrim( Str( nNota4 ) )
@ 21,61 say AllTrim( Str( nFaltas4 ) )


nMedia3         := ( nNota1 + nNota2 + nNota3 + nNota4 )/4
nTotalFaltas3   := nFaltas1 + nFaltas2 + nFaltas3 + nFaltas4


@ 23,12 get nNota1    picture cMascaraNota
@ 23,19 get nFaltas1  picture cMascaraFaltas
@ 23,26 get nNota2    picture cMascaraNota
@ 23,33 get nFaltas2  picture cMascaraFaltas
@ 23,40 get nNota3    picture cMascaraNota
@ 23,47 get nFaltas3  picture cMascaraFaltas
@ 23,54 get nNota4    picture cMascaraNota
@ 23,61 get nFaltas4  picture cMascaraFaltas
read

@ 23,12 say AllTrim( Str( nNota1 ) )
@ 23,19 say AllTrim( Str( nFaltas1 ) )
@ 23,26 say AllTrim( Str( nNota2 ) )
@ 23,33 say AllTrim( Str( nFaltas2 ) )
@ 23,40 say AllTrim( Str( nNota3 ) )
@ 23,47 say AllTrim( Str( nFaltas3 ) )
@ 23,54 say AllTrim( Str( nNota4 ) )
@ 23,61 say AllTrim( Str( nFaltas4 ) )


nMedia4         := ( nNota1 + nNota2 + nNota3 + nNota4 )/4
nTotalFaltas4   := nFaltas1 + nFaltas2 + nFaltas3 + nFaltas4

@ 13,01 clear to 23,78

nReprova := 0
cMateria1 := ''
cMateria2 := ''
cMateria3 := ''
cMateria4 := ''

if nMedia1 < 6 .or. nTotalFaltas1 > 48
   nReprova += 1
   cMateria1 := cExatas  + ' '
endif

if nMedia2 < 6 .or. nTotalFaltas2 > 48
   nReprova += 1
   cMateria2 := cHumanas + ' '
endif

if nMedia3 < 6 .or. nTotalFaltas3 > 48
   nReprova += 1
   cMateria3 := cLetras  + ' '
endif

if nMedia4 < 6 .or. nTotalFaltas4 > 48
   nReprova += 1
   cMateria4 := cArtes   + ' '
endif

if nReprova >2
   cResposta := 'Reprovado na(s) seguinte(s) disciplina(s):'
elseif nReprova <= 2 .and. nReprova > 0
   cResposta := 'Aprovado com dependencia(s) na(s) seguinte(s) disciplina(s):'
   nMensalidade += nMensalidade * ( 0.15 * nReprova )
  // @ 13,01 say cResposta
  // @ 14,01 say cMateria1 + cMateria2 + cMateria3 + cMateria4
   @ 15,01 say 'Nova mensalidade: ' + Str( nMensalidade )
else
   cResposta := 'Parabens, voce esta aprovado!'
endif

   @ 13,01 say cResposta
   @ 14,01 say cMateria1 + cMateria2 + cMateria3 + cMateria4

Inkey( 0 )
