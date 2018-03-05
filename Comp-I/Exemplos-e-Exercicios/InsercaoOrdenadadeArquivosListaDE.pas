//procedimento para inserir arquivos de maneira ordenada por nome numa lista duplamente encadeada
procedure criaInsereArquivo;
var
	maior,aux: lista;
	nome,autor,texto: string;
	
begin
	if(inicio = nil)then
	begin	
        writeln;
		writeln('Não existem arquivos! Crie!');
        writeln;
	end;

	writeln('Digite um nome para o arquivo: ');
	readln(nome);
    writeln;
	writeln('Digite o nome do autor: ');
	readln(autor);

    clrscr;
    menu;
	 
     new(aux);
     aux^.ant := nil;
     aux^.prox := aux^.ant;
     aux^.arquivo.fileName := nome;
	 
	 assign(aux^.arquivo.fileRef,nome);
	 rewrite(aux^.arquivo.fileRef);
     writeln;
	 writeln('Digite um texto a ser inserido no arquivo ',nome,': ');
	 readln(texto);
	 writeln(aux^.arquivo.fileRef,texto);
	 close(aux^.arquivo.fileRef);
	 
	 aux^.arquivo.fileAuthor := autor;	
	 
	 GetDate(aux^.arquivo.fileLastModif.ano, aux^.arquivo.fileLastModif.mes, aux^.arquivo.fileLastModif.dia, aux^.arquivo.fileLastModif.diaS);
	 
     if(inicio = nil)then
	 begin
                       inicio := aux;
                       aux := nil;
     end
     else
	 begin
          if(aux^.arquivo.fileName < inicio^.arquivo.fileName)then  //insere no inicio da lista
		  begin
                                    inicio^.ant := aux;
                                    aux^.prox := inicio;
                                    inicio := aux;
                                    aux := nil;
          end
          else
		  begin
               maior := inicio;
			   
               while(maior^.prox <> nil)do //percorre lista
			   begin
					if(maior^.arquivo.fileName < nome)then
					begin
						maior := maior^.prox;
					end;
			   end;
			   
               if(maior^.arquivo.fileName > nome)then  //insere no meio de qualquer posição da lista
			   begin
                                    maior^.ant^.prox := aux;
                                    aux^.prox := maior;
                                    aux^.ant := maior^.ant;
                                    maior^.ant := aux;
                                    aux := nil;
               end
               else
			   begin     //insere no fim da lista
                     maior^.prox := aux;
                     aux^.ant := maior;
                     aux := nil;
                     maior := aux;
                    
                    
                end;
          end;
     end;
end;