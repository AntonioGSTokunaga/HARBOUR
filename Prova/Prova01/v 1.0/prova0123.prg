//Antonio Gabriel Satoshi Tokunaga

set date to british
set epoch to 1940
set scoreboard off
//set century on

set color to W/B

//falta cor na media e reprova por falta
//falta


clear

cNome           := Space( 30 )
cCurso          := Space( 30 )
cBolsista       := ' '

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

@ 06,01 say 'Aluno.................................: '
@ 07,01 say 'Data de nascimento....................: '
@ 08,01 say 'Curso.................................: '
@ 09,01 say 'Serie.................................: '
@ 09,43 say 'ø'
@ 10,01 say 'Ano letivo............................: '
@ 11,01 say 'Valor da mensalidade..................: '
@ 12,01 say 'Bolsista(N-Nao; I-Integral; P-Parcial): '

@ 06,42 get cNome             picture '@!'           valid !Empty( cNome )
@ 07,42 get dDataNascimento                          valid dDataNascimento < Date()
@ 08,42 get cCurso            picture '@!'           valid !Empty( cCurso )
@ 09,42 get nSerie            picture '9'            valid nSerie > 0
@ 10,42 get nAnoLetivo        picture '9999'
@ 11,42 get nMensalidade      picture '@E 99,999.99' valid nMensalidade >= 0
@ 12,42 get cBolsista         picture '@!'           valid cBolsista = 'N' .or. cBolsista = 'I' .or. cBolsista = 'P'
read

@ 06,42 clear to 12,78

cMensalidade := AllTrim( Str( nMensalidade ) )

if cBolsista = 'I'
   nMensalidade := nMensalidade * 0.02
   cMensalidade := AllTrim( Str( nMensalidade ) ) + ' (Desconto de 98%)'
elseif cBolsista = 'P'
   nMensalidade := nMensalidade / 2
   cMensalidade := AllTrim( Str( nMensalidade ) ) + ' (Desconto de 50%)'
endif

@ 06,42 say AllTrim( cNome )
@ 07,42 say dDataNascimento
@ 08,42 say AllTrim( cCurso )
@ 09,42 say AllTrim(Str( nSerie ) ) + 'ø'
@ 10,42 say AllTrim(Str( nAnoLetivo ) )
@ 11,42 say cMensalidade
@ 12,42 say cBolsista

cDisciplina1  := Space( 15 )
cDisciplina2  := Space( 15 )
cDisciplina3  := Space( 15 )
cDisciplina4  := Space( 15 )

@ 13,01 to 13,78

@ 14,17 say '1ø BIMESTRE'
@ 14,29 say '2ø BIMESTRE'
@ 14,41 say '3ø BIMESTRE'
@ 14,53 say '4ø BIMESTRE'
@ 15,01 say 'DISCIPLINA'
@ 15,17 say 'NOTA'
@ 15,22 say 'FALTAS'
@ 15,29 say 'NOTA'
@ 15,34 say 'FALTAS'
@ 15,41 say 'NOTA'
@ 15,46 say 'FALTAS'
@ 15,53 say 'NOTA'
@ 15,58 say 'FALTAS'
@ 15,65 say 'MEDIA'
@ 15,71 say 'FINAL'

//DISCIPLINA 1
@ 17,01 get cDisciplina1
@ 17,17 get nNota1    picture cMascaraNota
@ 17,22 get nFaltas1  picture cMascaraFaltas
@ 17,29 get nNota2    picture cMascaraNota
@ 17,34 get nFaltas2  picture cMascaraFaltas
@ 17,41 get nNota3    picture cMascaraNota
@ 17,46 get nFaltas3  picture cMascaraFaltas
@ 17,53 get nNota4    picture cMascaraNota
@ 17,58 get nFaltas4  picture cMascaraFaltas
read

nMedia1         := ( nNota1 + nNota2 + nNota3 + nNota4 )/4
nTotalFaltas1   := nFaltas1 + nFaltas2 + nFaltas3 + nFaltas4

nReprova   := 0
cMateriaDp := ''
cMediaCor  := ''



@ 17,17 clear to 17,64

@ 17,17 say AllTrim( Str( nNota1 ) )
@ 17,22 say AllTrim( Str( nFaltas1 ) )
@ 17,29 say AllTrim( Str( nNota2 ) )
@ 17,34 say AllTrim( Str( nFaltas2 ) )
@ 17,41 say AllTrim( Str( nNota3 ) )
@ 17,46 say AllTrim( Str( nFaltas3 ) )
@ 17,53 say AllTrim( Str( nNota4 ) )
@ 17,58 say AllTrim( Str( nFaltas4 ) )

if nMedia1 < 6 //.or. nTotalFaltas1 > 48
   nReprova   += 1
   cMateriaDp := cDisciplina1 + ' '
   cMediaCor  := AllTrim( Str( nMedia1 ) )

   @ 17,65 say cMediaCor color 'R/B'
else
   cMediaCor  := AllTrim( Str( nMedia1 ) )

   @ 17,65 say cMediaCor color 'G/B'
endif

//DISCIPLINA2
@ 19,01 get cDisciplina2
@ 19,17 get nNota1    picture cMascaraNota
@ 19,22 get nFaltas1  picture cMascaraFaltas
@ 19,29 get nNota2    picture cMascaraNota
@ 19,34 get nFaltas2  picture cMascaraFaltas
@ 19,41 get nNota3    picture cMascaraNota
@ 19,46 get nFaltas3  picture cMascaraFaltas
@ 19,53 get nNota4    picture cMascaraNota
@ 19,58 get nFaltas4  picture cMascaraFaltas
read

