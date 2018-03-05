//Algoritmo para gerenciamento de uma DVDTECA
//Responsável: Lucas do Vale Santos
//Data: 25 de novembro de 2013

program DVDTECA; 

Uses manipulaArq;

const MAX = 100;

type
	filme = record
			codigo: integer;
			titulo: string[40];
			descricao: string[255];
			local: string[20];
	end;
	arquivo = file of filme;
	
	
procedure inclusao(operac: char; var nomeExt: string; var numeroFilmes: integer);
//inclusao de novos filmes
var
	operac: char;
	i: integer;
	arq: arquivo;
	reg: filme;
begin
	
	if(operac = 'C')then    //pela primeira vez, quando o arquivo for criado
	begin
		write(arq,reg);
		seek(arq,filepos(arq)-1);
        numeroFilmes := 0;
	end
	else
	begin
		
		seek(arq,filesize(arq)); //carrega o aqruivo e seus respectivos dados existente fazendo cópias dos registros para os campos do vetor vetFilmes
		numeroFilmes := filesize(arq);
		
	end;
	
	repeat 
		
		writeln('Digite o titulo do filme: ');
		readln(reg.titulo);
		writeln('Digite o código do filme: ');
		readln(reg.codigo);
		writeln('Digite a descrição do filme: ');
		readln(reg.descricao);
		writeln('Digite o local onde se encontra: ');
		readln(reg.local);
		writeln;
		
		write(arq,reg);
		
		writeln('Deseja inserir outro filme? (S - sim/ N - não)');
		readln(continua);
	
		numeroFilmes := numeroFilmes + 1;
	
		if(numeroFilmes = MAX)then   //se o limite for atingido...
			begin
				
				 writeln('Numero maximos de filmes atingido!');
				 
			end;	
				
	until((continua = 'S') or (numeroFilmes = MAX));
	

end;

procedure exclusao;
//exclusao de filmes
var
	aux: string;	
	
begin
	writeln('Entre com o codigo do filme que deseja retirar: ');
	readln(codigo);
	
	while not eof(arq) do   
	begin
		read(arq,reg);   //a cada loop faz a leitura de um registro do arquivo
		if(codigo = reg.codigo)then   //se o codigo informado corresponder com o codigo contido no registro...
		begin
			
			while not eof(arq)do  
			begin
				seek(arq,filepos(arq+1));     //posiciona no próximo registro do arquivo    
				aux := reg.codigo;           //copia para uma variavel auxiliar o codigo deste registro psicionado
				seek(arq,filepos(arq-1));    //volta para a posição anterior
				write(arq,aux);     //sobrescreve com o contepudo guardado em aux
			end;
		
		end;
	end;
	
end;

procedure consultaPorCodigo;
//consulta de filme pelo codigo
var
	
	arq: arquivo;
	reg: carro;
	codigo,encontrou: integer;

begin
	
	encontrou := 0;

	writeln('Digite um codigo: ');
	readln(codigo);
	
	clrscr;
    menu;
	
	while not eof(arq) do   
	begin
		read(arq,reg);   //a cada loop faz a leitura de um registro do arquivo
		if(codigo = reg.codigo)then   //se o fabricante informado corresponder com o fabricante contido no registro, os dados desse registro são impressos na tela
		begin
			encontrou := 1;
			writeln;
			writeln(reg.titulo,' ',reg.codigo,' ',reg.descricao,' ',reg.local);
		
		end;
	end;
	
	if(encontrou = 0)then
	begin
		writeln('Este codigo nao existe!');
	end;
	
	writeln;

end;
	
end;

procedure consultaPorpalavra;
//consulta de filme por uma palavra
var	
	arq: arquivo;
	reg: carro;
	encontrou,codigo,pos: integer;
	palavra: string;

begin

	encontrou := 0;

	writeln('Digite uma palavra: ');
	readln(palavra);
	
	clrscr;
    menu;
	
	while not eof(arq) do   
	begin
		read(arq,reg);		//a cada loop faz a leitura de um registro do arquivo
		
		pos := posicao(titulo,palavra);
		
		
		if(pos <> 0)then   //se o fabricante informado corresponder com o fabricante contido no registro, os dados desse registro são impressos na tela
		begin
			encontrou := 1;
			writeln;
			writeln(reg.titulo,' ',reg.codigo);
		
		end;
	end;
	
	if(encontrou <> 0)then
	begin
		writeln('informe um dos códigos acima:');
		readln(codigo);
		
		while not eof(arq) do   
		begin
		read(arq,reg);		//a cada loop faz a leitura de um registro do arquivo

		if(codigo = reg.codigo)then   //se o fabricante informado corresponder com o fabricante contido no registro, os dados desse registro são impressos na tela
		begin
			encontrou := -1;
			writeln;
			writeln(reg.titulo,' ',reg.codigo);
		
		end;
	end;
		
	end
	
	else
	begin
		writeln('Esta palavra não existe em nenhum filme!');
	end;
	if(encontrou = 1)then
		writeln('O código informado está incorreto!');
	
	writeln;

end;
	
	
	
	
var
	nomeExt: string;
	arq: arquivo;
	op,numeroFilmes: integer;
	vetFilmes: filme;
	
begin

  writeln('******** DvdTeca ********');
  writeln;
  writeln('1 - Incluir filme;');
  writeln('2 - Excluir filme;');
  writeln('3 - Consultar filme pelo código;');
  writeln('4 - Consultar filme pelo nome;');	
  //writeln('5 - Apagar arquivo existente;');
  writeln('5 - Sair');
  writeln;
  
  
  
  writeln;
  writeln('Digite uma opcao: ');
  readln(op);
  
  while(op <> 5)do
  begin
	writeln('Deseja criar um novo arq de filmes ou abrir um já existente?(A - abrir/ C - criar)');
	readln(operac);

	abrirArqBin(operac,arq,nomeExt);
	
    case op of
    
      1: begin
			
			inclusao(operac,nomeExt,numeroFilmes,vetFilmes);  //inclui novos filmes
	  
		end;

      2: begin
	  
			exclusao(); //exclui algum filme

		end;

      3: begin

			consultaPorCodigo; //consulta os dados de um filme pelo código

		end;

      4: begin

			consultaPorPalavra; //consulta os dados de um filme por uma palavra

		end;

      else
		begin
			if(op <> 5)then
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

    close(arq); //fecha orquivo salvando todas as alterações possóveis feitas

  end;
  
  
  clrscr;
  writeln('Voce SAIU! Ate Mais! Pressione ENTER para continuar...');
  readln;
	
	
end.
	
