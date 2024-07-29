//ANTONIO GABRIEL SATOSHI TOKUNAGA

set date to british
set epoch to 1940
set century on
set scoreboard off

set color to 'W/B'

clear

@ 00,00 to 24,79 double

do while .t.

   cNome       := Space( 30 )
   dNascimento := CToD( ' ' )

   @ 01,01 say 'Nome..............:'
   @ 02,01 say 'Data de nascimento:'

   @ 01,21 get cNome   picture '@!'   valid !Empty( cNome )
   @ 02,21 get dNascimento            valid dNascimento <= Date()
   read

   if LastKey() == 27

      nOpcao := Alert("Deseja Sair do Programa?",{"Sim","Nao"},"N/W")

      if nOpcao == 1
         exit
      else
         loop
      endif

   endif

   nDia       := Day( dNascimento )
   nMes       := Month( dNascimento )
   nAno       := Year( dNascimento )
   nDiaSemana := DoW( dNascimento )

   nDiaAtual  := Day( Date() )
   nMesAtual  := Month( Date() )
   nAnoAtual  := Year( Date() )

   if nDiaSemana = 7
      cDiaSemana := 'Sabado'
   elseif nDiaSemana = 6
      cDiaSemana := 'Sexta-feira'
   elseif nDiaSemana = 5
      cDiaSemana := 'Quinta-feira'
   elseif nDiaSemana = 4
      cDiaSemana := 'Quarta-feira'
   elseif nDiaSemana = 3
      cDiaSemana := 'Ter‡a-feira'
   elseif nDiaSemana = 2
      cDiaSemana := 'Segunda-fera'
   elseif nDiaSemana = 1
      cDiaSemana := 'Domingo'
   endif

   if nMes = 1
      cMes     := "Janeiro"
      nDiasMes := 31
   elseif nMes = 2
      cMes     := "Fevereiro"
      nDiasMes := 28
   elseif nMes = 3
      cMes     := "Marco"
      nDiasMes := 31
   elseif nMes = 4
      cMes     := "Abril"
      nDiasMes := 30
   elseif nMes = 5
      cMes     := "Maio"
      nDiasMes := 31
   elseif nMes = 6
      cMes     := "Junho"
      nDiasMes := 30
   elseif nMes = 7
      cMes     := "Julho"
      nDiasMes := 31
   elseif nMes = 8
      cMes     := "Agosto"
      nDiasMes := 31
   elseif nMes = 9
      cMes     := "Setembro"
      nDiasMes := 30
   elseif nMes = 10
      cMes     := "Outubro"
      nDiasMes := 31
   elseif nMes = 11
      cMes     := "Novembro"
      nDiasMes := 30
   elseif nMes = 12
      cMes     := "Dezembro"
   endif

   cSigno := ''

   if ( nDia >= 21 .and. nMes = 1 ) .or. ( nDia <= 18 .and. nMes = 2 )
      cSigno := 'Aquario'
   elseif ( nDia >= 19 .and. nMes = 2 ) .or. ( nDia <= 20 .and. nMes = 3 )
      cSigno := 'Peixes'
   elseif ( nDia >= 21 .and. nMes = 3 ) .or. ( nDia <= 20 .and. nMes = 4 )
      cSigno := 'Aries'
   elseif ( nDia >= 21 .and. nMes = 4 ) .or. ( nDia <= 20 .and. nMes = 5 )
      cSigno := 'Touro'
   elseif ( nDia >= 21 .and. nMes = 5 ) .or. ( nDia <= 20 .and. nMes = 6 )
      cSigno := 'Gemeos'
   elseif ( nDia >= 21 .and. nMes = 6 ) .or. ( nDia <= 22 .and. nMes = 7 )
      cSigno := 'Cancer'
   elseif ( nDia >= 23 .and. nMes = 7 ) .or. ( nDia <= 22 .and. nMes = 8 )
      cSigno := 'Leao'
   elseif ( nDia >= 23 .and. nMes = 8 ) .or. ( nDia <= 22 .and. nMes = 9 )
      cSigno := 'Virgem'
   elseif ( nDia >= 23 .and. nMes = 9 ) .or. ( nDia <= 22 .and. nMes = 10 )
      cSigno := 'Libra'
   elseif ( nDia >= 23 .and. nMes = 10 ) .or. ( nDia <= 21 .and. nMes = 11 )
      cSigno := 'Escorpiao'
   elseif ( nDia >= 22 .and. nMes = 11 ) .or. ( nDia <= 21 .and. nMes = 12 )
      cSigno := 'Sagitario'
   elseif ( nDia >= 22 .and. nMes = 12 ) .or. ( nDia <= 20 .and. nMes = 1 )
      cSigno := 'Capricornio'
   endif

   if nDia > nDiaAtual
      nIdadeDia           := ( nDiaAtual - nDia ) * -1
   else
      nIdadeDia           := nDiaAtual - nDia
   endif

   nIdadeMes           := nMesAtual - nMes
   nIdadeAno           := nAnoAtual - nAno

   nProximoAno         := nAno + 1

   cProximoAno         := AllTrim( Str( nProximoAno ) )
   cProximoDia         := AllTrim( Str( nDia ) )
   cProximoMes         := AllTrim( Str( nMes ) )

   //cProximoAniversario := DToC( Date( nProximoAno, nMes, nDia) )
   //dProximoAniversario := CToD( cDia, cMes, cProximoAno )


   /*nProximoDiaSemana   := DoW( dProximoAniversario )

   if nProximoDiaSemana = 7
      cProximoDiaSemana := 'Sabado'
   elseif nProximoDiaSemana = 6
      cProximoDiaSemana := 'Sexta-feira'
   elseif nProximoDiaSemana = 5
      cProximoDiaSemana := 'Quinta-feira'
   elseif nProximoDiaSemana = 4
      cProximoDiaSemana := 'Quarta-feira'
   elseif nProximoDiaSemana = 3
      cProximoDiaSemana := 'Ter‡a-feira'
   elseif nProximoDiaSemana = 2
      cProximoDiaSemana := 'Segunda-fera'
   elseif nProximoDiaSemana = 1
      cProximoDiaSemana := 'Domingo'
   endif*/

//fazer um limitador de dias para os meses e aplica-los para saber quanto tempo falta para o proximo aniversario

   nDiaAniversario     := nDiasMes - nIdadedia
   nMesAniversario     := 12 - nIdadeMes
   nAnoAniversario     := nProximoAno - nAnoAtual

   @ 04,01 clear to 23,78

   @ 04,01 say 'Nascido em..........................: ' + AllTrim( Str( nDia ) ) + " de " + cMes + " de " + AllTrim( Str( nAno ) )
   @ 05,01 say 'Dia da semana.......................: ' + cDiaSemana
   @ 06,01 say 'Idade...............................: ' + AllTrim( Str( nIdadeAno ) ) + 'ano(s), ' + AllTrim( Str( nIdadeMes ) ) + 'mes(es) e ' + AllTrim( Str( nIdadeDia ) ) + 'dia(s)'
   @ 07,01 say 'Signo...............................: ' + cSigno
   @ 08,01 say 'Proximo aniversario em..............: ' + AllTrim( Str( nMesAniversario ) ) + 'mes(es) e ' + AllTrim( Str( nDiaAniversario ) ) + 'dia(s)'
   @ 09,01 say 'Dia da semana do proximo aniversario: '// + cProximoDiaSemana
   //calendario do mes do proximo aniversario - destacar o dia do aniversario

enddo
