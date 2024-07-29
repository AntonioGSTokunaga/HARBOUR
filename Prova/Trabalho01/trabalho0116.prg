// RAFAEL ROSMAN RODRIGUES MONTREZOL

set date to british // MM/DD/YY -> DD/MM/YY
set epoch to 1940 // as datas vao comecar a partir de 1940
set scoreboard off // desabilita as mengagens de erro no topo

// Mascaras de cor
cColorGet   := "W/N"

nControleLoops := 0

dHoje    := Date()
nAnoHoje := Year( dHoje )
nMesHoje := Month( dHoje )
nDiaHoje := Day( dHoje )

do while .t.
   clear

   @ 00,33 say "CONTROLE_INSS"

   nQtdeEmpregados := 0

   @ 02,01 say "Quantidade de empregados paraanalisar: "

   @ 02,42 get nQtdeEmpregados picture "999" valid nQtdeEmpregados > 0
   read

   if LastKey() == 27 // 27 -> ESC
      nControleLoops := Alert( "Deseja sair do programa?", { "Sim", "Nao" } )
   
      if nControleLoops == 1
         exit
      else
         loop
      endif
   endif

   nQtdeTotalAposentado := 0
   nTotalRemuneracao    := 0

   nQtdeHomem              := 0
   nQtdeAposentadoHomem    := 0
   nTotalRemuneracaoHomem  := 0
   nQtdeHomemMaisDe82Anos  := 0

   nQtdeMulher                   := 0
   nQtdeAposentadoMulher         := 0
   nTotalRemuneracaoMulher       := 0
   nQtdeMulherAdmitidaAntes2002  := 0
   nQtdeMulherIRRF               := 0

   nContador := 0
   do while nContador < nQtdeEmpregados
      @ 01,00 clear to 24,79

      @ 01,01 say "Coleta de dados numero " + AllTrim( Str( ++nContador ) )
      
      cNome             := Space( 30 )
      cSexo             := " " // M/F
      dNascimento       := CToD( "" )
      dAdmissao         := CToD( "" )
      dDemissao         := CToD( "" )
      nSalarioBase      := 0
      nLimiteIRRF       := 0
      nAddNoturno       := 0 // em %
      nAddInsalubridade := 0 // em %

      @ 02,01 say "Nome do colaborador........: "
      @ 03,01 say "Sexo.......................: X [M]asculino [F]eminino"
      @ 04,01 say "Data de nascimento.........: "
      @ 05,01 say "Data de admissao...........: "
      @ 06,01 say "Data de demissao...........: "
      @ 07,01 say "Salario base...............: "
      @ 08,01 say "Valor limite IRRF..........: "
      @ 09,01 say "Adicional noturno.(%)......: "
      @ 10,01 say "Adicional insalubridade (%): "

      @ 02,30 get cNome             picture "@!"            valid !Empty( cNome )
      @ 03,30 get cSexo             picture "@!"            valid cSexo $ "MF"
      @ 04,30 get dNascimento                               valid !Empty( dNascimento ) .and. dNascimento <= dHoje
      @ 05,30 get dAdmissao                                 valid dAdmissao <= dHoje .and. dAdmissao > dNascimento
      @ 06,30 get dDemissao                                 valid dDemissao <= dHoje .and. dDemissao => dAdmissao
      @ 07,30 get nSalarioBase      picture "@E 99999.99"   valid nSalarioBase > 0
      @ 08,30 get nLimiteIRRF       picture "@E 99999.99"   valid nLimiteIRRF > 0
      @ 09,30 get nAddNoturno       picture "999"           valid nAddNoturno >= 0 .and. nAddNoturno <= 100
      @ 10,30 get nAddInsalubridade picture "999"           valid nAddInsalubridade >= 0 .and. nAddInsalubridade <= 100
      read

      if LastKey() == 27 // 27 -> ESC
         nControleLoops := Alert( "Deseja...", { "Cancelar", "Retornar", "Processar" } )
         
         if nControleLoops == 2
            nContador--
            loop
         else
            exit
         endif
      endif

      nSalario := nSalarioBase + ( nSalarioBase * ( nAddNoturno / 100 ) ) + ( nSalarioBase * ( nAddInsalubridade / 100 ) )
      
      // CALCULO DA IDADE
      nAnoNascimento := Year( dNascimento )
      nMesNascimento := Month( dNascimento )
      nDiaNascimento := Day( dNascimento )

      nAnoIdade	:= nAnoHoje - nAnoNascimento
      nMesIdade	:= nMesHoje - nMesNascimento
      nDiaIdade	:= nDiaHoje - nDiaNascimento

      if nDiaIdade < 0
         nMesIdade--
      endif
      if nMesIdade < 0
         nAnoIdade--
      endif

      nIdade := nAnoIdade

      // CALCULO DO TEMPO TRABALHADO
      nAnoAdmissao := Year( dAdmissao )
      nMesAdmissao := Month( dAdmissao )
      nDiaAdmissao := Day( dAdmissao )

      nAnoDemissao := Year( dDemissao )
      nMesDemissao := Month( dDemissao )
      nDiaDemissao := Day( dDemissao )

      nAnoTempoTrabalhado	:= nAnoDemissao - nAnoAdmissao
      nMesTempoTrabalhado	:= nMesDemissao - nMesAdmissao
      nDiaTempoTrabalhado	:= nDiaDemissao - nDiaAdmissao

      if nDiaTempoTrabalhado < 0
         nMesTempoTrabalhado--
      endif
      if nMesTempoTrabalhado < 0
         nAnoTempoTrabalhado--
      endif

      nTempoTrabalhado := nAnoTempoTrabalhado

      lAptoAposentar := .f.

      if cSexo == "M"
         nQtdeHomem++

         if nIdade > 82
            nQtdeHomemMaisDe82Anos++
         endif

         if nIdade >= 61 .and. nTempoTrabalhado >= 29
            nQtdeAposentadoHomem++
            nQtdeTotalAposentado++
            lAptoAposentar := .t.
         endif
      else
         nQtdeMulher++

         if nAnoAdmissao < 2002
            nQtdeMulherAdmitidaAntes2002++
         endif

         if nSalario >= nLimiteIRRF // PAGA IRRF
            nQtdeMulherIRRF++
         endif

         if nIdade >= 58 .and. nTempoTrabalhado >= 22
            nQtdeAposentadoMulher++
            nQtdeTotalAposentado++
            lAptoAposentar := .t.
         endif
      endif

      if lAptoAposentar
         lTrabalhou2009 := nAnoAdmissao <= 2009 .and. nAnoDemissao >= 2009
         lTrabalhou2012 := nAnoAdmissao <= 2012 .and. nAnoDemissao >= 2012
         lTrabalhou2015 := nAnoAdmissao <= 2015 .and. nAnoDemissao >= 2015
         lTrabalhou2018 := nAnoAdmissao <= 2018 .and. nAnoDemissao >= 2018

         if lTrabalhou2009 .or. lTrabalhou2012 // AUMENTAR 9%
            nSalario += nSalarioBase * ( 9 / 100 )
         endif
         
         if lTrabalhou2015 .or. lTrabalhou2018 // REDUZIR 9%
            nSalario -= nSalarioBase * ( 3 / 100 )
         endif

         if nSalario >= nLimiteIRRF // REDUZIR 7%
            nSalario -= nSalarioBase * ( 7 / 100 )
         endif

         nTotalRemuneracao += nSalario
         if cSexo == "M"
            nTotalRemuneracaoHomem += nSalario
         else
            nTotalRemuneracaoMulher += nSalario
         endif

      endif

   enddo

   if nControleLoops == 1
      loop
   endif

   nPercentHomemAposentado := ( nQtdeAposentadoHomem / nQtdeTotalAposentado ) * 100
   nPercentMulherAposentado := ( nQtdeAposentadoMulher / nQtdeTotalAposentado ) * 100

   @ 01,00 clear to 24,79

   @ 02,00 to 24,79

   @ 03,01 say "Quantidade de aposentados..........................: " + AllTriM( Str( nQtdeTotalAposentado ) )
   @ 04,01 say "Quantidade e percentual homens aposentados.........: " + AllTriM( Str( nQtdeAposentadoHomem ) ) + " ( "+ AllTriM( Str( nPercentHomemAposentado ) ) + "% )"
   @ 05,01 say "Valor total da remuneracao dos homens aposentados..: " + Transform( nTotalRemuneracaoHomem, "@E 99,999.99" )
   @ 06,01 say "Quantidade e percentual mulheres aposentadas.......: " + AllTriM( Str( nQtdeAposentadoMulher ) ) + " ( "+ AllTriM( Str( nPercentMulherAposentado ) ) + "% )"
   @ 07,01 say "Valor total da remuneracao das mulheres aposentadas: " + Transform( nTotalRemuneracaoMulher, "@E 99,999.99" )
   @ 08,01 say "Quantidade de homens com idade superior a 82 anos..: " + AllTriM( Str( nQtdeHomemMaisDe82Anos ) )
   @ 09,01 say "Quantidade de mulheres admitidas antes de 2002.....: " + AllTriM( Str( nQtdeMulherAdmitidaAntes2002 ) )
   @ 10,01 say "Percentual de mulheres que pagam IRRF..............: " + AllTriM( Str( nQtdeMulherIRRF ) )

   @ 20,01 say "Pressione qualquer tecla para reiniciar o programa..."
   Inkey( 0 )
   
enddo