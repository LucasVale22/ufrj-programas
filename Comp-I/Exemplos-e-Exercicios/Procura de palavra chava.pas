program PROCURANOARQUIVO;

var
	arq: text;
	resp,i,j,k,resultado,ocorrs: integer;
	linha,palavra,nome: string;
begin
    resp := 1;
    while(resp = 1)do
	begin
		writeln('Entre com o nome do arquivo que deseja abrir: ');
		readln(nome);
		assign(arq,nome);
		{$i-}  // para inibir rotina de tratamento de erro
		reset(arq);  // tenta abrir para verificar se já existe
		{$I+}
		resultado := ioresult;
		if(resultado <> 0)then
		begin
			writeln('Este arquivo nao existe!');
		end
		else
		begin
			writeln('Que palavra deseja buscar?');
			readln(palavra);
			while not eof(arq)do
			begin
				readln(arq,linha);
			
				i := 0;
				j := 0;
				k := 0;
				ocorrs := 0;
				
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
							writeln(linha);
							seek(arq,filepos(arq));
							readln(arq,linha);
							writeln(linha);
							seek(arq,filepos(arq)-1);
							
						end;
					end;
				end;
				
			end;
		end;
		writeln;
		writeln('Deseja buscar outro arquivo?');
		writeln('Digite 1 para sim ou digite 0 para nao: ');
		readln(resp);
	end;
	writeln('Fim! Pressione ENTER para sair....');
	readln;
	
end.
