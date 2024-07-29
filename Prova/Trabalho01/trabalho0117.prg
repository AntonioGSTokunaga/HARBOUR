//willian roosevelt dos santos

set date to british
set epoch to 1940
set scoreboard off
set color to 'N/W'

clear

do while .t.

   nSolicitacoes := 0


   @ 00,10 to 24,61 double

   @ 01,11 say 'QUANTOS EMPREGADOS SERAO ANALISADOS?'

   @ 01,48 get nSolicitacoes picture '999' valid nSolicitacoes > 0



   do while .t.

   cNomeColaborador       :=Space( 15 )
   cSexo                  :=Space( 1 )

   cMaskNome              := '@!'
   cMaskValor             := '@E 99999.99'
   cMaskAdicional         := '99'

   dNascimento            :=CToD( '' )
   dAdmissao              :=CToD( '' )
   dDemissao              :=CToD( '' )

   nSalarioBase           := 0
   nLimiteIrrf            := 0
   nAdcionalNoturno       := 0
   nAdcionalInsalubridade := 0

   @ 03,11 say 'Nome:                    '       + 'Sexo:     '          + 'Data de Nascimento:'
   @ 04,11 say 'Data Admissao:            '      + 'Salario Base:'
   @ 05,11 say 'Limite IRRF:             '       + 'Adicional Noturno:'
   @ 06,11 say 'Adicional Insalubridade:     '   + 'Data Demissao:'

   @ 03,16 get cNomeColaborador       picture cMaskNome      valid !Empty( cNomeColaborador )
   @ 03,42 get cSexo                  picture cMaskNome      valid !Empty( cSexo ) .and. cSexo = 'M' .or. cSexo = 'F'
   @ 03,72 get dNascimento                                   valid dNascimento < Date()
   @ 04,27 get dAdmissao                                     valid dAdmissao > dNascimento
   @ 04,57 get nSalarioBase           picture cMaskValor     valid nSalarioBase > 0
   @ 05,24 get nLimiteIrrf            picture cMaskValor     valid nLimiteIrrf > 0
   @ 05,57 get nAdcionalNoturno       picture cMaskAdicional
   @ 06,36 get nAdcionalInsalubridade picture cMaskAdicional
   @ 06,57 get dDemissao                                     valid dDemissao > dAdmissao
   read

   if LastKey() == 27
      nOpcao := Alert('DESEJA CANCELAR(1), RETORNAR(2) OU PROCESSAR(3)?',{'1','2','3'})
      if nOpcao == 1
         exit
      elseif nOpcao == 2
         loop
      elseif nOpcao == 3
         exit
      endif
   endif
   enddo

   if LastKey() == 27
      nOpcao := Alert('DESEJA CANCELAR(1), RETORNAR(2) OU PROCESSAR(3)?',{'1','2','3'})
      if nOpcao == 1
         exit
      elseif nOpcao == 2
         loop
      elseif nOpcao == 3
         exit
      endif
   endif


   if nOpcao == 1
      exit
   endif

   do while .t.

      clear

      cAptoInapto :=Space( 3 )

      @ 00,10 to 24,70 double

      @ 01,11 say 'Apto a aposentadoria?'

      if cSexo = 'M' .and. Year(Date()) - Year(dNascimento) = 61 .and. dDemissao = dAdmissao + 29
         cAptoInapto := 'SIM'
      elseif cSexo = 'F' .and. Year(Date()) - Year(dNascimento) = 58 .and. dDemissao = dAdmissao + 22
         cAptoInapto := 'SIM'
      else
         cAptoInapto := 'NAO'
      endif

      @ 01,33 say cAptoInapto

      if cAptoInapto = 'SIM'
         exit
      endif

   InKey( 0 )
   enddo

   do while .t.
      nAdcionalInsalubridade := (nAdcionalInsalubridade / 100 * nAdcionalInsalubridade) + nAdcionalInsalubridade
      nAdcionalNoturno       := (nAdcionalNoturno       / 100 * nAdcionalNoturno      ) + nAdcionalNoturno
      nBeneficio             := nLimiteIrrf + nAdcionalNoturno + nAdcionalInsalubridade

      if nLimiteIrrf <= nSalarioBase
         nBeneficio := nSalarioBase + nAdcionalInsalubridade + nAdcionalNoturno
      endif

      if nLimiteIrrf > 0
         nBeneficio := nBeneficio - (nBeneficio * 0.07)
      endif



      @ 03,11 say 'Valor do Beneficio:' + Transform( nBeneficio, cMaskValor)



   enddo










InKey( 0 )
enddo
