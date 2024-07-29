// ANTONIO GABRIEL SATOSHI TOKUNAGA
setmode (25,80)
set date British
set epoch to 1940
set scoreboard off
set century on
set color to "W/B"

clear

@ 00,00 to 24,79 double

cCorLivre   := 'N/G'
cCorOcupado := 'N/R'
cCor1       := cCorLivre
cCor2       := cCorLivre
cCorAlerta  := 'G/N'

nTotal1     := 0
nTotal2     := 0

do while .t.

   nMesa      := 0
   nAtendente := 0

   @ 01,11 say 'RESTAURANTE SG'
   @ 03,01 say 'Nø Da Mesa.........:'
   @ 04,01 say 'Codigo Do Atendente:'
   @ 03,23 say '01' color cCor1
   @ 03,26 say '02' color cCor2

   @ 03,21 get nMesa        picture '9'   valid AllTrim( Str( nMesa ) ) $ '12'
   @ 04,21 get nAtendente   picture '9'   valid AllTrim( Str( nAtendente ) ) $ '12'
   read

   if LastKey() == 27

      nOpcao := Alert( 'Deseja Sair Do Programa?', { '[S]im', '[N]ao' }, cCorAlerta )

      if nOpcao == 1
         exit
      else
         loop
      endif

   endif

   if ( nMesa == 1 .and. cCor1 == cCorLivre ) .or. ( nMesa == 2 .and. cCor2 == cCorLivre )

      @ 06,11 say 'PEDIDO'
      @ 08,01 say 'Descricao Do Produto'
      @ 08,33 say 'QTDE'
      @ 08,38 say 'Preco Unit'
      @ 08,50 say 'Valor Total'

      nLinha1     := 9
      nLinha2     := 11
      nValorTotal := 0

      do while .t.

         cProduto       := Space( 30 )
         nQuantidade    := 0
         nPrecoUnitario := 0
         nSubTotal      := 0

         @ nLinha1,01 get cProduto         picture '@!'            valid !Empty( cProduto )
         @ nLinha1,35 get nQuantidade      picture '99'            valid nQuantidade > 0
         @ nLinha1,42 get nPrecoUnitario   picture '@E 999.99'   valid nPrecoUnitario > 0
         read

         if LastKey() == 27
            nOpcao := Alert( 'Deseja?', { 'Enviar pedido para producao', 'Continuar digitando', 'Abandonar digitacao' }, cCorAlerta )
            if nOpcao == 1
               Alert( 'Pedido enviado para producao', {'OK'}, cCorAlerta )

               if nMesa == 1
                  cCor1   := cCorOcupado
                  nTotal1 := nValorTotal
               elseif nMesa == 2
                  cCor2   := cCorOcupado
                  nTotal2 := nValorTotal
               endif

               @ 06,01 clear to 23,78
               exit
            elseif nOpcao == 2
               loop
            else
               @ 06,01 clear to 23,78
               nValorTotal := 0
               exit
            endif
         endif

         nSubTotal   := nQuantidade * nPrecoUnitario
         nValorTotal += nSubTotal

         @ nLinha1,01 clear to nLinha1,78

         --nLinha2

         @ nLinha2,50 clear to nLinha2,78

         ++nLinha2

         @ nLinha1,01 say AllTrim( cProduto )
         @ nLinha1,35 say Transform( nQuantidade, '99' )
         @ nLinha1,42 say Transform( nPrecoUnitario, '@E 999.99' )
         @ nLinha1,50 say Transform( nSubTotal, '@E 99,999.99' )
         @ nLinha2,50 say Transform( nValorTotal, '@E 99,999.99' )

         nLinha1++
         nLinha2++

         if nLinha2 > 21
            @ 22,01 say 'Dados registrados com sucesso!'
            @ 23,01 say 'Pressione qualquer tecla para continuar...'

            Inkey( 0 )

            @ 09,01 clear to 23,78

            nLinha1 := 9
            nLinha2 := 11
         endif
      enddo

   elseif ( nMesa == 1 .and. cCor1 == cCorOcupado ) .or. ( nMesa == 2 .and. cCor2 == cCorOcupado )
      nOpcao := Alert( 'Mesa ocupada. Deseja?', { 'Digitar outra mesa', 'Faturar atendimanto', 'Cancelar atendimento' }, cCorAlerta )
      if nOpcao == 1
         loop
      elseif nOpcao == 2
         nTotalPagamento := 0
         nOpcao := Alert( 'Aceita a taxa de servico (10%) ?', { '[S]im', '[N]ao' }, cCorAlerta )
         if nOpcao == 1
            if nMesa == 1
               nTotal1 += nTotal1 * 0.10
               nTotalPagamento := nTotal1
            elseif nMesa == 2
               nTotal2 += nTotal2 * 0.10
               nTotalPagamento := nTotal2
            endif
         else
            if nMesa == 1
               nTotalPagamento := nTotal1
            elseif nMesa == 2
               nTotalPagamento := nTotal2
            endif
         endif

            do while .t.
               cFormaPagamento := Space( 1 )

               nValorPago      := 0
               nValorTroco     := 0

               @ 06,11 say 'PAGAMENTO'
               @ 08,01 say '[D]inheiro, [C]artao, ou Che[Q]ue?'
               @ 09,01 say 'Total a pagar.: ' + Transform( nTotalPagamento, '@E 99,999.99' )
               @ 10,01 say 'Valor recebido:'

               @ 08,36 get cFormaPagamento   picture '@!'              valid cFormaPagamento $ 'DCQ'
               @ 10,17 get nValorPago        picture '@E 99,999.99'   valid nValorPago > 0
               read

               if LastKey() == 27
                  nOpcao := Alert( 'Deseja?', { 'Cancelar pagamento', 'Recomecar pagamento' }, cCorAlerta )
                  if nOpcao == 1

                     /*If nMesa == 1
                        cCor1 := cCorLivre
                     elseif nMesa == 2
                        cCor2 := cCorLivre
                     endif
                     Inkey( 0 )*/

                     @ 01,01 clear to 23,78
                     exit
                  else

                    /* if nMesa == 1
                        nTotal1 -= nTotal1 * 0.10
                        nTotalPagamento := nTotal1
                     elseif nMesa == 2
                        nTotal2 -= nTotal2 * 0.10
                        nTotalPagamento := nTotal2
                     endif*/
                     loop

                  endif
               endif
            enddo

            if nOpcao == 1
               loop
            endif

            if nValorPago > nTotalPagamento
               nValorTroco := nValorPago - nTotalPagamento
            endif

            @ 11,01 say 'Valor troco...: ' + Transform( nValorTroco, '@E 99,999.99' )
            @ 13,01 say 'Pagamento efetuado com sucesso!'
            @ 14,01 say 'Pressione qualquer tecla para retornar ao atendimento...'

            If nMesa == 1
               cCor1 := cCorLivre
            elseif nMesa == 2
               cCor2 := cCorLivre
            endif
            Inkey( 0 )

            @ 01,01 clear to 23,78

         endif
      else
         nValorTotal := 0
      endif

  // endif

enddo

