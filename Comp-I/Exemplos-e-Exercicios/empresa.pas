program ESTOQUEVENDAS;

uses Pontman;

type
	estrutura = record
		codigo: string[4];
		nome: string;
		qtdeEstoque,qtdeVendida: integer;	
end;

type
	lista = ^elemento;
	elemento = record
	    item: estrutura;
		prox: lista;
		ant: lista;
	
end;

type
	arquivo = file of item;
end;

var
	inicio: lista;
	
procedure abreArquivo;
var
	aux: lista;
begin
	
	
	assign(estoque,'estoque.bin');
	{$I-}
	reset(estoque);
	{$I+}
	if(IORESULT = 2)then    //pela primeira que estiver sendo criado o arquivo...
	begin
		rewrite(estoque);
		write(estoque,reg);
		seek(estoque,filepos(estoque)-1);
	end
	
	else    //carrega o aqruivo e seus respectivos dados existente fazendo cópias dos registros para os campos do vetor vetCarros
	begin
		seek(estoque,filesize(estoque));
        reset(estoque);
		
		while not eof(estoque) do
		begin
			aux := inicio;
			
			if(inicio = nil)then
			begin
			    new(inicio);
                read(estoque,inicio^.item);
				inicio^.ant := nil;
				inicio^.prox := nil;
			end
			else
			begin
				while(aux^.prox <> nil)do
				begin
					aux := aux^.prox;
				end;
				new(aux^.prox);
				aux^.prox^.ant := aux;
				aux := aux^.prox;
				read(estoque,aux^.item);
				aux^.prox := nil;
				
			end;
		end;

	end;
	
end;	

	
procedure incluirNovoItem;
//este procedimento insere um novo produto na lista de forma ordenada por código...
var	
	maior,aux: lista;
	item: estrutra;
	codigo: string[4];
	nome: string;
	encontrou: integer;
begin
	 
	encontrou = 0; 
	
	writeln('Digite o nome do produto: ');
	readln(nome);	
	writeln('Digite um código para o produto: ');
	readln(codigo);
	new(aux);
	aux^.ant := nil;
	aux^.prox := aux^.ant;
		 
	aux^.item.codigo := codigo;
	aux^.item.nome := nome
	aux^.item.qtdeEstoque := 1;
	aux^.item.qtdeVendida := 0;
	
	
	if(inicio = nil)then
	begin
	    
		inicio := aux;
		aux := nil;
		
		end
		else
		begin	  
			  
			if(aux^.item.codigo < inicio^.item.codigo)then  //insere no inicio da lista
			begin
				inicio^.ant := aux;
				aux^.prox := inicio;
				inicio := aux;
				aux := nil;
			end
			else
			begin
				maior := inicio;
				  
				while(maior^.prox <> nil)do //percorre inicio
				begin
					if(maior^.item.codigo < codigo)then
					begin
						maior := maior^.prox;
					end;
				end;
				   
				if(maior^.item.codigo > codigo)then  //insere no meio de qualquer posição da inicio
				begin
					maior^.ant^.prox := aux;
					aux^.prox := maior;
					aux^.ant := maior^.ant;
					maior^.ant := aux;
					aux := nil;
				end
				else
				begin     //insere no fim da inicio
					maior^.prox := aux;
					aux^.ant := maior;
					aux := nil;
					maior := aux;
					 
				end;
			end;
		end;
	end;
	
	incluirNovoItem := encontrou;

end.


function consultarItem:integer;
var
	aux: lista;
	nome: string;
begin
	encontrou := 0;
	aux := inicio;
	writeln('Informe o nome do produto que deseja consultar');
	readln(nome);

	while(aux <> nil)do
	begin
		if(aux^.item.nome = nome)then
		begin
			encontrou := 1;

			writeln('Codigo: ',aux^.item.codigo);
			writeln('Nome: ',aux^.item.nome);
			writeln('Quantidase em Estoque: ',aux^.item.qtdeEstoque);
			writeln('Quantidade Total: ',aux^.item.qtdeVendida);
		end;
		aux := aux^.prox;
	end;
	
	consultarItem := encontrou;	
	
end.

function venderItem:integer;
var
	aux: lista;
	encontrou: integer;

