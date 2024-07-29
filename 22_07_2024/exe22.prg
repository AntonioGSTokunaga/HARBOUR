set scoreboard off
set color to 'W/B'

clear

cMascaraTotal      := '@E 999999.99'
cMascaraValor      := '@E 99999.99'
cMascaraQuantidade := '999'
cAviso1            := 'Deseja fechar o programa?'
cAviso2            := 'Deseja abandonar a(s) compra(s)?'
cAviso3            := 'Deseja concluir a(s) compra(s)?'
cCor               := 'G/N'

nLinha      := 6
//nColuna     := 1

@ 00,00 to 24,79 double
@ 02,01 to 02,78

@ 01,01 say 'Nome:'
@ 01,40 say 'Limite R$:'

do while .t.

   cNome   := Space( 30 )
   nLImite := 0

   @ 01,07 get cNome     picture '@!'            valid !Empty( cNome )
   @ 01,51 get nLImite   picture cMascaraTotal   valid nLImite > 0
   read

   if LastKey() == 27
      nOpcao := Alert( cAviso1, { 'Sim', 'Nao' }, cCor )

      if nOpcao == 1
         exit
      else
         loop
      endif

   endif

   @ 04,01 say 'PRODUTO'
   @ 04,17 say 'QTD'
   @ 04,21 say 'VALOR'
   @ 04,30 say 'TOTAL'

   do while .t.

      cProduto    := Space( 15 )
      nQuantidade := 0
      nValor      := 0

      @nLinha,01 get cProduto      picture '@!'                 valid !Empty( cProduto )
      @nLinha,17 get nQuantidade   picture cMascaraQuantidade   valid nQuantidade > 0
      @nLinha,21 get nValor        picture cMascaraValor        valid nValor > 0
      read

      if LastKey == 27
         nOpcao := Alert( cAviso2, { 'Sim', 'Nao' }, cCor )

         if nOpcao == 1
            exit
         else
            loop
         endif

      endif

      // falta meios para ir ao pagamento, etc

      nLinha += 2

      if nLinha > 20
         @ 06,01 clear to 20,78

         nLinha := 6
      endif

   enddo

enddo
