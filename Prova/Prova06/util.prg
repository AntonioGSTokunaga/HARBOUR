
// Cabe�alho
setmode (25,80)
set date British
set epoch to 1940
set scoreboard off
set century on

clear

//Para pegar o Dia da Semana

if nDiaSemanaVenda = 1
   cDiaSemanaVenda := "Domingo"

elseif nDiaSemanaVenda = 2
   cDiaSemanaVenda := "Segunda-Feira"

elseif nDiaSemanaVenda = 3
   cDiaSemanaVenda := "Terca-Feira"

elseif nDiaSemanaVenda = 4
   cDiaSemanaVenda := "Quarta-Feira"

elseif nDiaSemanaVenda = 5
   cDiaSemanaVenda := "Quinta-Feira"

elseif nDiaSemanaVenda = 6
   cDiaSemanaVenda := "Sexta-Feira"

elseif nDiaSemanaVenda = 7
   cDiaSemanaVenda := "Sabado"

endif

//Para pegar o m�s

if nMesVenda = 1
   cMesVenda := "Janeiro"

elseif nMesVenda = 2
   cMesVenda := "Fevereiro"

elseif nMesVenda = 3
   cMesVenda := "Marco"

elseif nMesVenda = 4
   cMesVenda := "Abril"

elseif nMesVenda = 5
   cMesVenda := "Maio"

elseif nMesVenda = 6
   cMesVenda := "Junho"

elseif nMesVenda = 7
   cMesVenda := "Julho"

elseif nMesVenda = 8
   cMesVenda := "Agosto"

elseif nMesVenda = 9
   cMesVenda := "Setembro"

elseif nMesVenda = 10
   cMesVenda := "Outubro"

elseif nMesVenda = 11
   cMesVenda := "Novembro"

elseif nMesVenda = 12
   cMesVenda := "Dezembro"

endif

//String para data completa em extenso
@ 19,01 say cLugarDeVenda + " , " + cDiaVenda + " de " + cMesVenda + " de " + cAnoVenda + " (" + cDiaSemanaVenda + ")"


if LastKey() == 27

   nOpcao := Alert("Deseja Sair do Programa?",{"Sim","Nao"},"N/W")

   if nOpcao == 1
      exit

   else
      loop

   endif

endif
