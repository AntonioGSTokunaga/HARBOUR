//GEOVANNA CARDOSO DA SILVA

set date to brit
set epoch to 1940


clear
do while .t.
   clear
nNumeroFuncionario:=0
@ 02,02 say "Quantidade de funcionarios: "
@ 02,40 get nNumeroFuncionario picture "99" valid nNumeroFuncionario>0
read
   if LastKey()==27
   nMensagem:=Alert('Deseja cancelar?', {'Sim', 'Nao'}, 'w/n')
      if nMensagem==1
         loop
      else
        exit
      endif
   endif

nMensagem:=2

nContador:=1
do while nContador<=nNumeroFuncionario
   clear
   cNome            :=space(25)
   cSexo            :=space(1)
   dNascimento      :=CToD('')
   dAdmissao        :=CToD('')
   dDemissao        :=CToD('')
   nSalarioBase:=0
   nAdicNoturno     :=0
   nInsalubridade   :=0
   nValorIrrf       :=0

   @ 02,02 say "Nome.............: "
   @ 02,45 say "Sexo: "
   @ 03,02 say "Admissao.........: "
   @ 03,45 say "Demissao: "
   @ 04,02 say "Salario Base.....: "
   @ 04,45 say "Valor IRRF: "
   @ 05,02 say "Adicional noturno: "
   @ 05,45 say "Insalubridade: "
   @ 06,02 say "Data de Nascimento: "

   @ 02,20 get cNome             picture "@!"             valid !Empty(cNome)
   @ 02,60 get cSexo             picture "@!"             valid cSexo $ 'MF'
   @ 03,20 get dAdmissao         picture "@E 99/99/99"  valid !Empty(dAdmissao)
   @ 03,60 get dDemissao         picture "@E 99/99/99"  valid !Empty(dDemissao) .and. dDemissao>dAdmissao
   @ 04,20 get nSalarioBase      picture "@E 999,999.99"  valid !Empty(nSalarioBase)
   @ 04,60 get nValorIrrf        picture "@E 999,999.99"
   @ 05,20 get nAdicNoturno      picture "@E 99"
   @ 05,60 get nInsalubridade    picture "@E 99"
   @ 06,20 get dNascimento       picture "@E 99/99/99" valid dNascimento <dAdmissao
   read

   if LastKey()==27
      nMensagem:=Alert('Deseja cancelar?', {'Cancelar', 'Retornar','Processar'}, 'w/n')
      if nMensagem==1
         loop
      elseif nMensagem==2
         exit
      else
         exit
      endif
   endif
   nMensagem:=3
//   do while .t.
   nAnoNascimento := Year(dNascimento)
   nAnoAtual := Year(Date())
   nIdade         := nAnoAtual-nAnoNascimento
   nMesNascimento:= Month(dNascimento)
   nMesAtual:=Month(Date())
   nAnoAdmissao:=Year(dAdmissao)
   nAnoDemissao:=Year(dDemissao)
   nAnosTrabalhados:=nAnoDemissao-nAnoAdmissao
   nMesAdmissao:=Month(dAdmissao)
   nMesDemissao:=Month(dDemissao)
   nHomemAposentado:=0
   nMulherAposentada:=0
   nHomemMaior82    :=0
   nMulherAdmissaoAntes2002:=0
   nRemuneracaoTotal:=0
   nMulherIrrf:=0
   nNaoAposenta:=0
   nAdicNoturnoNovo  :=nAdicNoturno/100
   nInsalubridadeNovo:=nInsalubridade/100

   if nMesAtual<nMesNascimento
      nIdade--
   endif



   if nMesDemissao<nMesAdmissao
      nAnosTrabalhados--
   endif
   if nMesNascimento>nMesAtual
      nIdade--
   endif

      if nAnoAdmissao<2009 .and. nAnoDemissao>2012
            nSalarioBase+=(nSalarioBase*0.09)
      elseif nAnoAdmissao<2015 .and. nAnoDemissao>2018
            nSalarioBase-=(nSalarioBase* 0.03)
      endif

      if nSalarioBase>=nValorIrrf
         nSalarioBase+=(nSalarioBase* 0.07)
      endif

      if cSexo=='M' .and. nIdade>60 .and. nAnosTrabalhados>28
         nHomemAposentado++
         nRemuneracaoTotal+=nSalarioBase +(nSalarioBase*nAdicNoturnoNovo)+(nSalarioBase*nInsalubridadeNovo)
//         @ 05,02 say "Aposentado"
         if nIdade>82
            nHomemMaior82++
         endif
            if nAnoAdmissao<2009 .and. nAnoDemissao>2012
               nSalarioBase+=(nSalarioBase*0.09)
            elseif nAnoAdmissao<2015 .and. nAnoDemissao>2018
               nSalarioBase-=(nSalarioBase* 0.03)
            endif
            if nSalarioBase>=nValorIrrf
               nSalarioBase+=(nSalarioBase* 0.07)
            endif
      elseif cSexo=='F' .and. nIdade>57 .and. nAnosTrabalhados>21
         nMulherAposentada++
         nRemuneracaoTotal+=nSalarioBase +(nSalarioBase*nAdicNoturnoNovo)+(nSalarioBase*nInsalubridadeNovo)
  //       @ 05,02 say "Aposentada"
         if nAnoAdmissao<2002
            nMulherAdmissaoAntes2002++
         endif
         if cSexo=='F'
            nMulherIrrf++
         endif

      else
          nNaoAposenta++
    //     @ 05,02 say "Nao vai se aposentar!"
      endif

//      Alert:=(nMulherAposentada)

      nContador++
  //  enddo


 enddo
      clear
      @ 01,01 to 15,79
      nPorcentagemMulher:=(nMulherAposentada/nNumeroFuncionario)*100
      nPorcentagemHomem:=(nHomemAposentado/nNumeroFuncionario)*100
      nPorcentaNaoAposentado:=(nNaoAposenta/nNumeroFuncionario)*100

      @ 03,03 say "Porcentagem de Mulheres Aposentadas........: " + AllTrim(Str(nPorcentagemMulher)) + "%"
      @ 04,03 say "Porcentagem de Homens Aposentados..........: " + (Str(nPorcentagemHomem)) + "%"
      @ 05,03 say "Remuneracao Total de Aposentados...........: " + " R$ "+ AllTrim(Str(nRemuneracaoTotal))
      @ 07,03 say "Quantidade de homens superior a 82 anos....: "+ (Str(nHomemMaior82))
      @ 08,03 say "Quantidade mulheres admitidas antes de 2002: "+ (Str(nMulherAdmissaoAntes2002))
      @ 09,03 say "Quantidade mulheres que pagam IRRF.........: "+ (Str(nMulherIrrf))
InKey(0)

enddo


