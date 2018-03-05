unit manipulaArq;

interface
	procedure abrirArqBin(operac: char; arq: file; var nomeExt: string);
	procedure abrirArqText(operac: char; arq: text; var nomeExt: string);


implementation

procedure abrirArqBin(operac: char; arq: file; var nomeExt: string);
var
	
	correto: boolean;
	reasultado: integer;
	confirma: char;

begin
	
	repeat
	
		correto := true; // inicia sem erro
		writeln('Informar o nome completo do arquivo: ');
		readln(nomeExt);
		assign(arq, nomeExt);
		{$i-}  // para inibir rotina de tratamento de erro
		reset(arq);  // tenta abrir para verificar se já existe
		{$I+}
		resultado := ioresult;
		if (operac = ‘A’) and (resultado <> 0) then
		begin
			writeln(‘Erro: o arquivo não existe. Escolha outro nome’);
			Correto := false;
		end;
		if (operac = ‘C’) and (resultado = 0) then
		begin
				writeln('O arquivo já existe! Deseja destrui-lo e criar um novo? (S - sim / N - nao)');
				readln(confirma);
				if(confirma = 'N')
				begin
					correto := false;
				end;
		end;		
	until correto;
	if operac = ‘C’ then rewrite(arq);

end;

procedure abrirArqText(operac: char; arq: text; var nomeExt: string);
var
	
	correto: boolean;
	reasultado: integer;
	confirma: char;

begin
	
	repeat
	
		correto := true; // inicia sem erro
		writeln('Informar o nome completo do arquivo: ');
		readln(nomeExt);
		assign(arq, nomeExt);
		{$i-}  // para inibir rotina de tratamento de erro
		reset(arq);  // tenta abrir para verificar se já existe
		{$I+}
		resultado := ioresult;
		if (operac = ‘A’) and (resultado <> 0) then
		begin
			writeln(‘Erro: o arquivo não existe. Escolha outro nome’);
			Correto := false;
		end;
		if (operac = ‘C’) and (resultado = 0) then
		begin
				writeln('O arquivo já existe! Deseja destrui-lo e criar um novo? (S - sim / N - nao)');
				readln(confirma);
				if(confirma = 'N')
				begin
					correto := false;
				end;
		end;		
	until correto;
	if operac = ‘C’ then rewrite(arq);

end;

end.