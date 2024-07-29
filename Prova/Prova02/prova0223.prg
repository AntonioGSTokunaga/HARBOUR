// ANTONIO GABRIEL SATOSHI TOKUNAGA
set date from british
set epoch to 1940
set scoreboard off
set color to 'W/B'

clear

cSenha        := 'teste123'
cLogin        := 'ADMIN'
cMascaraValor := '@E 999,999.99'
cAviso1       := 'Quer sair do programa?'
cAviso2       := 'Codigo inexistente.'
cAviso3       := 'Deseja finalizar as compras?'
cAviso4       := 'Desconto maior que o permitido.'
cCor          := 'G/N'

cProduto1     := 'Banana Prata'
cProduto2     := 'Banana Argentina'
cProduto3     := 'Banana Peruana'

nQuantidade   := 0
nDesconto     := 0

nDesconto1    := 20
nDesconto2    := 15
nDesconto3    := 10


nCodigo1      := 1500
nCodigo2      := 2501
nCodigo3      := 3001

nPreco1       := 1.50
nPreco2       := 9.00
nPreco3       := 5.00

nEstoque1500  := 155.00
nEstoque2501  := 117.50
nEstoque3001  := 859.00

nPedido       := 0

@ 00,00 to 24,79 double

do while .t.

   cEspacoLogin := Space( 30 )
   cEspacoSenha := Space( 30 )

   @ 01,01 say 'Login:'
   @ 02,01 say 'Senha:'

   @ 01,08 get cEspacoLogin   valid !Empty( cEspacoLogin )
   @ 02,08 get cEspacoSenha   valid !Empty( cEspacoSenha )
   read

   if LastKey() == 27
      cOpcao := Alert( cAviso1, { 'Sim', 'Nao' }, cCor )

      if cOpcao == 1
         exit
      else
         loop
      endif

   endif

   cEspacoLogin := AllTrim( cEspacoLogin )
   cEspacoSenha := AllTrim( cEspacoSenha )

   if cLogin == cEspacoLogin .and. cSenha == cEspacoSenha

      do while .t.

         nMenu := 0

         @ 01,01 clear to 23,78

         @ 01,01 say 'ANTONIO FRUTARIA'
         @ 02,01 say 'MENU'
         @ 03,01 say '1. Efetuar vendas'
         @ 04,01 say '2. Sair'

         @ 06,01 get nMenu   valid nMenu > 0
         read

         if LastKey() == 27
            cOpcao := Alert( cAviso1, { 'Sim', 'Nao' }, cCor )

            if cOpcao == 1
               exit
            else
               loop
            endif

         endif

         if nMenu == 1
            @ 02,01 clear to 23,78

            cNome       := Space( 30 )

            nCredito    := 0
            nValorTotal := 0

            dVenda      := CToD( ' ' )
            cResposta   := Space( 1 )

            ++nPedido

            @ 03,01 say 'Pedido Nø' + AllTrim( Str( nPedido ) )
            @ 04,01 say 'Nome do cliente..................:'
            @ 05,01 say 'Limite de credito................:'
            @ 06,01 say 'Data da venda....................:'
            @ 07,01 say 'Entrega domicilio? [S]im / [N]ao :'
            @ 08,01 say 'Se [S], taxa de entrega = R$ 5,00'

            @ 04,35 get cNome      picture '@!'            valid !Empty( cNome )
            @ 05,35 get nCredito   picture cMascaraValor   valid nCredito > 0
            @ 06,35 get dVenda                             valid dVenda <= Date()
            @ 07,35 get cResposta  picture '@!'            valid cResposta $ 'SN'
            read

            if LastKey() == 27
               cOpcao := Alert( cAviso1, { 'Sim', 'Nao' }, cCor )

               if cOpcao == 1
                  exit
               else
                  --nPedido
                  loop
               endif

            endif

            if cResposta == 'S'

               cEndereco   := Space( 30 )
               cBairro     := Space( 30 )
               cReferencia := Space( 30 )
               cTelefone   := Space( 15 )

               @ 10,01 say 'Endereco..:'
               @ 11,01 say 'Bairro....:'
               @ 12,01 say 'Referencia:'
               @ 13,01 say 'Telefone..:'

               @ 10,13 get cEndereco     picture '@!'   valid !Empty( cEndereco )
               @ 11,13 get cBairro       picture '@!'   valid !Empty( cBairro )
               @ 10,13 get cReferencia   picture '@!'   valid !Empty( cReferencia )
               @ 10,13 get cTelefone                    valid Len( cTelefone ) >= 10 //.and. !Empty( cTelefone )
               read

               if LastKey() == 27
                  cOpcao := Alert( cAviso1, { 'Sim', 'Nao' }, cCor )

                  if cOpcao == 1
                     exit
                  else
                     --nPedido
                     loop
                  endif

               endif

               nValorTotal += 5

               @ 03,01 clear to 23,78

               nLinha  := 4

               do while .t.

                  nCodigo := 0

                  @ 03,01 say 'Codigo'
                  @ 03,08 say 'Descricao do produto'
                  @ 03,30 say 'Qtde'
                  @ 03,35 say 'Pre‡o Unit.'
                  @ 03,47 say '%Desc.'
                  @ 03,54 say 'Valor Total'

                  @ nLinha,01 get nCodigo       valid nCodigo > 0
                  @ nLinha,30 get nQuantidade   valid nQuantidade > 0
                  @ nLinha,47 get nDesconto     valid nDesconto >= 0
                  read

                  if LastKey() == 27
                     cOpcao := Alert( cAviso3, { 'Sim', 'Nao' }, cCor )

                     if cOpcao == 1
                        exit
                     else
                        loop
                     endif

                  endif

                  cProdutoAtual  := ''
                  nPrecoAtual    := 0
                  nDescontoAtual := 0
                  nValorProduto  := 0

                  if nCodigo == nCodigo1
                     cProdutoAtual  := cProduto1
                     nPrecoAtual    := nPreco1
                     nDescontoAtual := nDesconto1
                  elseif nCodigo == nCodigo2
                     cProdutoAtual  := cProduto2
                     nPrecoAtual    := nPreco2
                     nDescontoAtual := nDesconto2
                  elseif nCodigo == nCodigo3
                     cProdutoAtual := cProduto3
                     nPrecoAtual   := nPreco3
                     nDescontoAtual := nDesconto3
                  else
                     Alert( cAviso2, cCor )
                     loop
                  endif

                     @nLinha,08 say cProdutoAtual
                     @nLinha,35 say nPrecoAtual
                     @nLinha,49 say '%'

                  if nDesconto > nDescontoAtual
                     Alert( cAviso4, cCor )
                     loop
                  endif

                  nValorProduto := nPrecoAtual * nQuantidade
                  //

                  //if

               enddo

         elseif nMenu == 2
            exit
         else
            Alert( cAviso2, cCor )
            loop
         endif
      enddo
   else
      Alert( 'Senha invalida', cCor)
   endif

enddo
