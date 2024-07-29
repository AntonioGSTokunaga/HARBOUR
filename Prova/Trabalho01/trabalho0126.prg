//vinicius reginaldo ferrarini
//Trabalho 01

set date to british
set epoch to 1940
set scoreboard off


//set color to ("N/W")
//@ 03,09 clear to 21,70

lFinaliza := .f.

dHoje    := date()
nHojeDia := Day(dHoje)
nHojeMes := month(dHoje)
nHojeAno := Year(dHoje)
nHojeSem := DoW(dHoje)


do while !lFinaliza
   clear
   nFuncionarios := 0

   @ 00,00 to 03,79 double
   @ 01,30 say 'Analise Funcionarios'
   @ 02,10 say "Digite a quantidade de Funcionarios analizados:"


   @ 02,60 get nFuncionarios   picture'9999' valid nFuncionarios > 0
   read

   if LastKey() == 27
      nOpcao := alert('Deseja sair do programa?' , { 'Sim' , 'Nao' })
      if nOpcao = 1
         lFinaliza := .t.
         exit
      else
         loop
      endif
   endif

   lAnalise       := .t.
   nCont          := 0
   nMasculino82   := 0
   nContMasculino := 0
   nContFeminino  := 0
   nAntes2002     := 0
   nTotalSalario  := 0
   nFemininoIRRF  := 0
   nAposentado    := 0

//--------------------------------------------------------
   do while nFuncionarios > nCont
      @ 03,00 clear to 24,79
      cFunNome        := Space(20)
      cFunSexo        := ' '
      dFunNascimento  := CToD('')
      dFunAdmissao    := CToD('')
      dFunDemissao    := CToD('')
      nFunSalarioBase := 0
      nFunLimiteIRRF  := 0
      nFunAdicionaNot := 0
      nFunAdicionaIns := 0
      nLinha          := 4
      lAposentado     := .f.

      @ nLinha  ,60 say "Funcionario: " + alltrim(str(nCont+1))
      @ nLinha++,10 say "Nome..........:"
      @ nLinha++,10 say "Sexo..........:  [ ]  [M]asculino  [F]eminino"
      @ nLinha++,10 say "Nascimento....:"
      @ nLinha++,10 say "Admissao......:"
      @ nLinha++,10 say "Demissao......:"
      @ nLinha++,10 say "Salario.......:"
      @ nLinha++,10 say "Limite IRRF...:"
      @ nLinha++,10 say "%Noturno......:"
      @ nLinha++,10 say "%Insalubridade:"

      nLinha := 4
      @ nLinha++,28 get cFunNome        valid !Empty(cFunNome)                                  picture "@!"
      @ nLinha++,28 get cFunSexo        valid cFunSexo $ "MF"                                   picture "@!"
      @ nLinha++,28 get dFunNascimento  valid dFunNascimento  < dHoje .and. !Empty(dFunNascimento)
      @ nLinha++,28 get dFunAdmissao    valid dFunAdmissao    < dHoje .and. dFunAdmissao > dFunNascimento
      @ nLinha++,28 get dFunDemissao    valid dFunDemissao    < dHoje .and. dFunDemissao > dFunAdmissao
      @ nLinha++,28 get nFunSalarioBase valid nFunSalarioBase > 0                                picture '@E 999,999.99'
      @ nLinha++,28 get nFunLimiteIRRF  valid nFunLimiteIRRF  > 0                                picture '@E 999,999.99'
      @ nLinha++,28 get nFunAdicionaNot valid nFunAdicionaNot >= 0 .and. nFunAdicionaNot <= 101  picture '99'
      @ nLinha++,28 get nFunAdicionaIns valid nFunAdicionaIns >= 0 .and. nFunAdicionaIns <= 101  picture '99'
      read
      if LastKey() == 27
         nOpcao := alert('Oque deseja fazer?', { 'Processar' , ' Retomar ' , 'Cancelar'})
         if nOpcao = 1     //fecha compra
            exit
         elseif nOpcao = 2 //Reroma
            loop
         else              //Inicio
            lAnalise := .f.
            exit
         endif
      endif
      //-------------------------Processamento-------------





      // idade
      nIdade := nHojeAno - Year(dFunNascimento)
      nMes   := month(dFunNascimento)
      if nHojeDia < Day(dFunNascimento)
         nMes++
      endif
      if nHojeMes < nMes
         nIdade--
      endif



      //   tempo trabalhado

      nTempoTrabalhado := Year(dFunAdmissao)-  Year(dFunDemissao)
      nMes             := month(dFunAdmissao)
      if day(dFunAdmissao) > Day(dFunDemissao)
         nMes++
      endif
      if nMes > month(dFunDemissao)
         nTempoTrabalhado--
      endif

      //---------------------------------------------------


      //-----------
      if cFunSexo = 'M'
         nContMasculino++
         if nIdade > 60 .and. nTempoTrabalhado > 28
           lAposentado := .t.
           nAposentado++
         endif

         if nIdade > 82
            nMasculino82++
         endif

      else
         nContFeminino++
         if nIdade > 57 .and. nTempoTrabalhado > 21
            lAposentado := .t.
            nAposentado++
         endif

         if Year(dFunAdmissao) < 2002
            nAntes2002++
         endif

         if nFunSalarioBase < nFunLimiteIRRF
            nFemininoIRRF++
         endif
      endif
      //-------------------------------------


      if lAposentado
         nSalarioAposentado := nFunSalarioBase
         if nAnoAdminssao >= 2009 .and. nAnoDemissao <= 2012
            nSalarioAposentado += nFunSalarioBase * 0.09
         endif

         if nAnoAdminssao >= 2015 .and. nAnoDemissao <= 2018
            nSalarioAposentado -= nFunSalarioBase * 0.03
         endif

         if nFunSalarioBase < nFunLimiteIRRF
            nPagaIRRF++
            nSalarioAposentado -= nFunSalarioBase * 0.07
         end
         nTotalSalario += nSalarioAposentado
      endif
      //---------------------------------------------------

      nCont++
   enddo

   if lAnalise
      clear
      nPorcentagemMasculina := nContMasculino  / nCont * 100
      nPorcentagemFeminina  := 100-nPorcentagemMasculina

      @ 05,30 say "Temos " + alltrim(str(nPorcentagemMasculina)) +"% de HOMENS"
      @ 06,30 say "Temos " + alltrim(str(nPorcentagemFeminina)) +"% de MULHERES"
      @ 07,30 say "O valor total de remuneracao foi R$"+ alltrim(transform(nTotalSalario , '@E 99,999,999.99'))
      @ 08,30 say "Quantidade de homens com mais de 82 anos: "+ alltrim(str(nMasculino82))
      @ 09,30 say "Quantidade de mulheres admitidas antes de 2002: "+ alltrim(str(nAntes2002))
      @ 10,30 say "Quantidade de mulheres que pagam IRRF: "+ alltrim(transform(nContFeminino /nFemininoIRRF,'999.9'))+'%'
      @ 11,30 say "Precione algum tecla para retornar..."
      InKey(0)

   endif
enddo





