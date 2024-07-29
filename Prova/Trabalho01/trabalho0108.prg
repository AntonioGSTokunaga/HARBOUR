//Francielle

set date to british
set epoch to 1940
set scoreboard off

clear

nNumeroEmpregados       := 0
cNomeColaborador        := space( 30 )
cSexo                   := ( 1 )
dDataNascimento         := CTod('')
dDataAdmissao           := CTod('')
dDataDemissao           := CTod('')
nValorSalarioBase       := 0
nValorLimiteIRRF        := 0
nAdicionalNoturno       := 0
nAdicionalInsalubridade := 0
nTempoServico           := 0


cMascara := '@E 9,999.99'



@ 01,00 say "Digite o numero de Empregados "
@ 01,20 get nNumeroEmpregados picture '99' valid nNumeroEmpregados >= 0
read

clear

do while .t.

@ 01,01 say "Nome Colaborador ........"
@ 02,01 say "Sexo (M/F)..............."
@ 03,01 say "Data Nascimento.........."
@ 04,01 say "Data Admissao............"
@ 05,01 say "Data Demissao............"
@ 06,01 say "Valor Salario Base......."
@ 07,01 say "Valor Limite IRRF........"
@ 08,01 say "Adicional Noturno........"
@ 09,01 say "Adicional Insalubridade ."


@ 01,25 get cNomeColaborador        picture '@!'      valid !Empty(cNomeColaborador)
@ 02,25 get cSexo                   picture '@!'      valid cSexo $ 'MF'
@ 03,25 get dDataNascimento                           valid dDataNascimento < Date()
@ 04,25 get dDataAdmissao                             valid dDataAdmissao > Date()
@ 05,25 get dDataDemissao                             valid dDataDemissao >= Date()
@ 06,25 get nValorSalarioBase        picture cMascara valid nValorSalarioBase > 0
@ 07,25 get nValorLimiteIRRF         picture cMascara valid nValorLimiteIRRF > 0
@ 08,25 get nAdicionalNoturno        picture cMascara valid nAdicionalNoturno > 0
@ 09,25 get nAdicionalInsalubridade  picture cMascara valid nAdicionalInsalubridade > 0
read

If LastKey() == 27
   nOpcao := Alert('O que deseja fazer',{'Retornar','Processar','Cancelar'},'G/B')
   If nOpcao == 1
      loop
   elseif nOpcao == 2
      loop
   else nOpcao == 3
   endif
endif


if cSexo == 'M'
   if nIdade <= 61 .and. nTemposervico <= 29
      Alert('Voce nao esta apto a receber.', {'Ok'}, 'G/B')
      exit
   else
      Alert('Voce esta apto a receber.', {'Ok'}, 'G/B')
   endif
endif


if cSexo == 'F'
   if nIdade <= 58 .and. nTemposervico <= 22
      Alert('Voce nao esta apto a receber.', {'Ok'}, 'G/B')
      exit
   else
      Alert('Voce esta apto a receber.', {'Ok'}, 'G/B')
   endif
endif

if dAnoAdmissao < 2009 .and. dAnoAdmissao > 2012
      nSalarioBase := nSalarioBase + ( nSalarioBase * 0.09)
   elseif dAnoAdmissao < 2015 .and. dAnoAdmissao > 2018
      nSalarioBase := nSalarioBase  + (nSalarioBase * 0.03)
   elseif
      nSalarioBase := nSalarioBase - ( nSalarioBase * 0.07)
   else
      nSalarioBase := nSalarioBase
   endif
endif


// contagem de homens e mulheres

nTotalHomens         := 0
nHomensAposentados   := 0
nHomens82            := 0
ntotalMulheres       := 0
nMulheresAposentadas := 0
nMulheresAntes2002   := 0
nMulheresIRRF        := 0
nTotalAposentadoria  := 0

if nNumeroColaboradores == 'M'
   nTotalHomens++
   if nNumeroColaboradores > 82
      nHomens82++
   endif
elseif nNumeroEmpregados == 'F'
   nTotalMulheres++
   if nTempoServico <=2002
      nMulhereAntes2002++
   endif
   If nNumeroEmpregado == nValorLimiteIRRF
      nMulheresIRRF++
   endif
endif


//Percentuais

if nTotalHomens + nTotalMulheres > 0
   nPercentualHomensAposentados   := (nHomensAposentados   / nTotalHomens)   * 100
   nPercentualMulheresAposentadas := (nMulheresAposentadas / nTotalMulheres) * 100
   else
      nPercentualHomensAposentados    := 0
      nPercenturalMulheresAposentadas := 0
endif

if nTotalMulheres > 0
   nPercentualMulheresIRRF := (nMulheresIRRF / nTotalMulheres) * 100
   else
   nPercentualMulheresIRRF := 0
endif


// apresentar um quadro com as informacoes

clear

@ 01,01 say "Quadro de Informacoes "
@ 02,01 say "Percentual de Homens Aposentados "                     + Str(nPercentualHomensAposentados, 5,2) + "%"
@ 03,01 say "Percentual de Mulheres Aposentadas "                   + Str(nPercentualMulheresAposentadas,5,2) + "%"
@ 04,01 say "Valor Total da Remuneracao "                           + Str(nTotalAposentadoria, 5,2)
@ 05,01 say "Quantidade de Homens com Idade Superior a 82 anos "    + Str(nHomens82,4)
@ 06,01 say "Quantidade de Mulheres Admitidas antes do ano de 2002" + Str(nMulheresAntes2002,3)
@ 07,01 say "percentual de Mulheres que pagam IRRF"                 + Str(nPercentualMulheresIRRF, 5,2) + "%"



Inkey( 0 )

