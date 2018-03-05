program GERENCIADORDEARQUIVOS;

uses crt,DOS;

type
	data = record
		dia,mes,ano,diaS: word;
	end;

type
	File_t = record 
		 fileRef: text;// Arquivo 
		 fileName: string;// Nome do arquivo 
		 fileAuthor: string;// Nome do autor do arquivo 
		 fileLastModif: data;//Data da última modificação (Formato DDMMAAAA) 
	end; 
	
type
	lista = ^elemento;
	elemento = record
		arquivo: File_t;
		prox: lista;
		ant: lista;
	end;
	
var
	inicio: lista;
	
procedure menu;
begin
	writeln('<<<<<<< GERENCIADOR DE ARQUIVOS >>>>>>>');
	writeln('Opções:');
	writeln('1 - Criar um Arquivo');
	writeln('2 - Editar um Arquivo;');
	writeln('3 - Remover um Arquivo;');
	writeln('4 - Exibir um Arquivo;');
	writeln('5 - Buscar Palavra-Chave em um Arquivo;');
	writeln('6 - Exibir todos os Arquivos;');
	writeln('7 - Sair.')
end;


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

function editaArquivo:integer;
var
	texto,nome: string;
	aux: lista;
	encontrou: integer;
begin
	encontrou := 0;
    writeln;
	writeln('Digite o nome de um arquivo que deseja editar: ');
	readln(nome);
	aux := inicio;
	while(aux <> nil)do
	begin
		if(aux^.arquivo.fileName = nome)then
		begin
			encontrou := 1;
            clrscr;
            menu;
            writeln;
			writeln('Digite o texto a ser inserido no arquivo ',nome,': ');
			readln(texto);
			append(aux^.arquivo.fileRef);
			writeln(aux^.arquivo.fileRef,texto);
			close(aux^.arquivo.fileRef); 
			GetDate(aux^.arquivo.fileLastModif.ano, aux^.arquivo.fileLastModif.mes, aux^.arquivo.fileLastModif.dia, aux^.arquivo.fileLastModif.diaS);
		end;
        aux := aux^.prox;
	end;

	editaArquivo := encontrou;	
	
	
end;


function removeArquivo:integer;
var
	aux: lista;
	nome: string;
    encontrou: integer;

begin
    encontrou := 0;
    writeln;
	writeln('Digite o nome do arquivo que deseja apagar: ');
	readln(nome);
	aux := inicio;
	while(aux <> nil)do
	begin
	
		if(aux^.arquivo.fileName = nome)then
		begin
			encontrou := 1;
			if(inicio^.prox = nil)then //remover quando a lista possuir apenas um elemento
			begin
				inicio := nil;
				erase(aux^.arquivo.fileRef);
				dispose(aux);
			end
			else
            begin
				if(inicio^.arquivo.fileName = nome)then //remover primeiro elemento da lista
				begin
					inicio := aux^.prox;
					inicio^.ant := nil;
					aux^.prox := nil;
					erase(aux^.arquivo.fileRef);
					dispose(aux);
				end
				else
				begin
					if(aux^.prox = nil)then //remover ultimo elemtno da lista
					begin
						aux^.ant^.prox := nil;
						aux^.ant := nil;
						erase(aux^.arquivo.fileRef);
						dispose(aux);
						
					end
					else
					begin //remover elemento em qualquer posição no meio da lista
						aux^.ant^.prox := aux^.prox;
						aux^.prox^.ant := aux^.ant;
						aux^.ant := nil;
						aux^.prox := nil;
						erase(aux^.arquivo.fileRef);
						dispose(aux);
					end;
					
				end;
			end;
			aux := nil;
		end;
		
		if(encontrou = 0)then
		begin
			aux := aux^.prox;
		end;
	end;
	removeArquivo := encontrou;
end;

function exibeArquivo:integer;
var
	nome,conteudo: string;
	aux: lista;
	encontrou: integer;
begin
	encontrou := 0;
	aux := inicio;
    writeln;
	writeln('Digite o nome de um arquivo que deseja exibir: ');
	readln(nome);
    writeln;
	while(aux <> nil)do
	begin
		if(aux^.arquivo.fileName = nome)then
		begin
			encontrou := 1;
			assign(aux^.arquivo.fileRef,nome);
			reset(aux^.arquivo.fileRef);
			
			while not eof(aux^.arquivo.fileRef) do
			begin
				readln(aux^.arquivo.fileRef,conteudo);
				writeln(conteudo);
			end;
			close(aux^.arquivo.fileRef);
			writeln;
			writeln('Ultima modificacao: ',aux^.arquivo.fileLastModif.dia,'/',aux^.arquivo.fileLastModif.mes,'/',aux^.arquivo.fileLastModif.ano);
			writeln;
		end;
		aux := aux^.prox;
	end;
	
	exibeArquivo := encontrou;	
		
