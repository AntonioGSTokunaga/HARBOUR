//Henry Glioti Tavares

set date to british
set epoch to 1940
set scoreboard off

clear

do while .t.
cCor                    := 'W/R'

nEmpregados             := 0

cNome                   := Space( 20 )
cSexo                   := Space( 1 )
dNascimento             := 0
dAdmissao               := 0
dDemissao               := 0

nSalarioBase            := 0
nValorLimite            := 0
nAdicionalNoturno       := 0
nAdicionalInsalubridade := 0

nAdicional              := 0
nSalarioAdicional       := 0

nDiaNascimento   := Day(date())
nMesNascimento   := Month(date())
nAnoNascimento   := Year(date())

nDiaAdm          := Day(date())
nMesAdm          := Month(date())
nAnoAdm          := Year(date())

nDiaDemi         := Day(date())
nMesDemi         := Month(date())
nAnoDemi         := Year(date())


@ 01,01 say 'Nø de empregados a ser analisado:'
@ 03,01 say 'Nome colaborador................:'
@ 04,01 say 'Sexo............................:'
@ 05,01 say 'Data de nascimento..............:'
@ 06,01 say 'Data de admissÆo................:'
@ 07,01 say 'Data de demissÆo................:'
@ 08,01 say 'Valor sal rio base..............:'
@ 09,01 say 'Valor Limite IRRF...............:'
@ 10,01 say 'Adicional noturno( % )..........:'
@ 11,01 say 'Adicional insalubridade( % )....:'


@ 01,34 get nEmpregados            picture '99'          valid !Empty(nEmpregados)
@ 03,34 get cNome                  picture '@!'          valid !Empty(cNome)
@ 04,34 get cSexo                  picture '@!'          valid !Empty(cSexo)
@ 05,34 get dNascimento            picture '99/99/9999'  valid !Empty(dNascimento)
@ 06,34 get dAdmissao              picture '99/99/9999'  valid !Empty(dAdmissao)
@ 07,34 get dDemissao              picture '99/99/9999'  valid !Empty(dDemissao)
@ 08,34 get nSalarioBase           picture '9999.99'     valid !Empty(nSalarioBase)
@ 09,34 get nSalarioLimite         picture '9999.99'     valid !Empty(nSalarioLimite)
@ 10,34 get AdicionalNoturno       picture '9%'          valid !Empty(nAdicionalNoturno)
@ 11,34 get AdicionalInsalubridade picture '9%'          valid !Empty(nAdicionalInsalubridade)
read

nTempoTrabalho := dAdmissao - dDemissao

if LastKey() = 27
   nOpcao:= Alert('Oque deseja fazer?',{'Cancelar','Retornar','Processar'},cCor)

elseif nOpcao == 1
   EXIT

elseif nOpcao == 2
   nOpcao := 0

elseif nOpcao == 3
   LOOP

if cSexo == 'M'
   (nIdade >= 61) .and. nTempoTrabalho >= 29

elseif cSexo == 'F'
   (nIdade >= 58) .and. nTempoTrabalho >= 22

/*
if dAdmissao = 2009  .and. dDemissao = 2012
   nAdicional:= 9

elseif dAdmissao = 2015 .and. dDemissao = 2018
   nAdicional:= 3

   endif
*/

  endif
endif


enddo


