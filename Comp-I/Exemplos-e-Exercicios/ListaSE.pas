type
	estrutura = record
		dado: integer;
		prox: ^estrutura;
	end;

var
   lista,ver: ^estrutura;

procedure mostra;
begin
     if(ver^.prox <> lista)then
     begin
                          writeln(ver^.dado);
                          ver := ver^.prox;
                          mostra;
     end
                          
     else
     begin
         writeln(ver^.dado);
     end;
end;
         
		 
procedure criaOrdemLSE;
     var
        dado: integer;
        aux: ^estrutura;
     begin
     writeln('Entre com o valor: ');
     readln(dado);
     if(dado>=0)then
	 begin
                 new(lista);
                 lista^.dado := dado;
                 aux := lista;
                 writeln('Entre com o valor: ');
                 readln(dado);
                 while(dado>=0)do
				 begin
                                new(aux^.prox);
                                aux := aux^.prox;
                                aux^.dado := dado;
                                writeln('Entre com o valor: ');
                                readln(dado);
                 end;
                 aux^.prox := lista;
                 aux := nil;
                 writeln('Fim da Lista!');
      end
     else
	 begin
          lista := nil;
          aux := lista;
          writeln('Lista Vazia!');
     end;
end;

begin
       criaOrdemLSE;
       ver := lista;
       mostra;
       readln;
end.
