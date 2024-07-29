//Rian da Cruz Torres da silva

set date to british
set epoch to 1940
set scoreboard off

set color to 'N/W'
clear

do while .t.

    cStatus          :=''

    nEmpregados      := 0
    nHomensApos      := 0
    nMulheresApos    := 0
    nHomens82        := 0
    nMulheres2002    := 0


    @ 01,01 say 'Numero de empregados(a):'
        
    @ 01,25 get nEmpregados       picture '999'         Valid !Empty (nEmpregados)
    Read

    if lastkey() == 27
        nOpcao:= Alert('O que deseja?', {'SAIR', 'CONTINUAR',}, 'N/R')

        if nOpcao == 1
            exit
        else 
            loop
        endif
    endif

    do while nEmpregados > 0 .or. Empty (cStatus)
        cNome            := Space ( 30 )
        cSexo            := Space ( 1 )

        dData1           := cToD('01/01/09')
        nAnoData1        := Year(dData1)
        dData2           := cToD('01/01/12')
        nAnoData2        := Year(dData2)
        dData3           := cToD('01/01/15')
        nAnoData3        := Year(dData3)
        dData4           := cToD('01/01/18')
        nAnoData4        := Year(dData4)

        dData            := Date()
        nDiaHoje         := day  (dData)
        nMesHoje         := Month(dData)
        nAnoHoje         := year (dData)  


        dNascimento      := CToD ('') 
        dAdmissao        := CToD ('')
        dDemissao        := CToD ('')     

        nIdade           := 0
        nTempoTrab       := 0

        nSalarioBase     := 0
        nSalarioTotal    := 0
        nValorIRRF       := 0
        nAdcionalNoturno := 0
        nAdcionalInsa    := 0
        nAdcionalApos    := 0
        nReducaoApos     := 0


        @ 02,01 say 'Nome do Colaborador....:'
        @ 03,01 say 'Data Nascimento........:'
        @ 04,01 say 'Sexo...................:'
        @ 05,01 say 'Data de Admissao.......:'
        @ 06,01 say 'Data de Demissao.......:'
        @ 07,01 say 'Salario Base...........:'
        @ 08,01 say 'Adcional Noturno.......:%'
        @ 09,01 say 'Adcional insalubridade.:%'

        @ 02,25 get cNome             picture '@!'          Valid !Empty (cNome)
        @ 03,25 get dNascimento                             Valid dNascimento < dData
        @ 04,25 get cSexo             picture '@!'          Valid cSexo == 'M' .or. cSexo == 'F'
        @ 05,25 get dAdmissao                               Valid !Empty (dAdmissao)
        @ 06,25 get dDemissao                               Valid !Empty (dDemissao)
        @ 07,25 get nSalarioBase      picture '@e 9,999'    Valid nSalarioBase > 0
        @ 08,26 get nAdcionalNoturno  picture '@e 99'       Valid nAdcionalNoturno >= 0
        @ 09,26 get nAdcionalInsa     picture '@e 99'       Valid nAdcionalInsa >= 0
        Read

        if lastkey() == 27
            nOpcao:= Alert('O que deseja?', {'Cancelar', 'Retornar', 'Processar'}, 'N/R')
    
            if nOpcao == 1
                exit
            elseif nOpcao == 2
                loop
            else
                cStatus:='Processar'
            endif
        endif


        nDiaNascimento   := day(dNascimento)
        nMesNascimento   := Month(dNascimento)
        nAnoNascimento   := year(dNascimento)

        nDiaAdmissao     := day(dAdmissao)
        nMesAdmissao     := Month(dAdmissao)
        nAnoAdmissao     := year(dAdmissao)

        nDiaDemissao     := day(dDemissao)
        nMesDemissao     := Month(dDemissao)
        nAnoDemissao     := year(dDemissao) 

        if nDiaNascimento <= nDiaHoje .and. nMesNascimento <= nMesHoje
            nIdade := nAnoHoje - nAnoNascimento
        else 
            nIdade := nAnoHoje - nAnoNascimento - 1
        endif

        if nDiaAdmissao <= nDiaDemissao .and. nMesAdmissao <= nMesDemissao
            nTempoTrab := nAnoDemissao - nAnoAdmissao
        else
            nTempoTrab := nAnoDemissao - nAnoAdmissao - 1
        endif 

        
        if cSexo == 'M'
            if nIdade >= 61 .and. nTempoTrab >= 29
                nHomensApos++
                if nIdade >=82
                    nHomens82++
                endif
            endif
        elseif cSexo =='F'
            if nIdade >= 58 .and. nTempoTrab >= 22
                nMulheresApos++
                if nAnoAdmissao < 2002
                    nMulheres2002 ++
                endif
            endif
        endif

        nSalarioTotal:=nSalarioBase
        
        if !Empty (nAdcionalNoturno) 
        nValorNoturno:=(nSalarioBase*nAdcionalNoturno)/100
        nSalarioTotal+=nValorNoturno
        endif

        if !Empty (nAdcionalInsa)
        nValorInsa   :=(nSalarioBase*nAdcionalInsa)/100
        nSalarioTotal+=nValorInsa
        endif

        if nAnoAdmissao >= nAnoData1 .and. nAnoAdmissao <= nAnoData2
            nAdcionalApos:=(nSalarioBase*9)/100
            nSalarioTotal+=nAdcionalApos
        elseif nAnoAdmissao >= nAnoData3 .and. nAnoAdmissao <=nAnoData4
            nReducaoApos:=(nSalarioBase*3)/100
            nSalarioTotal-=nReducaoApos
        endif


        
        @ 10,25 say Alltrim(str(nSalarioTotal))


        nEmpregados--
        inkey(0)
    enddo
    if cStatus = 'Processar'

        clear 

        @ 16,25 say 'Homens Aposentados................:' + Alltrim(str(nHomensApos))
        @ 17,25 say 'Homens maiores de 82 anos.........:' + Alltrim(str(nHomens82))
        @ 18,25 say 'Mulheres Aposentadas..............:' + Alltrim(str(nMulheresApos))
        @ 19,25 say 'Mulheres contratadas antes de 2002:' + Alltrim(str(nMulheres2002))
    endif
enddo