nMedia2         := ( nNota1 + nNota2 + nNota3 + nNota4 )/4
nTotalFaltas2   := nFaltas1 + nFaltas2 + nFaltas3 + nFaltas4


if nMedia2 < 6 //.or. nTotalFaltas2 > 48
   nReprova += 1
   cMateriaDp += cDisciplina2 + ' '
   cMediaCor  := AllTrim( Str( nMedia2 ) )

   @ 19,65 say cMediaCor color 'R/B'
else
   cMediaCor  := AllTrim( Str( nMedia2 ) ) color 'G/B'
endif

@ 19,17 clear to 19,64

@ 19,17 say AllTrim( Str( nNota1 ) )
@ 19,22 say AllTrim( Str( nFaltas1 ) )
@ 19,29 say AllTrim( Str( nNota2 ) )
@ 19,34 say AllTrim( Str( nFaltas2 ) )
@ 19,41 say AllTrim( Str( nNota3 ) )
@ 19,46 say AllTrim( Str( nFaltas3 ) )
@ 19,53 say AllTrim( Str( nNota4 ) )
@ 19,58 say AllTrim( Str( nFaltas4 ) )

//DISCIPLINA 3
@ 21,01 get cDisciplina3
@ 21,17 get nNota1    picture cMascaraNota
@ 21,22 get nFaltas1  picture cMascaraFaltas
@ 21,29 get nNota2    picture cMascaraNota
@ 21,34 get nFaltas2  picture cMascaraFaltas
@ 21,41 get nNota3    picture cMascaraNota
@ 21,46 get nFaltas3  picture cMascaraFaltas
@ 21,53 get nNota4    picture cMascaraNota
@ 21,58 get nFaltas4  picture cMascaraFaltas
read

nMedia3         := ( nNota1 + nNota2 + nNota3 + nNota4 )/4
nTotalFaltas3   := nFaltas1 + nFaltas2 + nFaltas3 + nFaltas4


if nMedia3 < 6 // .or. nTotalFaltas3 > 48
   nReprova += 1
   cMateriaDp += cDisciplina3 + ' '
   cMediaCor  := AllTrim( Str( nMedia3 ) ) color 'R/B'
else
   cMediaCor  := AllTrim( Str( nMedia3 ) ) color 'G/B'
endif

@ 21,17 clear to 21,64

@ 21,17 say AllTrim( Str( nNota1 ) )
@ 21,22 say AllTrim( Str( nFaltas1 ) )
@ 21,29 say AllTrim( Str( nNota2 ) )
@ 21,34 say AllTrim( Str( nFaltas2 ) )
@ 21,41 say AllTrim( Str( nNota3 ) )
@ 21,46 say AllTrim( Str( nFaltas3 ) )
@ 21,53 say AllTrim( Str( nNota4 ) )
@ 21,58 say AllTrim( Str( nFaltas4 ) )
@ 21,65 say cMediaCor

//DISCIPLINA 4
@ 23,01 get cDisciplina4
@ 23,17 get nNota1    picture cMascaraNota
@ 23,22 get nFaltas1  picture cMascaraFaltas
@ 23,29 get nNota2    picture cMascaraNota
@ 23,34 get nFaltas2  picture cMascaraFaltas
@ 23,41 get nNota3    picture cMascaraNota
@ 23,46 get nFaltas3  picture cMascaraFaltas
@ 23,53 get nNota4    picture cMascaraNota
@ 23,58 get nFaltas4  picture cMascaraFaltas
read

nMedia4         := ( nNota1 + nNota2 + nNota3 + nNota4 )/4
nTotalFaltas4   := nFaltas1 + nFaltas2 + nFaltas3 + nFaltas4

if nMedia4 < 6 .or. nTotalFaltas4 > 48
   nReprova += 1
   cMateriaDp += cDisciplina4
   cMediaCor  := AllTrim( Str( nMedia4 ) ) color 'R/B'
else
   cMediaCor  := AllTrim( Str( nMedia1 ) ) color 'G/B'
endif

@ 23,17 clear to 23,64

@ 23,17 say AllTrim( Str( nNota1 ) )
@ 23,22 say AllTrim( Str( nFaltas1 ) )
@ 23,29 say AllTrim( Str( nNota2 ) )
@ 23,34 say AllTrim( Str( nFaltas2 ) )
@ 23,41 say AllTrim( Str( nNota3 ) )
@ 23,46 say AllTrim( Str( nFaltas3 ) )
@ 23,53 say AllTrim( Str( nNota4 ) )
@ 23,58 say AllTrim( Str( nFaltas4 ) )
@ 23,65 say cMediaCor

@ 13,01 clear to 23,78

if nReprova >2 .or. (cBolsista = 'I' .and. nReprova > 0) .or. (cBolsista = 'P' .and. nReprova > 1)
   cResposta := 'Reprovado na(s) seguinte(s) disciplina(s):'
elseif (nReprova <= 2 .and. nReprova > 0) .or. (cBolsista = 'P' .and. nReprova = 1)
   cResposta := 'Aprovado com dependencia(s) na(s) seguinte(s) disciplina(s):'
   nMensalidade += nMensalidade * ( 0.15 * nReprova )
  // @ 13,01 say cResposta
  // @ 14,01 say cMateria1 + cMateria2 + cMateria3 + cMateria4
   @ 15,01 say 'Nova mensalidade: ' + Str( nMensalidade )
else
   cResposta := 'Parabens, voce esta aprovado!'
endif

   @ 13,01 say cResposta
   @ 14,01 say cMateriaDp

Inkey( 0 )
