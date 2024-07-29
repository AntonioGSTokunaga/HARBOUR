//ANTONIO GABRIEL SATOSHI TOKUNAGA

setmode (25,80)
set date British
set epoch to 1940
set scoreboard off
set century on
set color to 'W/B'

clear

@ 00,00 to 24,79 double

nOrdemServico         := 1

do while .t.

   cNomeCliente          := Space( 50 )
   cNomeTecnico          := Space( 40 )
   cDescricaoEquipamento := Space( 50 )

   dOrdemServico         := CToD( ' ' )
   dCompra               := CToD( ' ' )

   @ 01,01 say 'Nome do cliente.........:'
   @ 02,01 say 'Data da ordem de servico:'
   @ 03,01 say 'Nome do tecnico.........:'
   @ 04,01 say 'Descricao do equipamento:'
   @ 05,01 say 'Data de compra..........:'
   @ 06,01 say 'Ordem de servico: '+ Transform( nOrdemServico, '999999' )

   @ 01,26 get cNomeCliente            picture '@!'   valid !Empty( cNomeCliente )
   @ 02,26 get dOrdemServico                          valid dOrdemServico <= Date()
   @ 03,26 get cNomeTecnico            picture '@!'   valid !Empty( cNomeTecnico )
   @ 04,26 get cDescricaoEquipamento   picture '@!'   valid !Empty( cDescricaoEquipamento )
   @ 05,26 get dCompra                                valid dCompra <= Date() .and. dCompra >= dOrdemServico
   read

   if LastKey() == 27

      nOpcao := Alert( "Deseja fechar o programa?",{ "Sim", "Nao" }, "N/W" )

      if nOpcao == 1
         exit

      else
         loop

      endif

   endif

   @ 01,01 clear to 23,78

   nValorTotal    := 0
   nSomaTotal     := 0
   nTotalGarantia := 0

   do while .t.

      nDia             := Day( Date() )
      nMes             := Month( Date() )
      nAno             := Year( Date() )

      nDiaCompra       := Day( dCompra )
      nMesCompra       := Month( dCompra )
      nAnoCompra       := Year( dCompra )

      cDescricao       := Space( 30 )

      nQuantidade      := 0
      nDesconto        := 0
      nPrecoUnitario   := 0
      nComissaoTecnico := 0
      nComissao        := 0
      nTotalComissao   := 0
      nPrecoTotal      := 0
      nLinha           := 3

      nServico := Alert( 'Quais dos servicos deseja efetuar?', { 'Produto', 'Servico' }, 'N/W' )


      if LastKey() == 27

         nOpcao := Alert( "Deseja fechar o programa?",{ "Sim", "Nao" }, "N/W" )

         if nOpcao == 1
            exit

         else
            loop

         endif

      endif

      do while .t.

         if nServico == 1

            do while .t.

               @ 01,01 say 'DESCRICAO DO PRODUTO'
               @ 01,32 say 'QTDE'
               @ 01,37 say 'PRECO UNIT'
               @ 01,49 say 'DESCONTO(%)'
               @ 01,60 say 'SUBTOTAL'

               @ nLinha,01 get cDescricao       picture '@!'                valid !Empty( cDescricao )
               @ nLinha,32 get nQuantidade      picture '9999'              valid nQuantidade > 0
               @ nLinha,37 get nPrecoUnitario   picture '@E 9,999,999.99'   valid nPrecoUnitario > 0
               @ nLinha,53 get nDesconto        picture '@E 999.99'         valid nDesconto >= 0 .and. nDesconto <= 100
               read

               if LastKey() == 27
                  nOpcao := Alert( 'O que deseja fazer?' , { 'Cancelar', 'Retomar', 'Finalizar', 'Efetuar Servico' }, 'N/W' )

                  if nOpcao == 1
                     exit
                  elseif nOpcao == 2
                     loop
                  elseif nOpcao == 3
                     exit
                  elseif nOpcao == 4
                     nServico := 2
                     exit
                  endif
               endif

               if ( nDiaCompra < nDia .and. nMesCompra <= nMes )
                  nAnoValidade := nAno - ( nAnoCompra + 1 )
               else
                  nAnoValidade := nAno - nAnoCompra
               endif

               if nDesconto = 0
                  nValorTotal := ( nQuantidade * nPrecoUnitario )
               else
                  nValorTotal := ( nQuantidade * nPrecoUnitario ) * ( nDesconto / 100 )
               endif

               nSomaTotal  += nValorTotal

               if nAnoValidade <= 2
                  nValorTotal    := 0
               endif

               nTotalGarantia += nValorTotal

               //cInformacao := ''

               @ nLinha,01 say cDescricao
               @ nLinha,32 say nQuantidade
               @ nLinha,37 say nPrecoUnitario
               @ nLinha,53 say nDesconto

               //if

               @ nLinha,60 say nValorTotal
               @ 23,01 say 'Valor total: ' + AllTrim( Str( nSomaTotal ) )
               @ 23,31 say 'Valor total com garantia: ' + AllTrim( Str( nTotalGarantia ) )

               nLinha++

               if nLinha > 21
                  nLinha := 3
                  @ 03,01 clear to 21,78
               endif

            enddo

         endif
         if nServico == 2

            do while .t.

               @ 01,01 say 'DESCRICAO DO SERVICO'
               @ 01,32 say 'DESCONTO(%)'
               @ 01,44 say 'COMISSAO TECNICO(%)'
               @ 01,60 say 'SUBTOTAL'

               @ nLinha,01 get cDescricao         picture '@!'                valid !Empty( cDescricao )
               @ nLinha,32 get nDesconto          picture '@E 999.99'         valid nDesconto >= 0 .and. nDesconto <= 100
               @ nLinha,44 get nComissaoTecnico   picture '@E 999.99'         valid nComissaoTecnico >= 0 .and. nComissaoTecnico <= 100
               read

               if LastKey() == 27
                  nOpcao := Alert( 'O que deseja fazer?' , { 'Cancelar', 'Retomar', 'Finalizar', 'Efetuar Produto' }, 'N/W' )

                  if nOpcao == 1
                     exit
                  elseif nOpcao == 2
                     loop
                  elseif nOpcao == 3
                     exit
                  elseif nOpcao == 4
                     nServico := 1
                     exit
                  endif
               endif

               if ( nDiaCompra < nDia .and. nMesCompra <= nMes )
                  nAnoValidade := nAno - ( nAnoCompra + 1 )
               else
                  nAnoValidade := nAno - nAnoCompra
               endif

               if nComissaoTecnico > 0
                  nComissao := 0
               else
                  nComissao := nValorTotal * ( nComissaoTecnico / 100 )
               endif

               nTotalComissao += nComissao

               if nDesconto = 0
                  nValorTotal := ( nQuantidade * nPrecoUnitario )
               else
                  nValorTotal := ( nQuantidade * nPrecoUnitario ) * ( nDesconto / 100 )
               endif
               nSomaTotal  += nValorTotal

               if nAnoValidade <= 1
                  nValorTotal    := 0
               endif

               nTotalGarantia += nValorTotal

               @ nLinha,01 say cDescricao
               @ nLinha,32 say AllTrim( Str( nDesconto ) )
               @ nLinha,44 say AllTrim( Str( nComissaoTecnico ) )
               @ nLinha,60 say AllTrim( Str( nValorTotal ) )


               @ nLinha,60 say nValorTotal
               @ 23,01 say 'Valor total: ' + AllTrim( Str( nSomaTotal ) )
               @ 23,31 say 'Valor total com garantia: ' + AllTrim( Str( nTotalGarantia ) )

               nLinha++

               if nLinha > 21
                  nLinha := 3
                  @ 03,01 clear to 21,78
               endif

            enddo

         endif

         @ 01,01 clear to 23,78

         if nOpcao == 1


            exit

         endif

         if nSomaTotal = 0
            Alert( 'Por favor, informe os dados da nota fiscal na tela seguinte', 'N/W' )

            nCnpjEmpresa := 0
            nNotaFiscal  := 0

            dNota        := CToD( ' ' )

            @ 01,01 say 'CNPJ da empresa:'
            @ 02,01 say 'Numero da nota.:'
            @ 03,01 say 'Data da nota...:'

            @ 01,17 get nCnpjEmpresa   picture '99999999999999'   valid Len( Str( nCnpjEmpresa ) ) = 14
            @ 01,17 get nNotaFiscal    picture '999999999'        valid Len( Str( nNotaFiscal ) ) = 9
            @ 01,17 get dNota                                     valid dNota <= Date() .and. dNota >= dCompra
         endif

         @ 01,01 say 'Valor total.......................: '
         @ 02,01 say 'Valor total com garantia..........: '
         @ 03,01 say 'Valor total da comissao do tecnico: '

         @ 01,60 say AllTrim( Str( nSomaTotal ) )
         @ 02,60 say AllTrim( Str( nTotalGarantia ) )
         @ 03,60 say AllTrim( Str( nTotalComissao ) )

         @ 04,01 say 'Pressione alguma tecla para finalizar a ordem de servico...'

         nOrdemServico++

         nOpcao := 1

         Inkey( 0 )


      enddo

      if nOpcao == 1

         exit

      endif

   enddo

enddo
