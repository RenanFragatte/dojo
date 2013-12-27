unit Game;

interface

const
  TamanhoGrid = 5;
  
type
  TGrid = array[0..TamanhoGrid] of array[0..TamanhoGrid] of Boolean;

  TGame = class
  private
    FGridOriginal: TGrid;
    function ObterQuantidadeDeVizinhos(Linha, Coluna: Integer): Integer;
  public
    Grid: TGrid;
    procedure Avancar; overload;
    procedure Avancar(Linha, Coluna: Integer); overload;
    procedure DefinirLinha(Linha: Integer; Valores: string);
    function ObterGrid: string;
    procedure RandomizarGrid;
  end;

implementation

uses
  System.StrUtils;

procedure TGame.Avancar;
var
  I: Integer;
  J: Integer;
begin
  FGridOriginal := Grid;

  for I := 0 to TamanhoGrid do
    for J := 0 to TamanhoGrid do
      Avancar(I, J);
end;

procedure TGame.Avancar(Linha, Coluna: Integer);
var
  QuantidadeVizinhos: Integer;
begin
  QuantidadeVizinhos := ObterQuantidadeDeVizinhos(Linha, Coluna);

  if Grid[Linha][Coluna] then
    Grid[Linha][Coluna] := QuantidadeVizinhos in [2,3]
  else
    Grid[Linha][Coluna] := QuantidadeVizinhos = 3;
end;

procedure TGame.DefinirLinha(Linha: Integer; Valores: string);
var
  I: Integer;
begin
  for I := 1 to Length(Valores) do
    Grid[Linha][I - 1] := Valores[I] = '1';
end;

function TGame.ObterGrid: string;
var
  I: Integer;
  J: Integer;
begin
  Result := '';
  for I := 0 to TamanhoGrid -1 do
  begin
    for J := 0 to TamanhoGrid -1 do
      Result := Result + IfThen(Grid[I][J], '*', ' ');
    Result := Result + sLineBreak;
  end;
end;

function TGame.ObterQuantidadeDeVizinhos(Linha, Coluna: Integer): Integer;
var
  EleMesmo: Boolean;
  LinhaAtual: Integer;
  ColunaAtual: Integer;
begin
  Result := 0;
  for LinhaAtual := Linha - 1 to Linha + 1 do
  begin
    if LinhaAtual < 0 then
      Continue;

    for ColunaAtual := Coluna - 1 to Coluna + 1 do
    begin
      if ColunaAtual < 0 then
        Continue;

      EleMesmo := (LinhaAtual = Linha) and (ColunaAtual = Coluna);
      if EleMesmo then
        Continue;

      if FGridOriginal[LinhaAtual, ColunaAtual] then
        Inc(Result);
    end;
  end;
end;

procedure TGame.RandomizarGrid;
var
  I: Integer;
  J: Integer;
begin
  for I := 0 to TamanhoGrid do
    for J := 0 to TamanhoGrid do
      Grid[I][J] := Random(2) = 1;
end;

end.
