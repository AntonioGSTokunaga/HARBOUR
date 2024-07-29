//Vinicius Yatsuda Brescansin

set date to british
set epoch to 1940
set scoreboard off
set color to "N/W"

clear

do while .t.

   nEmpregados := 0
   nContador   := 0
   nOpcao := 0

   nPercentualHomen  := 0
   nPercentualMulher := 0
   nPercentualTotal  := 0

   nIdadeMaior82 := 0

   nMulheresIRRF := 0

   @ 01,01 say "Bem Vindo ao Programa de Controle INSS"
   @ 02,01 say "Quantos empregados gostaria de analisar?"

   @ 02,45 get nEmpregados picture "999" valid nEmpregados > 0
   read

   if LastKey() == 27
      nOpcao = Alert('Oque deseja fazer?',{'Cancelar','Retornar'})

      if nOpcao = 1
         exit
      elseif nOpcao = 2
         loop
      endif
   endif

   InKey(0)

   clear

   do while nContador < nEmpregados

      cNome                   := Space ( 30 )
      cSexo                   := Space ( 1  )
      dNascimento             := CToD("")
      dAdmissao               := CToD("")
      dDemissao               := CToD("")
      nSalarioBase            := 0
      nIRRF                   := 0
      nAdicionalNoturno       := 0
      nAdicionalInsalubridade := 0

      nOpcao1                 := 5

      cMaskSalarioBase := "@E 99999.99"
      cMaskAdicionais  := "999"
      cMaskMaiusculo   := "@!"
      cMaskRemuneracao := "@E 99999.99"

      @ 01,01 say "Nome....................:"
      @ 02,01 say "Sexo....................:"
      @ 03,01 say "Nascimento..............:"
      @ 04,01 say "Data de Admissao........:"
      @ 05,01 say "Data de Demissao........:"
      @ 06,01 say "Valor do Salario........:"
      @ 07,01 say "IRRF....................:"
      @ 08,01 say "Adicional Noturno.......:"
      @ 09,01 say "Adicional Insalubridade.:"

      @ 01,28 get cNome                      picture cMaskMaiusculo      valid !Empty(cNome)
      @ 02,28 get cSexo                      picture cMaskMaiusculo      valid cSexo $ "MF"
      @ 03,28 get dNascimento                                            valid !Empty(dNascimento)
      @ 04,28 get dAdmissao                                              valid !Empty(dAdmissao) .and. dAdmissao > dNascimento
      @ 05,28 get dDemissao                                              valid !Empty(dDemissao) .and. dDemissao > dAdmissao
      @ 06,28 get nSalarioBase               picture cMaskSalarioBase    valid !Empty(nSalarioBase)
      @ 07,28 get nIRRF                      picture cMaskSalarioBase    valid !Empty(nIRRF)
      @ 08,28 get nAdicionalNoturno          picture cMaskAdicionais     valid !Empty(nAdicionalNoturno)
      @ 09,28 get nAdicionalInsalubridade    picture cMaskAdicionais     valid !Empty(nAdicionalInsalubridade)
      read

      nContador++

      if LastKey() == 27
         nOpcao1 = Alert('Oque deseja fazer?',{'Cancelar','Retornar','Processar'})

         if nOpcao1 = 1
            clear
            exit
         elseif nOpcao1 = 2
            clear
            loop
         elseif nOpcao1 = 3
            clear
            exit
         endif
      endif

      nRemuneracaoAposentado := nSalarioBase

      nIdade := date() - dNascimento
      nIdade := nIdade/365

      nDiasTrabalhados := dDemissao - dAdmissao
      nAnosTrabalhados := nDiasTrabalhados/365

      if nIdade > 61 .and. cSexo = "M" .and. nAnosTrabalhados >= 29
         @ 11,01 say "VALIDO PARA RECEBER APOSENTADORIA"
         nPercentualHomen++
      elseif nIdade > 58 .and. cSexo = "F" .and. nAnosTrabalhados >= 22
         @ 11,01 say "VALIDO PARA RECEBER APOSENTADORIA"
         nPercentualMulher++
      else
         @ 11,01 say "Nao esta apto a receber aposentadoria"
      ENDIF

      nRemuneracaoAposentado += ( nSalarioBase * ( 1 + (nAdicionalNoturno/100))) - nSalarioBase

      nRemuneracaoAposentado += ( nSalarioBase * ( 1 + (nAdicionalInsalubridade/100))) - nSalarioBase

      if Year(dAdmissao) < 2009 .and. Year(dDemissao) > 2012
         nRemuneracaoAposentado += ( nSalarioBase * 1.09 ) - nSalarioBase
      endif

      if Year(dAdmissao) < 2015 .and. Year(dDemissao) > 2018
         nRemuneracaoAposentado += ( nSalarioBase * 0.97 ) - nSalarioBase
      endif

      if nIdade > 61 .and. cSexo = "M" .and. nAnosTrabalhados >= 29
         @ 12,01 say "O salario eh : " +  AllTrim(Transform (nRemuneracaoAposentado,cMaskRemuneracao))
      elseif nIdade > 58 .and. cSexo = "F" .and. nAnosTrabalhados >= 22
         @ 12,01 say "O salario eh : " + AllTrim(Transform (nRemuneracaoAposentado,cMaskRemuneracao))
      endif

      if ( nRemuneracaoAposentado >= nIRRF .and. nIdade > 61 .and. cSexo = "M" .and. nAnosTrabalhados >= 29 ) .or. ( nRemuneracaoAposentado >= nIRRF .and. nIdade > 58 .and. cSexo = "F" .and. nAnosTrabalhados >= 22 )
         nRemuneracaoAposentado += ( nSalarioBase * 0.93 ) - nSalarioBase
         @ 13,01 say "Renda maior que o IRRF, salario tributavel"
         @ 14,01 say "Salario apos tributos eh :"
         @ 14,45 say nRemuneracaoAposentado
         if cSexo = "F"
            nMulheresIRRF++
         endif
      endif

      InKey(0)

      if nIdade > 82 .and. cSexo = "M"
         nIdadeMaior82++
      endif

      clear

   enddo

   if nOpcao1 == 1
      clear
      exit
   endif

   nPercentualTotal += nPercentualHomen + nPercentualMulher

   cMaskPorcentagem := "@E 999.9"

   @ 01,01 say "O percentual de Homens eh..................: " + AllTrim(transform((nPercentualHomen *  100/nPercentualTotal),cMaskPorcentagem)) + " % "
   @ 02,01 say "O percentual de Mulheres eh................: " + AllTrim(transform((nPercentualMulher * 100/nPercentualTotal),cMaskPorcentagem)) + " % "
   @ 03,01 say "Existem " + AllTrim( transform (nIdadeMaior82,"999")) + " aposentados mais velhos que 82 anos"
   @ 04,01 say "O percentual de mulheres que pagam IRRF eh.: " + AllTrim(transform((nMulheresIRRF * 100/nPercentualMulher),cMaskPorcentagem))    + " % "



   InKey(0)

   clear

enddo
