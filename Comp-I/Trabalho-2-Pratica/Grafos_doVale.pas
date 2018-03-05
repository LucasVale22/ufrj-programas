program GRAFOS;

uses Crt;

const N = 10;     //tamanho fixo para o vetor de rótulos e a matriz de adjacências

type matriz = array[1..N,1..N] of integer;
	 vetor = array[1..N] of char;

procedure menu;
begin
    writeln('Simples Manipulacoes com Grafos');
    writeln;
	writeln('1 - criar um grafo');
	writeln('2 - exibir a matriz de adjacencias');
	writeln('3 - calcular menor distancia entre qualquer par de vértices');
	writeln('4 - calcular o diâmetro do grafo');
	writeln('5 - sair');
	writeln;
    writeln('Observacao: cada rótulo deve corresponder a um caracter diferente. Use letras de preferencia.');
    writeln;
end;

procedure zeraMatriz(var mat: matriz); 
var
	i,j: integer;
begin
	for i := 1 to 10 do
	begin
		for j := 1 to 10 do
		begin
			mat[i,j] := 0;
		end;
	end;
end;

procedure copiaMatriz(var matSal,mat: matriz; var ord: integer);
var
	i,j: integer;
begin
	for i := 1 to ord do
	begin
		for j := 1 to ord do
		begin
			matSal[i,j] := mat[i,j];
		end;
	end;
end;

procedure criaGrafo(var mat: matriz; var rot: vetor; var ord: integer);
var
	i,j,verdadeiro,arestas: integer;
	r1,r2: char;
begin
	
    zeraMatriz(mat);

	verdadeiro := 0;
    arestas := 0;
	
	writeln('Quantos vertices voce deseja que existam no grafo?');
	readln(ord);
    clrscr;
    menu;
	while((ord <2) or (ord > 10))do //permanece aqui ate o usuario entre com um valor adequado de vertices
	begin
        clrscr;
        menu;
		writeln('Este grafo deve possuir no minimo 2 vertices e no maximo 10 vertices!');
		writeln('Digite novamente a quantidade de vertices que deseja: ');
		readln(ord);
	end;
	for i := 1 to ord do //guarda em um vetor todos os rotulos dos vertices
	begin
        clrscr;
        menu;

		writeln('Entre com um rotulo para o ',i,' vertice: ');
		readln(rot[i]);
	end;

    clrscr;
    menu;
	writeln('Informe as arestas existentes.');
	
	while(verdadeiro = 0)do   
	begin

		writeln('Digite o rotulo de um vertice: ');
		readln(r1);
		if(r1 <> '0')then
		begin
		
			writeln('Digite o rotulo de outro vertice que deseja ligar ao anterior:');
			readln(r2);
            clrscr;
            menu;
			for i := 1 to ord do 
			begin
				
				if(r1 = rot[i])then //corresponde com algum rotulo no vetor
				begin
					
					for j := 1 to ord do
					begin
						if(r2 = rot[j])then //corresponde com algum rotulo no vetor
						begin
							
							if((mat[i,j] <> 1) and (mat[j,i] <> 1))then  //se já existir este enlace entre dois vertices, ele não contara uma nova aresta
							begin
								arestas := arestas + 1;
							end;
							
							mat[i,j] := 1;   //a aresta passa a existir
							mat[j,i] := 1;
							
							
						end;
					end;
					
				end;
				
			end;
			
		end
		else
		begin
		
			if(arestas >= (ord -1))then //ografo deve ter pelo menos ord-1 arestas para não haver desconexões
			begin
				verdadeiro := 1;
			end
			else
			begin
                clrscr;
                menu;
				writeln('Este grafo deve conter pelo menos ',ord -1,' arestas!')
			end;
			
		end;
		
	end;
    clrscr;
    menu;
		
end;

procedure exibeMatAdj(mat: matriz; var ord: integer; var rot: vetor);
var
	i,j: integer;
begin
    writeln('Matriz de Adjacencias:');
    writeln;
    write(' ');
    for i := 1 to ord do
    begin
         write(' ',rot[i]);    //imprime os rotulos em cima de cada coluna
    end;

    writeln;

	for i := 1 to ord do
	begin
		for j := 1 to ord do
		begin
            if(j = 1)then
            begin
                write(rot[i],' ');    //imprime os rotulos a esquerda de cada linha
            end;
			write(mat[i,j],' ');   //imprime a matriz 
		end;
        writeln;
	end;
    writeln;
end;

procedure calculaDistMin(mat: matriz; var rot: vetor; var ord: integer);
var
   i,j,x,y,z,saltos: integer;
   r1,r2: char;
   matAux,matSal: matriz;
