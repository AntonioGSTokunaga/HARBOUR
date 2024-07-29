// Jhonatan Bueno de Souza

set date to british
set century on
set scoreboard off
set epoch to 1940

clear

set color to 'B/N'

@00,00 to 24,79 double

nOpcaoCadastro := 0

do while .t.
   @03,01 clear to 11,78
   nEmpregadosAnalisados   := 0
   nContador               := 0
   nValorTotalH            := 0
   nValorTotalM            := 0
   nHomensAptos            := 0
   nMulheresAptas          := 0
   nMulheres2002           := 0
   nMulherImposto          := 0
   nHomensVelhos           := 0
   @01,01 say 'Quantos empregados serao analisados?'
   @01,36 get nEmpregadosAnalisados      valid nEmpregadosAnalisados > 0  picture '99'
   read
   if LastKey()==27
      nOpcaoEmpregados := Alert('O que deseja fazer?',{'Sair do programa','Cancelar'})
      if nOpcaoEmpregados == 1
         exit
      endif
   endif
   nLinha   := 2
   do while nContador < nEmpregadosAnalisados
      @03,01 clear to 05,78
      cNome                   := Space( 25 )
      cSexo                   := Space( 1 )
      dNascimento             := CToD('')
      dAdmissao               := CToD('')
      dDemissao               := CToD('')
      nSalarioBase            := 0
      nLimiteIRRF             := 0
      nAdicionarNoturno       := 0 // %
      nAdicionarInsalubridade := 0 // %
      nContador               += 1
      nLinha   := 3
      nSalarioTotal := 0

      @nLinha++,01   say 'Nome                 : '
      @nLinha++,01   say 'Nascimento           : '
      @nLinha++,01   say 'Sexo                 : '
      @nLinha++,01   say 'Admissao             : '
      @nLinha++,01   say 'Demissao             : '
      @nLinha++,01   say 'Sal rio Base         : '
      @nLinha++,01   say 'Adic Noturno         : '
      @nLinha++,01   say 'Adic Insalubridade   : '
      @nLinha++,01   say 'Limite IRRF          : '

      nLinha   := 3
      @nLinha++,24   get cNome                      picture '@!'              valid !Empty(cNome)
      @nLinha++,24   get dNascimento                                          valid dNascimento < Date()
      @nLinha++,24   get cSexo                      picture '@!'              valid cSexo == 'M' .or. cSexo == "F"
      @nLinha++,24   get dAdmissao                                            valid dAdmissao > dNascimento
      @nLinha++,24   get dDemissao                                            valid dDemissao > dAdmissao
      @nLinha++,24   get nSalarioBase               picture '@E 999,999.99'   valid nSalarioBase > 0
      @nLinha++,24   get nAdicionarNoturno          picture '99%'             valid nAdicionarNoturno >= 0
      @nLinha++,24   get nAdicionarInsalubridade    picture '99%'             valid nAdicionarInsalubridade >= 0
      @nLinha++,24   get nLimiteIRRF                picture '@E 999,999.99'   valid nLimiteIRRF >= 0
      read

      if LastKey () == 27
         nOpcaoCadastro := Alert('O que deseja fazer?',{'Cancelar','Retornar','Processar'},'B,N')
         if nOpcaoCadastro == 1 .or. nOpcaoCadastro == 0
            loop
         else
            exit
         endif
      endif
      dContas := dAdmissao
      do while (Year(dContas) <= Year(dDemissao))
         if Year(dContas) == 2009 .or. Year(dContas) == 2012
            nSalarioBase *= 1.09
         endif
         if Year(dContas) == 2015 .or. Year(dContas) == 2018
            nSalarioBase *= 0.97
         endif
         dContas +=  365
      enddo
      if nSalarioTotal > nLimiteIRRF
         nSalarioBase  *= 0.93
      endif
      nSalarioTotal := nSalarioBase*(1+nAdicionarInsalubridade/100+nAdicionarNoturno/100)
      if cSexo = 'M'
         if ((dDemissao - dAdmissao)/365 >= 29) .and. ((Date()-dNascimento)/365 >= 61)
            if (Date()-dNascimento>=82)
               nHomensVelhos += 1
            endif
            nHomensAptos += 1
            nValorTotalH += nSalarioTotal
         endif
      endif
      if cSexo = 'F'
         if (Year(dAdmissao)<2002)
            nMulheres2002 += 1
         endif
         if ((dDemissao - dAdmissao)/365 >= 22) .and. ((Date()-dNascimento)/365 >= 58)
            nMulheresAptas += 1
            nValorTotalM   += nSalarioTotal
            if nSalarioTotal > nLimiteIRRF
               nMulherImposto += 1
            endif
         endif
      endif
   enddo

   if nOpcaoCadastro == 2
      loop
   endif
   @02,01 clear to nLinha,78
   @02,01 to 02,78
   if nHomensAptos >0 .or. nMulheresAptas >0
      nPercentualH := (nHomensAptos/(nHomensAptos+nMulheresAptas))*100
      nPercentualM := (nMulheresAptas/(nHomensAptos+nMulheresAptas))*100

      @03,01 say 'Dos aptos, ' + Transform(nPercentualH,'999%')+ ' ‚ homem e ' +Transform(nPercentualM,'999%') +' ‚ mulher'
      @04,01 say 'O valor total pago a homens ‚: R$ ' + Transform(nValorTotalH,'@E 999,999.99')
      @05,01 say 'O valor total pago a mulheres ‚: R$ ' + Transform(nValorTotalM,'@E 999,999.99')
      @06,01 say 'Mulheres admitidas pr‚ 2002: ' + Transform(nMulheres2002,'99')
      @07,01 say 'Homens com mais de 82 anos: ' + Transform(nHomensVelhos,'99')
      @08,01 say Transform((nMulheres2002/(nMulheres2002+nMulheresAptas))*100,'999%') + 'das mulheres aptas pagam IRRF'
   else
      @03,01 say 'Nao houveram colaboradores aptos para a aposentadoria'
      @04,01 say 'Mulheres admitidas pr‚ 2002: ' + Transform(nMulheres2002,'99')
      @05,01 say 'Homens com mais de 82 anos: ' + Transform(nHomensVelhos,'99')

   endif
   InKey(0)
   // PROCESSAR
enddo
