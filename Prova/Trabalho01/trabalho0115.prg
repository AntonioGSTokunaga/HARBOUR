  //Samuel Victor


  set date to british
  set epoch to 1940
  set scoreboard off
  clear
  nContadorEmp := 0
  nTotalGasto  := 0
  @ 00,00 to 12,50
  @ 01,28 say 'CONTROLE INSS'
  @ 02,01 to 02,49


  @ 04,01 say 'Qtde de trab. que serao analisados?:'
  @ 04,40 get nContadorEmp valid !Empty(nContadorEmp)
  read
  do while nContadorEmp > 0
        //vars num‚ricas
     nSalarioBase            := 0
     nValorLimiteIRRF        := 0
     nAdicionalNoturno       := 0
     nAdicionalInsalubridade := 0
     nIdade                  := 0
     nAnyUso                 := 0
     nRemuneracao            := 0
          //Vars de data
     dNascimento := CToD('')
     dAdmissao   := CToD('')
     dDemissao   := CToD('')
     dAno1       := Date()
     dAno2       := Date()

     //vars string
     cNome := Space( 20 )
     cSexo := Space( 1 )

     //var logica
     lNegadoM := .f.
     lNegadoF := .f.

     //CONTADORESSS
     nHomens82           := 0
     nMulheres2022       := 0
     nHomensAposentados  := 0
     nMulheresAposentadas:= 0

     @ 02,01 clear to 06,18
     @ 05,01 say 'Digite o nome:'
     @ 06,01 say 'A idade'
     @ 07,01 say 'Sexo(M/F):'
     @ 08,01 say 'Admissao:'
     @ 09,01 say 'Demissao:'
     @ 10,01 say 'Sal rio base:'

     //gets
     @ 05,18 get cNome valid !Empty(cNome)
     @ 06,09 get nIdade valid nIdade > 18
     @ 07,14 get cSexo picture '@!' valid cSexo == 'M' .or. cSexo == 'F'
     read

     if LastKey() == 27
        nEsc := Alert('Deseja:', {'Cancelar','Retornar', 'Processar'})
        if nEsc == 1
           exit
        elseif nEsc == 2
           nAnyUso += 1
        elseif nEsc == 3
        endif
     endif

     //se a idade nao for suficiente
     if cSexo == 'M' .and. nIdade < 61
        Alert('NÆo possui idade suficiente, nao sera validado')
        lNegadoM := .t.
     elseif cSexo == 'F' .and. nIdade < 58
        Alert('NÆo possui idade suficiente, nao sera validado')
        lNegadoF := .t.
     endif


     @ 08,11 get dAdmissao valid !Empty(dAdmissao)

     @ 09,11 get dDemissao valid !Empty(dDemissao)
     @ 10,15 get nSalarioBase picture '9.999,99' valid nSalarioBase > 1.400
     read
     dAno1 := Year(dAdmissao)
     dAno2 := Year(dDemissao)

     if LastKey() == 27
       nEsc := Alert('Deseja:', {'Cancelar','Retornar', 'Processar'})
       if nEsc == 1
          exit
       elseif nEsc == 2
          nAnyUso += 1
       elseif nEsc == 3
       endif
     endif


     //verifica qual o tempo de contribuicao

     nTempoContribuicao := (dAno2 - dAno1)
     Alert(nTempoContribuicao)
     if cSexo == 'M' .and. nTempoContribuicao < 29
        Alert('Tempo de contribuicao menor que 29, nao sera validado')
        lNegadoM := .t.
     elseif cSexo == 'F' .and. nTempoContribuicao < 22
        Alert('Tempo de contribuicao menor que 22 anos, nao sera validado')
        lNegadoF := .t.
     endif

     // verifica se colaborador trabalhou em 2009, 2012, 2015 e 2018
     if dAno1 <= 2009 .and. dAno2 >= 2009
        nRemuneracao := nSalarioBase + (nSalarioBase * 0.09)
     elseif dAno1 <+ 2012 .and. dAno2 >= 2012
        nRemuneracao := nSalarioBase + (nSalarioBase * 0.09)
     endif

     if dAno1 <= 2015 .and. dAno2 >= 2015
        nRemuneracao := nSalarioBase - (nSalarioBase * 0.03)
     elseif  dAno1 <= 2018 .and. dAno2 >= 2018
        nRemuneracao := nSalarioBase - (nSalarioBase * 0.03)
     endif



    //estat¡sticas
     if cSexo == 'M' .and. nIdade > 82
        nHomens82 += 1
     endif

     if cSexo == 'F' .and. dAno1 < 2022
        nMulheres2022 += 1
     endif

     if cSexo == 'M' .and. lNegadoM == .t.
        nRemuneracao := 0
     elseif cSexo == 'F' .and. lNegadoF == .t.
        nRemuneracao := 0
     endif

     if lNegadoM != .f.
        nHomensAposentados += 1
     endif
     if lNegadoF != .f.
        nMulheresAposentadas += 1
     endif

     nTotalGasto += nRemuneracao
     nContadorEmp -= 1
  enddo

  clear
@ 01,01 say 'O n£mero de homens aposentados foi de:'+Str(nHomensAposentados)
@ 02,01 say 'O n£mero de mulheres aposentadas foi de:'+Str(nMulheresAposentadas)
@ 03,01 say 'O total de gastos que o governo ter  ‚ de R$'+Str(nTotalGasto)
@ 04,01 say 'A m‚dia salarial da aposentadoria a ser paga ser  de:'+Str(nTotalGasto/nContadorEmp)
inKey( 0 )

