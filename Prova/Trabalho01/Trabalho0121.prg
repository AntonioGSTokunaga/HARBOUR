//Hugo Miguel dos Santos Deroide

set date to british
set epoch to 1940
set scoreboard off

clear



nEmpregados                 := 0
nEmpregadosAnalisados       := 0
nConta82                    := 0
nContaIRRF                  := 0
nContaM2002                 := 0
nPercentualH                := 0
nPercentualM                := 0
nAposentadoria              := 0
nHomens                     := 0
nMulheres                   := 0



@ 01,01 say 'Numero de empregados a serem analisados:'

@ 01,51 get nEmpregados                                  picture '999'  valid !Empty( nEmpregados )
read



do while nEmpregadosAnalisados < nEmpregados


   do while nEmpregadosAnalisados < nEmpregados

      nEmpregadosAnalisados += nEmpregadosAnalisados

      cNomeColaborador        := Space( 30 )
      cSexoColaborador        := Space( 1 )
      dNascimento             := CToD( '' )
      dAdmissao               := CToD( '' )
      dDemissao               := CToD( '' )
      nSalariobase            := 0
      nValorLimiteIRRF        := 0
      nAdcionalNoturno        := 0
      nAdcionalInsalubridade  := 0
      nIdade                  := 0
      nAnoNascimento          := Year( dNascimento )
      nAnoAtual               := Year( Date() )
      nMesNascimento          := Month( dNascimento )
      nMesAtual               := Month( Date() )
      nTempoTrabalho          := 0
      nAnoAdmissao            := Year( dAdmissao )
      nMesAdmissao            := Month( dAdmissao )
      nAnoDemissao            := Year( dDemissao )
      nMesDemissao            := Month( dDemissao )
      nAdcionalAnoTrabalhado  := 0
      nRedutorAnoTrabalhado   := 0

      @ 03,01 say 'Nome do colaborador...:'
      @ 04,01 say 'Sexo..................:'
      @ 05,01 say 'Data de Nascimento....:'
      @ 06,01 say 'Data da admissao......:'
      @ 07,01 say 'Data de demissao......:'
      @ 08,01 say 'Salario...............:'
      @ 09,01 say 'Valor limite IRRF.....:'
      @ 10,01 say 'Adcional noturno......:'
      @ 11,01 say 'Adcional insalubridade:'

      @ 03,24 get cNomeColaborador                     picture '@!'            valid !Empty( cNomeColaborador )
      @ 04,24 get cSexoColaborador                     picture '@!'            valid !Empty( cSexoColaborador )
      @ 05,24 get dNascimento                                                  valid !Empty( dNascimento) .and. dNascimento < Date()
      @ 06,24 get dAdmissao                                                    valid !Empty( dAdmissao ) .and. dAdmissao < Date()
      @ 07,24 get dDemissao                                                    valid !Empty( dDemissao)  .and. dDemissao > dAdmissao
      @ 08,24 get nSalariobase                         picture '@E 99,999.99'  valid nSalariobase > 0
      @ 09,24 get nValorLimiteIRRF                     picture '@E 9,999.99'   valid nValorLimiteIRRF > 0
      @ 10,24 get nAdcionalNoturno                     picture '@E 99.9'       valid nAdcionalNoturno >= 0
      @ 11,24 get nAdcionalInsalubridade               picture '@E 99.9'       valid nAdcionalInsalubridade >=0
      read

      if LastKey() == 27
         nOpcoes := Alert( 'O que deseja fazer?', { 'Cancelar', 'Retornar', 'Processar'} )
         if nOpcoes == 3
              nEmpregados := nEmpregadosAnalisados


         elseif nOpcoes == 2

            loop

         else
            exit

         endif

      endif

      if nMesNascimento < nMesAtual
         nIdade := nAnoAtual - nAnoNascimento

      else
         nIdade := nAnoNascimento - nAnoAtual

      endif

      if nMesAdmissao < nMesDemissao
         nTempoTrabalho := nAnoDemissao - nAnoAdmissao

      else
         nTempoTrabalho := nAnoAdmissao - nAnoDemissao

      endif

      if cSexoColaborador == 'M'
         nHomens += 1
         if nIdade >=82
            nConta82 += 1

         endif

         if nIdade >= 61 .and. nTempoTrabalho >= 29
            nAptidao := 1

         else
            nAptidao := 0

         endif

      else
         nMulheres += 1
         if Year( dAdmissao ) < 2002
            nContaM2002 += 1

         endif

         if nSalariobase > nValorLimiteIRRF
            nContaIRRF +=1

         endif

         if nIdade >= 58 .and. nTempoTrabalho >= 22
            nAptidao := 1

         else
            nAptidao :=0

         endif

      endif

      if ( dAdmissao < CToD( '01/01/2009') .and. dDemissao > CToD( '31/12/2009') ) .or. ( dAdmissao < CToD( '01/01/2012' ) .and. dDemissao > CToD( '31/12/2012') )
         nAdcionalAnoTrabalhado := 0.09

      else
         nAdcionalAnoTrabalhado := 0

      endif

      if ( dAdmissao < CToD( '01/01/2015') .and. dDemissao > CToD( '31/12/2015') ) .or. ( dAdmissao < CToD( '01/01/2018' ) .and. dDemissao > CToD( '31/12/2018') )
         nRedutorAnoTrabalhado := 0.03

      else
         nRedutorAnoTrabalhado := 0

      endif

      if nSalariobase > nValorLimiteIRRF
         nRedutor := 0.07*nSalariobase

      else
         nRedutor := 0

      endif


      nAposentadoria := nSalariobase - (nRedutorAnoTrabalhado*nSalariobase) + (nAdcionalAnoTrabalhado*nSalariobase) + ((nAdcionalNoturno/100)*nSalariobase) + ((nAdcionalInsalubridade/100)*nSalariobase)




   enddo

nPercentualH := (nHomens/nEmpregadosAnalisados)
nPercentualM := (nMulheres/nEmpregadosAnalisados)

enddo

clear

@ 00,00 to 10,79
@ 02,01 to 02,78
@ 04,01 to 04,78
@ 01,51 to 03,51
@ 01,60 to 03,60
@ 01,67 to 03,67

@ 03,01 say 'Percentual de aposentados e valor de remuneracao:'
@ 01,52 say 'Mulheres'
@ 01,61 say 'Homens'
@ 01,68 say 'Valor Total'
@ 03,53 say AllTrim( Str( nPercentualM ))
@ 03,62 say AllTrim( Str( nPercentualH ))
@ 03,69 say AllTrim( Str( nAposentadoria ))
@ 05,01 say 'Homens com idade acima de 82 anos..............: ' + AllTrim( Str( nConta82 ))
@ 06,01 say 'Mulheres admitidas desde 2002..................: ' + AllTrim( Str( nContaM2002 ))
@ 07,01 say 'Percentual de mulheres que pagam IRRF..........: ' + AllTrim( Str( nContaIRRF))




InKey ( 0 )




























