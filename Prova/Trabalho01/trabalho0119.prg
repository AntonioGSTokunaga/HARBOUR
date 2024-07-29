// Gabriel Fagundes Colle
clear

do while .t.
   clear

   set color to " GR+ / N+ ", " GR+ / N+ "

   nEmpregadosAnalisar           := 0
   nContador                     := 0
   nOpcaoColaborador             := 0
   nQuantidadeAposentados        := 0
   nTotalRenumeracaoAposentado   := 0
   nQuantidadeHomem82            := 0
   nQuantidadeMulher             := 0
   nQuantidadeMulher02           := 0
   nQuantidadeColaboradores      := 0
   nQuantidaeMulherPagaIrrf      := 0
   nQuantidadeAposentados        := 0

   @ 00,00 to 20,79

   @ 01,20 say "CONTROLE_INSS"

   @ 02,01 to 02,78

   @ 03,01 say "QUAL O NUMEROS DE EMPREGADOS A SEREM ANALISADOS?"

   @ 03,50 get nEmpregadosAnalisar picture "9999" valid nEmpregadosAnalisar >= 0
   read

   if LastKey() == 27
      nOpcaoEmpregadosAnalisar := Alert("O QUE DESEJA FAZER",{"REFAZER", "SAIR"})

      if nOpcaoEmpregadosAnalisar == 1
         loop
      else
         exit
      endif
   endif

   do while .t.

      set date to british
      set epoch to 1940

      clear

      set color to " GR+ / N+ ", " GR+ / N+ "

      ++nContador

      if nContador > nEmpregadosAnalisar
         exit
      endif

      cNomeColaborador           := Space(25)
      cSexoColaborador           := Space(1)
      dNascimento                := CToD("")
      dAdmissao                  := CToD("")
      dDemissao                  := cToD("")
      nValorSalarioBase          := 0
      nValorLimiteIrrf           := 0
      nAdicionalNoturno          := 0
      nAdicionalInsalubridade    := 0
      cSituacaoAposentadoria     := "NAO APTO"
      nRenumeracaoAposentadoria          := 0
      cSituacaoIrrf              := "NAO PAGA"

      @ 00,00 to 20,79

      @ 01,01 say "COLABORADOR N " + Alltrim(str(nContador))
      @ 01,35 say "COLABORADOR......: "
      @ 02,01 say "SEXO (M/F).......:"
      @ 02,35 say "DATA NASCIMENTO..:"
      @ 03,01 say "DATA ADMISSAO....:"
      @ 03,35 say "DATA DEMISSAO....:"
      @ 04,01 say "SALARIO BASE.....:"
      @ 04,35 say "LIMITE IRRF......:"
      @ 05,01 say "ADICIONAL NOTURNO %:"
      @ 05,35 say "ADICIONAL INSALUBRIDADE %:"

      @ 01,54 get cNomeColaborador           picture "@!"         valid !Empty(cNomeColaborador)
      @ 02,22 get cSexoColaborador           picture "@!"         valid cSexoColaborador $ "MF"
      @ 02,54 get dNascimento                                     valid !Empty(dNascimento)
      @ 03,22 get dAdmissao                                       valid dAdmissao >dNascimento
      @ 03,54 get dDemissao                                       valid dDemissao > dAdmissao
      @ 04,22 get nValorSalarioBase          picture "999999.99"  valid nValorSalarioBase >= 0
      @ 04,54 get nValorLimiteIrrf           picture "999999.99"  valid nValorLimiteIrrf >= 0
      @ 05,22 get nAdicionalNoturno          picture "999"        valid nAdicionalNoturno >= 0 .and. nAdicionalNoturno <= 100
      @ 05,62 get nAdicionalInsalubridade    picture "999"        valid nAdicionalInsalubridade >= 0 .and. nAdicionalInsalubridade <= 100
      read

      @ 06,01 to 06,78

      nIdadeColaborador          := (Year(Date()) - Year(dNascimento))
      nTempoTrabalhado           := (Year(dDemissao) - Year(dAdmissao))

      if LastKey() == 27
         nOpcaoColaborador := Alert("O QUE DESEJA FAZER:", {"CANCELAR", "RETORNAR", "PROCESSAR"})

         if nOpcaoColaborador == 1
            loop
         elseif nOpcaoColaborador == 2
            exit
         else
            exit
         endif
      endif

      if (cSexoColaborador == "M") .and. (nIdadeColaborador > 60) .and. (nTempoTrabalhado > 28)
         cSituacaoAposentadoria := "APTO"
      endif

      if (cSexoColaborador == "F") .and. (nIdadeColaborador) > 57 .and. (nTempoTrabalhado > 21)
         cSituacaoAposentadoria := "APTO"
      endif

      if nValorSalarioBase >= nValorLimiteIrrf
         cSituacaoIrrf := "PAGA"
      endif

      @ 07,01 say "SITUACAO APOSENTADORIA: " + cSituacaoAposentadoria

      nRenumeracaoAposentadoria := nValorSalarioBase

      nRenumeracaoAposentadoria += nValorSalarioBase * ((nAdicionalNoturno/100))
      nRenumeracaoAposentadoria += nValorSalarioBase * ((nAdicionalInsalubridade/100))

      if (Year(dDemissao) >= 2009) .and. (Year(dDemissao) >= 2012) .and. cSituacaoAposentadoria == "APTO"
         nRenumeracaoAposentadoria += nValorSalarioBase * (0.09)
      endif

      if (Year(dDemissao) >= 2015) .and. (Year(dDemissao) >= 2018) .and. cSituacaoAposentadoria == "APTO"
         nRenumeracaoAposentadoria += nValorSalarioBase * (0.03)
      endif

      if nValorSalarioBase >= nValorLimiteIrrf
         nRenumeracaoAposentadoria += nValorSalarioBase * (0.07)
      endif

      if cSituacaoAposentadoria == "APTO"
         @ 08,01 say "RENUMERACAO APOSENTADORIA: " + Alltrim(Transform(nRenumeracaoAposentadoria,"999999.99"))
      endif

      if cSituacaoAposentadoria == "APTO"
         nQuantidadeAposentados++
         nTotalRenumeracaoAposentado += nRenumeracaoAposentadoria
      endif

      if nIdadeColaborador >= 82 .and. cSexoColaborador == "M"
         nQuantidadeHomem82++
      endif

      if cSexoColaborador == "F"
         nQuantidadeMulher++
      endif

      if cSexoColaborador == "F" .and. Year(dAdmissao) < 2002
         nQuantidadeMulher02++
      endif

      if cSexoColaborador == "F" .and. cSituacaoIrrf == "PAGA"
         nQuantidaeMulherPagaIrrf++
      endif


      nQuantidadeColaboradores++

      inkey(0)
   enddo

   if nOpcaoColaborador == 1
      loop
   endif

   clear

   set color to " GR+ / N+ ", " GR+ / N+ "

   @ 00,00 to 08,79

   @ 01,26 say "DASHBOARD CONTROLE INSS"

   @ 02,01 to 02,78

   nMediaAposentados := (nQuantidadeAposentados / nQuantidadeColaboradores) * 100
   nMediaMulherIrrf  := (nQuantidaeMulherPagaIrrf / nQuantidadeMulher) * 100

   @ 03,10 say "PERCENTUAL HOMEM E MULHER APOSENTADOS...........: " + Alltrim(Transform(nMediaAposentados,"999.99")) + " % "
   @ 04,10 say "VALOR TOTAL RENUMERACAO APOSENTADOS.............: R$" + Alltrim(Transform(nTotalRenumeracaoAposentado, "999999.99"))
   @ 05,10 say "QUANTIDADE HOMEM COM IDADE SUPERIOR A 82 ANOS...: " + Alltrim(Transform(nQuantidadeHomem82,"9999")) + " HOMENS."
   @ 06,10 say "QUANTIDADE MULHER ADMITIDAS ANTES DO ANO DE 2002: " + Alltrim(Transform(nQuantidadeMulher02, "9999")) + " MULHERES."
   @ 07,10 say "PERCENTUAL DE MULHERES QUE PAGAM IRRF...........: " + Alltrim(Transform(nMediaMulherIrrf, "9999")) + " % "

   inkey(0)
   exit
enddo

