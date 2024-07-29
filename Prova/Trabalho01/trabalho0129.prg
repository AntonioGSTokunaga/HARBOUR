// João Pedro Ricardo
//

setmode (25,80)
set date British
set epoch to 1940
set scoreboard off

clear

cPictureQuantidade  := "@e 9,999"
cPictureString      := "@!"
cPictureValores     := "@e 99,999.99"
cPicturePorcentagem := "99"

nIdadeParaAposentadoriaHomem            := 61
nIdadeParaAposentadoriaMulher           := 58
nTempoDeTrabalhoParaAposentadoriaHomem  := 22
nTempoDeTrabalhoParaAposentadoriaMulher := 29


dDataHoje   := Date()

do while .t.

   clear

   nNumeroDeFuncionarios                 := 0
   nCancelar                             := 0
   nVezesFeitas                          := 0
   nHomenMaiorQueOitentaEDois            := 0
   nMulheresAdmitidasAntesDeDoisMilEDois := 0
   nAposentadoMulher                     := 0
   nAposentadoHomem                      := 0
   nMulheresQuePagamIRRF                 := 0
   nSalarioAposentadoriaTotal            := 0
   nAposentadoriaTotalHomem              := 0
   nAposentadoriaTotalMulher             := 0

   @ 01,02 to 04,55 double

   @ 02,04 say "Digite o numero de Funcionarios a serem analisados"

   @ 03,04 get nNumeroDeFuncionarios Picture cPictureQuantidade Valid nNumeroDeFuncionarios > 0
   read

   if LastKey() == 27
      nOpcao := Alert("Deseja Sair do Programa?",{"Sim","Nao"},"N/W") 
      if nOpcao == 1
         exit
      else
         loop
      endif
   endif

   do while nVezesFeitas < nNumeroDeFuncionarios 
      
      clear
      
      cNomeColaborador      := Space(30)
      cSexo                 := Space(1)
      dDataDeNascimento     := CToD("")
      dDataDeAdmissao       := CToD("")
      dDataDeDemissao       := CToD("")
      nValorSalarioBase     := 0
      nValorLimiteIRRF      := 0
      nAdicionalNoturno     := 0
      nAdicionalInsalubre   := 0
      nAposentado           := 0

      @ 01,01 to 07,72 double

      @ 02,02 say "Nome Colaborador: "
      @ 02,55 say "Sexo: [M] [F]: "
      @ 03,02 say "Data de Nascimento: "
      @ 04,02 say "Data de Admissao..: "
      @ 04,40 say "Data de Demissao....: "
      @ 05,02 say "Valor Do Salario..: "
      @ 05,40 say "Valor Limite do IRRF: "
      @ 06,02 say "Adicional Noturno (%): "
      @ 06,40 say "Adicional Insalubre (%): "

      @ 02,20 get cNomeColaborador    Picture cPictureString      Valid !Empty(cNomeColaborador)
      @ 02,70 get cSexo               Picture cPictureString      Valid cSexo $ "MF"
      @ 03,21 get dDataDeNascimento                               Valid !Empty(dDataDeNascimento) .and. dDataDeNascimento < dDataHoje
      @ 04,21 get dDataDeAdmissao                                 Valid !Empty(dDataDeAdmissao) .and. dDataDeAdmissao > dDataDeNascimento .and. dDataDeAdmissao < dDataHoje
      @ 04,62 get dDataDeDemissao                                 Valid !Empty(dDataDeDemissao) .and. dDataDeDemissao > dDataDeAdmissao .and. dDataDeDemissao <= dDataHoje
      @ 05,21 get nValorSalarioBase   Picture cPictureValores     Valid nValorSalarioBase > 0
      @ 05,62 get nValorLimiteIRRF    Picture cPictureValores     Valid nValorLimiteIRRF > 0
      @ 06,25 get nAdicionalNoturno   Picture cPicturePorcentagem Valid nAdicionalNoturno >= 0
      @ 06,65 get nAdicionalInsalubre Picture cPicturePorcentagem Valid nAdicionalInsalubre >= 0
      read 
      
      if LastKey() == 27
         nOpcao := Alert("Deseja?",{"Cancelar","Retornar","Processar"},"N/W") 
         if nOpcao == 1
            nCancelar := 1
            exit
         elseif nOpcao == 3
            exit
         else
            loop
         endif
      endif

