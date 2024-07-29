//Gustavo Barbosa Dantas

set color to 'K/W'

set epoch to 1940
set date to British
set scoreboard off
set century on

do while .t.
   clear
   nEmpregados := 0


   @ 01,01 say 'Insira o numero de empregados a serem analisados:'
   @ 01,50 get nEmpregados picture "9999999" valid nEmpregados > 0
   read

   if LastKey() == 27
      nOpcao := Alert ('Sair do programa?', {'Sim', 'Nao'})
      if nOpcao == 1
         Exit
      else
         loop
      endif
   endif

   clear

   nContador            := nEmpregados
   lProcessamento       := .f.
   nHomensAposentados   := 0
   nMulheresAposentadas := 0
   nPessoasAposentadas  := 0
   nRemuneracaoTotal    := 0
   nMulheres2002        := 0
   nHomens82            := 0
   nMulheresIRRF        := 0

   do while .t.
      cNomeColaborador        := Space (30)
      cSexo                   := Space (1)
      dNascimento             := CToD ('')
      dAdmissao               := CToD ('')
      dDemissao               := CToD ('')
      nSalarioBase            := 0
      nLimiteIRRF             := 0
      nValorIIRF              := 0
      nAdicionalNoturno       := 0
      nAdicionalInsalubridade := 0
      lAposentadoria          := .f.
      nRemuneracaoParcial     := 0

      @ 01,01 say "Numero a ser analisado:" + AllTrim(Str(nContador))

      @ 03,01 say "Nome do Colaborador(a).."
      @ 03,58 say "Sexo(M/F)"
      @ 04,01 say 'Data de Nascimento......'
      @ 05,01 say 'Data admissao...........'
      @ 06,01 say 'Data demissao...........'
      @ 07,01 say 'Salario base............'
      @ 08,01 say 'Limite IRRF.............'
      @ 09,01 say 'Adicional Noturno.......'
      @ 10,01 say 'Adicional insalubridade'





      @ 03,25 get cNomeColaborador picture "@!"                           valid !Empty(cNomeColaborador)
      @ 03,67 get cSexo            picture "@!"                           valid cSexo $ 'MF'
      @ 04,25 get dNascimento                                             valid dNascimento              <  Date() .and. !Empty(dNascimento)
      @ 05,25 get dAdmissao                                               valid dAdmissao                >  dNascimento
      @ 06,25 get dDemissao                                               valid dDemissao                >  dAdmissao
      @ 07,25 get nSalarioBase              picture '@E R$ 9,999,999.99'  valid nSalarioBase             >  0
      @ 08,25 get nLimiteIRRF               picture '@E R$ 9,999,999.99'  valid nLimiteIRRF              >= 0
      @ 09,25 get nAdicionalNoturno         picture '999'                 valid nAdicionalNoturno        >= 0
      @ 10,25 get nAdicionalInsalubridade   picture '999'                 valid nAdicionalInsalubridade  >= 0
      read

      if LastKey() == 27
         nOpcao := Alert ('O que deseja fazer?', {'Cancelar', 'Retornar', 'Processar'})
         if nOpcao == 1
            Exit
         elseif nOpcao == 2
            loop
         else
            lProcessamento := .t.
            Exit
         endif
      endif

      if cSexo == 'F' .and. Year(dAdmissao) < 2002 .and. Year(dDemissao) >= 2002
         nMulheres2002 += 1
      endif

      if nAdicionalNoturno > 0
         nAdicionalNoturno := nSalarioBase * (nAdicionalNoturno/100)
      endif

      if nAdicionalInsalubridade > 0
         lAdicionalInsalubridade := nAdicionalInsalubridade * (nAdicionalInsalubridade/100)
      endif

      nIdade := Year(dDemissao) - Year(dNascimento)
      if Month(dNascimento) > Month(dDemissao)
         nIdade -= 1
      endif

      nAnosTrabalhados := Year(dDemissao) - Year(dAdmissao)
      if Month(dAdmissao) > Month(dDemissao)
         nAnosTrabalhados -= 1
      endif

      if cSexo == 'M' .and. nIdade > 82
         nHomens82 += 1
      endif

      if cSexo == 'M' .and.nIdade >= 61 .and. nAnosTrabalhados >= 29
         lAposentadoria      := .t.
         nHomensAposentados  += 1
         nPessoasAposentadas += 1
      endif

      if cSexo == 'F' .and. nIdade >= 58 .and. nAnosTrabalhados >= 22
         lAposentadoria       := .t.
         nMulheresAposentadas += 1
         nPessoasAposentadas  += 1
      endif

      //Calcular se trabalhou em 2009, 2012, 2015 ou 2018 - Se tiver tempo, procurar uma forma melhor de calcular
      nAdicionalAno := 0

      do while .t.
         if Year(dAdmissao) <= Year(dDemissao)
            if (Year(dAdmissao) == 2009) .or. (Year(dAdmissao) == 2012)
               nAdicionalAno += (nSalarioBase * (9/100))
            elseif (Year(dAdmissao) == 2015) .or. (Year(dAdmissao) == 2018)
               nAdicionalAno -= (nSalarioBase * (3/100))
            endif
            dAdmissao += 365
         else
            exit
         endif
      enddo

      //CALCULO DE REMUNERA€ÇO APOSENTADORIA

      if nLimiteIRRF < nSalarioBase
         nValorIIRF -= nSalarioBase * (7/100)
         if cSexo = 'F'
            nMulheresIRRF += 1
         endif
      endif

      nRemuneracaoParcial := nSalarioBase + nAdicionalInsalubridade + nAdicionalNoturno
      if lAposentadoria = .t.
         nRemuneracaoParcial += nAdicionalAno + nValorIIRF
      endif

      nRemuneracaoTotal += nRemuneracaoParcial




      ////////////////////////////// se tiver tempo para fazer uma tabela mostrando os dados inseridos
      if nContador > 1
         nContador--
         loop
      else
         lProcessamento := .t.
         exit
      endif
   enddo

   if lProcessamento = .t.
      clear

      @ 00,00 to 07,79 double

      @ 01,01 say 'Porcentagem de homens aposentados..............: ' + AllTrim(Str(nPorcentagemHomensAposentados)+ '%')
      @ 02,01 say 'Porcentagem de mulheres aposentadass...........: ' + AllTrim(Str(nPorcentagemMulheresAposentadas)+ '%')
      @ 03,01 say 'Quantidade de homens com mais de 82 anos.......: ' + AllTrim(Str(nHomens82))
      @ 04,01 say 'Quantidade de mulheres adimitidas antes de 2002: ' + AllTrim(Str(nMulheres2002))
      @ 05,01 say 'Porcentagem de mulheres que pagam IRRF.........: ' + AllTrim(Str(nMulheresIRRF))
      @ 06,01 say 'Remuneracao total..............................: ' + AllTrim(Str(nRemuneracaoTotal))
      inkey(0)
   nOpcao := Alert('Deseja reiniciar o programa ou sair?', {'Reiniciar','Sair'})
     if nOpcao == 1
        loop
     else
        exit
     endif
   endif
enddo



