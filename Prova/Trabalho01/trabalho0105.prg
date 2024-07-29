Clear

set date to british
set epoch to 1940
set scoreboard off


   cMascara                   := "@!"
   nMascaraNumero             := "99"
   nMascaraValores            := "999999.99"
   nNumeroEmpregados          := 0
   dHoje                      := Date()
   nHomensAptos               := 0
   nHomens                    := 0
   nSalarioTotalHomens        := 0
   nMulheresAptas             := 0
   nMulheres                  := 0
   nSalarioTotalMulheres      := 0
   nHomensIdosos              := 0
   nMulheresAntesDoisMileDois := 0
   nMulheresPagantesIRRF      := 0
   lProcessar                 := .f.

do while .t.
   @ 01,01 say "Numero de empregados a serem analizados"
   @ 01,40 get nNumeroEmpregados picture nMascaraNumero valid nNumeroEmpregados > 0
   read

   if LastKey() == 27
        nOpcao := Alert("Deseja:", {"Sair", "Retornar"})
        if nOpcao == 1
            exit
        elseif nOpcao == 2
            loop
        endif
   endif

   nContador := 1
   do while lProcessar == .f.
       cNome             := Space( 20 )
       cSexo             := Space( 1 )
       dNascimento       := Ctod( ' ' )
       dAdmissao         := Ctod( ' ' )
       dDemissao         := Ctod( ' ' )
       nSalarioBase      := 0
       nSalarioCalculado := 0
       nLimiteIRRF       := 0
       nAdcNoturno       := 0
       nAdcInsalubridade := 0

       @ 04,01 say "Digite o nome do funcionario.....................:"
       @ 05,01 say "Digite o sexo F Feminino e M Masculino...........:"
       @ 06,01 say "Digite a data de nascimento......................:"
       @ 07,01 say "Digite a data de admissao........................:"
       @ 08,01 say "Digite a data de desmissao.......................:"
       @ 09,01 say "Digite o valor do salario base...................:"
       @ 10,01 say "Digite o limite do IRRF..........................:"
       @ 11,01 say "Digite o Percentual do adicional noturno.........:"
       @ 12,01 say "Digite o Percentual do adicional de insalubridade:"

       @ 04,51 get cNome             Picture cMascara         Valid !empty( cNome )
       @ 05,51 get cSexo             Picture cMascara         Valid cSexo $ "FM"
       @ 06,51 get dNascimento                                Valid !empty( dNascimento )
       @ 07,51 get dAdmissao                                  Valid !empty( dAdmissao )
       @ 08,51 get dDemissao                                  Valid !empty( dDemissao )
       @ 09,51 get nSalarioBase      Picture  nMascaraValores Valid nSalarioBase       > 0
       @ 10,51 get nLimiteIRRF       Picture  nMascaraValores Valid nLimiteIRRF        > 0
       @ 11,51 get nAdcNoturno       Picture  nMascaraNumero  Valid nAdcNoturno        >= 0
       @ 12,51 get nAdcInsalubridade Picture  nMascaraNumero  Valid nAdcInsalubridade  >= 0
       read

       if LastKey() == 27
           nOpcao := Alert("Deseja:", {"Cancelar", "Retornar", "processar"})
           if nOpcao == 1
               exit
           elseif nOpcao == 2
               loop
           elseif nOpcao ==3
               lProcessar := .t.
           end if
       end if

       if cSexo == "M"
         nHomens++
       else
         nMulheres++
       endif

       nNascimentoDia := Day(dNascimento)
       nNascimentoMes := Month(dNascimento)
       nNascimentoAno := Year(dNascimento)

       nHojeDia := Day(dHoje)
       nHojeMes := Month(dHoje)
       nHojeAno := Year(dHoje)

       nAdmissaoDia  := Day(dAdmissao)
       nAdmissaoMes  := Month(dAdmissao)
       nAdmissaoAno := Year(dAdmissao)

       nDemissaoDia  := Day(dDemissao)
       nDemissaoMes  := Month(dDemissao)
       nDemissaoAno := Year(dDemissao)

       nIdade :=  nHojeAno - nNascimentoAno
       if (nHojeMes < nNascimentoMes) .or. (nHojeMes == nNascimentoMes .and. nHojeDia < nNascimentoDia )
           nIdade -= 1
       endif

       nTrabalhado := nDemissaoAno - nAdmissaoAno
       if (nDemissaoMes < nAdmissaoMes) .or. (nDemissaoMes == nAdmissaoMes .and. nDemissaoDia < nAdmissaoDia)
           nTrabalhado -= 1
       endif


       if (cSexo == "M" .and. nIdade >= 61 .and. nTrabalhado >= 29).or.( cSexo == "F" .and. nIdade >= 58 .and. nTrabalhado >= 22)
           nSalarioCalculado := nSalarioBase + ( nSalarioBase * ( nAdcNoturno / 100)) + ( nSalarioBase * ( nAdcInsalubridade /100))

           if nAdmissaoAno <= 2009 .and. nDemissaoAno >= 2012
              nSalarioCalculado += nSalarioBase * 0.09
           endif

           if nAdmissaoAno <= 2015 .and. nDemissaoAno >= 2018
              nSalarioCalculado -= nSalarioBase * 0.03
           endif

           if nSalarioCalculado >= nLimiteIRRF
               nSalarioCalculado -= nSalarioBase * 0.07
          endif

          if cSexo == "M"
             if nIdade > 82
               nHomensIdosos++
             endif
             nHomensAptos++
             nSalarioTotalHomens += nSalarioCalculado
          else
             nMulheresAptas++
             if nAdmissaoAno < 2002
               nMulheresAntesDoisMileDois++
             endif
             if nSalarioCalculado >= nLimiteIRRF
               nMulheresPagantesIRRF++
             endif
             nSalarioTotalMulheres += nSalarioCalculado
          endif
       endif

       nContador++
       if nContador > nNumeroEmpregados
         lProcessar := .t.
       endif
   enddo
nPercentualHomens   := ( nHomensAptos * 100 ) / nHomens
nPercentualMulheres := ( nMulheresAptas * 100) / nMulheres
nPercentualMulheresIRRF := (nMulheresPagantesIRRF * 100) / nMulheresAptas

@ 16,01 say "HOMENS APTOS.......................: " + AllTrim(STR(nPercentualHomens)) + " REMUNERACAO: " + AllTrim(STR(nSalarioTotalHomens))
@ 17,01 say "MULHERES APTAS.....................: " + AllTrim(STR(nPercentualMulheres)) + " REMUNERACAO: " +  AllTrim(STR(nSalarioTotalMulheres))
@ 18,01 say "HOMENS COM MAIS DE 82 ANOS.........: " + Alltrim(STR(nHomensIdosos))
@ 19,01 say "MULHERS ADMITIDAS ANTES DE 2002....: " + Alltrim(STR(nMulheresAntesDoisMileDois))
@ 20,01 say "PERCENTUAL DE MULHES QUE PAGAM IRRF: " + Alltrim(STR(nPercentualMulheresIRRF))
enddo





