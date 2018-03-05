PROGRAM LOJADEAUTOMOVEIS;

uses Crt,Sysutils;

const
    MAX = 100;

type
	carro = record
		placa: string;
		modelo: string;
		fabricante: string;
		ano: integer;
		preco: real;
     end;
	 arquivo = file of carro;

type
		
	vetor = array[1..MAX] of carro;



procedure menu;   //exibe menu
begin
  writeln('******** Loja de Automoveis ********');
  writeln;
  writeln('1 - Incluir carros;');
  writeln('2 - Editar preco de um carro;');
  writeln('3 - Consultar dados de um carro;');
  writeln('4 - Listar todos os carros de um fabricante;');	
  writeln('5 - Listar todos os dados;');
  writeln('6 - Apagar arquivo existente;');
  writeln('7 - Sair');
  writeln;

end;

procedure preencheVetCarros(var vetCarros: vetor; var antes: integer; var depois: integer); //faz a movimentação dos registros dentro do vetor
var
	aux1: string;
	aux2: integer;
	aux3: real;

begin //troca a posição dos modelos
	
	aux1 := vetCarros [depois].modelo;
	vetCarros [depois].modelo := vetCarros [antes].modelo;
	vetCarros [antes].modelo := aux1;
			
	aux1 := vetCarros [depois].placa;
	vetCarros [depois].placa := vetCarros [antes].placa;
	vetCarros [antes].placa := aux1;
						
	aux1 := vetCarros [depois].fabricante;
	vetCarros [depois].fabricante := vetCarros [antes].fabricante;             
	vetCarros [antes].fabricante := aux1;
						
	aux2 := vetCarros [depois].ano;
	vetCarros [depois].ano := vetCarros [antes].ano;
	vetCarros [antes].ano := aux2;
						
	aux3 := vetCarros [depois].preco;
	vetCarros [depois].preco := vetCarros [antes].preco;
	vetCarros [antes].preco := aux3;
						
      
	antes := antes - 1;
	depois := depois - 1;
	
end;

procedure incluiOrdenado(var vetCarros: vetor; var numeroCarros: integer; modelo: string; placa: string; fabricante: string; ano: integer; preco: real);
//este procedimento realiza a ordenaçao dos carros dentro do vetor
var
	antes,depois: integer;

begin
	
	
	if (numeroCarros = 0) then //se o vetor estiver vazio
		begin
		
			vetCarros [numeroCarros + 1].modelo := modelo;
			vetCarros [numeroCarros + 1].placa := placa;
			vetCarros [numeroCarros + 1].fabricante := fabricante;
			vetCarros [numeroCarros + 1].ano := ano;
			vetCarros [numeroCarros + 1].preco := preco;
			
		end

	else if (numeroCarros >= 1) then  //se o vetor já estiver preeenchido
	begin
		
			vetCarros [numeroCarros + 1].modelo := modelo;
			vetCarros [numeroCarros + 1].placa := placa;
			vetCarros [numeroCarros + 1].fabricante := fabricante;
			vetCarros [numeroCarros + 1].ano := ano;
			vetCarros [numeroCarros + 1].preco := preco;
			
			depois := numeroCarros + 1;
			antes := numeroCarros;

			while (vetCarros [antes].modelo > vetCarros [depois].modelo) and (antes > 0) do  //vai verificar se o elemento está desordenado, e portanto, ordenar
			begin

                 preencheVetCarros(vetCarros,antes,depois);  //faz a movimentação dos registros dentro do vetor

			end;

            while(vetCarros[antes].modelo = vetCarros[depois].modelo) and (vetCarros[antes].placa > vetCarros[depois].placa)do  //vai verificar se o modelo é igual a outro existente, e portanto, ordenar por placa
            begin

                 preencheVetCarros(vetCarros,antes,depois); //faz a movimentação dos registros dentro do vetor

            end;
			

	end;
end;

procedure inclusaoCarros(var vetCarros: vetor; var numeroCarros: integer);
var
	catalogo: arquivo;
	reg:carro;
	modelo,placa,fabricante: string;
	ano,continua,i: integer;
	preco: real;

