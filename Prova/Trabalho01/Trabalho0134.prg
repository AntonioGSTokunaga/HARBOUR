//LUCAS EDUARDO RIBEIRO

set color to '0/8'
set date to british
set epoch to 1940
set scoreboard off

clear

do while .t.
   nFuncionariosAnalisados := 0
   nEntradas := 0

   @ 01,02 say 'Quantos funcionarios serao analisados?'
   @ 01,50 get nFuncionariosAnalisados
   read

   if lastkey() == 27
      nOpcao := Alert( 'O que deseja fazer?' , { 'Cancelar' , 'Retornar' , } , 'G/B' )
      if nOpcao == 1
         exit
      endif
      Loop
   endif

   nHomens := 0
   nMulheres := 0
   nHomensAposentados := 0
   nMulheresAposentadas := 0
   nRemuneracaoTotalH := 0
   nRemuneracaoTotalM := 0
   nHomensVelhos := 0
   nMulheres2002 := 0
   nMulheresIRRF := 0
   nLinhas:= 1
   nOpcao := 3

   do while nEntradas++ < nFuncionariosAnalisados

      cNomeColaborador        := Space(30)
      cSexoColaborador        := Space(1)
      dNascimentoColaborador  := CTod('')
      dAdmissaoColaborador    := CToD('')
      dDemissaoColaborador    := CToD('')
      nValorSalarioBase       := 0
      nValorLimiteIRRF        := 0
      nAdcionalNoturno        := 0
      nAdicionalIsalubridade  := 0
      nLinha                  := nLinhas+1


      @ nLinha++,02 say ALLTrim( Str( nEntradas ) )+'§ colaborador: '
      @ nLinha++,02 say 'Nome..................:'
      @ nLinha++,02 say 'Nascimento............:'
      @ nLinha++,02 say 'Sexo..................:   [H]omem, [M]ulher'
      @ nLinha++,02 say 'Admissao..............:'
      @ nLinha++,02 say 'Demissao..............:'
      @ nLinha++,02 say 'Salario...............:'
      @ nLinha++,02 say 'Limite................:'
      @ nLinha++,02 say 'Adicional Noturno:....:'
      @ nLinha++,02 say 'Adicional Isalubridade:'

      nLinha := nLinhas+2//4

      @ nLinha++,26 get cNomeColaborador         picture '@!'   valid !Empty(cNomeColaborador)
      @ nLinha++,26 get dNascimentoColaborador                  valid !Empty(dNascimentoColaborador) .and. dNascimentoColaborador < Date()
      @ nLinha++,26 get cSexoColaborador         picture '@!'   valid cSexoColaborador == 'H' .or. cSexoColaborador == 'M'
      @ nLinha++,26 get dAdmissaoColaborador                    valid dAdmissaoColaborador > dNascimentoColaborador .and. dAdmissaoColaborador < Date()
      @ nLinha++,26 get dDemissaoColaborador                    valid dDemissaoColaborador > dAdmissaoColaborador .and. dDemissaoColaborador < Date()
      @ nLinha++,26 get nValorSalarioBase                       valid nValorSalarioBase > 0
      @ nLinha++,26 get nValorLimiteIRRF                        valid nValorLimiteIRRF > 0
      @ nLinha++,26 get nAdcionalNoturno
      @ nLinha++,26 get nAdicionalIsalubridade
      read

      if lastkey() == 27
         nOpcao := Alert( 'O que deseja fazer?' , { 'Cancelar' , 'Retornar' , 'Processar'} , 'G/B' )
         if nOpcao == 1 .or. nOpcao == 3
            nEntradas--
            exit
         elseif nOpcao == 2
            nEntradas--
            loop
         endif
      endif

     // nLinhas += 10
      nMesesTrabalhados := (dDemissaoColaborador - dAdmissaoColaborador)/30
      nSalarioTotal     := nValorSalarioBase*(nAdcionalNoturno/100)+nValorSalarioBase*(nAdicionalIsalubridade/100)
      cIRRF             :='N'
      nIndice           := 1
      nTempoTrabalho    := ( dDemissaoColaborador - dAdmissaoColaborador ) / 30

      if dAdmissaoColaborador < CToD('01/01/2009') .and. dDemissaoColaborador > CToD('31/12/2012')
         nIndice += 0.09
      endif
      if dAdmissaoColaborador < CToD('01/01/2015') .and. dDemissaoColaborador > CToD('31/12/2018')
         nIndice -= 0.03
      endif

      if nSalarioTotal > nValorLimiteIRRF
         cIRRF := 'S'
         nIndice -= 0.07
      endif

      cStatus := ''
      if cSexoColaborador == 'H'
         nHomens++
         if nTempoTrabalho >= 29 .and. Date() - dNascimentoColaborador > 22265
            nHomensAposentados++
            nRemuneracaoTotalH += nSalarioTotal*nindice*nMesesTrabalhados
            if Date() - dNascimentoColaborador > 29930
               nHomensVelhos++
            endif
         endif
      elseif cSexoColaborador == 'M'
         nMulheres++
         if cIRRF == 'S'
            nMulheresIRRF += 1
         endif
         if dAdmissaoColaborador < CToD('01/01/2002')
           nMulheres2002++
         endif
         if nTempoTrabalho >= 28 .and. Date() - dNascimentoColaborador > 21170
         nMulheresAposentadas++
         nRemuneracaoTotalM += nSalarioTotal*nindice*nMesesTrabalhados
         endif
      endif

      if nEntradas = nFuncionariosAnalisados
         nOpcao := 3
         exit
      endif
   enddo


   if nOpcao == 3
      @ nLinha++,02 say "                 |Homens    |Mulheres"
      @ nLinha++,02 say "Total:           |"+ALLTrim( Str( nHomens ) )+replicate( ' ' , 10-len( ALLTrim(str( nHomens))))+"|"+ALLTrim( Str( nMulheres ) )
      @ nLinha++,02 say "Aposentado       |"+ALLTrim( Str( (nHomensAposentados/nHomens)*100 ) )+'%'+replicate( ' ' , 9-len( ALLTrim(str( nHomensAposentados))))+"|"+ALLTrim( Str( (nMulheresAposentadas/nMulheres)*100 ) )+"%"
      @ nLinha++,02 say "Remuneracao Total|"+Transform(nRemuneracaoTotalH, '@E 9999999,99')+'|'+Transform(nRemuneracaoTotalM, '@E 9999999,99')
      @ nLinha++,02 say "+82anos          |"+ALLTrim( Str( nHomensVelhos ) )+replicate( ' ' , 10-len( ALLTrim( Str (nHomensVelhos))))+'|'
      @ nLinha++,02 say "2002             |"+replicate( ' ' , 10)+'|'+ALLTrim( Str( nMulheres2002 ) )
      @ nLinha++,02 say "IRRF             |"+replicate( ' ' , 10)+'|'+ALLTrim( Str( nMulheresIRRF ) )
      Inkey(0)
   endif
enddo
