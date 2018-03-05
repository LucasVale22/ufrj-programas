//Units
unit matematica;

interface
  
  procedure soma(var r: integer; a,b: integer);

implementation

  procedure soma(var r: integer; a,b: integer);
  begin

    r := verifica(a) + verifica(b);

  end;

  function verifica(n: integer):integer;
  begin

    if(n < 0)then verifica := 0;
    else verifica := n;

  end;

end.

program USAUNIT;

uses matematica;

var 
  a,b: integer;
  resultado: integer;

begin

  resultado := 0;
  writeln('Entre com a e b: ');
  readln(a,b);
  writeln('Resultado: ',resultado);

end.

end.
