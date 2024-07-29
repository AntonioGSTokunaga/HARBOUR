//WESLEY NOBUYUKI TOMIMORI WATERKEMPER
set date to british
set epoch to 1940

clear


nEmpregados          := 0
nContador            := 0

nHomemAposentadoria  := 0
nMulherAposentadoria := 0
nTotalRemuneracao    := 0
nAdmitidas2002       := 0
nHomensAcima82       := 0
nPagamIRRF           := 0

dDataHoje            := Date()

nDiasAno             := 365

cNome           := Space(20)
cSexo           := Space(01)
dDataNascimento := Ctod('')
dDataAdmissao   := Ctod('')
dDataDemissao   := Ctod('')
nSalarioBase    := 0
nLimiteIRRF     := 0
nNoturno        := 0
nInsalubridade  := 0


@ 01, 01 say "Numero de empregados a serem analizados: "

@ 01, 42 get nEmpregados
read

do while (nContador < nEmpregados)
   @ 03, 01 say "Nome:"
   @ 03, 30 say "Sexo(M/F):"
   @ 03, 43 say "Data de Nascimento:"
   @ 04, 01 say "Data de Admissao:"
   @ 04, 30 say "Data de Demissao:"
   @ 04, 59 say "Salario Base:"
   @ 05, 01 say "Limite IRRF:"
   @ 05, 24 say "Adicional Noturno"
   @ 05, 43 say "Adiconal Insalubridade"

   @ 03, 07 get cNome
   @ 03, 40 get cSexo           picture "@!" valid cSexo $ 'MF'
   @ 03, 63 get dDataNascimento
   @ 04, 19 get dDataAdmissao
   @ 04, 48 get dDataDemissao
   @ 04, 73 get nSalarioBase
   @ 05, 13 get nLimiteIRRF
   @ 05, 41 get nNoturno
   @ 05, 65 get nInsalubridade
   read

   if LastKey() == 27
      nOpcao := Alert("Deseja:", {'Cancelar', 'Retornar', 'Processar'})

      if (nOpcao == 1)
         exit
      
      elseif(nOpcao == 2)
         loop

      else
         exit

      endif

   endif
      
      

   nIdade := (dDataHoje - dDataNascimento)
   cIdade := nIdade / nDiasAno

   cTempoEmpresa := Str(nTempoEmpresa := (dDataDemissao - dDataAdmissao) / nDiasAno)


   if (nSalarioBase <= 1.045)
      nContribuicaoINSS := 7.5

   elseif (nSalarioBase <= 1045.01)
      nContribuicaoINSS := 9

   elseif (nSalarioBase <= 2089.61)
      nContribuicaoINSS := 12

   elseif (nSalarioBase <= 3134.41)
      nContribuicaoINSS := 14

   endif

   nAcrescimoNoturno       := (nSalarioBase * nNoturno)
   nAcrescimoInsalubridade := (nSalarioBase * nInsalubridade)

   nSalarioBase := nAcrescimoInsalubridade + nAcrescimoNoturno
   
   nFatorPrevidenciario := 0.7
   

   if (cSexo == "M")

      if(nIdade > 82)
         nHomensAcima82 += 1
      endif

      if(nTempoEmpresa >= 29 .and. nIdade >= 61)
         nHomemAposentadoria += 1

         if (nTempoEmpresa <= 15)
            nSalarioBase := nSalarioBase + (nSalarioBase / 100) * 9
            nSalarioBase := nSalarioBase - (nSalarioBase / 100) * 3
         
         endif

         if (nSalarioBase > nLimiteIRRF)
            nSalarioBase := nSalarioBase - nSalarioBase / 100 * 7
         endif

      endif

      
      if (nSalarioBase > nLimiteIRRF)
         nSalarioBase := nSalarioBase - nSalarioBase / 100 * 7
      endif

   else

      if(nTempoEmpresa > 24)
         nAdmitidas2002 += 1

      endif

      if (nTempoEmpresa >= 22 .and. nIdade >= 58)
         nMulherAposentadoria += 1
         
         if (nTempoEmpresa >= 15)
            nSalarioBase := nSalarioBase + (nSalarioBase / 100) * 9
            nSalarioBase := nSalarioBase - (nSalarioBase / 100) * 3

         endif

         if (nSalarioBase > nLimiteIRRF)
            nSalarioBase := nSalarioBase - nSalarioBase / 100 * 7
            nPagamIRRF += 1
         endif

         
         
      endif

   endif
   
   nAposentadoria    := nSalarioBase * nFatorPrevidenciario
   nTotalRemuneracao += nAposentadoria

   cNome           := Space(20)
   cSexo           := Space(01)
   dDataNascimento := Ctod('')
   dDataAdmissao   := Ctod('')
   dDataDemissao   := Ctod('')
   nSalarioBase    := 0
   nLimiteIRRF     := 0
   nNoturno        := 0
   nInsalubridade  := 0

   nContador++
enddo

cTotalAposentados := Str(nHomemAposentadoria + nMulherAposentadoria)
cTotalRemuneracao := Str(nTotalRemuneracao)
cHomensAcima82    := Str(nHomensAcima82)
cAdmitidas2002    := Str(nAdmitidas2002)
cPagamIRRF        := Str(nPagamIRRF)  

@ 07, 01 say "Homens e Mulheres Aposentados...: "
@ 08, 01 say "Valor total da Remuneracao......: "
@ 10, 01 say "Homens com idade superior a 82..: "
@ 11, 01 say "Mulheres Admitidas antes de 2002: "
@ 12, 01 say "Mulheres que pagam IRRF.........: "

@ 07, 34 say cTotalAposentados
@ 08, 34 say cTotalRemuneracao
@ 10, 34 say cHomensAcima82
@ 11, 34 say cAdmitidas2002
@ 12, 34 say cPagamIRRF

@ 13, 01 say nFatorPrevidenciario
