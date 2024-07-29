set color to W/B

clear

nValorA := 0
nValorB := 0
nValorC := 0

nLinha  := 1

cMascara := '@E 99,999,999'


@ 00,00 to 07,43 double

@ nLinha++,01 say 'Insira o primeiro numero: '
@ nLinha++,01 say 'Insira o segundo numero.: '
@ nLinha--,01 say 'Insira o terceiro numero: '

@ --nLinha,27 get nValorA picture cMascara
@ ++nLinha,27 get nValorB picture cMascara
@ ++nLinha,27 get nValorC picture cMascara
read

nLinha += 2

nMaior := nValorA

if nValorB > nMaior
   nMaior := nValorB
endif

if nValorC > nMaior
   nMaior := nValorC
endif

//cMaior := transform( nMaior, cMascara )
//cMaior := Str( nMaior ) //tanto a linha acima quanto esta fazem a mesma coisa
//a diferen‡a ‚ q transform requer a mascara definida entre os parenteses
cMaior := AllTrim( Str( nMaior ) )

if nValorA = nValorB .and. nValorA = nValorC
   cMaior := 'Inexistente, os 3 sao iguais'
endif

@ nLinha++,01 say 'Maior numero: ' + cMaior
@ nLinha,01   say 'Pressione alguma tecla para encerrar...'

Inkey( 0 )
