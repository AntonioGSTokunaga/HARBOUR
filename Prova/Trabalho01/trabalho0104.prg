/*
ALUNO: LUCAS ANTONIO GUANDALIN
TRABALHO: CONTROLE INSS
*/


Clear

set date to british
set epoch to 1940
set scoreboard off


dHoje                       := Date()

nNumeroEmpregados           := 0
nFuncionariosDigitados      := 0

nHomensAptos                := 0
nMulheresAptas              := 0
nHomensDigitados            := 0
nMulheresdigitadas          := 0

nTotalRemuneracaoHomem      := 0
nTotalRemuneracaoMulher     := 0

nPercentualHomemAposentado  := 0
nPercentualMulherAposentada := 0
nPercentualMulherPagaIrrf   := 0

nHomemSuperior82anos        := 0
nMulherAdmissaoAntes2002    := 0
nMulheresPagaIRRF           := 0

lDigitandoFuncionario       := .t.

@ 00, 00 say "NUMERO DE EMPREGADOS:"
@ 00, 22 get nNumeroEmpregados      picture "999"
read

do while lDigitandoFuncionario
   cNome             := Space(20)
   cSexo             := Space(1)
   dNascimento       := Ctod("")
   dAdmissao         := Ctod("")
   dDemissao         := Ctod("")
   nSalarioBase      := 0
   nLimiteIRRF       := 0
   nAdcNoturno       := 0
   nAdcInsalubridade := 0

  //se o salario total maior que o limite irrf reduzir 7%
  //sempre em cima do salario base

   @ 02, 00 say "EMPREGADO: " + Alltrim(Str(nFuncionariosDigitados + 1))
   @ 04, 01 say "NOME DO FUNCIONARIO..........:"
   @ 05, 01 say "SEXO(M/F)....................:"
   @ 06, 01 say "NASCIMENTO...................:"
   @ 07, 01 say "DATA DE ADMISSAO.............:"
   @ 08, 01 say "DATA DE DEMISSAO.............:"
   @ 09, 01 say "SALARIO BASE.................:"
   @ 10, 01 say "LIMITE DO IRRF...............:"
   @ 11, 01 say "ADICIONAL NOTURNO(%).........:"
   @ 12, 01 say "ADICIONAL DE INSALUBRIDADE(%):"

   @ 04, 32 get cNome                 picture "@!"
   @ 05, 32 get cSexo                 picture "@!"          valid cSexo $ "MF"
   @ 06, 32 get dNascimento                                 valid !Empty(dNascimento) .and. dNascimento < Date()
   @ 07, 32 get dAdmissao                                   valid !Empty(dAdmissao)   .and. dAdmissao   < Date()
   @ 08, 32 get dDemissao                                   valid !Empty(dDemissao)   .and. dDemissao   >= dAdmissao
   @ 09, 32 get nSalarioBase          picture "9999.99"     valid nSalarioBase       > 0
   @ 10, 32 get nLimiteIRRF           picture "9999.99"     valid nLimiteIRRF        > 0
   @ 11, 32 get nAdcNoturno           picture "99"          valid nAdcNoturno        >= 0
   @ 12, 32 get nAdcInsalubridade     picture "99"          valid nAdcInsalubridade  >= 0
   read

   if LastKey() == 27
       nOpcao := Alert("Deseja:", {"Cancelar", "Retornar", "processar"})
       if nOpcao == 1
           exit
       elseif nOpcao == 2
           loop
       elseif nOpcao == 3
           lDigitandoFuncionario := .f.
       else
           loop
       endif
   endif

   nNascimentoDia := Day(dNascimento)
   nNascimentoMes := Month(dNascimento)
   nNascimentoAno := Year(dNascimento)

   nDiaAtual       := Day(dHoje)
   nMesAtual       := Month(dHoje)
   nAnoAtual       := Year(dHoje)

   nAdmissaoDia  := Day(dAdmissao)
   nAdmissaoMes  := Month(dAdmissao)
   nAdmissaoAno  := Year(dAdmissao)

   nDemissaoDia  := Day(dDemissao)
   nDemissaoMes  := Month(dDemissao)
   nDemissaoAno  := Year(dDemissao)

   nIdade := nAnoAtual - nNascimentoAno
   if (nMesAtual < nNascimentoMes) .or. (nMesAtual == nNascimentoMes .and. nDiaAtual < nNascimentoDia)
       nIdade -= 1
   endif

   nTrabalhado := nDemissaoAno - nAdmissaoAno
   if (nDemissaoMes < nAdmissaoMes) .or. (nDemissaoMes == nAdmissaoMes .and. nDemissaoDia < nAdmissaoDia)
     nTrabalhado -= 1
   endif

   if (cSexo == "M" .and. nIdade >= 61 .and. nTrabalhado >= 29) .or. (cSexo == "F" .and. nIdade >= 58 .and. nTrabalhado >= 22)
      //Salario total + adcionais noturno e Insalubridade
      nSalarioTotal := nSalarioBase + (nSalarioBase * (nAdcNoturno / 100)) + (nSalarioBase * (nAdcInsalubridade / 100))

      //Adicional de trabalho entre 2009 e 2013
      if nAdmissaoAno <= 2009 .and. nDemissaoAno >= 2012
         nSalarioTotal += nSalarioBase * 0.09
      endif

      //Reducao de trabalho entre 2015 e 2018
      if nAdmissaoAno <= 2015 .and. nDemissaoAno >= 2018
         nSalarioTotal -= nSalarioBase * 0.03
      endif

      //Reducao caso atinge o limite de IRRF
      if nSalarioTotal >= nLimiteIRRF
         nSalarioTotal -= nSalarioBase * 0.07
      endif

      if cSexo == "M"
         nHomensAptos++
         nTotalRemuneracaoHomem += nSalarioTotal
      else
         nMulheresAptas++
         nTotalRemuneracaoMulher += nSalarioTotal
         if nSalarioTotal >= nLimiteIRRF
            nMulheresPagaIRRF++
         endif
      endif

   endif

   if cSexo == "M"
      nHomensDigitados++
      if nIdade > 82
         nHomemSuperior82anos++
      endif
   else
      nMulheresdigitadas++
      if nAdmissaoAno < 2002
         nMulherAdmissaoAntes2002++
      endif
   endif

   nFuncionariosDigitados++

   if nFuncionariosDigitados == nNumeroEmpregados
      lDigitandoFuncionario := .f.
   endif

