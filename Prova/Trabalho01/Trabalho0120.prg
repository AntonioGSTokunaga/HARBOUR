//Gabriel Augusto Pereira

set date to british
set epoch to 1940
set century on
set scoreboard off

do while .t.
   //variaveis
   nEmpregados             := 0
   nContador               := 0
   nSalarioBase            := 0
   nSalarioFinal           := 0
   nLimiteIRRF             := 0
   nAdicionalNoturno       := 0
   nAdicionalInsalubre     := 0
   nLinha                  := 0
   nContinuar              := -1
   nAnosTrabalhados        := 0
   nAptoAposentHomens      := 0
   nAptoAposentMulheres    := 0
   nIdade                  := 0
   nTotalAposentHomens     := 0
   nTotalAposentMulheres   := 0
   nHomensMaisDe82         := 0
   nMulheresAntesDe2002    := 0
   nMulheresPagandoIRRF    := 0

   nHomens                 := 0
   nMulheres               := 0
   nPercentHomensAposent   := 0
   nPercentMulheresAposent := 0

   cNome                   := space(20)
   cSexo                   := ' '

   dNascimento             := ctod('')
   dContratado             := ctod('')
   dDemitido               := ctod('')

   bAposentado             := .f.

   set color to 'W/BG+'
   clear

   @1,1 say "Informe o numero total de empregados:"
   @2,1 get nEmpregados             valid nEmpregados > 0
   read

   do while nContador < nEmpregados
      @3,1 clear to 12,50
      @3,0 to 14,70  double

      //Reiniciando valores
      nLinha               := 4

      @nLinha++,1 say "Digite o nome do empregado:"
      @nLinha++,1 say "Digite o sexo: [M/F]"
      @nLinha++,1 say "Digite a data de nascimento:"
      @nLinha++,1 say "Digite a data que foi contratado:"
      @nLinha++,1 say "Digite a data que foi demitido:"
      @nLinha++,1 say "Digite o salario base:"
      @nLinha++,1 say "Digite o limite IRRF:"
      @nLinha++,1 say "Digite o adicional noturno:"
      @nLinha++,1 say "Digite o adicional insalubre:"

      nLinha := 4

      @nLinha++,40 get cNome               picture '@!'               valid !empty(cNome)
      @nLinha++,40 get cSexo               picture '@!'               valid cSexo $ 'FM'
      @nLinha++,40 get dNascimento                                    valid dNascimento < date() .and. !empty(dNascimento)
      @nLinha++,40 get dContratado                                    valid dContratado < date() .and. dContratado > dNascimento
      @nLinha++,40 get dDemitido                                      valid dDemitido   < date() .and. dDemitido   > dContratado
      @nLinha++,40 get nSalarioBase        picture '@E R$ 999,999.99' valid nSalarioBase > 0
      @nLinha++,40 get nLimiteIRRF         picture '@E R$ 999,999.99' valid nLimiteIRRF  > 0
      @nLinha++,40 get nAdicionalNoturno   picture '99%'              valid nAdicionalNoturno   >= 0
      @nLinha++,40 get nAdicionalInsalubre picture '99%'              valid nAdicionalInsalubre >= 0
      read

      if lastkey() == 27
         nContinuar := alert("Deseja sair do programa?", {"Cancelar", "Retornar", "Processar"}, 'R/N+')
         if nContinuar == 0 .or. nContinuar == 2
            loop
         elseif nContinuar == 1
            nContinuar := 9

            exit
         elseif nContinuar == 3
            //Prosseguir
         endif
      endif

      @nLinha,1 say "Digite alguma tecla para confirmar:"
      inkey(0)
      @nLinha,1 clear to nLinha,40

      //Jogando valores em variaveis
      nLinha           := 14

      nSalarioFinal    := nSalarioBase

      nAnosTrabalhados := year(dDemitido) - year(dContratado)
      nIdade           := year(date()) - year(dNascimento)

      //Uso das informacoes
      nSalarioFinal += nSalarioFinal * (nAdicionalNoturno / 100)
      nSalarioFinal += nSalarioFinal * (nAdicionalInsalubre / 100)

      if cSexo == 'M'
         nHomens++

         if nIdade > 82
            nHomensMaisDe82++                            //Homens com mais de 82 anos
         endif

         if nIdade >= 61 .and. nAnosTrabalhados >= 29         //Liberando aposentadoria
            nAptoAposentHomens++
            bAposentado := .t.

            @16,1 say "Apto a aposentar" color 'R+/W'
         endif
      else
         nMulheres++

         if year(dContratado) < 2002
            nMulheresAntesDe2002++                       //Mulheres contratadas antes de 2002
         endif

         if nIdade >= 58 .and. nAnosTrabalhados >= 22        //Liberando aposentadoria
            nAptoAposentMulheres++
            bAposentado := .t.

         @16,1 say "Apta a aposentar" color 'R+/W'
         endif
      endif

      //Reajustes na aposentadoria
      if bAposentado == .t.
         if year(dContratado) <= 2009 .and. year(dDemitido) >= 2012
            nSalarioFinal += nSalarioFinal * 9/100
         endif
         if year(dContratado) <= 2015 .and. year(dDemitido) >= 2018
            nSalarioFinal -= nSalarioFinal * 3/100
         endif

         //Valor aposentadoria homens e mulheres
         if cSexo == 'M'
            nTotalAposentHomens += nSalarioFinal
         else
            nTotalAposentMulheres += nSalarioFinal
         endif
      endif

      if nSalarioBase >= nLimiteIRRF
         @17,1 say "Funcionario paga IRRF" color 'R+/W'

         if bAposentado == .t.
            nSalarioFinal -= nSalarioFinal * 7/100
         endif
         if cSexo == 'F'
            nMulheresPagandoIRRF++
         endif
      endif

      @13,40 say "Salario final: " + alltrim(transform(nSalarioFinal, '@E R$999,999.99'))

      nContador++

      cNome                := space(20)
      cSexo                := ' '
      dNascimento          := ctod('')
      dContratado          := ctod('')
      dDemitido            := ctod('')
      nSalarioBase         := 0
      nLimiteIRRF          := 0
      nAdicionalNoturno    := 0
      nAdicionalInsalubre  := 0
      nAnosTrabalhados     := 0
      nIdade               := 0
      bAposentado := .f.

      nContinuar           := -1

   enddo

   if nContinuar == 9
      loop
   endif

   //valores as variaveis
   nPercentHomensAposent   := (nAptoAposentHomens / nHomens)     * 100
   nPercentMulheresAposent := (nAptoAposentMulheres / nMulheres) * 100
   nMulheresPagandoIRRF    := (nMulheresPagandoIRRF / nMulheres) * 100

   @18,0 to 24,79 double
   @19,1  say "Percentual de homens aposentados:   " + alltrim(transform(nPercentHomensAposent, '999%'))
   @19,50 say "Valor pago: "                         + alltrim(transform(nTotalAposentHomens, '@E R$999,999.99'))
   @20,1  say "Percentual de mulheres aposentadas: " + alltrim(transform(nPercentMulheresAposent, '999%'))
   @20,50 say "Valor pago: "                         + alltrim(transform(nTotalAposentMulheres, '@E R$999,999.99'))
   @21,1  say "Homens com mais de 82 anos:         " + alltrim(str(nHomensMaisDe82))
   @22,1  say "Mulheres contratadas antes de 2002: " + alltrim(str(nMulheresAntesDe2002))
   @23,1  say "Mulheres pagando IRRF:              " + alltrim(transform(nMulheresPagandoIRRF, '999%'))

   inkey(0)

   if lastkey() == 27
      nContinuar := alert("Deseja sair do programa?", {"Sim", "Nao"}, 'R/N')

      if nContinuar == 1
         exit
      else
         loop
      endif
   endif
enddo
