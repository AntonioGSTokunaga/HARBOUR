set date to british // Joao Luiz Fernandes
set epoch to 1940
set scoreboard off
clear

do while .t.

   nNumeroFuncionarios     := 0
   cNome                   := Space(30)
   cSexo                   := Space(1)
   dNascimento             := CToD( '' )
   dAdmissao               := CToD( '' )
   dDemissao               := CToD( '' )
   nSalarioBase            := 0
   nLimiteIrrf             := 0
   nAdicionalNoturno       := 0
   nAdicionalInsalubridade := 0
   nLinha                  := 0
   nContador               := 0
   nAposentados            := 0
   nNumeroHomens           := 0
   nNumeroMuLheres         := 0

   @ nLinha,00 say "Qual o numero de empregados?"

   @ nLinha++,30 get nNumeroFuncionarios valid nNumeroFuncionarios > 0
   read

   do while nContador < nNumeroFuncionarios

      nContador++
      @ nLinha++,00 say "Coloque as infor‡oes do empregado N: " + Str( nContador )
      nLinha2 := nLinha
      @ nLinha++,00 say "Nome: "
      @ nLinha++,00 say "Sexo: "
      @ nLinha++,00 say "Data de nascimento: "
      @ nLinha++,00 say "Data de Admissao: "
      @ nLinha++,00 say "Data de Demissao: "
      @ nLinha++,00 say "Salario base: "
      @ nLinha++,00 say "Limite do Irrf: "
      @ nLinha++,00 say "Adicional noturno: "
      @ nLinha++,00 say "Adicional de insalubridade: "

      @ nLinha2++,30 get cNome
      @ nLinha2++,30 get cSexo picture '@!' valid cSexo $ (MH)
      @ nLinha2++,30 get dNascimento
      @ nLinha2++,30 get dAdmissao
      @ nLinha2++,30 get dDemissao
      @ nLinha2++,30 get nSalarioBase
      @ nLinha2++,30 get nLimiteIrrf
      @ nLinha2++,30 get nAdicionalNoturno
      @ nLinha2++,30 get nAdicionalInsalubridade
      read
      if lastkey() == 27
         nOpcao := Alert( "O que deseja?", { "Cancelar", "Retornar", "Processsar" } )
         if nOpcao = 1
            exit
         elseif nOpcao = 2
            loop
         else
         enddo
         endif

      if cSexo = "H"
         nNumeroHomens++
      else
         nNumeroMuLheres++
      endif

      nIdade               := Year( Date ) - Year( dNascimento )
      nTempoTrabalhado     := Year( dDemissao ) - Year( dAdmissao )
      nHomensAposentados   := 0
      nMulheresAposentadas := 0
      nValorAposentadoria  := 0
      nSalarioIrrf         := nSalarioBase - 7%
      nTemporario          := nSalarioIrrf - nSalarioBase
      nRemuneracaoTotal    := 0

      do while nContador > 0
         nContador--
         if cSexo = "H" .and. nIdade >= 61 .and. nTempoTrabalhado >= 29
            lAposentado := .t.
            nHomensAposentados++


         elseif cSexo = "M" .and. nIdade >= 58 .and. nTempoTrabalhado >= 22
            lAposentado := .t.
            nMulheresAposentadas++

         endif

         if lAposentado .t.
            if Year( dAdmissao ) = 09 .or.  Year( dAdmissao ) = 12
               nValorAposentadoria := nSalarioBase + 9%

            elseif  Year( dAdmissao ) = 15 .or.  Year( dAdmissao ) = 18
               nValorAposentadoria := nSalarioBase - 3%
            endif

            if nSalarioBase > nLimiteIrrf
               nValorAposentadoria -= nTemporario
               lMulherIrrf := .t.
            endif
         endif


         if nLinha > 22
            nLinha := 0
            clear
         endif
         inkey(0)
         nRemuneracaoTotal  += nValorAposentadoria
         nHomensVelhos      := 0
         nMulheresAntes2002 := 0
         nMulheresIrrf      := 0

         if nIdade > 81 .and. cSexo = "H"
            nHomensVelhos++
         endif

         if Year( dAdmissao ) < 12 .and. cSexo = "M"
            nMulheresAntes2002++
         endif

         if lMulherIrrf = .t.
            nMulheresIrrf++
         endif
      enddo
   enddo

   nLinha3 := nLinha + nNumeroFuncionarios

   @ nLinha3++,00 say "Total de pessoas aposentadas: " + Str( nHomensAposentados + nMulheresAposentadas )
   @ nLinha3++,00 say "Valor total da remunera‡ao: " + Str( nValorAposentadoria )
   @ nLinha3++,00 say "Total de homens com mais de 82: " + Str( nHomensVelhos )
   @ nLinha3++,00 say "Total de mulheres admitidas antes de 2002: " + Str( nMulheresAntes2002 )
   @ nLinha3++,00 say "Total de mulheres que pagam imposto: " + Str( nMulheresIrrf )

enddo