begin

continua := 1;

	assign(catalogo,'catalogo.bin');
	{$I-}
	reset(catalogo);
	{$I+}
	if(IORESULT = 2)then    //pela primeira que estiver sendo criado o arquivo...
	begin
		rewrite(catalogo);
		write(catalogo,reg);
		seek(catalogo,filepos(catalogo)-1);
        numeroCarros := 0;
	end
	
	else    //carrega o aqruivo e seus respectivos dados existente fazendo cópias dos registros para os campos do vetor vetCarros
	begin
		seek(catalogo,filesize(catalogo));
		numeroCarros := filesize(catalogo);
        reset(catalogo);
		i := 1;
		while not eof(catalogo) do
		begin
			
			read(catalogo,reg);
			vetCarros[i].modelo := reg.modelo;
			vetCarros[i].placa := reg.placa;
			vetCarros[i].fabricante := reg.fabricante;
			vetCarros[i].ano := reg.ano;
			vetCarros[i].preco := reg.preco;
			i := i + 1;
			
		end;

	end;
		
    close(catalogo);
	
	repeat  //permanece aqui até que o usário deseje ou até que o limite de registros no vetor seja atiingido
		
		writeln;
		writeln ('Digite o nome do modelo: ');
		readln (modelo);
		writeln;
		writeln ('Digite a placa: ');
		readln (placa);
		writeln;
		writeln ('Digite o nome do fabricante: ');
		readln (fabricante);
		writeln;
		writeln ('Digite o ano de fabricacao: ');
		readln (ano);
		writeln;
		writeln ('Digite o preco: ');
		readln (preco);
		writeln;
		
		incluiOrdenado (vetCarros,numeroCarros,modelo,placa,fabricante,ano,preco);  //oredena os carros por ordem alfabética
		numeroCarros := numeroCarros + 1;
		
		clrscr;
		menu;
		
		writeln('Deseja inserir outro carro? 1(sim)/0(nao)');
		readln(continua);
		
		
        if(numeroCarros = MAX)then   //se o limite for atingido...
        begin
			
             writeln('Numero maximos de carros atingido!');
        end;
		
		clrscr;
		menu;
        
	until((numeroCarros = MAX) or (continua = 0));

    rewrite(catalogo);

    for i := 1 to numeroCarros do    //atualiza arquivo com os novos dados
    begin
         reg.modelo := vetCarros [i].modelo;
         reg.placa := vetCarros [i].placa;
	     reg.fabricante := vetCarros [i].fabricante;
	     reg.ano := vetCarros [i].ano;
	     reg.preco := vetCarros [i].preco;
		
         write(catalogo,reg);
    end;
	
	close(catalogo);

end;

procedure edicaoPreco;
var
   reg: carro;
   catalogo: arquivo;
   modelo,placa: string;
   i,j,continua,encontrouModelo,encontrouPlaca,numeroCarros: integer;
   vetCarros: vetor;

