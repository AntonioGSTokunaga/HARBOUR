//Isadora Fernanda da Silva Pontoli


set date to british
set epoch to 1940

clear

do while .t.

   nContaEmpregados  := 0
   nNumEmpregados    := 0
   nSalarioBase      := 0
   nLimiteIRFF       := 0
   nAdicionalNoturno := 0
   nAdicionalInsalu  := 0
   nIdadeMinHomem    := 61
   nIdadeMinMulher   := 58
   nAnosMinTrabalhoH := 29
   nAnosMinTrabalhoM := 22
   nSalarioTotalAdc  := 0
   nSalarioReduto    := 0
   nContaHomens       := 0
   nContaMulheres     := 0
   nContaIdadeHomens  := 0

   cNome   := Space( 30 )
   cSexo   := Space( 1 )

   dAdmissao   := CTod( '' )
   dDemissao   := CTod( '' )
   dNascimento := CTod( '' )
   dHoje       := Date()
   dAnoHoje    := Year( dHoje )


   @ 00,01 say 'Digite a quantidade de empregados a serem analisados:'

   @ 00,60 get nNumEmpregados valid nNumEmpregados > 0
   read

  do while nContaEmpregados < nNumEmpregados

      @ 02,01 say 'Empregado entrevistado.:' + AllTrim( Str( nContaEmpregados ))
      @ 03,01 say 'Nome...................:'
      @ 04,01 say 'Sexo (F/M).............:'
      @ 05,01 say 'Data de nascimento.....:'
      @ 06,01 say 'Data de AdmissÆo.......:'
      @ 07,01 say 'Data de DemissÆo.......:'
      @ 08,01 say 'Sal rio base...........:'
      @ 09,01 say 'Limite IRRF............:'
      @ 10,01 say 'Adicional noturno......:'
      @ 11,01 say 'Adicional Insalibridade:'

      @ 03,30 get cNome             picture '@!'            valid !Empty( cNome )
      @ 04,30 get cSexo             picture '@!'            valid cSexo $ 'FM'
      @ 05,30 get dNascimento                               valid !Empty( dNascimento )
      @ 06,30 get dAdmissao                                 valid dAdmissao > dNascimento
      @ 07,30 get dDemissao                                 valid dDemissao >= dAdmissao
      @ 08,30 get nSalarioBase      picture '@! 99,999.99'  valid nSalarioBase >= 0
      @ 09,30 get nLimiteIRFF       picture '@! 99,999.99'  valid nLimiteIRFF >= 0
      @ 10,30 get nAdicionalNoturno picture '999'           valid nAdicionalNoturno >= 0
      @ 11,30 get nAdicionalInsalu  picture '999'           valid nAdicionalInsalu >= 0
      read

      if LastKey() == 27
         nOpcoes := Alert( 'Deseja sair?', { 'Retornar', 'Cancelar', 'Processar'}, 'W/B')
         if nOpcoes == 1
            loop
         elseif nOpcoes == 2
            exit
         endif
      endif

      dAnoNasci      := Year( dNascimento )
      dAnoDemissao   := Year( dDemissao )
      dAnoAdmissao   := Year( dAdmissao )


      nIdade         := dAnoHoje - dAnoNasci
      nTempoTrabalho := dAnoDemissao - dAnoAdmissao

      if cSexo == 'M'
         if nIdade < nIdadeMinHomem .and.  nTempoTrabalho < nAnosMinTrabalhoH
         Alert( 'NÆo esta apto a se aposentar!')
         else
         Alert( 'Esta apto para se aposentar!')
         nContaIdadeHomens++
         if nIdade > 82
            nContaIdadeHomens++
         endif
         endif
      endif

      if cSexo == 'F'
         if nIdade < nIdadeMinMulher .and. nTempoTrabalho < nAnosMinTrabalhoM
            Alert( 'NÆo esta apto a se aposentar!')
         else
            Alert( 'Esta apto para se aposentar!')
            nContaMulheres++
         endif
      endif

      nSalarioTotalAdc += nSalarioBase

      if dAnoAdmissao >= 2009 .and. dAnoAdmissao <= 2012 .or. dAnoDemissao >= 2009 .and. dAnoDemissao <= 2012
         nSalarioTotalAdc  := (( nSalarioBase * 9)/100) + nSalarioBase
      elseif dAnoAdmissao >= 2015 .and. dAnoAdmissao <= 2018 .or. dAnoDemissao >= 2015 .and. dAnoDemissao <= 2012
         nSalarioTotalAdc  := (( nSalarioBase * 3)/100) + nSalarioBase
      endif

      nSomaAdcNoturno := ( nSalarioBase * nAdicionalNoturno)/100
      nSomaAdcInsalu  := ( nSalarioBase * nAdicionalInsalu)/100
      nSomaTotal      := nSomaAdcInsalu + nSomaAdcNoturno  + nSalarioTotalAdc

       if nSalarioBase > nLimiteIRFF
          nRedutor           := ( nSalarioBase * 7)/100
          nSalarioReduto     := nSalarioTotalAdc - nRedutor
          nSomaAposentadoria := nSalarioReduto
      else
         nSomaAposentadoria := nSalarioTotalAdc
       endif

      @ 15,01 say 'Remunarea‡Æo da aposentadoria: '+ AllTrim( Str( nSomaAposentadoria ))

      nContaEmpregados++
      nSomaAposentadoria := 0


   enddo

   nPercHomens := ( nNumEmpregados * nContaHomens )/ 100
   @ 20,01 say nPercHomens


enddo
