set scoreboard off

set color to 'W/B'

clear

cNome := Space( 30 )

@ 00,00 to 24,79 double

@ 01,01 say 'Digite o seu nome para imprimi-lo 10 vezes:'

@ 01,45 get cNome picture '@!' valid !Empty(cNome)
read

nLinha := 3

do while nLinha < 13
   @nLinha,01 say cNome
   nLinha++
enddo

@ ++nLinha,01 say 'Pressione alguma tecla para encerrar...'

Inkey( 0 )