enddo

nPercentualHomemAposentado  := (nHomensAptos * 100) / nFuncionariosDigitados
nPercentualMulherAposentada := (nMulheresAptas * 100) / nFuncionariosDigitados
nPercentualMulheresPagaIRRF := (nMulheresPagaIRRF * 100) / nMulheresAptas
nTotalRemuneracaoSomados    := nTotalRemuneracaoHomem + nTotalRemuneracaoMulher

@ 15, 01 say "PORCENTAGEM DE HOMENS APOSENTADOS.....: " + Alltrim(Str(nPercentualHomemAposentado))
@ 16, 01 say "REMUNERACAO TOTAL DOS HOMENS..........: " + Alltrim(Str(nTotalRemuneracaoHomem))
@ 17, 01 say "PORCENTAGEM DE MULHERES APOSENTADOS...: " + Alltrim(Str(nPercentualMulherAposentada))
@ 18, 01 say "REMUNERACAO TOTAL DOS HOMENS..........: " + Alltrim(Str(nTotalRemuneracaoMulher))
@ 19, 01 say "REMUNERACAO TOTAL SOMADOS.............: " + Alltrim(Str(nTotalRemuneracaoSomados))
@ 20, 01 say "HOMENS COM IDADE SUPERIOR A 82 ANOS...: " + Alltrim(Str(nHomemSuperior82anos))
@ 21, 01 say "MULHERES ADMITIDAS ANTES DO ANO 2002..: " + Alltrim(Str(nMulherAdmissaoAntes2002))
@ 22, 01 say "PORCENTAGEM DE MULHERES QUE PAGAM IRRF: " + Alltrim(Str(nMulherAdmissaoAntes2002))