//Descobrindo a Idade da Pessoa e o Tempo de Trabalho da mesma

      nIdadePessoa     := Year(dDataHoje) - Year(dDataDeNascimento)
      nTempoTrabalhado := Year(dDataDeAdmissao) - Year(dDataDeDemissao)


      if Month(dDataDeNascimento) >= Month(dDataHoje) .and. day(dDataDeNascimento) > day(dDataHoje)
         nIdadePessoa--
      endif



      if Month(dDataDeAdmissao) >= Month(dDataDeDemissao) .and. day(dDataDeAdmissao) > day(dDataDeDemissao)
         nTempoTrabalhado--
      endif

//Começa o calculo da apossentadoria dele

      nSalarioAposentadoriaTotal := nValorSalarioBase + ((nValorSalarioBase * nAdicionalNoturno) / 100) + ((nValorSalarioBase * nAdicionalInsalubre) / 100)
     

      if (Year(dDataDeAdmissao) <= 2009 .and. Year(dDataDeDemissao) >= 2009) .or. (Year(dDataDeAdmissao) <= 2012 .and. Year(dDataDeDemissao) >= 2012)
         nSalarioAposentadoriaTotal += ((nValorSalarioBase * 9) / 100)
      endif
     


      if (Year(dDataDeAdmissao) <= 2015 .and. Year(dDataDeDemissao) >= 2015) .or. (Year(dDataDeAdmissao) <= 2018 .and. Year(dDataDeDemissao) >= 2018)
         nSalarioAposentadoriaTotal -= ((nValorSalarioBase * 3) / 100)
      endif
      


      if nSalarioAposentadoriaTotal > nValorLimiteIRRF
         
         nSalarioAposentadoriaTotal -= ((nValorSalarioBase * 7) / 100)
         
         if cSexo == "F"
            nMulheresQuePagamIRRF++
         endif
      
      endif


   
      if cSexo == "M" 
         
         if nIdadePessoa >= nIdadeParaAposentadoriaHomem .and. nTempoTrabalhado >= nTempoDeTrabalhoParaAposentadoriaHomem
            nAposentadoHomem++
            nAposentadoriaTotalHomem := nSalarioAposentadoriaTotal
         
         endif

            if nIdadePessoa > 82
               nHomenMaiorQueOitentaEDois++
            endif

      elseif cSexo == "F" 
         
         if nIdadePessoa >= nIdadeParaAposentadoriaMulher .and. nTempoTrabalhado >= nTempoDeTrabalhoParaAposentadoriaMulher
            nAposentadoMulher++
            nAposentadoriaTotalMulher:= nSalarioAposentadoriaTotal 
         endif
          
         if Year(dDataDeAdmissao) < 2002
            nMulheresAdmitidasAntesDeDoisMilEDois++
         endif
     
      endif



      nVezesFeitas++
   enddo

   if nCancelar == 0 

      clear

      @ 01,01 to 10,70 double 

      nPorcentualDeHomensAposentados    := nVezesFeitas / (nAposentadoHomem * 100)
      nPorcentualDeMulheresAposentadas  := nVezesFeitas / (nAposentadoMulher * 100)
      nPorcentualDeMulheresQuePagamIRRF := nAposentadoMulher / (nMulheresQuePagamIRRF * 100)

      @ 02,02 say "Dos " + AllTrim(Str(nVezesFeitas))
      @ 03,02 say Transform(nPorcentualDeHomensAposentados,"999") + "% de Homens Aposentados"
      @ 04,02 say "Remuneracao para todos eles em um valor total de R$ " + Transform(nAposentadoriaTotalHomem,"@e 999,999,999.99")
      @ 05,02 say Transform(nPorcentualDeMulheresAposentadas,"999") + "% de Mulheres Aposentados"
      @ 06,02 say "Remuneracao para todos elas em um valor total de R$ " + Transform(nAposentadoriaTotalMulher,"@e 999,999,999.99")
      @ 07,02 say "Na Analise Realizada " + Alltrim(Str(nHomenMaiorQueOitentaEDois)) + " Sao Aposentados Maiores de 82 anos"
      @ 08,02 say "Na Analise Realizada " + Alltrim(Str(nMulheresAdmitidasAntesDeDoisMilEDois)) + " Sao Mulheres Admitidas antes de 2002"
      @ 09,02 say "Das Mulheres aposentadas " + Alltrim(Str(nPorcentualDeMulheresQuePagamIRRF)) + "% Pagam IRRF"
      
      Inkey(0)
   endif

enddo