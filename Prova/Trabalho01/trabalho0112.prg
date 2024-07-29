// DAVI TAVEIRA

// DEFINICOES DE AMBIENTE
set date       to british
set scoreboard off
set epoch      to 1930
set color      to 'W/B'
clear

do while .t. // PROGRAMA

    // BOX
    @ 00,00       to 24,79 double
    @ 01,01 clear to 23,78

    // VARIAVEIS
    nEmpregados              := 0
    nOpcao                   := 0
    cCorPadrao               := 'W/B'
    cMascTotal               := '@E 999,999,999.99'

    @ 01,01 say 'Numero de empregados a serem analisados:'
    @ 01,42 get nEmpregados picture 9999 valid nEmpregados > 0
    read

    if LastKey() == 27 
        nOpcao := Alert( 'Deseja encerrar o programa?.' , { 'SIM','NAO' } , cCorPadrao )
        if nOpcao == 1
            exit // ENCERRA PROGRAMA           
        else 
            loop
        endif
    endif

    do while .t. // CONTROLE INSS

        // VARIAVEIS
        nContador            := 0
        cNome                := Space(25)
        cSexo                := Space(1)      
        dAtual               := Date()  
        dNascimento          := CToD('')
        dAdmissao            := CToD('')
        dDemissao            := CToD('')
        nSalarioBase         := 0
        nAdcInsalubridade    := 0
        nLimiteIRRF          := 0
        nAdcNoturno          := 0
        nAposentadosM        := 0
        nAposentadosF        := 0
        nTotalRemuneracao    := 0
        nTotalRemuneracaoM   := 0
        nTotalRemuneracaoF   := 0
        nHomens              := 0
        nMulheres            := 0
        nHomens82            := 0
        nMulheres2002        := 0
        nMulheresIRRF        := 0
        nPorcentagemF        := 0
        nPorcentagemH        := 0

        clear 
        @ 01,01 say 'Analisando '+AllTrim( Str( nEmpregados ) )+' Empregados'

        do while nContador < nEmpregados // INSERCAO DADOS EMPREGADOS
        
            // RESET VARIAVEIS
            cNome                 := Space(25)
            cSexo                 := Space(1)    
            dNascimento           := CToD('')
            dAdmissao             := CToD('')
            dDemissao             := CToD('')
            nAnoNascimento        := 0
            nMesNascimento        := 0
            nDiaNascimento        := 0
            nAnoAtual             := 0
            nMesAtual             := 0
            nDiaAtual             := 0
            nIdade                := 0
            nSalarioBase          := 0
            nSalarioAposentadoria := 0
            nAdcInsalubridade     := 0
            nLimiteIRRF           := 0
            nAdcNoturno           := 0
            nAnosTrabalho         := 0
            nAnoAdmissao          := 0
            nMesAdmissao          := 0
            nDiaAdmissao          := 0
            nAnoDemissao          := 0
            nMesDemissao          := 0
            nDiaDemissao          := 0
            lAposentadoria        := .f.

            @ 03,01 say 'Dados Do empregado '+AllTrim( Str( nContador+1 ) )
            @ 04,01 say 'Nome..............:'
            @ 05,01 say 'Sexo.( M ou F )...:'
            @ 05,47 say 'Data Nascimento...:'
            @ 06,01 say 'Data Admissao.....:'
            @ 07,01 say 'Salario Base......:'
            @ 06,47 say 'Data Demissao.....:'
            @ 07,47 say 'Adic Insalubridade:'
            @ 08,01 say 'Limite IRRF.......:'
            @ 08,47 say 'Adic Noturno......:'
            
            @ 04,21 get cNome picture '@!' valid !Empty(cNome)
            @ 05,21 get cSexo picture '@!' valid cSexo == 'F' .or. cSexo == 'M'
            @ 05,67 get dNascimento        valid dNascimento < dAtual
            @ 06,21 get dAdmissao          valid dAdmissao < dAtual .and. dAdmissao > dNascimento
            @ 06,67 get dDemissao          valid dDemissao < dAtual .and. dDemissao > dAdmissao
            @ 07,21 get nSalarioBase       valid nSalarioBase      > 0
            @ 07,67 get nAdcInsalubridade  valid nAdcInsalubridade >= 0
            @ 08,21 get nLimiteIRRF        valid nLimiteIRRF       >= 0
            @ 08,67 get nAdcNoturno        valid nAdcNoturno       >= 0

            read

            if LastKey() == 27 
                nOpcao := Alert( 'ESC PRESSIONADO.' , { 'PROCESSAR','RETORNAR','CANCELAR' } , cCorPadrao )
                if nOpcao == 3
                    nOpcao := 9 // ENCERRA PROGRAMA
                    exit
                elseif nOpcao == 2
                    loop     
                elseif nOpcao == 1
                    exit   
                endif
            endif

            // CALCULA IDADE
            nAnoNascimento := Year(dNascimento)
            nMesNascimento := Month(dNascimento)
            nDiaNascimento := Day(dNascimento)
            nAnoAtual      := Year(dAtual)
            nMesAtual      := Month(dAtual)
            nDiaAtual      := Day(dAtual)
            nIdade         := 0

            nIdade := nAnoAtual - nAnoNascimento
            // AINDA NAO FEZ ANIVERSARIO
            if nMesNascimento > nMesAtual .or. (nMesNascimento == nMesAtual .and. nDiaAtual > nDiaNascimento)
                nIdade--
            endif

            // CALCULA TEMPO DE TRABALHO
            nAnoAdmissao   := Year(dAdmissao)
            nMesAdmissao   := Month(dAdmissao)
            nDiaAdmissao   := Day(dAdmissao)
            nAnoDemissao   := Year(dDemissao)
            nMesDemissao   := Month(dDemissao)
            nDiaDemissao   := Day(dDemissao)
            nAnosTrabalho  := 0

            nAnosTrabalho := nAnoDemissao - nAnoAdmissao

            // NAO COMPLETOU O ANO
            if nMesAdmissao > nMesDemissao .or. (nMesAdmissao == nMesDemissao .and. nDiaDemissao > nDiaAdmissao)               
                nAnosTrabalho--
            endif


            // VERIFICACOES MASCULINO
            if cSexo == 'M'
                nHomens++
                if nIdade > 82
                    nHomens82++
                endif
                if nIdade >= 61 .and. nAnosTrabalho >= 29
                    lAposentadoria := .t.
                    nAposentadosM++                   
                endif
            endif

            // VERIFICACOES FEMININO
            if cSexo == 'F'
                nMulheres++
                if nIdade >= 58 .and. nAnosTrabalho >= 22
                    lAposentadoria := .t.
                    nAposentadosF++
                    if nAnoAdmissao < 2002
                        nMulheres2002++
                    endif
                endif
            endif

            // CALCULO APOSENTADORIA
            if lAposentadoria == .t.
                nSalarioAposentadoria := nSalarioBase
                if nAnoAdmissao <= 2009 .and. nAnoDemissao >= 2012
                    nSalarioAposentadoria += nSalarioBase * 0.09
                endif

                if nAnoAdmissao <= 2015 .and. nAnoDemissao >= 2018
                    nSalarioAposentadoria -= nSalarioBase * 0.03
                endif

                nSalarioAposentadoria += (nAdcNoturno / 100) * nSalarioBase
                
                nSalarioAposentadoria += (nAdcInsalubridade / 100) * nSalarioBase

                // REDUTOR IRFF DOS APOSENTADOS
                if nSalarioAposentadoria > nLimiteIRRF
                    nSalarioAposentadoria -= nSalarioBase * 0.07
                    if cSexo == 'F'
                        nMulheresIRRF++
                    endif
                endif

                if cSexo == 'M'
                    nTotalRemuneracaoM += nSalarioAposentadoria
                elseif cSexo == 'F'
                    nTotalRemuneracaoF += nSalarioAposentadoria
                endif

            elseif nSalarioBase > nLimiteIRRF
                // MULHERES SEM APOSENTADORIA QUE PAGAM IRRF
                if cSexo == 'F'
                    nMulheresIRRF++
                endif
            endif

            nContador++ // INCREMENTA CONTADOR
        enddo

        if nOpcao == 9 // ENCERRA PROGRAMA
            exit
        endif

        // % DOS APOSENTADOS
        nPorcentagemH := (nAposentadosM * 100) / nHomens
        nPorcentagemF := (nAposentadosF * 100) / nMulheres

        nTotalRemuneracao := nTotalRemuneracaoM + nTotalRemuneracaoF

        // QUADRO FINAL
        @ 01,01 clear to 23,78
        @ 01,01 say 'Relatorio:'
        @ 03,01 say '% de Homens Aposentados.........: ' + Str( nPorcentagemH, 6 , 2) + '%'
        @ 04,01 say 'Homens com mais de 82 anos......: ' + AllTrim( Str( nHomens82 ) )
        
        @ 06,01 say '% de Mulheres Aposentadas.......: ' + Str( nPorcentagemF , 6 , 2 ) + '%'
        @ 07,01 say 'Mulheres admitidas antes de 2002: ' + AllTrim( Str( nMulheres2002 ) )
        @ 08,01 say 'Mulheres que pagam IRFF.........: ' + AllTrim( Str( nMulheresIRRF ) )
        
        @ 10,01 say 'Valor da Remuneracao Homens.....: R$' + Transform( nTotalRemuneracaoM, cMascTotal )
        @ 11,01 say 'Valor da Remuneracao Mulheres...: R$' + Transform( nTotalRemuneracaoF, cMascTotal )                
        @ 12,01 say 'Valor Total da Remuneracao......: R$' + Transform( nTotalRemuneracao, cMascTotal )

        InKey(0)

        nOpcao := Alert( 'Analise Finalizada' , { 'MENU' , 'INSERIR NOVAMENTE OS DADOS' }, cCorPadrao )
        if nOpcao == 2
            loop
        else 
            exit
        endif


    enddo


enddo 