begin
    encontrou := 0
	writeln('Informe o nome do item que deseja vender: ');
	readln(nome);
	
	aux := inicio;
	while(aux <> nil)do
	begin
	     
		if(aux^.item.nome = nome)then
		begin
		
			encontrou := 1;
			aux^.item.qtdeEstoque := aux^.item.qtdeEstoque - 1;
			aux^.item.qtdeVendida := aux^.item.qtdeVendida + 1;
			
			if(aux^.item.qtdeEstoque = 0)then
		    begin
				if(inicio^.prox = nil)then //remover quando a inicio possuir apenas um elemento
				begin
					inicio := nil;
				end
				else
				begin
					if(inicio^.item.nome = nome)then //remover primeiro elemento da inicio
					begin
						inicio := aux^.prox;
						inicio^.ant := nil;
						aux^.prox := nil;
					end
					else
					begin
						if(aux^.prox = nil)then //remover ultimo elemtno da inicio
						begin
							aux^.ant^.prox := nil;
							aux^.ant := nil;
							
						end
						else
						begin //remover elemento em qualquer posição no meio da inicio
							aux^.ant^.prox := aux^.prox;
							aux^.prox^.ant := aux^.ant;
							aux^.ant := nil;
							aux^.prox := nil;
						end;
						
					end;
				end;
				
				aux := nil;
				dispose(aux);
			end;
			
		end;
		
		if(encontrou = 0)then
		begin
			aux := aux^.prox;
		end;
	end;
	
	venderItem := encontrou;
	
end;

procedure darEntrada;
var

begin
    
	vendido := 0;
	
	encontrou := 0;
	
	writeln('Digite o nome do produto: ');
	readln(nome);
	
    aux := inicio;

		  
	 while(aux <> nil)do
	 begin
			
		if(aux^.item.nome = nome)then
		begin
			aux^.item.qtdeEstoque := aux^.item.qtdeEstoque + 1;
            aux := nil;		
            encontrou := 1;			
		end
		else
		begin
			aux := aux^.prox;
		end;
		  
	 end;
	 
	 darEntrada := encontrou;
	
end;

procedure encerrarDia;
var
	aux: lista;
begin
	aux := inicio;
	while(aux <> nil)do
	begin
		if(aux^.item.qtdeVendida <> 0)then
		begin
			writeln('Codigo: ',aux^.item.codigo);
			writeln('Nome: ',aux^.item.nome);
			writeln('Quantidade Vendida: ',aux^.item.qtdeVendida);
		end;
		
	end;
end;

var
	op,res: integer;
	inicio: lista;
	estoque: arquivo;
begin

	abreArquivo;

	writeln('<<<<<<< EMPRESA DE COMERCIO>>>>>>>');
	writeln('Opções:');
	writeln('1 - Incluir novo item');
	writeln('2 - Consultar um item;');
	writeln('3 - Vender um item;');
	writeln('4 - Dar entrada em um item;');
	writeln('5 - Encerrar o Processamento;');
	writeln('6 - Sair');

	inicio := nil;

	writeln;
	writeln('Digite uma opcao: ');
	readln(op);

	while(op <> 5)do
	begin
		  case op of
			  
			1:	begin

					incluirNovoItem;
					writeln('Um novo produto foi incluido no estoque!');
			
				end;
				
			2:	begin
                    
					res := consultarItem;
					if(res = 0)then
						writeln('Este produto não existe!');
			
				end;
				
			3:	begin

					res := venderItem;
					if(res = 0)then
						writeln('Este produto não existe!');
					else
						writeln('Produto vendido!');
			
				end;
				
			4:	begin
				
					res := darEntrada;
					if(res = 0)then
						writeln('Este produto não existe!');
					else
						writeln('Quantidade do produto atualizada com sucesso!')
			
				end;
				
			else
				begin
					if(op <> 5)then
					begin
						writeln('Essa opcao nao existe!');
						writeln;
					end;
				end;
		  end;
			
		  writeln('Digite uma opcao: ');
		  readln(op);

	end;

	encerrarDia;
	close(estoque);
	writeln('O dia foi encerrado. Pressione ENTER para continuar...');
	readln;

end.

	