end;

function buscaPalavra:integer;
var
	a,i,j,k,encontrouLinha,encontrouArq: integer;
	ocorrs: array[0..100] of integer;
	palavra,linha: string;
	aux: lista;
	
begin
    encontrouArq := 0;
	writeln;
	writeln('Digite uma palavra-chave que deseja buscar: ');
	readln(palavra);
    clrscr;
    menu;
	aux := inicio;
	while(aux <> nil)do //...até que atinja o fim da lista
	begin
		
		encontrouLinha := 0;
		a := 1;
		reset(aux^.arquivo.fileRef);
	
		while not eof(aux^.arquivo.fileRef)do //...até que atinja o fim do arquivo
		begin
			
			readln(aux^.arquivo.fileRef,linha);
			
			i := 0;
			j := 0;
			k := 0;
			ocorrs[a] := 0;
			
			for k := length(palavra) to length(linha) do  //fornece a ocorrencia de uma subcadeia de strings(palavra) na cadeia de strings(linha)
            begin			
				i := length(palavra);
				j := k;
				while (i >= 1) and (palavra[i] = linha[j])do
				begin
					i := i - 1;
					j := j - 1;   
					if (i < 1)then
					begin
						encontrouLinha := 1;
						ocorrs[a] := ocorrs[a] + 1;
					end;
				end;
			end;
			
			a := a + 1;
			
		end;
		
		if(encontrouLinha = 1)then //...apenas se encontrar a palavra em alguma linha do arquivo
		begin
		    encontrouArq := 1;
			writeln;
			writeln('Arquivo ',aux^.arquivo.fileName,': ');
			writeln;
			for i := 1 to (a-1) do
			begin
				if(ocorrs[i] <> 0)then //imprime somente o numero das linhas em que a palavra foi encontrada
				begin
					writeln(ocorrs[i],' palavras encontradas na linha ',i);
				end;
			end;
		end;
		
		
		close(aux^.arquivo.fileRef);
		
		aux := aux^.prox;	
      end;
	  
	  buscaPalavra := encontrouArq;
	  
end;

procedure exibeTodosArquivos;
var
    aux: lista;
begin
	aux := inicio;
	while(aux <> nil)do
	begin
        writeln;
		writeln('Nome: ',aux^.arquivo.fileName);
        writeln('Autor: ',aux^.arquivo.fileAuthor);
        writeln('Ultima Modificacao: ',aux^.arquivo.fileLastModif.dia,'/',aux^.arquivo.fileLastModif.mes,'/',aux^.arquivo.fileLastModif.ano);
        writeln;
		aux := aux^.prox;
	end;
    if(inicio = nil)then
    begin
        writeln;
        writeln('Nao existem arquivos!');
    end;
end;

var
	op,res: integer;

begin

menu;

inicio := nil;

writeln;
writeln('Digite uma opcao: ');
readln(op);

while(op <> 7)do
begin
	  case op of
		  
		1:	begin
                clrscr;
                menu;
				criaInsereArquivo;
				writeln;
				writeln('Arquivo criado com sucesso!');
                writeln;
		
			end;
			
		2:	begin

                clrscr;
                menu;
				res := editaArquivo;
                writeln;
				if(res = 0)then
					writeln('Não existe arquivo com esse nome!')
				else
					writeln('Arquivo editado com sucesso!');
                writeln;
		
			end;
			
		3:	begin

                clrscr;
                menu;
				res := removeArquivo;
                writeln;
				if(res = 1)then
					writeln('Arquivo removido com sucesso!')
				else
					writeln('O arquivo que deseja remover nao existe!');
                writeln;
		
			end;
			
		4:	begin

                clrscr;
                menu;
				res := exibeArquivo;
				writeln;
				if(res = 0)then
				begin
					writeln('Não existe arquivo com esse nome!');
				end;
                writeln;
		
			end;
		
		5:	begin

                clrscr;
                menu;
		        res := buscaPalavra;
                writeln;
				if(res = 0)then
				begin
					writeln('Esta palavra nao pode ser encontrada!');
				end;
				writeln;
		
			end;
			
		6:	begin

                clrscr;	
                menu;
				exibeTodosArquivos;
		
			end;
			
		else
			begin
				if(op <> 7)then
				begin
					clrscr;
					menu;
					writeln('Essa opcao nao existe!');
					writeln;
				end;
			end;
      end;
		
      writeln('Digite uma opcao: ');
      readln(op);

end;
clrscr;

writeln('Voce SAIU do programa. Pressione ENTER para continuar...');
readln;

end.
