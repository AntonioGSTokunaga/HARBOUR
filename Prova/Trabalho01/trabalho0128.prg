//André de Oliveira Fazion

Set Date to British 
Set epoch to 1940   
Set scoreboard off
Set Century on      
Set color to "8/0"

do while .t.

   clear

   //sistemas
   nColaboradorTotal      := 0
   nColaboradorColetado   := 0
   nHomens                := 0
   nHomensAposentados     := 0
   nMulheres              := 0
   nMulheresAposentados   := 0
   nLimiteIRRF            := 0

   nSair                  := 0
   nLinha                 := 1

   nMulherPagaIRRF        := 0
   nHomensMaior82         := 0
   nMulherAdimitidas2002  := 0

   nTotalAposentadoria    := 0
   nSubtotalHomens        := 0 
   nSubtotalMulheres      := 0 

   //mascaras
   cMascaraTexto          := "@!"
   cMascaraSalario        := "@e 999,999.99"


   @ 00,00 to 03,79 double

   @ 01,01 say "Quantos empregados vao ser analizados? :"
   @ 02,01 say "Limite atual do IRRF:"

   @ 01,41 get nColaboradorTotal  picture "@e 9,999"       valid nColaboradorTotal > 0
   @ 02,22 get nLimiteIRRF        picture cMascaraSalario  valid nLimiteIRRF > 0
   read
   if( LastKey() == 27 )

      nSair := Alert( "FINALIZAR O PROGRAMA?",{"SIM","NAO"},"8/0" )
      
      if( nSair = 1 ) 

         exit

      else	

         loop 

      endif
   endif

   clear

   @ 00,00 to 22,79 double

   do while( nColaboradorColetado < nColaboradorTotal )
      
      if nLinha >= 17
         
         @ 01,01 clear to 21,78 
         nLinha := 1

      endif
      
      //Colaborador
      cNomeColaborador       := Space( 30 )
      cSexoColaborador       := Space( 1 )
      dNascimentoColaborador := CToD("")   
      dAdmissao              := CToD("")  
      dDemissao              := CToD("")
      nSalarioBase           := 0

      //adicionais
      nAdicionalNoturno      := 0
      nAdicionaInsalubridade := 0

      @ (nLinha)    ,01 say "Coloborador Numero: " + transform( ++nColaboradorColetado, "@e 9,999" ) 
      @ (nLinha + 1),01 say "Nome:"
      @ (nLinha + 1),41 say "Sexo(M/F):"
      @ (nLinha + 1),56 say "Nacido em:"
      @ (nLinha + 2),01 say "Admitido em:"
      @ (nLinha + 2),24 say "Demitido em:"         
      @ (nLinha + 2),47 say "Valor do Salario Base:"
      @ (nLinha + 3),01 say "Adicional Noturno:   %"
      @ (nLinha + 3),30 say "Adicional de Insalubridade:   %"

      @ (nLinha + 1),06 get cNomeColaborador       picture cMascaraTexto   valid !Empty(cNomeColaborador)
      @ (nLinha + 1),51 get cSexoColaborador       picture cMascaraTexto   valid cSexoColaborador $ "MF"
      @ (nLinha + 1),66 get dNascimentoColaborador                         valid dNascimentoColaborador < date() .and. !Empty(dNascimentoColaborador)
      @ (nLinha + 2),13 get dAdmissao                                      valid dAdmissao > dNascimentoColaborador
      @ (nLinha + 2),36 get dDemissao                                      valid dDemissao > dAdmissao .and. dDemissao <= date()
      @ (nLinha + 2),69 get nSalarioBase           picture cMascaraSalario valid nSalarioBase >= 0
      @ (nLinha + 3),19 get nAdicionalNoturno      picture "999"           valid nAdicionalNoturno >= 0
      @ (nLinha + 3),57 get nAdicionaInsalubridade picture "999"           valid nAdicionaInsalubridade >= 0
      read
      if( LastKey() == 27 )

         nSair := Alert( "Oque fazer?",{"Cancelar","Retornar","Processar"},"8/0" )
         
         if( nSair = 1 ) .or. ( nSair = 3 )
   
            exit
   
         else	
   
            nColaboradorColetado--
            loop 
   
         endif
      endif

      nAposentadoriaTotal := nSalarioBase + ((nSalarioBase/100)*nAdicionalNoturno) + ((nSalarioBase/100)*nAdicionaInsalubridade)

      //Admissao
      nAnoAdmissao     := Year (dAdmissao)
      nMesAdmissao     := month(dAdmissao)
 
      //Demissao
      nAnoDemissao     := Year (dDemissao)
      nMesDemissao     := month(dDemissao)
 
      //Comtribuicao
      nAnoComtribuicao := nAnoDemissao - nAnoAdmissao
      nMesComtribuicao := nMesDemissao - nMesAdmissao

      //tirar meses negativos
      if( nMesComtribuicao < 0 )

         nMesComtribuicao += 12
         nAnoComtribuicao += -1

      endif

      //Nascimento
      nAnoNascimento     := Year (dNascimentoColaborador)
      nMesNascimento     := month(dNascimentoColaborador)
 
      //Hoje
      dHoje              := Date()
      nAnoHoje           := Year (dHoje)
      nMesHoje           := month(dHoje)
 
      //Idade
      nAnoIdade          := nAnoHoje - nAnoNascimento
      nMesIdade          := nMesHoje - nMesNascimento

      //tirar meses negativos
      if( nMesIdade < 0 )

         nMesIdade += 12
         nAnoIdade += -1

      endif

      if( nAnoDemissao > 2018 ) .and. ( nAnoAdmissao < 2015 )

         nAposentadoriaTotal += -(nSalarioBase/100)*3

      endif

      if( nAnoDemissao > 2012 ) .and. ( nAnoAdmissao < 2009 )

         nAposentadoriaTotal += +(nSalarioBase/100)*9

      endif

      if( cSexoColaborador == "M" )

         nHomens++

         if( nAnoIdade >= 61 ) .and. ( nAnoComtribuicao >= 29)

            if( nAnoIdade >= 82 )

               nHomensMaior82++
               
            endif

            if( nAposentadoriaTotal <= nLimiteIRRF )

               nAposentadoriaTotal += -(nSalarioBase/100)*7
      
            endif
      
            @ nLinha++    ,49 say "APTO" color "2/0"
            @ (nLinha + 3),01 say "Aposentadoria:" + transform(nAposentadoriaTotal, cMascaraSalario)
            nHomensAposentados++

            nSubtotalHomens += nAposentadoriaTotal

         else

            @ nLinha,45 say "NAO APTO" color "4/0"

         end if

      else

         nMulheres++

         if( nAnoIdade >= 58 ) .and. ( nAnoComtribuicao >= 22)
      
            if( nAposentadoriaTotal <= nLimiteIRRF )

               nMulherPagaIRRF++

            endif

            if( nAnoAdmissao < 2002)

               nMulherAdimitidas2002++
               
            endif

            if( nAposentadoriaTotal <= nLimiteIRRF )

               nAposentadoriaTotal += -(nSalarioBase/100)*7
      
            endif

            nMulheresAposentados++
            @ nLinha++    ,49 say "APTO" color "2/0"
            @ (nLinha + 3),01 say "Aposentadoria: " + transform(nAposentadoriaTotal, cMascaraSalario)

            nSubtotalMulheres += nAposentadoriaTotal

         else

            @ nLinha,45 say "NAO APTO" color "4/0"

         end if
      endif
      

      nLinha += 4



      @ (nLinha),01 to (nLinha++),78

      if ( nColaboradorColetado < nColaboradorTotal )
      
         @ 23,00 say"pressione alguma tecla para adicionar adicionar mais um colaborador"

      else

         @ 23,00 say"pressione alguma tecla para ver resultados"

      endif
      
      Inkey (0)
   enddo

   if( nSair = 1 )
      
      exit

   endif

   clear

   @ 00,00 to 11,79 double

   nPercentualHomens       := (nHomensAposentados/nHomens)*100
   nPercentualMulheres     := (nMulheresAposentados/nMulheres)*100
   nPercentualMulheresIRRF := (nMulherPagaIRRF/nMulheresAposentados)*100

   nTotalAposentadoria     := nSubtotalHomens+nSubtotalMulheres

   @ 01,01 say "Percentual de Homens Aposentados  : " + transform(nPercentualHomens, "@e 999.99") +"%"
   @ 02,01 say "Custo: " + transform(nSubtotalHomens, cMascaraSalario)
   @ 03,01 say "Percentual de Mulheres Aposentadas: " + transform(nPercentualMulheres, "@e 999.99") +"%"
   @ 04,01 say "Custo: " + transform(nSubtotalMulheres, cMascaraSalario)

   @ 06,01 say "Custo Total: " + transform(nTotalAposentadoria, cMascaraSalario)

   @ 08,01 say "Quantidade de Homens Aposentados acima de 82 Anos: " + transform(nHomensMaior82, "@e 9,999")
   @ 09,01 say "Quantidade de Mulheres Adimitidas antes de 2022  : " + transform(nMulherAdimitidas2002, "@e 9,999")
   @ 10,01 say "Percentual de Mulheres que pagam IRRF            : " + transform(nPercentualMulheresIRRF, "@e 999.99") +"%"

   @ 23,00 say"pressione alguma tecla para finalizar"
   Inkey (0)
enddo