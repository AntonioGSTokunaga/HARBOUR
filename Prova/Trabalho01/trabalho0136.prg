// ROBSON DIAS

SET DATE TO BRITISH
SET EPOCH TO 1940
SET SCOREBOARD OFF

clear

nEmpregados             := 0
cNomeColaborador        := Space (30)
cSexo                   := Space (1)
dHoje                   := date()
dAdmissao               := CTod ("")
dDemissao               := CTod ("")
dNascimento             := CTod ("")
nValorSalarioBase       := 0
nValorLimiteIRRF        := 0
nAdicionalNoturno       := 0
nAdicionalInsalubridade := 0




@ 01,01 say "Digite a quantidade de Empregados a serem analisados: "

@ 01, 60 get nEmpregados                           Valid !Empty(nEmpregados)
read

@01,01 clear to 24,79 // Limpa Tela do Programa

@01,01 to 24,76 double // Box em volta do programa

do while .t.
//say

@ 03,02 say 'Nome do Colaborador:.........'
@ 04,02 say 'Sexo:........................'
@ 05,02 say 'Data de Nascimento:..........'
@ 06,02 say 'Data de AdimissÆo:...........'
@ 07,02 say 'Data de DemissÆo:............'
@ 08,02 say 'Valor do Salario Base:.......'
@ 09,02 say 'Valor do Limite IRRF:........'
@ 10,02 say 'Adicional Noturno:...........'
@ 11,02 say 'Adicional de Insalubridade:..'

//gets

@ 03,32 get cNomeColaborador        Picture ('@!')   Valid !Empty(cNomeColaborador)
@ 04,32 get cSexo                   Picture ('@!')   Valid !Empty(cSexo)
@ 05,32 get dNascimento
@ 06,32 get dAdmissao
@ 07,32 get dDemissao
@ 08,32 get nValorSalarioBase
@ 09,32 get nValorLimiteIRRF
@ 10,32 get nAdicionalNoturno
@ 11,32 get nAdicionalInsalubridade
read

//alerta do esc

if LastKey() == 27
   nOpcoes := Alert('O que deseja fazer?', { 'PROCESSAR', 'RETORNAR', 'CANCELAR'})

   if nOpcoes == 1

   elseif nOpcoes == 3
   @ 02,02 clear to 15,32

   elseif nOpcoes == 2
         exit

   endif
endif


nIdade            := dHoje - dNascimento
nTempoTrabalho    := dDemissao - dAdmissao

@ 15,01 say


 if nIdade >= 61 .and. nTempoTrabalho >= 29 .and. cSexo == 'M'
    @ 20,01 say "Parab‚ns, vc ja pode aposentar!"
else
   @ 20,01 say "vc nÆo pode aposentar ainda!"
endif

if nIdade >= 58 .and. nTempoTrabalho >= 22 .and. cSexo == 'F'
   @ 20,01 say "Parab‚ns, vc ja pode aposentar!"
else
   @ 20,01 say "vc nÆo pode aposentar ainda!"
endif

enddo

















@ 22,01 say "bay bay! ..."
Inkey(5)

