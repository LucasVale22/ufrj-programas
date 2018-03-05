program EXEMPLOARQUIVO;

type
	registro = record
				nome: string;
				idade: integer;
			end;
			
			
procedure ler;

var
	arquivo_proc: file of registro;
	reg: registro;

begin

	assign(arquivo_proc,'registros.dat');
	reset(arquivo_proc);
	
	while not eof(arquivo_proc)do
	begin
		read(arquivo_proc,reg);
		writeln(reg.nome,'',reg.idade);
		
	end;

	close(arquivo_proc);
	
end;

var
	arquivo: file of registro;
	reg: registro;
	continua: char;
	
begin

	assign(arquivo,'registro.dat');
	{$I-}
	reset(arquivo);
	{$I+}
	if(IORESULT = 2)then
	begin
		rewrite(arquivo);
		write(arquivo,reg);
		seek(arquivo,filepos(arquivo));
	end
	
	else
		seek(arquivo,filesize(arquivo));
	
	repeat
	
		writeln('Digite o nome: ');
		readln(reg.nome);
		writeln('Digite a idade: ');
		readln(reg.idade);
		
		write(arquivo,reg);
		
		writeln('Deseja continuar? (s/n)');
        readln(continua);
	
	until((continua = 'N') or (continua = 'n'));
		
	close(arquivo);

	ler;


		

end.
