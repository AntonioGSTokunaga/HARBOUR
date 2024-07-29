//Nome: Amanda de Castro Shimano
set date to british
set epoch to 1940
set scoreboard off

do while .t.

   nEmpregadosAnalisados       := 0
   nContadorEmpregados         := 1
   nAposentados                := 0
   nAposentadas                := 0
   nHomens82Mais               := 0
   nMulheresAdmitidasAntes2002 := 0
   nMulheresPagantesIRRF       := 0
   nAdicionalAnos2009e2012     := 0.09
   nReducaoAnos2015e2018       := 0.03
   nReducaopagantesiRRF        := 0.07
   nAposentadoriaTotal         := 0
   nMulheres                   := 0
   nHomens                     := 0

   clear

   @ 01,01 say "CONTROLE_INSS"
   @ 03,01 say "Numero de empregados analisados: "

   @ 03,34 get nEmpregadosAnalisados   valid nEmpregadosAnalisados > 0 .and. nEmpregadosAnalisados <= 50
   read

   If LastKey() == 27
      cSair := Alert( "Deseja sair do programa?", {"Sim", "Nao" } )
      If cSair == 2
         Loop
      else
         exit
      endif
   endif

   do while nContadorEmpregados <= nEmpregadosAnalisados
      clear

      cNomeColaborador        := Space( 30 )
      cSexo                   := Space( 1 )
      dNascimento             := CToD( "" )
      dAdmissao               := CToD( "" )
      dDemissao               := Date()
      nSalarioBase            := 0
      nValorLimiteIRRF        := 0
      nAdicionalNoturno       := 0
      nAdicionalInsalubridade := 0
      cMascaraSalario         := "@E 999,999.99"
      nSalarioLiquido         := 0

      @ 01,01 say "Registro" + alltrim( str( nContadorEmpregados ) )
      @ 03,01 say "Nome colaborador(a)....: "
      @ 04,01 say "Sexo...................:   [F]eminino | [M]asculino"
      @ 05,01 say "Data de Nascimento.....: "
      @ 06,01 say "Data de admissao.......: "
      @ 07,01 say "Data de demissao.......: "
      @ 08,01 say "Valor de salario base..: "
      @ 09,01 say "Valor limite IRRF......: "
      @ 10,01 say "Adicional noturno......:   %"
      @ 11,01 say "Adicional insalubridade:   %"

      @ 03,26 get cNomeColaborador          picture "@!"              valid !Empty(cNomeColaborador)
      @ 04,26 get cSexo                     picture "@!"              valid cSexo $ "MF"
      @ 05,26 get dNascimento                                         valid !Empty( dNascimento ) .and. dNascimento < date()
      @ 06,26 get dAdmissao                                           valid !Empty( dAdmissao ) .and. dAdmissao <= date()
      @ 07,26 get dDemissao                                           valid !Empty( dDemissao ) .and. dDemissao >= dAdmissao
      @ 08,26 get nSalarioBase              picture cMascaraSalario   valid nSalarioBase > 0
      @ 09,26 get nValorLimiteIRRF          picture cMascaraSalario   valid nValorLimiteIRRF >= 0
      @ 10,26 get nAdicionalNoturno         picture "99"              valid nAdicionalNoturno >= 0
      @ 11,26 get nAdicionalInsalubridade   picture "99"              valid nAdicionalInsalubridade >= 0
      read

      nSalarioLiquido += nSalarioBase + nAdicionalNoturno * 0.01 * nSalarioBase + nAdicionalInsalubridade * 0.01 * nSalarioBase

      dMinimoHomem    := dAdmissao + ( 29 * 365 )
      dMinimoMulher   := dAdmissao + ( 22 * 365 )
      nAnoNascimento  := Year( dNascimento )
      nMesNascimento  := Month( dNascimento )
      nDiaNascimento  := Day( dNascimento )
      nAnoAtual       := Year( Date() )
      nMesAtual       := Month( Date() )
      nDiaAtual       := Day( Date() )
      nIdade          := nAnoAtual - nAnoNascimento
      nAnoAdmissao    := Year( dAdmissao )
      nAnoDemissao    := Year( dDemissao )
      nPagaIRRF       := 0

      If Month( Date() ) < nMesNascimento
         nIdade -= 1
      elseif nMesAtual = nMesNascimento .and. nDiaNascimento > nDiaAtual
         nIdade -= 1
      endif

      If nAnoAdmissao <= 2009 .and. nAnoDemissao >= 2012
         nSalarioLiquido += nAdicionalAnos2009e2012 * nSalarioBase
      endif

      If nAnoAdmissao <= 2015 .and. nAnoDemissao >= 2018
         nSalarioLiquido -= nReducaoAnos2015e2018 * nSalarioBase
      endif

      If nValorLimiteIRRF > nSalarioBase
         nSalarioLiquido -= nValorLimiteIRRF - nSalarioBase
         nSalarioLiquido += nReducaopagantesiRRF * nSalarioBase
         nPagaIRRF := 1
      endif

      If cSexo == "M"
         nHomens++
         if dDemissao >= dMinimoHomem .and. nIdade >= 61
            nAposentados++
            nAposentadoriaTotal += nSalarioLiquido
            if nIdade >= 82
               nHomens82Mais++
            endif
         endif
         elseif cSexo == "F"
         nMulheres++
         If dDemissao >= dMinimoMulher .and. nIdade >= 58
            nAposentadas++
            nAposentadoriaTotal += nSalarioLiquido
            If dAdmissao < 2000
               nMulheresAdmitidasAntes2002++
            endif
            If nPagaIRRF = 1
               nMulheresPagantesIRRF++
            endif
         endif
      endif

      nContadorEmpregados++

      If LastKey() == 27
         cOpcao := Alert( "Deseja?", { "Cancelar", "Retornar", "Processar"})
         If cOpcao == 1
            loop
         elseif cOpcao == 2
            nContadorEmpregados--
            loop
         else
            exit
         endif
      endif

   enddo

   clear

   @ 01,01 say "Percentual"
   @ 02,01 say "Homens aposentados........: " + Alltrim( str( (nAposentados/nHomens) * 100 ) ) + " % "
   @ 03,01 say "Mulheres aposentadas......: " + Alltrim( str( (nAposentadas/nMulheres) * 100 ) ) + " % "
   @ 04,01 say "Outras Informacoes"
   @ 05,01 say "Valor total da remuneracao......: " + alltrim( str( nAposentadoriaTotal ) ) + " reais"
   @ 06,01 say "Homens com mais de 82 anos......: " + alltrim( str( nHomens82Mais ) )
   @ 07,01 say "Mulheres admitidas antes de 2002: " + alltrim( str( nMulheresAdmitidasAntes2002 ) )
   @ 08,01 say "Mulheres pagantes de IRRF.......: " + alltrim( str( (nMulheresPagantesIRRF/nMulheres) * 100 ) )

   InKey( 0 )

enddo