begin
	
	clrscr;
    menu;
	
	assign(catalogo,'catalogo.bin');
	reset(catalogo);
	i := 0;
   while not eof(catalogo) do  //lê todos os registros contidos no arquivo e copia cada um para uma posição do vetor vetCarros
   begin
		
        i := i + 1;
		read(catalogo,reg);
		vetCarros[i].modelo := reg.modelo;
		vetCarros[i].placa := reg.placa;
		vetCarros[i].fabricante := reg.fabricante;
		vetCarros[i].ano := reg.ano;
		vetCarros[i].preco := reg.preco;
		
	end;
	numeroCarros := i;
	close(catalogo);
	
	writeln('Digite o nome um modelo: ');
	readln(modelo);
    encontrouPlaca := 0;
	encontrouModelo := 0;
    i := 0;
	
	while(i < numeroCarros + 1)do   //percorre todo o vetor até o fim
	begin

        i := i + 1;

		if(modelo = vetCarros[i].modelo) and (encontrouModelo = 0)and (i <= numeroCarros)then //verifica se o modelo digitado corresponde com o modelo contido no registro na posição atual do vetor
		begin

			if(modelo = vetCarros[i+1].modelo) and (i+1 <= numeroCarros)then  //verifica se existe um modelo igual na próxima posição
			begin
				
                encontrouModelo := 1;

				clrscr;
                menu;

				writeln('Existe mais de um carro desse modelo!');
				writeln;
				
				j := i;

				while(modelo = vetCarros[j].modelo) and (j <= numeroCarros)do   //imprime na tela todos os modelos iguais ao desejado pelo usuário
				begin
				
					writeln;
					writeln(vetCarros[j].modelo,' ',vetCarros[j].placa,' ',vetCarros[j].fabricante,' ',vetCarros[j].ano,' R$',vetCarros[j].preco:2:2);
					writeln;
					j := j + 1;	
				
				end;
				
				writeln('Entre com uma das placas acima: ');
				readln(placa);
				
				j := i;
				
				while(modelo = vetCarros[j].modelo) and (j <= numeroCarros)do  //permanece aqui somente enquanto o modelo for repetido
				begin
					
					if(placa = vetCarros[j].placa)then   //verifica se a placa corresponde a placa contida no registro que está no vetor na posição atual
					begin
						
						clrscr;
						menu;
						
						writeln;
						encontrouPlaca := 1;
						writeln(vetCarros[j].modelo,' ',vetCarros[j].placa,' ',vetCarros[j].fabricante,' ',vetCarros[j].ano,' R$',vetCarros[j].preco:2:2);
						writeln;
						writeln('Deseja alterar seu preco? 1(sim)/0(nao)');
						readln(continua);
						
						clrscr;
						menu;
						
						if(continua = 1)then  //só vai altera o preço se o usuário desejar
						begin
							
							writeln('Entre com o novo preco do carro: ');
							readln(vetCarros[j].preco);
							
							clrscr;
							menu;
						
						end;
						
					end
					
					else if(placa < vetCarros[j].placa) and (encontrouPlaca = 0)then  //se a placa que o usuário digitou não existir...
					begin
						
						encontrouPlaca := 1;
						writeln;
						writeln('A placa',placa,' nao existe! Esta e a proxima placa da lista em ordem alfabetica: ');
						writeln;
						writeln(vetCarros[j].modelo,' ',vetCarros[j].placa,' ',vetCarros[j].fabricante,' ',vetCarros[j].ano,' R$',vetCarros[j].preco:2:2);
						writeln('Deseja alterar seu preco? 1(sim)/0(nao)');
						readln(continua);
						
						clrscr;
						menu;
						
						if(continua = 1)then  //só vai altera o preço se o usuário desejar
						begin
						
							writeln('Entre com o novo preco do carro: ');
							readln(vetCarros[j].preco);
							
							clrscr;
							menu;
							
						end;
						
					end;
				
					j := j + 1;
			
				end;

				
                if(j + 1 > numeroCarros)and(encontrouPlaca = 0)then
				begin
                    clrscr;
                    menu;
                    writeln;
					writeln('Não existe proxima placa em ordem alfabetica!');
                    writeln;
				end;
				
			end

			
			else  //entra aqui se o modelo digitado pelo usuário for único
			begin
			    encontrouModelo := 1;
				clrscr;
                menu;
			
				writeln;
				writeln(vetCarros[i].modelo,' ',vetCarros[i].placa,' ',vetCarros[i].fabricante,' ',vetCarros[i].ano,' R$ ',vetCarros[i].preco:2:2);
				writeln('Deseja alterar seu preco? 1(sim)/0(nao)');
				readln(continua);
				
				clrscr;
				menu;
				
				if(continua = 1)then //só muda o preço se o usuário desejar
				begin
				
					writeln('Entre com o novo preco do carro: ');
					readln(vetCarros[i].preco);
					
					clrscr;
					menu;
				
				end;
				
			end;
			
		end;
		
	end;

	i := 0;

    while(i <= numerocarros + 1)do //percorre ate o fim do vetor
	begin
	
		i := i + 1;
		
		if(encontrouModelo = 0) and (modelo < vetCarros[i].modelo) and (i < numeroCarros)then //se o modelo não existir, vai mostrar o próximo em ordem alfabética
		begin
			encontrouModelo := 1; //para que não entre novamente nessa condição/encontrou o proximo em ordem alfabetica
			writeln;
			writeln('O modelo ',modelo,' nao existe! Este e o proximo carro da lista em ordem alfabetica: ');
			writeln;
			writeln(vetCarros[i].modelo,' ',vetCarros[i].placa,' ',vetCarros[i].fabricante,' ',vetCarros[i].ano,' R$ ',vetCarros[i].preco:2:2);
			writeln('Deseja alterar seu preco? 1(sim)/0(nao)');
			readln(continua);
				
			clrscr;
			menu;
				
			if(continua = 1)then //só altera o preço se o usuário desejar
			begin
				
				writeln('Entre com o novo preco do carro: ');
				readln(vetCarros[i].preco);
				
				clrscr;
				menu;
			
			end;
					
		end
		
		else if(i > numeroCarros) and (encontrouModelo = 0)then //se o modelo não existir, e se também o proximo em ordem alfabetica não existir
		begin

			clrscr;
			menu;

			writeln('O modelo ',modelo,' nao existe! Nao existe proximo carro na lista tambem!');
			writeln;
		end;
		
	end;
	
	rewrite(catalogo);  

    for i := 1 to numeroCarros do     //atuliza o arquivo com os novos dados (preços alterados)
    begin
         reg.modelo := vetCarros [i].modelo;
         reg.placa := vetCarros [i].placa;
	     reg.fabricante := vetCarros [i].fabricante;
	     reg.ano := vetCarros [i].ano;
	     reg.preco := vetCarros [i].preco;
		
         write(catalogo,reg);
    end;
	
	close(catalogo);
	

