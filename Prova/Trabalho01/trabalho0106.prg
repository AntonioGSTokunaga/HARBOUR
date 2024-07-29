//KETHELLIN PEREIRA DA SILVA
set date to brit
set epoch to 1940
set scoreboard off
set color to "n/w"
clear

do while .t.
   nQuantidadeEmpregados          := 0
   nTotalRemuneracao              := 0
   nContador                      := 1
   nQuantidadeMulheres            := 0
   nQuantidadeHomens              := 0
   nMulheresAdmitidasAntes2002    := 0
   nMulheresPagamIrrf             := 0
   nHomensMais82                  := 0
   nOpcao                         := 0
   nQuantidadeNaoApto             := 0

   @ 01,30 say "CONTROLE DE INSS"
   @ 02,01 SAY replicate("-",60)

   @ 03,02 say "Digite a quantidade de empregados a serem analisados: "

   @ 03,56 get nQuantidadeEmpregados picture "999" valid nQuantidadeEmpregados > 0
   read

   if LastKey() == 27
      nAlerta := Alert("Deseja sair?", {"Sim", "Nao"})
      if nAlerta == 1
         exit
      else
         loop
      endif
   endif

   do while nContador <= nQuantidadeEmpregados

      @ 04,02 say "Quantidade de empregados digitados: " + Alltrim(Str(nContador - 1))

      cNomeColaborador        := Space( 20 )
      cSexo                   := Space( 1 )
      dNascimento             := CToD( "" )
      dAdmissao               := CToD( "" )
      dDemissao               := CToD( "" )
      nSalarioBase            := 0
      nSalarioFinal           := 0
      nLimiteIrrf             := 0
      nAdicionalNoturno       := 0
      nAdicionalInsalubridade := 0
      cSituacaoAposentar      := "Nao apto"

      @ 06,02 say "Nome.............:"
      @ 06,41 say "Sexo:"
      @ 07,02 say "Data nascimento..:"
      @ 07,31 say "Data admissao:"
      @ 07,55 say "Data demissao:"
      @ 08,02 say "Salario base.....:"
      @ 08,31 say "Limite IRRF............:"
      @ 09,02 say "Adicional noturno:"
      @ 09,31 say "Adicional insalubridade:"

      @ 06,20 get cNomeColaborador        picture "@!"           valid !empty(cNomeColaborador)
      @ 06,46 get cSexo                   picture "@!"           valid cSexo $ "FM"
      @ 07,20 get dNascimento                                    valid Year(dNascimento) < Year(Date()) - 18
      @ 07,46 get dAdmissao                                      valid Year(dAdmissao) > Year(dNascimento) + 18 .and. dAdmissao <= Date()
      @ 07,69 get dDemissao                                      valid dDemissao >= dAdmissao .and. dDemissao <= Date()
      @ 08,20 get nSalarioBase            picture "@E 99,999.99" valid nSalarioBase > 0
      @ 08,57 get nLimiteIrrf             picture "@E 99,999.99" valid nLimiteIrrf > 0
      @ 09,20 get nAdicionalNoturno       picture "999"          valid nAdicionalNoturno >= 0 .and. nAdicionalNoturno <= 100
      @ 09,57 get nAdicionalInsalubridade picture "999"          valid nAdicionalInsalubridade >= 0 .and. nAdicionalInsalubridade <= 100
      read

      if LastKey() == 27
         nAlerta := Alert("Deseja:", {"Cancelar", "Retornar", "Processar"}, "n/g")

         if nAlerta == 1
            nOpcao := Alert("Deseja cancelar?", {"Sim", "Nao"})
            if nOpcao == 1
               exit
            else
               loop
            endif
         elseif nAlerta == 2
            loop
         elseif nAlerta == 3
            exit
         endif

      endif

      nDiaHoje := Day(Date())
      nMesHoje := Month(Date())
      nAnoHoje := Year(Date())

      //anos trabalhado
      nDiaAdmissao := Day(dAdmissao)
      nMesAdmissao := Month(dAdmissao)
      nAnoAdmissao := Year(dAdmissao)

      nDiaDemissao := Day(dDemissao)
      nMesDemissao := Month(dDemissao)
      nAnoDemissao := Year(dDemissao)

      nAnosTrabalhado := nAnoDemissao - nAnoAdmissao
      if (nMesAdmissao < nMesDemissao) .or. ((nMesAdmissao == nMesDemissao) .and. (nDiaAdmissao < nDiaDemissao))
         nAnosTrabalhado--
      endif

      //idade
      nDiaNascimento := Day(dNascimento)
      nMesNascimento := Month(dNascimento)
      nAnoNascimento := Year(dNascimento)

      nIdade := nAnoHoje - nAnoNascimento
      if (nMesNascimento > nMesHoje) .or. ((nMesHoje == nMesNascimento) .and. (nDiaNascimento > nDiaHoje))
         nIdade--
      endif

      //condicao para aposentar
      if cSexo == "M"

         if nIdade > 82
            nHomensMais82++
         endif

         if nIdade > 60 .and. nAnosTrabalhado > 28
            nQuantidadeHomens++
            cSituacaoAposentar := "Apto"
         endif
      elseif cSexo == "F"

         if nAnoAdmissao < 2002
            nMulheresAdmitidasAntes2002++
         endif

         if nIdade > 57 .and. nAnosTrabalhado > 21
            nQuantidadeMulheres++
            cSituacaoAposentar := "Apto"
         endif

      endif

      //calculo salario
      nSalarioFinal := nSalarioBase
      nSalarioFinal += nSalarioBase * nAdicionalNoturno / 100
      nSalarioFinal += nSalarioBase * nAdicionalInsalubridade / 100

      if cSituacaoAposentar == "Apto"
         if nAnoAdmissao <= 2009 .and. nAnoDemissao >= 2012
            nSalarioFinal += nSalarioBase * 0.09
         endif

         if nAnoAdmissao <= 2015 .and. nAnoDemissao >= 2018
            nSalarioFinal -= nSalarioBase * 0.03
         endif

         if nSalarioFinal > nLimiteIrrf
            nSalarioFinal += nSalarioBase * 0.07
         endif

         nTotalRemuneracao += nSalarioFinal
      else
         if nSalarioFinal > nLimiteIrrf
            nSalarioFinal += nSalarioBase * 0.07
         endif

         nQuantidadeNaoApto++
      endif

      nContador++
   enddo

   if nOpcao == 1
      clear
      loop
   endif

   @ 11,02 say "Mulheres aposentadas...............: "    + Alltrim(Str(nQuantidadeMulheres * 100 / (nContador - 1))) + " %"
   @ 12,02 say "Homens aposentados.................: "    + Alltrim(Str(nQuantidadeHomens * 100 / (nContador - 1)))   + " %"
   @ 13,02 say "Homens +82.........................: "    + Alltrim(Str(nHomensMais82))
   @ 14,02 say "Mulheres admitidas antes de 2002...: "    + Alltrim(Str(nMulheresAdmitidasAntes2002))
   @ 15,02 say "Mulheres que pagam IRRF............: "    + Alltrim(Str(nMulheresPagamIrrf))
   @ 16,02 say "Total remuneracao..................: R$ " + Alltrim(Transform(nTotalRemuneracao, "@E 999,999,999.99"))
   @ 17,02 say "Colaboradores nao aptos a aposentar: "    + Alltrim(Str(nQuantidadeNaoApto))

   @ 20,02 say "Pressione qualquer tecla para realizar outra analise..."
   Inkey( 0 )
   clear
enddo
