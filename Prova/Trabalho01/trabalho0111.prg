// Lucas Kolapouski Serafim

set color to '0/15'
set epoch to 1940
set date to british
set scoreboard off


do while .t.

    clear

    cMascaraValores             := '@e 99,999.99'

    cStatus                     := 'recebendo'
    nOpcao                      := 0

    nEmpregados                 := 0
    nEntrevistados              := 0

    nHomens                     := 0
    nMulheres                   := 0

    nAptos                      := 0
    nInaptos                    := 0
    nHomensAptos                := 0
    nMulheresAptas              := 0
    nMulheresAntes2002          := 0
    nValorTotalHomens           := 0
    nValorTotalMulheres         := 0
    nValorTotalAposentados      := 0
    nHomensMaiores82            := 0
    nMulheresIRRF               := 0

    nPercentualHomens           := 0
    nPercentualMulheres         := 0

    nDiaHoje                    := Day( Date() )
    nMesHoje                    := Month( Date() )
    nAnoHoje                    := Year( Date() )

    nDiaNascimento              := CToD( ' ' )
    nMesNascimento              := CToD( ' ' )
    nAnoNascimento              := CToD( ' ' )

    nDiaAdmissao                := CToD( ' ' )
    nMesAdmissao                := CToD( ' ' )
    nAnoAdmissao                := CToD( ' ' )

    nDiaDemissao                := CToD( ' ' )
    nMesDemissao                := CToD( ' ' )
    nAnoDemissao                := CToD( ' ' )
    

    @ 01,01 say 'Quantos empregados serao analisados?'
    @ 01,38 get nEmpregados picture '999' valid nEmpregados > 0
    read
    
    if LastKey() == 27
        nOpcao := Alert( 'Voce realmente deseja sair do programa?', {'Sim', 'Nao'}, 'W/B' )
        if nOpcao == 1
            exit
        else
            loop
        endif
    endif


    do while cStatus = 'recebendo'

        cNomeColaborador            := Space( 30 )
        cSexoColaborador            := ' '
        dNascimentoColaborador      := CToD( ' ' )
        dAdmissaoColaborador        := CToD( ' ' )
        dDemissaoColaborador        := CToD( ' ' )
        nSalarioBase                := 0
        nLimiteIRRF                 := 0
        nAdicionalNoturno           := 0
        nAdicionalInsalubridade     := 0
        nIdade                      := 0
        nAnosTrabalhados            := 0
        nValorAposentadoria         := 0
        cStatusColaborador          := 'inapto'
        
        @ 03,01 say 'Nome do colaborador........:'
        @ 04,01 say 'Sexo.......................:'
        @ 05,01 say 'Data de nascimento.........:'
        @ 06,01 say 'Data de admissao...........:'
        @ 07,01 say 'Data de demissao...........:'
        @ 08,01 say 'Valor do salario base......:'
        @ 09,01 say 'Valor limite IRRF..........:'
        @ 10,01 say 'Adicional noturno (%)......:'
        @ 11,01 say 'Adicional insalubridade (%):'

        @ 03,30 get cNomeColaborador        picture '@!'                    valid !Empty( cNomeColaborador )
        @ 04,30 get cSexoColaborador        picture '@!'                    valid cSexoColaborador $ 'FM'
        @ 05,30 get dNascimentoColaborador                                  valid !Empty( dNascimentoColaborador ) .and. dNascimentoColaborador < Date()
        @ 06,30 get dAdmissaoColaborador                                    valid dAdmissaoColaborador > dNascimentoColaborador
        @ 07,30 get dDemissaoColaborador                                    valid dDemissaoColaborador > dAdmissaoColaborador              
        @ 08,30 get nSalarioBase            picture cMascaraValores         valid nSalarioBase > 0
        @ 09,30 get nLimiteIRRF             picture cMascaraValores         valid nLimiteIRRF > 0
        @ 10,30 get nAdicionalNoturno       picture '999'                   valid nAdicionalNoturno >= 0 
        @ 11,30 get nAdicionalInsalubridade picture '999'                   valid nAdicionalInsalubridade >= 0
        read
        
        if LastKey() == 27
            nOpcao := Alert( 'O que voce deseja fazer?', {'Cancelar', 'Retornar', 'Processar'}, 'W/B' )
            if nOpcao == 1
                @ 03,00 clear to 24,78
                exit
            elseif nOpcao == 3
                cStatus := 'processar'
                --nEntrevistados
            else
                loop
            endif
        endif

        nDiaNascimento              := Day( dNascimentoColaborador )
        nMesNascimento              := Month( dNascimentoColaborador )
        nAnoNascimento              := Year( dNascimentoColaborador )

        nDiaAdmissao                := Day( dAdmissaoColaborador )
        nMesAdmissao                := Month( dAdmissaoColaborador )
        nAnoAdmissao                := Year( dAdmissaoColaborador )

        nDiaDemissao                := Day( dDemissaoColaborador )
        nMesDemissao                := Month( dDemissaoColaborador )
        nAnoDemissao                := Year( dDemissaoColaborador )

        // Calculando idade

        if nDiaNascimento <= nDiaHoje .and. nMesNascimento <= nMesHoje
            nIdade := nAnoHoje - nAnoNascimento
        else
            nIdade := nAnoHoje - nAnoNascimento - 1
        endif
        
        // Calculando tempo trabalhado

        if nDiaDemissao >= nDiaAdmissao .and. nMesDemissao >= nMesAdmissao
            nAnosTrabalhados := nAnoDemissao - nAnoAdmissao
        else
            nAnosTrabalhados := nAnoDemissao - nAnoAdmissao - 1
        endif

        // Verificando aptidao

        if cSexoColaborador == 'M'
            nHomens++
            if nIdade >= 61 .and. nAnosTrabalhados >= 29
                cStatusColaborador := 'apto'
                nHomensAptos++
                nAptos++
            endif
            if nIdade >= 82
                nHomensMaiores82++
            endif
        elseif cSexoColaborador == 'F'
            nMulheres++
            if nIdade >= 58 .and. nAnosTrabalhados >= 22
                cStatusColaborador := 'apto'
                nMulheresAptas++
                nAptos++
            endif
            if nAnoAdmissao < 2002
                nMulheresAntes2002++
            endif
        endif


        // Calculando remuneracao aposentadoria

        if cStatusColaborador == 'apto'

            nValorAposentadoria := nSalarioBase

            
            nValorAposentadoria += ( nSalarioBase * ( nAdicionalNoturno / 100 ) )
            nValorAposentadoria += ( nSalarioBase * ( nAdicionalInsalubridade / 100 ) )
            
            if nAnoAdmissao <= 2009 .and. nAnoDemissao >= 2012
                nValorAposentadoria += ( nSalarioBase * ( 9 / 100 ) ) 
            endif
            
            if nAnoAdmissao <= 2015 .and. nAnoDemissao >= 2018
                nValorAposentadoria -= ( nSalarioBase * ( 3 / 100 ) )  
            endif
            
            if nSalarioBase >= nLimiteIRRF
                nValorAposentadoria -= ( nSalarioBase * ( 7 / 100 ) ) 
                if cSexoColaborador == 'F'
                    nMulheresIRRF++
                endif
            endif
            
            if cSexoColaborador == 'F'
                nValorTotalMulheres += nValorAposentadoria
            else
                nValorTotalHomens += nValorAposentadoria
            endif

            nValorTotalAposentados := nValorTotalHomens + nValorTotalMulheres

        endif

        @ 13,01 say 'Valor aposentadoria: R$' + Transform( nValorAposentadoria, cMascaraValores )

        nEntrevistados++

        if nEntrevistados == nEmpregados
            Alert( 'Todos empregados foram analisados!' )
            cStatus := 'processar'
        endif

        InKey( 0 )

        @ 13,01 clear to 13,79

    enddo

    clear

    if cStatus == 'processar'

        nPercentualHomens       := ( nHomensAptos / nEntrevistados ) * 100 
        nPercentualMulheres     := ( nMulheresAptas / nEntrevistados ) * 100 
        nPercentualMulheresIRRF := ( nMulheresAptas / nMulheres ) * 100

        @ 01,01 say 'Total de entrevistados.................: ' + AllTrim( Str( nEntrevistados ) )

        @ 03,01 say 'Percentual de homens aposentados.......: ' + Transform( nPercentualHomens, '@e 99.9') + '%'
        @ 04,01 say 'Percentual de mulheres aposentadas.....: ' + Transform( nPercentualMulheres, '@e 99.9') + '%'

        @ 06,01 say 'Valor total remuneracao dos homens.....: R$ ' + Transform( nValorTotalHomens, cMascaraValores) 
        @ 07,01 say 'Valor total remuneracao das mulheres...: R$ ' + Transform( nValorTotalMulheres, cMascaraValores) 
        @ 08,01 say 'Valor total dos remunerados............: R$ ' + Transform( nValorTotalAposentados, cMascaraValores)

        @ 10,01 say 'Analisados com mais de 82 anos.........: ' + AllTrim( Str( nHomensMaiores82 ) )

        @ 12,01 say 'Mulheres admitidas antes do ano de 2002: ' + AllTrim( Str( nMulheresAntes2002 ) )

        @ 14,01 say 'Percentual de mulheres que pagam IRRF..: ' + Transform( nPercentualMulheresIRRF, '@e 999.9') + '%'

        InKey( 0 )

        exit

    endif


enddo