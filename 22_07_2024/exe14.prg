clear

do while .t.
   nCodigoCliente := 0

   @ 12,10 say 'Informe o codigo do cliente:'

   @ 12,29 get nCodigoCliente picture '999999' valid nCodigoCliente > 0 //pict funciona, mas por padr∆o se usa picture
   read

   if LastKey() == 27
      exit //se fosse o loop, o programa continuaria preso no laáo de repetiá∆o
   endif

enddo
