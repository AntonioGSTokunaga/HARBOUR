//Joaquim Alexendre Ribeiro Machado

set scoreboard off
set date british
set century on
set epoch to 1940
set color to "B/W"

clear

@ 00,00 to 24,79 double

//variaveis gerais
dDataAtual          := date()
nAnoAtual           := year(dDataAtual)
nOpcao              := 0
nQntdAnalisados     := 0
nContadorEmpregados := 0
nAptoAposentadoM    := 0
nAptoAposentadoF    := 0

nHomens             := 0
nMulheres           := 0

nIdadeAcima82      := 0
nAdmitidas2002     := 0
nMulherPagaIRRF    := 0

nTotalRemuneracaoM  := 0
nTotalRemuneracaoF  := 0

//variaveis mascara
cMascUpper       := "@!"
cMascQntd        := "99"
cMascPorcentagem := "99"
cMascSalario     := "@E 99,999.99"

do while .t.

    @ 02,05 clear to 23,78

    @ 02,05 say "Digite o numero de empregadores a serem analisados:"

    @ 02,60 get nQntdAnalisados picture cMascQntd valid !Empty(nQntdAnalisados)
    read

    do while nContadorEmpregados < nQntdAnalisados

        cNomeColaborador        := space(20)
        cSexoColaborador        := space(1)
        dDataNascimento         := CToD("")
        dDataAdmissao           := CToD("")
        dDataDemissao           := CToD("")
        nValorSalario           := 0
        nValorSalarioTotal      := 0
        nLimiteIRRF             := 0
        nAdicionalNoturno       := 0
        nAdicionalInsalubridade := 0

        nIdade                  := 0
        nAnosTrabalhando        := 0

        @ 02,05 clear to 03,78

        @ 02,05 say "Nome:"
        @ 03,05 say "Sexo(M/F):"
        @ 03,35 say "Data de Nascimento:"
        @ 04,05 say "Data de Admissao:"
        @ 04,35 say "Data de Demissao:"
        @ 05,05 say "Salario Base:"
        @ 05,35 say "Valor Limite IRRF:"
        @ 06,40 say "Adicional Noturno(%):"
        @ 06,05 say "Adicional Insalubridade(%):"

        @ 02,11 get cNomeColaborador        picture cMascUpper       valid !Empty(cNomeColaborador)
        @ 03,15 get cSexoColaborador        picture cMascUpper       valid !Empty(cSexoColaborador) .and. cSexoColaborador $ "MF"
        @ 03,55 get dDataNascimento                                  valid !Empty(dDataNascimento)  .and. dDataNascimento < date()
        @ 04,23 get dDataAdmissao                                    valid !Empty(dDataAdmissao)    .and. dDataAdmissao > dDataNascimento
        @ 04,52 get dDataDemissao                                    valid !Empty(dDataDemissao)    .and. dDataDemissao > dDataAdmissao
        @ 05,18 get nValorSalario           picture cMascSalario     valid !Empty(nValorSalario)
        @ 05,53 get nLimiteIRRF             picture cMascSalario     valid !Empty(nLimiteIRRF)
        @ 06,32 get nAdicionalInsalubridade picture cMascPorcentagem
        @ 06,60 get nAdicionalNoturno       picture cMascPorcentagem 
        read

        if lastkey() == 27
            nOpcao := alert("oque deseja fazer?" , {"Cancelar" , "Retornar" , "Processar"} , "W/B")

            if nOpcao == 2
               loop
            else
               exit
            endif
        endif

        nAnoNascimento    := year(dDataNascimento)
        nAnoAdmissao      := year(dDataAdmissao)
        nAnoDemissao      := year(dDataDemissao)

        nContadorAdmissao   := year(dDataAdmissao)
        nContadorNascimento := year(dDataNascimento)
   
        nValorSalarioTotal = nValorSalario + (nValorSalario * (nAdicionalNoturno / 100)) + (nValorSalario * (nAdicionalInsalubridade / 100))
        Alert(str( nValorSalarioTotal))
        //Descobrindo idade

        do while nContadorNascimento < nAnoAtual
            nIdade++
            nContadorNascimento++
        enddo

        do while nContadorAdmissao < nAnoDemissao
            nAnosTrabalhando++
            nContadorAdmissao++
        enddo

        if cSexoColaborador == "M"
            if nIdade >= 61
                if nAnosTrabalhando >= 29
                    nAptoAposentadoM++

                    if nAnoAdmissao <= 2009 .and. nAnoDemissao >= 2012
                        nTotalRemuneracaoM += nValorSalarioTotal
                        nTotalRemuneracaoM += (nValorSalario * 0.09)
                        alert(str(nTotalRemuneracaoM += (nValorSalario * 0.09)))

                        if nAnoAdmissao <= 2015 .and. nAnoDemissao >= 2018
                            nTotalRemuneracaoM -= (nValorSalario * 0.03)
                            alert(str(nTotalRemuneracaoM -= (nValorSalario * 0.03)))
                        endif
                        if nValorSalario > nLimiteIRRF
                            nTotalRemuneracaoM -= (nValorSalario * 0.07)
                            alert(str(nTotalRemuneracaoM -= (nValorSalario * 0.07)))
                        endif
                    endif            
                endif
            endif
        endif

        if cSexoColaborador == "F"
            if nIdade >= 58
                if nAnosTrabalhando >= 22
                    nAptoAposentadoF++
                    
                    if nAnoAdmissao <= 2009 .and. nAnoDemissao >= 2012
                        nTotalRemuneracaoF += nValorSalarioTotal
                        ntotalRemuneracaoF += (nValorSalario * 0.09)

                        if nAnoAdmissao <= 2015 .and. nAnoDemissao >= 2018
                            nTotalRemuneracaoF -= (nValorSalario * 0.03)
                        endif
                        if nValorSalario > nLimiteIRRF
                            nTotalRemuneracaoF -= (nValorSalario * 0.07)
                        endif
                    endif            
                endif
            endif
        endif

        if cSexoColaborador == "M"
            nHomens++
            if nIdade > 82
                nIdadeAcima82++
            endif
        endif

        if cSexoColaborador == "F"
            nMulheres++
            if nAnoAdmissao < 2002
                nAdmitidas2002++
            endif
        endif

        if cSexoColaborador == "F"
            if nValorSalario > nLimiteIRRF
                nMulherPagaIRRF++
            endif
        endif

        nContadorEmpregados++
    enddo

    if nOpcao == 1
        loop
    endif

    nPorcentagemAposentadoM := nHomens - nAptoAposentadoM
    nPorcentagemAposentadoF := nMulheres - nAptoAposentadoF)

    @ 02,05 clear to 23,78

    @ 02,05 say "O percentual de homens aposentados e............: " + alltrim(str(nPorcentagemAposentadoM))
    @ 03,05 say "O percentual de mulheres aposentadas e..........: " + alltrim(str(nPorcentagemAposentadoF))
    @ 04,05 say "O Valor total da remuneracao dos homens e.......: " + alltrim(transform(nTotalRemuneracaoM , "@ 999,999.99"))
    @ 05,05 say "O Valor total da remuneracao das mulheres e.....: " + alltrim(transform(nTotalRemuneracaoF , "@ 999,999.99"))
    @ 06,05 say "A quantidade de Homens com mais de 82 anos......: " + alltrim(str(nIdadeAcima82))
    @ 07,05 say "A quantidade de mulheres admitidas antes de 2002: " + alltrim(str(nAdmitidas2002))
    @ 08,05 say "O percentual de mulheres que pagam IRRF.........: " + alltrim(str(nMulherPagaIRRF))

    @ 20,05 say "Pressione qualquer tecla para sair do programa..."
    inkey(0)
    exit
enddo
