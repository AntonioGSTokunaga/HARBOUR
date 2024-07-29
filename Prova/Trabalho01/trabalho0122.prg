//Bruno kenji guedes nakashima

set scoreboard off
set date to british
set epoch to 1940

clear

cNome                := Space (15)
cSexo                := Space (1)
dHoje                := Date ()

nEmpregados          := 0
nIdade               := 0
nTrabalhado          := 0
nAposentadoM         := 0
nAposentadoF         := 0
nContador            := 0
nTotalRemuneracao    := 0
nAcimaDeOitenta      := 0
nMulherIrrf          := 0
nMulherAdmitidaAntes := 0
nMulher              := 0
nHomem               := 0

@ 00,35 say 'CONTROLE_INSS.'

@ 00,01 say 'Numero de Empregados:'

@ 00,22 get nEmpregados        valid nEmpregados > 0
read

do while nContador < nEmpregados

   cNome                   := Space (15)
   cSexo                   := Space (1)
   dNascimento             := CtoD  ( ' ' )
   dAdmissao               := CtoD  ( ' ' )
   dDemissao               := CtoD  ( ' ' )
   nSalario                := 0
   nSalarioBase            := 0
   nValorLimiteIrrf        := 0
   nAdicionalNoturno       := 0
   nAdicionalInsalubridade := 0
   dHoje                   := Date ()

   nIdade                  := 0
   nTrabalhado             := 0

   @ 01,01 say 'Nome:'
   @ 01,23 say 'Sexo M/F'
   @ 01,34 say 'Data de Nascimento:'
   @ 02,01 say 'Data Admissao:'
   @ 02,25 say 'Data Demissao'
   @ 03,01 say 'Adicional Noturno(%)'
   @ 04,01 say 'Adicional Insalubridade:(%)'

   @ 01,06 get cNome                   picture '@!' valid !Empty (cNome)
   @ 01,32 get cSexo                   picture '@!' valid cSexo  $ 'MF'
   @ 01,54 get dNascimento                          valid dNascimento < dHoje
   @ 02,16 get dAdmissao                            valid dAdmissao   < dHoje
   @ 02,40 get dDemissao                            valid dDemissao   <= dHoje
   @ 03,21 get nAdicionalNoturno       picture '99' valid nAdicionalNoturno >= 0
   @ 04,30 get nAdicionalInsalubridade picture '99' valid nAdicionalInsalubridade >= 0
   nContador += 1
   read

   nIdade      := Year (dHoje) - Year (dNascimento)
   nTrabalhado := Year (dDemissao ) - Year (dAdmissao)

   if cSexo == 'M'
      nHomem += 1
   endif

   if cSexo == 'F'
      nMulher += 1
   endif

   if nIdade >= 82 .and. cSexo == 'M'
      nAcimaDeOitenta += 1
   endif

   if cSexo == 'F' .and. Year (dAdmissao) < 2002
      nMulherAdmitidaAntes += 1
   endif

   if cSexo == 'M' .and. nIdade >= 61 .and. nTrabalhado >= 29
      nSalario := nSalarioBase * (nAdicionalNoturno / 100) + nSalarioBase * (nAdicionalInsalubridade / 100) - nSalarioBase
      nAposentadoM += 1
   endif

   if cSexo == 'F' .and. nIdade >= 58 .and. nTrabalhado >= 22
      nSalario := nSalarioBase * (nAdicionalNoturno / 100) + nSalarioBase * (nAdicionalInsalubridade / 100) - nSalarioBase
      nAposentadoF += 1
   endif

   if Year(dAdmissao) <= 09 .and. Year(dDemissao) <= 17
      nSalario += nSalarioBase * 0.09
   endif

   nTotalRemuneracao += nSalario - nSalarioBase

   if Year(dAdmissao) <= 15 .and. Year(dDemissao) >= 18
      nSalario -= nSalarioBase * 0.03
   endif

   if nSalario > nValorLimiteIrrf
      nSalario -= nSalarioBase * 0.07
      if cSexo == 'F'
         nMulherIrrf += 1
      endif
   endif

   if LastKey() == 27
     nOpcao := Alert('Voce quer sair do programa?' ,{'Cancelar', 'Retornar', 'Processar'})
       if nOpcao == 1
          exit
       elseif nOpcao == 2

       elseif nOpcao == 3
          exit
       endif
    endif

enddo


nAposentados := nAposentadoM + nAposentadoF
nMulherIrrf := (nMulherIrrf / nMulher) * 100
nAposentados := (nAposentados / nEmpregados) * 100

clear

@ 00,00 to 08,70
@ 02,01 to 02,69
@ 04,01 to 04,69
@ 06,01 to 06,69
@ 08,01 to 08,69

@ 01,01 say '% de Homens e Mulheres aposentados e Remunera‡ao total:'
@ 01,57 say nAposentados
@ 01,67 say nTotalRemuneracao

@ 03,01 say 'Homens acima de 82 anos:'
@ 03,27 say nAcimaDeOitenta
@ 05,01 say 'Mulheres admitidas antes de 2002:'
@ 05,35 say nMulherAdmitidaAntes
@ 07,01 say 'porcentual de mulhures que pagam irrf:'
@ 07,42 say nMulherIrrf

InKey( 0 )
