//Gabriel Ailton Romanini Pinto

set color to 'B/W+'

clear

set date to british
set epoch to 1940
set scoreboard off

do while .t.

   clear

   nQuantidadeAnalizar := 0
   dDataAtual          := Date()
   nAnoAtual           := year(dDataAtual)
   nMesAtual           := Month(dDataAtual)
   nDiaAtual           := Day(dDataAtual)
   nCont               := 0
   nOpcao              := 0
   nPessoasAposentadas := 0
   nMulheresIrrf       := 0
   nMulheresTotal      := 0
   nMulheres2002       := 0
   nHomens82           := 0
   nRemuneracao        := 0

   @ 00,00 say "bem vindo ao programa Controle_INSS"
   @ 01,00 say "insira quantos empregados serao analizados:"

   @ 01,43 get nQuantidadeAnalizar
   read

   if LastKey() == 27
      nOpcao := Alert("voce deseja sair ???",{'sim','nao',})
      if nOpcao = 1
         exit
      else
         loop
      endif
   endif

   do while nCont < nQuantidadeAnalizar

      nOpcao                  := 0
      cNomeColaborador        := Space(15)
      cSexoColaborador        := ' '
      dDataNascimento         := CToD('')
      dDataAdmissao           := CToD('')
      dDataDemissao           := CToD('')
      nSalarioBase            := 0
      nLimiteIrrf             := 0
      nAdicionalNoturno       := 0
      nAdicionalInsalubridade := 0
      nAposentado             := 0

      @ 03,00 clear to 06,79

      @ 03,00 say "insira os dados do " + ALLTrim(STR(nCont+1)) + " Empregado"
      @ 04,00 say "nome:                Sexo[M/F]:   data Nascimento: "
      @ 05,00 say "data admissao:         data demissao:          Salario Base:"
      @ 06,00 say "Limite IRRF:            adicional [noturno:   %  insalubridade:   %"

      @ 04,05 get cNomeColaborador        Picture '@!'            Valid !Empty(cNomeColaborador)
      @ 04,31 get cSexoColaborador        Picture '@!'            Valid !Empty(cSexoColaborador) .and. cSexoColaborador $ 'MF'
      @ 04,50 get dDataNascimento                                 Valid !Empty(dDataNascimento)  .and. dDataNascimento < dDataAtual
      @ 05,14 get dDataAdmissao                                   Valid !Empty(dDataAdmissao)    .and. dDataAdmissao < dDataAtual
      @ 05,37 get dDataDemissao                                   Valid !Empty(dDataDemissao)    .and. dDataDemissao < dDataAtual
      @ 05,60 get nSalarioBase            Picture '@e 999,999.99' Valid !Empty(nSalarioBase)
      @ 06,12 get nLimiteIrrf             Picture '@e 999,999.99' Valid !Empty(nLimiteIrrf)
      @ 06,43 get nAdicionalNoturno       Picture '999'           Valid nAdicionalNoturno >= 0
      @ 06,63 get nAdicionalInsalubridade Picture '999'           Valid nAdicionalInsalubridade >= 0
      read



      if LastKey() == 27
         nOpcao := Alert("oque deseja fazer?",{'Cancelar','Retornar','Processar'})
         if nOpcao = 1 .or. nOpcao = 3
            exit
         else
            loop
         endif
      endif

      nCont++

      nIdadeAno := Year(dDataNascimento)
      nIdadeMes := Month(dDataNascimento)
      nIdadeDia := Day(dDataNascimento)

      nIdadeAno :=nAnoAtual - nIdadeAno
      nIdadeMes :=nMesAtual - nIdadeMes
      nIdadeDia :=nDiaAtual - nIdadeDia



      if nIdadeDia < 0
         nIdadeMes--
      endif

      if nIdadeMes <0
         nIdadeAno--
      endif



      nAnoAdmisao := Year(dDataAdmissao)
      nMesAdmisao := Month(dDataAdmissao)
      nDiaAdmisao := Day(dDataAdmissao)

      nAnoDemisao := Year(dDataDemissao)
      nMesDemisao := Month(dDataDemissao)
      nDiaDemisao := Day(dDataDemissao)

      nAnoTrabalhado := nAnoDemisao - nAnoAdmisao
      nMesTrabalhado := nMesDemisao - nMesAdmisao
      nDiaTrabalhado := nDiaDemisao - nDiaAdmisao


      if nDiaTrabalhado < 0
         nMesTrabalhado--
      endif

      if nMesTrabalhado <0
         nAnoTrabalhado--
      endif



      if cSexoColaborador == 'M' .and. nIdadeAno >= 61 .and. nAnoTrabalhado >= 29
         nAposentado := 1

      elseif cSexoColaborador == 'F' .and. nIdadeAno >= 58 .and. nAnoTrabalhado >= 22
         nAposentado := 1

      endif

      if nAposentado = 1



         nPessoasAposentadas++

         nAposentadoria := nSalarioBase

         nAposentadoria += (nSalarioBase / 100) * nAdicionalNoturno

         nAposentadoria += (nSalarioBase / 100) * nAdicionalInsalubridade

         if nAnoAdmisao < 2009 .and. nAnoDemisao > 2012
            nAposentadoria += (nSalarioBase / 100) * 9
         endif

         if nAnoAdmisao < 2015 .and. nAnoDemisao > 2018
            nAposentadoria -= (nSalarioBase / 100) * 3
         endif

         if nAposentadoria >= nLimiteIrrf
            nAposentadoria -= (nSalarioBase / 100) * 7

            if cSexoColaborador == 'F'
               nMulheresIrrf++
            endif

         endif

         nRemuneracao += nAposentadoria

      else



         nSalario := nSalarioBase

         nSalario += (nSalarioBase / 100) * nAdicionalNoturno

         nSalario += (nSalarioBase / 100) * nAdicionalInsalubridade

         if nSalario >= nLimiteIrrf
            nSalario -= (nSalarioBase / 100) * 7

            if cSexoColaborador == 'F'
               nMulheresIrrf++
            endif

         endif



      endif

      if cSexoColaborador == 'M' .and. nIdadeAno > 82
         nHomens82++
      elseif cSexoColaborador == 'F'
         nMulheresTotal++
            if nAnoAdmisao < 2002
               nMulheres2002++
            endif
      endif

   enddo

   if nOpcao =1
      loop
   endif

   nPercentualAPosentados := (100 / nCont) * nPessoasAposentadas

   @ 07,00 to 07,79

   if nPessoasAposentadas > 0
      @ 08,00 say "o Percentual de Homens e mulheres aposentados foi de " + ALLTrim(STR(nPercentualAPosentados)) + "%"
      @ 09,00 say "e o total de remuneracao que else receberam foi de " + ALLTrim(Transform(nRemuneracao,'@e 999,999,999.99'))
   else
      @ 08,00 say "nÆo houveram homens nem mulheres aposentados"
   endif

   if nHomens82 > 0
      @ 10,00 say "houve um total de " + ALLTrim(STR(nHomens82)) + " homens com mais de 82 anos"
   else
      @ 10,00 say "nao houveram homens com mais de 82 anos"
   endif

   if nMulheres2002 > 0
      @ 11,00 say "houve um total de " + ALLTrim(STR(nMulheres2002)) + " mulheres contratadas antes de 2002"
   else
      @ 11,00 say "nao houveram mulheres contratadas antes de 2002"
   endif

   if nMulheresIrrf > 0
      nPercentualMulheresIRRF := (100 / nMulheresTotal) * nMulheresIrrf
      @ 12,00 say "o percentual de mulheres que pagam IRRF foi de " + ALLTrim(Str(nPercentualMulheresIRRF)) + "%"
   else
      @ 12,00 say "nao houveram mulheres que pagam o IRRF"
   endif

   @ 15,00 say "prescione qualquer tecla para contiinuar"
   inkey(0)

enddo

@ 23,00 say ''