end;

procedure consultaDados;
var
    reg: carro;
    catalogo: arquivo;
    modelo: string;
    i,verProximo,encontrou,numeroCarros: integer;
	vetCarros: vetor;

begin

	assign(catalogo,'catalogo.bin');
	reset(catalogo);
    i := 0;
	while not eof(catalogo) do //lê todos os registros contidos no arquivo e copia cada um para uma posição do vetor vetCarros
	begin
		
        i := i + 1;
		read(catalogo,reg);
		vetCarros[i].modelo := reg.modelo;
		vetCarros[i].placa := reg.placa;
		vetCarros[i].fabricante := reg.fabricante;
		vetCarros[i].ano := reg.ano;
		vetCarros[i].preco := reg.preco;

		
	end;
	numeroCarros := i;
	close(catalogo);

	writeln('Entre com um modelo: ');
	readln(modelo);
	
	clrscr;
    menu;
	
	i := 0;
    verProximo := 0;
	encontrou := 0;
	while(i < numeroCarros + 1)do  //permanece aqui até atingir o fim do vetor
	begin
		
        i := i + 1;

		if(modelo = vetCarros[i].modelo) and (i <= numeroCarros)then  //verifica se o modelo digitado é igual ao modelo contido no campo do vetor na posição atual
		begin

			encontrou := 1;
			writeln;
			writeln(vetCarros[i].modelo,' ',vetCarros[i].placa,' ',vetCarros[i].fabricante,' ',vetCarros[i].ano,' R$ ',vetCarros[i].preco:2:2);
			writeln;
			
			if(modelo = vetCarros[i+1].modelo)then //verifica se o proximo campo do vetor também contém o mesmo modelo
			begin
				writeln('Ainda existem outros carros do mesmo modelo. Deseja ver o proximo?1(sim)/0(nao)');
				readln(verProximo);
				
				i := i + 1;
				
				while((modelo = vetCarros[i].modelo) and (verProximo = 1))do  //permanece aqui ate que não haja mais modelos iguais ou até que o usuário deseje não consultar mais
				begin
					
					clrscr;
					menu;
					
					writeln;
					writeln(vetCarros[i].modelo,' ',vetCarros[i].placa,' ',vetCarros[i].fabricante,' ',vetCarros[i].ano,' R$ ',vetCarros[i].preco:2:2);
					writeln;
					i := i + 1;
					if(modelo = vetCarros[i].modelo)then //se ainda existir um modelo igual na proxima posição...
					begin
						writeln('Ainda existem outros carros do mesmo modelo. Deseja ver o proximo?1(sim)/0(nao)');
						readln(verProximo);
					end;
					
				end;
				
				encontrou := -1; //a variável sofre esta atribuição se pelo menos um modelo dos repetidos já tiver sido consultado (de fato o programa só chega a esta linha quando acontece isso)
				
			end;
		end
		
		else if ((modelo < vetCarros[i].modelo) or (i > numeroCarros)) and (encontrou = 0) then //se o modelo desejado pelo usuário não existir...
		begin
			
			clrscr;
            menu;
			
			writeln('Este modelo nao existe!');
			writeln;
			encontrou := -1; //neste caso a variável sofre esta atribuição para indicar que o modelo não foi encontrado, e dessa forma não entrar de novo nesta condição
		
		end;
		
	end;

