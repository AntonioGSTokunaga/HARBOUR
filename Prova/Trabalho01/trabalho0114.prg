//LISANDRO PINHEIRO BELTRA
set date to british
set epoch to 1940
set scoreboard off
set color to 'B*,N+'
clear

do while .t.
   nNumeroEmpregados           := 0
   nContadorEmpregados         := 0
   nHomem                      := 0
   nMulher                     := 0
   nMulheresAposentadas        := 0
   nHomensAposentados          := 0
   nValorTotalRemuneracao      := 0
   nHomensMais82               := 0   
   nMulheresAdmitidasAntes2002 := 0  
   nMulherPagaIRRF             := 0
   nHomemPagaIRRF              := 0

   @ 00,32 say 'CONTROLE INSS'

   @ 04,00 clear to 24,79
   @ 03,00 to 03,79 double
   @ 14,00 to 14,79 double

   @ 02,00 say 'Digite o numero de empregados a analisar'

   @ 02,41 get nNumeroEmpregados picture '999' valid nNumeroEmpregados > 0
   read

   if LastKey() == 27
      nOpcao := Alert( 'Deseja sair sem iniciar a pesquisa?' , { 'Sim' , 'Retornar' } )

      if nOpcao == 1
         exit

      else
         loop

      endif

   endif

   do while nContadorEmpregados < nNumeroEmpregados
      cNomeColaborador := Space( 15 )
      cSexo            := Space( 1 ) 

      dDataNascimento  := CToD( '' )
      dDataAdmissao    := CToD( '' )
      dDataDemissao    := CToD( '' )

      nValorSalarioBase           := 0
      nLimiteIRRF                 := 0
      nAdicionalNoturno           := 0
      nAdcionalInsalu             := 0
      nTempoTrabalho              := 0
      nValorAposentadoria         := 0
      nAposentou                  := 0 //0 -> não aposenta - 1 -> aposenta
      nCancelou                   := 0

      @ 05,00 say 'Nome do colaborador.........: '
      @ 06,00 say 'Sexo (M/F)..................: '
      @ 07,00 say 'Data de nascimento..........: '
      @ 08,00 say 'Data de admissao............: '
      @ 09,00 say 'Data de demissao............: '
      @ 10,00 say 'Valor do salario base.......: '
      @ 11,00 say 'Valor limite IRRF...........: '
      @ 12,00 say 'Adicional noturno(%)........: '
      @ 13,00 say 'Adicional insalubridade (%).: '

      @ 05,31 get cNomeColaborador  picture '@!'           valid !Empty( cNomeColaborador )
      @ 06,31 get cSexo             picture '@!'           valid cSexo              $ 'MF'
      @ 07,31 get dDataNascimento                          valid dDataNascimento    < Date()
      @ 08,31 get dDataAdmissao                            valid dDataAdmissao      < Date() .and. dDataAdmissao > dDataNascimento
      @ 09,31 get dDataDemissao                            valid dDataDemissao      < Date() .and. dDataDemissao > dDataAdmissao
      @ 10,31 get nValorSalarioBase picture '@E 99,999.99' valid nValorSalarioBase  > 0
      @ 11,31 get nLimiteIRRF       picture '@E 99,999.99' valid nLimiteIRRF       >= 0
      @ 12,31 get nAdicionalNoturno picture '999'          valid nAdicionalNoturno >= 0
      @ 13,31 get nAdcionalInsalu   picture '999'          valid nAdcionalInsalu   >= 0
      read

      if LastKey() == 27
         nOpcao := Alert( 'O que deseja fazer?' , { 'Cancelar' , 'Retornar' , 'Processar' } )
   
         if nOpcao == 1
            exit
            nCancelou := 1

         elseif nOpcao == 3
            exit
   
         else 
            loop

         endif

      endif

      nContadorEmpregados++

      nValorSalarioBase += nValorSalarioBase * ( ( nAdcionalInsalu + nAdicionalNoturno ) / 100 )

      //Pega sexo
      if cSexo == 'F'
         nMulher++
      
      else
         nHomem++

      endif

      //Pega idade
      nIdade := ( Date() - dDataNascimento ) / 365

      if nIdade > 82 .and. cSexo == 'M'
         nHomensMais82++

      endif

      //IRRF
      if cSexo == 'F' .and. nValorSalarioBase > nLimiteIRRF
         nMulherPagaIRRF++

      elseif nValorSalarioBase > nLimiteIRRF
         nHomemPagaIRRF++

      endif

      //Tempo trabalhado
      nTempoTrabalho := ( dDataDemissao - dDataAdmissao ) / 365

      if cSexo == 'F' .and. dDataAdmissao < CToD( '01/01/2002' )
         nMulheresAdmitidasAntes2002++

      endif 

      //Check aposentadoria 
      if cSexo == 'F' .and. nTempoTrabalho > 22 .and. nIdade >= 58
         nMulheresAposentadas++
         nAposentou := 1

      elseif nTempoTrabalho > 29 .and. nIdade >= 61
         nHomensAposentados++
         nAposentou := 1
      endif

      //Calculo remuneração
      if nAposentou == 1
         nValorAposentadoria += nValorSalarioBase

         if dDataAdmissao < CToD( '01/01/2009' ) .and. dDataDemissao > CToD( '01/01/2012' )
            nValorAposentadoria += ( nValorSalarioBase / 100 ) * 0.9

         endif

         if dDataAdmissao < CToD( '01/01/2015' ) .and. dDataDemissao > CToD( '01/01/2018' )
            nValorAposentadoria -= ( nValorSalarioBase / 100 ) * 0.3

         endif

         if nValorSalarioBase > nLimiteIRRF
            nValorAposentadoria -= ( nValorSalarioBase / 100 ) * 0.7

         endif

         nValorTotalRemuneracao += nValorAposentadoria

      endif

   enddo

   if nCancelou == 1
      exit

   endif

   nPercentAposentados            := ( ( nHomensAposentados + nMulheresAposentadas ) / nContadorEmpregados  ) * 100
   nPercentualMulheresAposentadas := ( nMulheresAposentadas / ( nHomensAposentados + nMulheresAposentadas ) ) * 100
   nPercentualHomensAposentados   := ( nHomensAposentados   / ( nHomensAposentados + nMulheresAposentadas ) ) * 100
   nPercentualMulheresIRRF        := ( nMulherPagaIRRF      / ( nHomemPagaIRRF     + nMulherPagaIRRF      ) ) * 100
 
   @ 16,00 say 'Mulheres aposentadas..........................: '   + Str( nPercentualMulheresAposentadas , 6 , 2 ) + '%'
   @ 17,00 say 'Homens aposentados............................: '   + Str( nPercentualHomensAposentados   , 6 , 2 ) + '%'
   @ 18,00 say 'Percentual de aposentados.....................: '   + Str( nPercentAposentados            , 6 , 2 ) + '%'
   @ 19,00 say 'Valor total da remuneracao....................: R$' + Transform( nValorTotalRemuneracao , '@E 99,999.99' )
   @ 20,00 say 'Quantidade de homens 82+ anos.................: '   + Str( nHomensMais82                  , 3 )
   @ 21,00 say 'Quantidade de mulheres admitidas antes de 2002: '   + Str( nMulheresAdmitidasAntes2002    , 3 )
   @ 22,00 say 'Percentual de mulheres que pagam IRRF.........: '   + Str( nPercentualMulheresIRRF        , 6 , 2 ) + '%'
   @ 24,20 say 'Pressione qualquer tecla para continuar...'

   inkey(0)

enddo