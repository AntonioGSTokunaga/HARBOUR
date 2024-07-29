
//ANTONIO GABRIEL SATOSHI TOKUNAGA
setmode (25,80)
set date British
set epoch to 1940
set scoreboard off
set century on
clear

@ 00,00 to 24,79 double

cCorAgua   := 'B/B'
cCorAcerto := 'R/R'
cCorErro   := 'W/W'
cCorPadrao := 'W/N'

do while .t.

   cHistorico     := ''
   cCoordenada    := ''

   nJogoEncerrado := 0
   nOpcao         := 0
   nRealizadas    := 0
   nRestantes     := 20
   nAcertos       := 0
   nErros         := 0

   @ 02,01 to 02,78 double

   @ 01,32 say 'DESCOBERTA NAVAL'
   @ 03,05 say 'JOGADA'

   @ 04,01 to 04,15 double

   @ 05,01 say 'LINHA.:'
   @ 06,01 say 'COLUNA:'

   @ 07,01 to 07,15 double


   @ 07,21 say '1'
   @ 10,21 say '2'
   @ 13,21 say '3'
   @ 16,21 say '4'
   @ 19,21 say '5'
   @ 22,21 say '6'

   @ 04,29 say '1'
   @ 04,38 say '2'
   @ 04,47 say '3'
   @ 04,56 say '4'
   @ 04,65 say '5'
   @ 04,74 say '6'

   @ 03,16 to 23,16 double

   set color to ( cCorAgua )

   @ 06,25 clear to 23,78


   do while .t.

      set color to ( cCorPadrao )

      @ 08,01 clear to 13,14

      @ 09,01 to 09,15 double

      @ 08,05 say 'JOGADAS'
      @ 10,01 say 'REALIZADAS: ' + AllTrim( Str( nRealizadas ) )
      @ 11,01 say 'RESTANTES.: ' + AllTrim( Str( nRestantes ) )
      @ 12,01 say 'ACERTOS...: ' + AllTrim( Str( nAcertos ) )
      @ 13,01 say 'ERROS.....: ' + AllTrim( Str( nErros ) )

      nLinha  := 0
      nColuna := 0

      @ 05,09 get nLinha    picture '9'   valid nLinha > 0 .and. nLinha <= 6
      @ 06,09 get nColuna   picture '9'   valid nColuna > 0 .and. nColuna <= 6
      read

      if LastKey() == 27

         nOpcao := Alert( 'Deseja sair do jogo?', { '[S]im', '[N]ao' } )

         if nOpcao == 1

            exit

         else

            loop

         endif

      endif

      cHistorico += cCoordenada + '-'

      cCoordenada := AllTrim( Str( nLinha ) ) + AllTrim( Str( nColuna ) )


      if cCoordenada $ cHistorico

         Alert( 'VOCE JA USOU ESSA COORDENADA' )

         loop

      endif

      //Y = coordenada de linha | X = coordenada de coluna
      nPosicaoX1   := 16 + ( 9 * nColuna )
      nPosicaoY1   := 3 + ( 3 * nLinha )

      nPosicaoX2   := 24 + ( 9 * nColuna )
      nPosicaoY2   := 5 + ( 3 * nLinha )

      if cCoordenada $ '11-15-36-42-55-63'//ou '1155-636-42', mas pode dificultar se for add mais

         Alert( 'ENCONTROU' )

         nAcertos++
         nRealizadas++
         nRestantes--

         set color to ( cCorAcerto )

         @ nPosicaoY1,nPosicaoX1 clear to nPosicaoY2,nPosicaoX2

         set color to ( cCorPadrao )

      else

         Alert( 'ERROU' )

         nErros++
         nRealizadas++
         nRestantes--

         set color to ( cCorErro )

         @ nPosicaoY1,nPosicaoX1 clear to nPosicaoY2,nPosicaoX2

         set color to ( cCorPadrao )

      endif


      if nAcertos = 6 .and. nRestantes >= 0

         Alert( 'VOCE GANHOU, PARABENS!' )

         nJogoEncerrado := 1

         exit

      elseif nRestantes + nAcertos < 6

         @ 08,01 clear to 13,14

         @ 08,01 say 'JOGADAS'
         @ 10,01 say 'REALIZADAS: ' + AllTrim( Str( nRealizadas ) )
         @ 11,01 say 'RESTANTES.: ' + AllTrim( Str( nRestantes ) )
         @ 12,01 say 'ACERTOS...: ' + AllTrim( Str( nAcertos ) )
         @ 13,01 say 'ERROS.....: ' + AllTrim( Str( nErros ) )

         Alert( 'VOCE PERDEU! TENTATIVAS RESTANTES NAO SAO SUFICIENTES PARA DESVENDAR TODAS AS EMBARCACOES' )

         nJogoEncerrado := 1

         exit

      endif

   enddo

   if nOpcao == 1

      exit

   endif

   if nJogoEncerrado = 1

      nOpcao := Alert( 'Deseja?', { 'Iniciar um novo jogo', 'Sair' } )

      if nOpcao == 1

         nJogoEncerrado := 0

         loop

      else

         exit

      endif

   endif

enddo