end;

procedure listagemFabricante;
var
	catalogo: arquivo;
	reg: carro;
	fabricante: string;
	encontrou: integer;

begin
	assign(catalogo,'catalogo.bin');
	reset(catalogo);
	
	encontrou := 0;

	writeln('Digite um fabricante: ');
	readln(fabricante);
	
	clrscr;
    menu;
	
	while not eof(catalogo) do   
	begin
		read(catalogo,reg);   //a cada loop faz a leitura de um registro do arquivo
		if(fabricante = reg.fabricante)then   //se o fabricante informado corresponder com o fabricante contido no registro, os dados desse registro são impressos na tela
		begin
			encontrou := 1;
			writeln;
			writeln(reg.modelo,' ',reg.placa,' ',reg.fabricante,' ',reg.ano,' R$ ',reg.preco:2:2);
		
		end;
	end;
	
	if(encontrou = 0)then
	begin
		writeln('Este fabricante nao existe!');
	end;
	
	close(catalogo);
	
	writeln;

end;

procedure listagemGeral; 
var
    catalogo: arquivo;
    reg: carro;
    i: integer;

begin

	clrscr;
    menu;
	
	assign(catalogo,'catalogo.bin');
	reset(catalogo);

        gotoxy(1,13);
        write('Modelo');
        gotoxy(11,13);
        write('Placa');
        gotoxy(21,13);
        write('Fabricante');
        gotoxy(35,13);
        write('Ano');
        gotoxy(41,13);
        write('Preco');

    i := 0;
	
	while not eof(catalogo)do   //lê cada registro contido no arquivo e imprime o que tiver dentro desses registros
	begin
		read(catalogo,reg);
        gotoxy(1,15+i);
        write(reg.modelo);
        gotoxy(11,15+i);
        write(reg.placa);
        gotoxy(21,15+i);
        write(reg.fabricante);
        gotoxy(35,15+i);
        write(reg.ano);
        gotoxy(41,15+i);
        write('R$',reg.preco:2:2);
        i := i + 2;
	end;
	
	close(catalogo);
	
	writeln;
    writeln;

end;


var
	vetCarros: vetor;
	op,numeroCarros: integer;

begin
  menu;
  
  writeln;
  writeln('Digite uma opcao: ');
  readln(op);
  
  clrscr;
  menu;
  
  while(op <> 7)do
  begin
    case op of
    
      1: begin
			
			inclusaoCarros(vetCarros,numeroCarros);  //inclui novos carros e seus respectivos dados
	  
		end;

      2: begin
	  
			edicaoPreco; //edita o preco de um carro

		end;

      3: begin

			consultaDados; //consulta os dados de um carro

		end;

      4: begin

			listagemFabricante; //lista todos os dados por fabricante

		end;
      
      5: begin

			listagemGeral; //lista todos os dados
    
		end;
		
	  6: begin

			deletefile('catalogo.bin'); //deleta o arquivo "catalogo.bin" existente
			writeln('O arquivo catalogo.bin foi exluido!');
			writeln;

		end

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

    clrscr;
    menu;

  end;
  
  clrscr;
  writeln('Voce SAIU! Ate Mais! Pressione ENTER para continuar...');
  readln;

end.
