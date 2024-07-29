//Pedro Henrique de Lima Lopes
set date to british
set epoch to 1940

clear

nOpcao        := 1
nAposentadoM  := 0
nAposentadoF  := 0
nIdade82      := 0
nAdmissao2002 := 0
nFIRRF        := 0
nRemuneracao  := 0
nM            := 0
nF            := 0


do while .t.

   if nOpcao = 1

   clear

   nEntrevista   := 0
   cNome         :=Space( 18 )
   cSexo         :=Space( 1 )
   dNascimento   :=Ctod( " " )
   dAdmissao     :=Ctod( " " )
   dDemissao     :=Ctod( " " )
   nSalario      := 0
   nIRRF         := 0
   nAdNoturno    := 0
   nAdInsalu     := 0

   @ 02,02 say "Numero de Entrevistas:"
   @ 02,24 get nEntrevista              picture "99"
   read

   endif

   if nEntrevista > 0

      clear

      @ 01,01 to 11,35
      @ 02,02 say "Nome:"
      @ 03,02 say "Sexo:"
      @ 04,02 say "Nascimento:"
      @ 05,02 say "Data Admissao:"
      @ 06,02 say "Data Demissao:"
      @ 07,02 say "Salario Base:"
      @ 08,02 say "Valor Limite:"
      @ 09,02 say "Adicional Noturno:"
      @ 10,02 say "Adicional Insalubridade:"

      @ 02,07 get cNome
      @ 03,07 get cSexo
      @ 04,13 get dNascimento
      @ 05,15 get dAdmissao
      @ 06,15 get dDemissao
      @ 07,14 get nSalario   picture "@E 99,999.99"
      @ 08,14 get nIRRF      picture "@E 99,999.99"
      @ 09,20 get nAdNoturno picture "99"
      @ 10,26 get nAdInsalu  picture "99"
      read

      if LastKey() = 27
         nOpcao := Alert( "" , { "Cancelar" , "Retornar" , "Precessar" } , "N/W" )

         if nOpcao = 3
            cNome       := cNome
            cSexo       := cSexo
            dNascimento := dNascimento
            dAdmissao   := dAdmissao
            dDemissao   := dDemissao
            nSalario    := nSalario
            nIRRF       := nIRRF
            nAdNoturno  := nAdNoturno
            nAdInsalu   := nAdInsalu

         else
            loop

         endif

      endif

      if cSexo = "M"
         nM++

         if Year( Date() ) - Year( dNascimento ) > 82
            nIdade82++

         endif

         if Year( Date() ) - Year( dNascimento ) >= 61

            if Year( dDemissao ) - Year( dAdmissao ) >= 29
               nAposentadoM++

            endif

         endif

      elseif cSexo = "F"
         nF++


         if Year( dAdmissao ) < 2002
            nAdmissao2002++

         endif

         if Year( Date() ) - Year( dNascimento ) >= 58

            if Year( dDemissao ) - Year( dAdmissao ) >= 22
               nAposentadoF++

            endif

         endif

      endif

      if ( ( Year( dAdmissao ) <= 2009 .and. Year( dDemissao ) >= 2009 ) .or. ( Year( dAdmissao ) <= 2012 .and. Year( dDemissao ) >= 2012 ) )
         nRemuneracao := nRemuneracao + nSalario * 0.09

      endif

      if ( ( Year( dAdmissao ) <= 2015 .and. Year( dDemissao ) >= 2015 ) .or. ( Year( dAdmissao ) <= 2018 .and. Year( dDemissao ) >= 2018 ) )
         nRemuneracao := nRemuneracao - nSalario * 0.03

      endif

      if nRemuneracao > nIRRF
         nRemuneracao := nRemuneracao - nSalario * 0.07

         if cSexo = "F"
            nFIRRF++

         endif

      endif

      nOpcao++
      nEntrevista--
      cNome       :=Space( 18 )
      cSexo       :=Space( 1 )
      dNascimento :=Ctod( " " )
      dAdmissao   :=Ctod( " " )
      dDemissao   :=Ctod( " " )
      nSalario    := 0
      nIRRF       := 0
      nAdNoturno  := 0
      nAdInsalu   := 0

   else
      exit

   endif

enddo

clear

@ 01,01 to 07,40
@ 02,02 say "Percentual de Aposentados: " + AllTrim( Str( nAposentadoM * 100 / nM ) )
@ 03,02 say "Percentual de Aposentados: " + AllTrim( Str( nAposentadoF * 100 / nF ) )
@ 03,02 say "Valor Total de Remuneracao: " + AllTrim( Str( nRemuneracao ) )
@ 04,02 say "Homens com mais de 82 anos: "+ AllTrim( Str( nIdade82 ) )
@ 05,02 say "Mulheres Admitidas antes de 2002: " + Alltrim( Str( nAdmissao2002 ) )
@ 06,02 say "Mulheres que pagaram IRRF: " + AllTrim( Str( nFIRRF ) )

