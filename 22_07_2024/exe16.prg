set scoreboard off

set color to 'W/B'
// Alt + C = encerra o programa
clear

cNome         := Space( 20 )


//use len para flexibilizar as colunas de acordo com o tamanho da string digitada
/*atribua todas as strings para calcula o valor de len e dividi-lo por colunas totais
para definir quantas colunas de strings serao feitas
*/
//nLinha1    := 4
//nLinha2    := 4
nLinha     := 4
nColuna    := 1
nVezes     := 0
nContador  := 0
//nNomeFeito := 0

@ 00,00 to 24,79 double

@ 01,01 say 'Digite o seu nome: '
@ 02,01 say 'Digite o nø de vezes que deseja imprimi-lo: '

@ 01,20 get cNome  picture '@!'  valid !Empty( cNome )
@ 02,45 get nVezes               valid nVezes >= 0
read


do while /*nNomeFeito*/ nContador < nVezes
   //fa‡a duas condi‡äes, uma de linha e outra de coluna
   //precisa da vari vel para a coordenada de coluna
   //

   nEspacoContador := Len( AllTrim( Str( nContador ) ) )
   nTamanhoNome    := Len( AllTrim( cNome ) ) + 2 + nEspacoContador

   if nLinha = 22
      nColuna += nTamanhoNome
      nLinha  := 4
   endif

   if ( nColuna + nTamanhoNome ) > 78
      nColuna := 1
      nLinha  := 4
      @ 04,01 clear to 21,78
   endif

   @ nLinha++,nColuna say AllTrim( cNome ) + ' ' + AllTrim( Str( nContador++ ) )

   Inkey( 0 )

   /*if nContador < 19
      @ nLinha1++,01 say AllTrim( cNome ) + ' ' + AllTrim( Str( nNomeFeito ) )

      nNomeFeito++
      nContador++

      Inkey( 0 )

   elseif nContador >= 19

      @ nLinha2++,40 say AllTrim( cNome ) + ' ' + AllTrim( Str( nNomeFeito ) )

      nNomeFeito++
      nContador++

      Inkey( 0 )

      if nContador > 40
         @ 04,01 clear to 22,78

         nLinha1   := 4
         nLinha2   := 4
         nContador := 0

      endif

   endif*/

enddo

@ 23,01 say 'Pressione alguma tecla para encerrar...'

Inkey( 0 )

