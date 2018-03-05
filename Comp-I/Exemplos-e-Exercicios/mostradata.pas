program MOSTRADATA;

uses DOS;

var
	dia,mes,ano,diaSemana: word;
    res: word;
	
begin
	GetDate(ano,mes,dia,diaSemana);
	writeln(res);
    readln;
end.
