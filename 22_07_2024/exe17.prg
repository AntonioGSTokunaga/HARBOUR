//alert('Teste')
//fa‡a um programa que leia uma palavra e imprima invertida
set scoreboard off
set color to 'W/B'
clear

@ 00,00 to 24,79 double

do while .t.
   cPalavra          := Space( 30 )
   cPalavraInvertida := ''

   nContador := 0

   @ 00,00 to 24,79 double

   @ 01,01 say 'Digite alguma coisa: '

   @ 01,22 get cPalavra picture '@!' valid !Empty( cPalavra )
   read

   if LastKey() == 27
      nOpcao := Alert( 'Voce deseja sair do programa?', { 'Sim', 'Nao' }, 'W/B')

      if nOpcao == 1
         exit
      else
         loop
      endif

   endif

   cPalavra   := Alltrim( cPalavra )

   nTamanho   := Len( cPalavra )

   do while !Empty( nTamanho ) //no momento que o nTamanho chegar a 0, a vari vel ficar  vazia e sair  do la‡o de repeti‡Æo
      cPalavraInvertida += SubStr( cPalavra, nTamanho--, 1 )
   enddo

   @ 03,01 say cPalavraInvertida

enddo
