// ANTONIO GABRIEL SATOSHI TOKUNAGA

setmode ( 25,80 )
set date to british
set epoch to 1940
set century on
set scoreboard off
set color to 'W/B'

clear

@ 00,00 to 24,79 double

cCor := 'G/N'

do while .t.

   nNumeroAnalise := 0

   @ 01,01 say 'Nø de empregados para analisar:'

   @ 01,42 get nNumeroAnalise   valid nNumeroAnalise > 0
   read

   if LastKey() == 27
      nOpcao := Alert( 'Deseja sair do programa?' , { 'Sim', 'Nao' }, cCor )

      if nOpcao == 1
         exit
      else
         loop
      endif
   endif

   nContador            := 0
   nTotalRemuneracao    := 0
   nHomensAposentados   := 0
   nMulheresAposentadas := 0
   nHomensOctagenarios  := 0
   nMulheresAdmitidas   := 0
   nMulheresIRRF        := 0
   nTotalHomens         := 0
   nTotalMulheres       := 0

   //do while nContador < nNumeroAnalise

      do while nContador < nNumeroAnalise

         cNomeColaborador := Space( 30 )
         cSexo            := Space( 1 )

         dNascimento      := CToD( ' ' )
         dAdmissao        := CToD( ' ' )
         dDemissao        := CToD( ' ' )

         nSalarioBase            := 0
         nLimiteIRRF             := 0
         nAdicionalNoturno       := 0
         nAdicionalInsalubridade := 0
         nIdade                  := 0
         nAposentado             := 0

         @ 01,01 clear to 23,78

         cMascara      := '999'
         cMascaraValor := '@E 999,999.99'

         @ 01,01 say 'Nome......................:'
         @ 02,01 say 'Sexo......................:'
         @ 03,01 say 'Data de nascimento........:'
         @ 04,01 say 'Data de admissao..........:'
         @ 05,01 say 'Data de demissao..........:'
         @ 06,01 say 'Salario base..............:'
         @ 07,01 say 'Limite IRRF...............:'
         @ 08,01 say 'Adicional noturno(%)......:'
         @ 09,01 say 'Adicional insalubridade(%):'

         @ 01,28 get cNomeColaborador           picture '@!'            valid !Empty( cNomeColaborador )
         @ 02,28 get cSexo                      picture '@!'            valid cSexo $ 'MF'
         @ 03,28 get dNascimento                                        valid dNascimento              <= Date()
         @ 04,28 get dAdmissao                                          valid dAdmissao                <= Date()
         @ 05,28 get dDemissao                                          valid dDemissao                <= Date()
         @ 06,28 get nSalarioBase               picture cMascaraValor   valid nSalarioBase             >= 0
         @ 07,28 get nLimiteIRRF                picture cMascaraValor   valid nLimiteIRRF              >= 0
         @ 08,28 get nAdicionalNoturno          picture cMascara        valid nAdicionalNoturno        >= 0 .and. nAdicionalNoturno       <= 100
         @ 09,28 get nAdicionalInsalubridade    picture cMascara        valid nAdicionalInsalubridade  >= 0 .and. nAdicionalInsalubridade <= 100
         read

         if LastKey() == 27
            nOpcao := Alert( 'O que deseja fazer?' , { 'Cancelar', 'Retomar', 'Processar' }, cCor )

            if nOpcao == 1
               exit
            elseif nOpcao == 2
               loop
            elseif nOpcao == 3
               nContador := nNumeroAnalise
               loop
            endif
         endif

         nDia       := Day( dNascimento )
         nMes       := Month( dNascimento )
         nAno       := Year( dNascimento )

         nDiaAtual  := Day( Date() )
         nMesAtual  := Month( Date() )
         nAnoAtual  := Year( Date() )

         if nDia > nDiaAtual
            nIdadeDia           := ( nDiaAtual - nDia ) * -1
         else
            nIdadeDia           := nDiaAtual - nDia
         endif

         nIdadeMes           := nMesAtual - nMes

         if ( nDia < nDiaAtual .and. nMes <= nMesAtual )
            nIdadeAno        := nAnoAtual - ( nAno + 1 )
         else
            nIdadeAno        := nAnoAtual - nAno
         endif

         nAnoAdmissao        := Year( dAdmissao )
         nAnoDemissao        := Year( dDemissao )

         nAnosTrabalho       := nAnoDemissao - nAnoAdmissao

         if ( cSexo == 'M' .and. nIdadeAno >= 61 .and. nAnosTrabalho >= 29 ) .or. ( cSexo == 'F' .and. nIdadeAno >= 58 .and. nAnosTrabalho >= 22 )
               nBonusNoturno       := 0
               nBonusInsalubridade := 0
               nBonusAdicao        := 0
               nBonusReducao       := 0
               nReducaoIRRF        := 0

            if nAdicionalNoturno > 0
               nTaxaNoturno        := nAdicionalNoturno       / 100
               nBonusNoturno       := nSalarioBase * nTaxaNoturno
            endif

            if nAdicionalInsalubridade > 0
               nTaxaInsalubridade  := nAdicionalInsalubridade / 100
               nBonusInsalubridade := nSalarioBase * nTaxaInsalubridade
            endif

            if nAnoAdmissao <= 2009 .and. nAnoDemissao >= 2012
               nBonusAdicao        := nSalarioBase * 0.09
            endif

            if nAnoAdmissao <= 2015 .and. nAnoDemissao >= 2018
               nBonusReducao       := nSalarioBase * 0.03
            endif

            if nLimiteIRRF > 0
               nReducaoIRRF        := nSalarioBase * 0.07
            endif

            nAposentadoria    := nBonusNoturno + nBonusAdicao + nBonusInsalubridade - nReducaoIRRF - nBonusReducao

            nTotalRemuneracao += nAposentadoria

            nAposentado++

         endif

         nContador++

         if cSexo == 'M'
            nTotalHomens++

            if nAposentado == 1
               nHomensAposentados++
            endif

            if nIdade > 82
               nHomensOctagenarios++
            endif

         elseif cSexo == 'F'
            nTotalMulheres++

            if nAnoAdmissao > 2002
               nMulheresAdmitidas++
            endif

            if cSexo == 'F' .and. nLimiteIRRF > 0
               nMulheresIRRF++
            endif

         endif


      enddo
   if nOpcao == 1
      @ 01,01 clear to 23,78
      loop
   endif
   //formulas para estatisticas


   //RESULTADOS
   //enddo
   @ 22,01 say 'Pressione alguma tecla para nova pesquisa...'

   Inkey( 0 )

   @ 01,01 clear to 23,78

enddo
