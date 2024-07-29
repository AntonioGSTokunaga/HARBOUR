set color to 'W/B'

clear
do while .t.
   cNome    := Space( 30 )
   nIdade   := 0

   @ 01,01 say 'Nome.:'
   @ 02,01 say 'Idade:'

   @ 01,07 get cNome    picture '@!'   valid !Empty( cNome )
   @ 02,07 get nIdade   picture '999'  valid nIdade >= 0
   read

   if Lastkey() == 27 //O 27 remete … tecla 'Esc'
      nOpcao := Alert( 'Deseja sair do programa?', { 'Sim', 'Nao' }, 'G/B' )

      if nOpcao == 1 //O 1 remete … op‡Æo 'Sim' por ser a primeira op‡Æo escrita
         exit
      else
         loop
      endif
   endif

   cProduto := Space( 15 )

   @ 04,01 say 'Produto:'

   @ 04,08 get cProduto   picture '@!'   valid !Empty( cProduto)
   read

   if Lastkey() == 27
      loop
   endif

enddo
