
//Antonio Gabriel Satoshi Tokunaga

set date to british
set epoch to 1940
set scoreboard off
//set century on

set color to 'W/B'

//falta cor na media e reprova por falta
//falta
//busque espa‡o na tela para o recurso de conselho

//use a valida‡Æo para o esc ap¢s cada read
clear

do while .t.

   cAviso := 'Deseja sair do programa?'
   cCor   := 'W/B'

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
   @ 03,01 say 'Fone: (00) 0000-0000'

   @ 04,01 to 04,78

   @ 05,01 say 'Aluno.................................: '
   @ 06,01 say 'Data de nascimento....................: '
   @ 07,01 say 'Curso.................................: '
   @ 08,01 say 'Serie.................................: '
   @ 08,43 say 'ø'
   @ 09,01 say 'Ano letivo............................: '
   @ 10,01 say 'Valor da mensalidade..................: '
   @ 11,01 say 'Bolsista(N-Nao; I-Integral; P-Parcial): '

   @ 05,42 get cNome             picture '@!'           valid !Empty( cNome )
   @ 06,42 get dDataNascimento                          valid dDataNascimento < Date()
   @ 07,42 get cCurso            picture '@!'           valid !Empty( cCurso )
   @ 08,42 get nSerie            picture '9'            valid nSerie > 0
   @ 09,42 get nAnoLetivo        picture '9999'
   @ 10,42 get nMensalidade      picture '@E 99,999.99' valid nMensalidade >= 0
   @ 11,42 get cBolsista         picture '@!'           valid cBolsista = 'N' .or. cBolsista = 'I' .or. cBolsista = 'P'
   read

   if LastKey() == 27
      nOpcao := Alert( cAviso, { 'Sim', 'Nao' }, cCor )

      if nOpcao == 1
         exit
      else
         loop
      endif

   endif

   @ 05,42 clear to 11,78

   cMensalidade := AllTrim( Str( nMensalidade ) )

   if cBolsista = 'I'
      nMensalidade := nMensalidade * 0.02
      cMensalidade := AllTrim( Str( nMensalidade ) ) + ' (Desconto de 98%)'
   elseif cBolsista = 'P'
      nMensalidade := nMensalidade / 2
      cMensalidade := AllTrim( Str( nMensalidade ) ) + ' (Desconto de 50%)'
   endif

   @ 05,42 say AllTrim( cNome )
   @ 06,42 say dDataNascimento
   @ 07,42 say AllTrim( cCurso )
   @ 08,42 say AllTrim(Str( nSerie ) ) + 'ø'
   @ 09,42 say AllTrim(Str( nAnoLetivo ) )
   @ 10,42 say cMensalidade
   @ 11,42 say cBolsista

   cDisciplina1  := Space( 15 )
   cDisciplina2  := Space( 15 )
   cDisciplina3  := Space( 15 )
   cDisciplina4  := Space( 15 )

   @ 12,01 to 12,78

   @ 13,17 say '1ø BIMESTRE'
   @ 13,29 say '2ø BIMESTRE'
   @ 13,41 say '3ø BIMESTRE'
   @ 13,53 say '4ø BIMESTRE'
   @ 14,01 say 'DISCIPLINA'
   @ 14,17 say 'NOTA'
   @ 14,22 say 'FALTAS'
   @ 14,29 say 'NOTA'
   @ 14,34 say 'FALTAS'
   @ 14,41 say 'NOTA'
   @ 14,46 say 'FALTAS'
   @ 14,53 say 'NOTA'
   @ 14,58 say 'FALTAS'
   @ 14,65 say 'MEDIA'
   @ 14,71 say 'FINAL'
   @ 23,01 say 'CONSELHO:'

   //DISCIPLINA 1
   @ 16,01 get cDisciplina1
   @ 16,17 get nNota1    picture cMascaraNota
   @ 16,22 get nFaltas1  picture cMascaraFaltas
   @ 16,29 get nNota2    picture cMascaraNota
   @ 16,34 get nFaltas2  picture cMascaraFaltas
   @ 16,41 get nNota3    picture cMascaraNota
   @ 16,46 get nFaltas3  picture cMascaraFaltas
   @ 16,53 get nNota4    picture cMascaraNota
   @ 16,58 get nFaltas4  picture cMascaraFaltas
   read

   nMedia1         := ( nNota1 + nNota2 + nNota3 + nNota4 )/4
   nTotalFaltas1   := nFaltas1 + nFaltas2 + nFaltas3 + nFaltas4

   nReprova   := 0
   nVoto      := 0

   cMateriaDp := ''
   cMediaCor  := ''
   cCor       := ''
   cResultado := ''
   cConselho1 := Space( 1 )
   cConselho2 := Space( 1 )
   cConselho3 := Space( 1 )

   @ 16,17 clear to 16,64

   @ 16,17 say AllTrim( Str( nNota1 ) )
   @ 16,22 say AllTrim( Str( nFaltas1 ) )
   @ 16,29 say AllTrim( Str( nNota2 ) )
   @ 16,34 say AllTrim( Str( nFaltas2 ) )
   @ 16,41 say AllTrim( Str( nNota3 ) )
   @ 16,46 say AllTrim( Str( nFaltas3 ) )
   @ 16,53 say AllTrim( Str( nNota4 ) )
   @ 16,58 say AllTrim( Str( nFaltas4 ) )

   cMediaCor  := AllTrim( Str( nMedia1 ) )
   //Replique isso para as outras disciplinas-------------------------------------
   if nMedia1 < 6 .or. nTotalFaltas1 > 56
      nReprova   += 1

      cMateriaDp := cDisciplina1 + ' '
      cCor       := 'R/B'
      cResultado := 'REP'
   elseif nMedia1 >= 6 .and. (nTotalFaltas1 <= 56 .and. nTotalFaltas1 > 48)
      cCor       := 'G/B'

      @ 23,11 get cConselho1 picture '@!' valid cConselho1 $ 'SN'
      @ 23,13 get cConselho2 picture '@!' valid cConselho2 $ 'SN'
      @ 23,15 get cConselho3 picture '@!' valid cConselho3 $ 'SN'
      read

         if cConselho1 = 'S'
            nVoto += 1
         endif

         if cConselho2 = 'S'
            nVoto += 1
         endif

         if cConselho3 = 'S'
            nVoto += 1
         endif

            if nVoto >= 2
               cResultado := 'APR'
            else
               cResultado := 'REP'
            endif
   else
      cCor       := 'G/B'
      cResultado := 'APR'
   endif

   @ 16,65 say cMediaCor  color cCor
   @ 16,72 say cResultado

   @ 23,15 clear to 23,15
   //-----------------------------------------------------------------------------
   //DISCIPLINA2
   @ 18,01 get cDisciplina2
   @ 18,17 get nNota1    picture cMascaraNota
   @ 18,22 get nFaltas1  picture cMascaraFaltas
   @ 18,29 get nNota2    picture cMascaraNota
   @ 18,34 get nFaltas2  picture cMascaraFaltas
   @ 18,41 get nNota3    picture cMascaraNota
   @ 18,46 get nFaltas3  picture cMascaraFaltas
   @ 18,53 get nNota4    picture cMascaraNota
   @ 18,58 get nFaltas4  picture cMascaraFaltas
   read

   nMedia2         := ( nNota1 + nNota2 + nNota3 + nNota4 )/4
   nTotalFaltas2   := nFaltas1 + nFaltas2 + nFaltas3 + nFaltas4

   if nMedia1 < 6 .or. nTotalFaltas1 > 56
      nReprova   += 1

      cMateriaDp := cDisciplina1 + ' '
      cCor       := 'R/B'
      cResultado := 'REP'
   elseif nMedia1 >= 6 .and. (nTotalFaltas1 <= 56 .and. nTotalFaltas1 > 48)
      cCor       := 'G/B'

      @ 23,11 get cConselho1 picture '@!' valid cConselho1 $ 'SN'
      @ 23,13 get cConselho2 picture '@!' valid cConselho2 $ 'SN'
      @ 23,15 get cConselho3 picture '@!' valid cConselho3 $ 'SN'
      read

         if cConselho1 = 'S'
            nVoto += 1
         endif

         if cConselho2 = 'S'
            nVoto += 1
         endif

         if cConselho3 = 'S'
            nVoto += 1
         endif

            if nVoto >= 2
               cResultado := 'APR'
            else
               cResultado := 'REP'
            endif
   else
      cCor       := 'G/B'
      cResultado := 'APR'
   endif

   @ 16,65 say cMediaCor  color cCor
   @ 16,72 say cResultado

   @ 23,15 clear to 23,15

   @ 18,17 clear to 18,64

   @ 18,17 say AllTrim( Str( nNota1 ) )
   @ 18,22 say AllTrim( Str( nFaltas1 ) )
   @ 18,29 say AllTrim( Str( nNota2 ) )
   @ 18,34 say AllTrim( Str( nFaltas2 ) )
   @ 18,41 say AllTrim( Str( nNota3 ) )
   @ 18,46 say AllTrim( Str( nFaltas3 ) )
   @ 18,53 say AllTrim( Str( nNota4 ) )
   @ 18,58 say AllTrim( Str( nFaltas4 ) )

   cMediaCor  := AllTrim( Str( nMedia2 ) )

   if nMedia2 < 6 .or. nTotalFaltas2 > 56
      nReprova   += 1

      cMateriaDp += cDisciplina2 + ' '
      cCor       := 'R/B'
   else
      cCor       := 'G/B'
   endif

   @ 18,65 say cMediaCor color cCor

   //DISCIPLINA 3
   @ 20,01 get cDisciplina3
   @ 20,17 get nNota1    picture cMascaraNota
   @ 20,22 get nFaltas1  picture cMascaraFaltas
   @ 20,29 get nNota2    picture cMascaraNota
   @ 20,34 get nFaltas2  picture cMascaraFaltas
   @ 20,41 get nNota3    picture cMascaraNota
   @ 20,46 get nFaltas3  picture cMascaraFaltas
   @ 20,53 get nNota4    picture cMascaraNota
   @ 20,58 get nFaltas4  picture cMascaraFaltas
   read

   nMedia3         := ( nNota1 + nNota2 + nNota3 + nNota4 )/4
   nTotalFaltas3   := nFaltas1 + nFaltas2 + nFaltas3 + nFaltas4

   if nMedia1 < 6 .or. nTotalFaltas1 > 56
      nReprova   += 1

      cMateriaDp := cDisciplina1 + ' '
      cCor       := 'R/B'
      cResultado := 'REP'
   elseif nMedia1 >= 6 .and. (nTotalFaltas1 <= 56 .and. nTotalFaltas1 > 48)
      cCor       := 'G/B'

      @ 23,11 get cConselho1 picture '@!' valid cConselho1 $ 'SN'
      @ 23,13 get cConselho2 picture '@!' valid cConselho2 $ 'SN'
      @ 23,15 get cConselho3 picture '@!' valid cConselho3 $ 'SN'
      read

         if cConselho1 = 'S'
            nVoto += 1
         endif

         if cConselho2 = 'S'
            nVoto += 1
         endif

         if cConselho3 = 'S'
            nVoto += 1
         endif

            if nVoto >= 2
               cResultado := 'APR'
            else
               cResultado := 'REP'
            endif
   else
      cCor       := 'G/B'
      cResultado := 'APR'
   endif

   @ 16,65 say cMediaCor  color cCor
   @ 16,72 say cResultado

   @ 23,15 clear to 23,15
   @ 20,17 clear to 20,64

   @ 20,17 say AllTrim( Str( nNota1 ) )
   @ 20,22 say AllTrim( Str( nFaltas1 ) )
   @ 20,29 say AllTrim( Str( nNota2 ) )
   @ 20,34 say AllTrim( Str( nFaltas2 ) )
   @ 20,41 say AllTrim( Str( nNota3 ) )
   @ 20,46 say AllTrim( Str( nFaltas3 ) )
   @ 20,53 say AllTrim( Str( nNota4 ) )
   @ 20,58 say AllTrim( Str( nFaltas4 ) )

   cMediaCor  := AllTrim( Str( nMedia3 ) )

   if nMedia3 < 6 .or. nTotalFaltas3 > 56
      nReprova   += 1

      cMateriaDp += cDisciplina3 + ' '
      cCor       := 'R/B'
   else
      cCor       := 'G/B'
   endif

   @ 20,65 say cMediaCor color cCor

   //DISCIPLINA 4
   @ 22,01 get cDisciplina4
   @ 22,17 get nNota1    picture cMascaraNota
   @ 22,22 get nFaltas1  picture cMascaraFaltas
   @ 22,29 get nNota2    picture cMascaraNota
   @ 22,34 get nFaltas2  picture cMascaraFaltas
   @ 22,41 get nNota3    picture cMascaraNota
   @ 22,46 get nFaltas3  picture cMascaraFaltas
   @ 22,53 get nNota4    picture cMascaraNota
   @ 22,58 get nFaltas4  picture cMascaraFaltas
   read

   nMedia4         := ( nNota1 + nNota2 + nNota3 + nNota4 )/4
   nTotalFaltas4   := nFaltas1 + nFaltas2 + nFaltas3 + nFaltas4

   if nMedia1 < 6 .or. nTotalFaltas1 > 56
      nReprova   += 1

      cMateriaDp := cDisciplina1 + ' '
      cCor       := 'R/B'
      cResultado := 'REP'
   elseif nMedia1 >= 6 .and. (nTotalFaltas1 <= 56 .and. nTotalFaltas1 > 48)
      cCor       := 'G/B'

      @ 23,11 get cConselho1 picture '@!' valid cConselho1 $ 'SN'
      @ 23,13 get cConselho2 picture '@!' valid cConselho2 $ 'SN'
      @ 23,15 get cConselho3 picture '@!' valid cConselho3 $ 'SN'
      read

         if cConselho1 = 'S'
            nVoto += 1
         endif

         if cConselho2 = 'S'
            nVoto += 1
         endif

         if cConselho3 = 'S'
            nVoto += 1
         endif

            if nVoto >= 2
               cResultado := 'APR'
            else
               cResultado := 'REP'
            endif
   else
      cCor       := 'G/B'
      cResultado := 'APR'
   endif

   @ 16,65 say cMediaCor  color cCor
   @ 16,72 say cResultado

   @ 23,15 clear to 23,15
   @ 22,17 clear to 22,64

   @ 22,17 say AllTrim( Str( nNota1 ) )
   @ 22,22 say AllTrim( Str( nFaltas1 ) )
   @ 22,29 say AllTrim( Str( nNota2 ) )
   @ 22,34 say AllTrim( Str( nFaltas2 ) )
   @ 22,41 say AllTrim( Str( nNota3 ) )
   @ 22,46 say AllTrim( Str( nFaltas3 ) )
   @ 22,53 say AllTrim( Str( nNota4 ) )
   @ 22,58 say AllTrim( Str( nFaltas4 ) )

   cMediaCor  := AllTrim( Str( nMedia4 ) )

   if nMedia4 < 6 .or. nTotalFaltas4 > 56
      nReprova   += 1

      cMateriaDp += cDisciplina4
      cCor       := 'R/B'
   else
      cCor       := 'G/B'
   endif

   @ 22,65 say cMediaCor color cCor

   @ 12,01 clear to 23,78

   if nReprova > 2 .or. (cBolsista = 'I' .and. nReprova > 0) .or. (cBolsista = 'P' .and. nReprova > 1)
      cResposta    := 'Reprovado na(s) seguinte(s) disciplina(s):'
   elseif (nReprova <= 2 .and. nReprova > 0) .or. (cBolsista = 'P' .and. nReprova = 1)
      cResposta    := 'Aprovado com dependencia(s) na(s) seguinte(s) disciplina(s):'
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

enddo
