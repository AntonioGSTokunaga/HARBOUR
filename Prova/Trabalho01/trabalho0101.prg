// Douglas Felix dos Santos Moreira

set epoch to 1940
set scoreboard off
set color to 'N/W+'

clear
@ 00,00 to 24,79 double

nPessoas              := 0
cNome                 := Space(20)
cSexo                 := ' '
dNascimento           := CToD('')
dAdmissao             := CToD('')
dDemissao             := CToD('')
nSalarioBase          := 0
nRemuneracao          := 0
nLimiteIRRF           := 0
nAddNoturno           := 0
nAddInsalubridade     := 0
nContador             := 1
nIdade                := 0
nAnoAdmissao          := 0
nAnoDemissao          := 0
nRemuneracaoTotal     := 0
nQuantidadeHomens     := 0
nQuantidadeMulheres   := 0
nHomensAposentados    := 0
nMulheresAposentadas  := 0
nHomensAcimaDe82      := 0
nMulheresAntesDe2002  := 0
nMulheresQuePagamIRRF := 0
lAposentado           := .f.
cMascaraTexto         := '@!'
cMascaraAlerta        := 'N/W'
cMascaraSalario       := '@E 9.999,99'
cMascaraRemuneracao   := '@E 999.999,99'

do while .t.
   @ 01,01 clear to 23,78
   @ 02,02 say 'N§ de pessoas a serem analisadas: '

   nPessoas := 0
   @ 02,36 get nPessoas picture '99'
   read

   if (LastKey() = 27)
      nOpcao := Alert('Tem certeza que deseja sair?', { 'Sim', 'Nao' }, cMascaraAlerta)
      if (nOpcao = 1)
         exit
      endif
   endif

   nContador := 1
   do while nContador < nPessoas + 1
      @ 04,01 clear to 23,78
      // desenho da caixa
      @ 03,01 to 15,48 color 'N/W'
      @ 05,03 say Replicate('Ä', 44)
      @ 04,03 say 'Analise ' + Alltrim(Str(nContador)) + '/' + AllTrim(Str(nPessoas))
      @ 06,03 say 'Nome.................:'
      @ 07,03 say 'Sexo (M/F)...........:'
      @ 08,03 say 'Nascimento...........:'
      @ 09,03 say 'Admissao.............:'
      @ 10,03 say 'Demissao.............:'
      @ 11,03 say 'Salario base.........:'
      @ 12,03 say 'Valor limite IRRF....:'
      @ 13,03 say 'Ad. noturno (%)......:'
      @ 14,03 say 'Ad. insalubridade (%):'

      cNome             := Space(20)
      cSexo             := ' '
      dNascimento       := CToD('')
      dAdmissao         := CToD('')
      dDemissao         := CToD('')
      nSalarioBase      := 0
      nLimiteIRRF       := 0
      nAddNoturno       := 0
      nAddInsalubridade := 0

      @ 06,27 get cNome             picture cMascaraTexto   valid !Empty(cNome)
      @ 07,27 get cSexo             picture cMascaraTexto   valid cSexo $ 'MF'
      @ 08,27 get dNascimento                               valid dNascimento < Date()
      @ 09,27 get dAdmissao                                 valid dAdmissao > dNascimento
      @ 10,27 get dDemissao                                 valid dDemissao < Date()
      @ 11,27 get nSalarioBase      picture cMascaraSalario valid nSalarioBase > 0
      @ 12,27 get nLimiteIRRF       picture cMascaraSalario valid nLimiteIRRF > 0
      @ 13,27 get nAddNoturno       picture '99'            valid nAddNoturno >= 0
      @ 14,27 get nAddInsalubridade picture '99'            valid nAddInsalubridade >= 0
      read

      if (LastKey() = 27)
         nOpcao := Alert('O que deseja fazer?', { 'Cancelar', 'Retornar', 'Processar' }, cMascaraAlerta)
         if (nOpcao = 1)
            nContador = 1
            exit
         elseif (nOpcao = 3)
            exit
         endif
      endif

      nIdade        := Year(Date()) - Year(dNascimento)
      nAnoAdmissao  := Year(dAdmissao)
      nAnoDemissao  := Year(dDemissao)
      nAnosTrabalho := nAnoDemissao - nAnoAdmissao
      lAposentado   := .f.

      if (cSexo = 'M')
         nQuantidadeHomens++
         if (nIdade >= 61 .and. nAnosTrabalho >= 29)
            lAposentado := .t.
            nHomensAposentados++
         endif
         if (nIdade >= 82)
            nHomensAcimaDe82++
         endif
      elseif (cSexo = 'F')
         nQuantidadeMulheres++
         if (nIdade >= 58 .and. nAnosTrabalho >= 22)
            lAposentado := .t.
            nMulheresAposentadas++
         endif
         if (nAnoAdmissao < 2002)
            nMulheresAntesDe2002++
         endif
      endif

      if (lAposentado)
         nRemuneracao := nSalarioBase

         // trabalhou nos anos de 2009 ou 2012
         if ((nAnoAdmissao <= 2009 .and. nAnoDemissao >= 2009) .or. (nAnoAdmissao <= 2012 .and. nAnoDemissao >= 2012))
            nRemuneracao += nSalarioBase * 0.09
         endif
         // trabalhou nos anos de 2015 ou 2018
         if ((nAnoAdmissao <= 2015 .and. nAnoDemissao >= 2015) .or. (nAnoAdmissao <= 2018 .and. nAnoDemissao >= 2018))
            nRemuneracao -= nSalarioBase * 0.03
         endif
         // paga IRRF
         if (nRemuneracao > nLimiteIRRF)
            nRemuneracao -= nSalarioBase * 0.07
            if (cSexo = 'F')
               nMulheresQuePagamIRRF++
            endif
         endif

         nRemuneracao      += (nAddNoturno +  nAddInsalubridade) * nRemuneracao / 100
         nRemuneracaoTotal += nRemuneracao
      endif

      nContador++
   enddo

   // se o contador for 0, nenhuma pessoa foi analisada
   if (nContador > 1)
      @ 01,01 clear to 23,78
      @ 01,01 to 08,52 color 'N/W'
      @ 02,03 say 'Percentual de homens aposentados.....: '  + AllTrim(Transform(nHomensAposentados*100/nQuantidadeHomens, '999')) + '% '
      @ 03,03 say 'Percentual de mulheres aposentadas...: '  + AllTrim(Transform(nMulheresAposentadas*100/nQuantidadeMulheres, '999')) + '%'
      @ 04,03 say 'Total da remuneracao.................: $' + AllTrim(Transform(nRemuneracaoTotal, cMascaraRemuneracao))
      @ 05,03 say 'Quantidade de homens acima de 82 anos: '  + AllTrim(Str(nHomensAcimaDe82))
      @ 06,03 say 'Mulheres admitidades antes de 2002...: '  + AllTrim(Str(nMulheresAntesDe2002))
      @ 07,03 say 'Percentual de mulheres que pagam IRRF: '  + AllTrim(Transform(nMulheresQuePagamIRRF*100/nQuantidadeMulheres, '999')) + '% '

      @ 20,02 say 'Pressione qualquer tecla para continuar...'
      inkey(0)
   endif
enddo
