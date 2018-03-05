program PARTEAGENDA;

uses
	crt;

const
	MAX = 5;

var
	{ Variáveis Globais -- Deve-se sempre evitar...}
	nomes: array [1..MAX] of string;
	numeroNomes: integer;

{ Procedimento para inclusão odenada.
  A lógica é colocar o nome no final do
  array e depois ir deslocando o nome para
  frente até ele encontrar a posição correta. }
procedure incluiOrdenado (nomeNovo: string);
var
	nomeAux: string;
	antes, depois: integer;
begin
	{ Primeiro teste. Se não tem nenhum nome no array,
	  faço uma inserção direta. }
	if (numeroNomes = 0) then
		begin
		nomes [numeroNomes + 1] := nomeNovo;
		end

	else if (numeroNomes >= 1) then
		begin
		nomes [numeroNomes + 1] := nomeNovo;
		depois := numeroNomes + 1;
		antes := numeroNomes;

		while (nomes [antes] > nomes [depois]) and (antes > 0) do
			begin
			nomeAux := nomes [depois];
			nomes [depois] := nomes [antes];
			nomes [antes] := nomeAux;
			antes := antes - 1;
			depois := depois - 1;
			end;
		end;
end;

var
	nome: string;
	conta: integer;
begin
	numeroNomes := 0;
	while (numeroNomes < MAX) do
		begin
		writeln ('Digite um novo nome');
		readln (nome);
		incluiOrdenado (nome);
		numeroNomes := numeroNomes + 1;
		end;

	clrscr;
	writeln ('Array lotado!');
	writeln;
	writeln ('Nomes ordenados:');
	writeln;

	for conta := 1 to MAX do
		writeln ('Nome ', conta, ' ', nomes [conta]);

	writeln;
	writeln ('Espero que ajude!');
end.