begin

	saltos := 1;
	writeln('Digite o rotulo de um vertice: ');
	readln(r1);
	writeln('Digite o rotulo de outro vertice:');
	readln(r2);
	for i := 1 to ord do 
	begin
			
		if(r1 = rot[i])then //corresponde com algum rotulo no vetor
		begin
				
			for j := 1 to ord do
			begin
				if(r2 = rot[j])then //corresponde com algum rotulo no vetor
				begin
					
					copiaMatriz(matSal,mat,ord);  //atualiza a matriz de possiblidades a "n" saltos, para a matriz de possibilidades a 1 salto(matriz adjacências)
					
					while((matSal[i,j] = 0) and (matSal[j,i] = 0))do
					begin
						zeraMatriz(matAux);
						
						for x := 1 to ord do
						begin
						
							for y := 1 to ord do
							begin
							
								for z := 1 to ord do
								begin
									matAux[x,y] := matAux[x,y] + matSal[x,z]*mat[z,y];
										
								end;
								 
							end;
							
						end;
                       
						copiaMatriz(matSal,matAux,ord);   //atualiza a matriz de possibilidades a "n" saltos, onde "n"="saltos"

						saltos := saltos + 1;
					end;
					
				end;
			end;
			
		end;
		
	end;
    clrscr;
    menu;
	writeln('A menor distância entre os vertices ',r1,' e ',r2, ' eh de ',saltos,' saltos');
end;

procedure calculaDmtGrafo(mat: matriz; var ord: integer);
var
   i,j,x,y,z,saltos,diametro: integer;
   matAux,matSal: matriz;
begin
	
	diametro := 1;
	
	for i := 1 to ord do 
	begin
		
		for j := 1 to ord do
		begin
			
			saltos := 1;
			
			copiaMatriz(matSal,mat,ord);  //atualiza a matriz de possiblidades a "n" saltos, para a matriz de possibilidades a 1 salto(matriz adjacências)
			
			while((matSal[i,j] = 0) and (matSal[j,i] = 0) and (i <> j))do        //Continua até que seja obtido um numero minimo para haver contato entre os vertices i e j. Quando i igual a j, o salto não pode ser considerado pois um vértice com ele mesmo não forma um par
			begin
				
				zeraMatriz(matAux);
				
				for x := 1 to ord do
				begin
				
					for y := 1 to ord do
					begin
					
						for z := 1 to ord do
						begin
						
							matAux[x,y] := matAux[x,y] + matSal[x,z]*mat[z,y];
						
						end;
					
					end;
				
				end;
				
				copiaMatriz(matSal,matAux,ord);   //atualiza a matriz de possibilidades a "n" saltos, onde "n"="saltos"
				
				saltos := saltos + 1;
				
			end;
			
			if(saltos > diametro)then          //verifica entre entre cada salto qual o menor possível para que qualquer par de vértice entre em contato
				begin
				
					diametro := saltos;
				
				end;
		
		end;
	
	end;
	 //desconta as conexoes repetidas
	writeln('O diametro do grafo corresponde a ',diametro,' saltos.');
end;

var
	mat: matriz; 
	rot: vetor;
    op,ord,existeGrafo: integer;

begin

    existeGrafo := 0;

    menu;
	
	writeln('Digite uma opcao: ');
	readln(op);

	while(op <> 5)do
    begin
         case op of
		
			1: begin
                    clrscr;
                    menu;
					criaGrafo(mat,rot,ord);  //cria grafo, ou edita o já existente
					existeGrafo := 1;	
			   end;
			
			2: begin
                    clrscr;
                    menu;
					if(existeGrafo <> 0)then
                    begin
						exibeMatAdj(mat,ord,rot);   //imprime a matriz de adjacências na tela
					end
					else
					begin
						writeln('Essa opcao nao pode ser utilizada, pois nao existe grafo!');
					end;
			   end;
			
			3: begin
                    clrscr;
                    menu;
					if(existeGrafo <> 0)then
                    begin
						calculaDistMin(mat,rot,ord); //calcula a menor distancia entre um par de vértices
					end
					else
					begin
						writeln('Essa opcao nao pode ser utilizada, pois nao existe grafo!');
					end;
			   end;
			
			4: begin
                    clrscr;
                    menu;
					if(existeGrafo <> 0)then
                    begin
						calculaDmtGrafo(mat,ord); //calcula o diâmetro do grafo
					end
					else
					begin
						writeln('Essa opcao nao pode ser utilizada, pois nao existe grafo!');
					end;
			   end
			
			else
			begin
				if(op <> 5)then
				begin
                    clrscr;
                    menu;
					writeln('Essa opcao não existe!');
				end;
			end;
			
		end;
		writeln('Digite uma opcao: ');
		readln(op);
	end;
    clrscr;
	writeln('Obrigado por utilizar o programa! Pressione a tecla ENTER para sair.');
    readln;
end.
