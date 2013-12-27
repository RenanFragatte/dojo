unit GameTests;

interface

uses
  TestFramework,
  Game;

type
  TGameTests = class(TTestCase)
  strict private
    FSUT: TGame;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure NovaInstancia_GridCriado_GridMultiDimensional;
    procedure Avancar_CelulasMenosDeDoisVizinhoVivos_Morrer;
    procedure Avancar_MaisDe3VizinhosVivos_Morrer;
    procedure Avancar_MaisDe3CentroDoGrid_Morrer;
    procedure DefinirLinha_Linha0TerceiraPosicao1_00100;
    procedure DefinirLinha_Linha0TodosFalse_00000;
    procedure DefinirLinha_Linha3_Colunas135True_10101;
    procedure Avancar_2VizinhosVivos_Viver;
    procedure Avancar_CelulaMortaCom3VizinhosVivos_Viver;
    procedure Avancar_CelulaMortaCom2VizinhosVivos_ContinuarMorta;
    procedure ObterGrid_CelulaMortasEVivas_RetornarStringCorreta;
  end;

implementation

procedure TGameTests.Avancar_2VizinhosVivos_Viver;
begin
  FSUT.DefinirLinha(0, '01000');
  FSUT.DefinirLinha(1, '11000');

  FSUT.Avancar;

  CheckTrue(FSUT.Grid[1][1]);
end;

procedure TGameTests.Avancar_CelulaMortaCom2VizinhosVivos_ContinuarMorta;
begin
  FSUT.DefinirLinha(0, '01000');
  FSUT.DefinirLinha(1, '01000');

  FSUT.Avancar;

  CheckFalse(FSUT.Grid[0][0]);
end;

procedure TGameTests.Avancar_CelulaMortaCom3VizinhosVivos_Viver;
begin
  FSUT.DefinirLinha(0, '01000');
  FSUT.DefinirLinha(1, '11000');

  FSUT.Avancar;

  CheckTrue(FSUT.Grid[0][0]);
end;

procedure TGameTests.Avancar_CelulasMenosDeDoisVizinhoVivos_Morrer;
begin
  FSUT.Grid[0][0] := True;

  FSUT.Avancar;

  CheckFalse(FSUT.Grid[0][0]);
end;

procedure TGameTests.Avancar_MaisDe3CentroDoGrid_Morrer;
begin
  FSUT.DefinirLinha(0, '00010');
  FSUT.DefinirLinha(1, '00111');
  FSUT.DefinirLinha(2, '00010');
  FSUT.DefinirLinha(3, '00000');

  FSUT.Avancar;

  CheckFalse(FSUT.Grid[1][3]);
end;

procedure TGameTests.Avancar_MaisDe3VizinhosVivos_Morrer;
begin
  FSUT.DefinirLinha(0, '11000');
  FSUT.DefinirLinha(1, '11000');
  FSUT.DefinirLinha(2, '10000');

  FSUT.Avancar;

  CheckFalse(FSUT.Grid[1][1]);
end;

procedure TGameTests.DefinirLinha_Linha0TerceiraPosicao1_00100;
begin
  FSUT.DefinirLinha(0, '00100');

  CheckFalse(FSUT.Grid[0][0]);
  CheckFalse(FSUT.Grid[0][1]);
  CheckTrue(FSUT.Grid[0][2]);
  CheckFalse(FSUT.Grid[0][3]);
  CheckFalse(FSUT.Grid[0][4]);
end;

procedure TGameTests.DefinirLinha_Linha0TodosFalse_00000;
begin
  FSUT.DefinirLinha(0, '00000');

  CheckFalse(FSUT.Grid[0][0]);
  CheckFalse(FSUT.Grid[0][1]);
  CheckFalse(FSUT.Grid[0][2]);
  CheckFalse(FSUT.Grid[0][3]);
  CheckFalse(FSUT.Grid[0][4]);
end;


procedure TGameTests.DefinirLinha_Linha3_Colunas135True_10101;
begin
  FSUT.DefinirLinha(3, '10101');

  CheckTrue(FSUT.Grid[3][0]);
  CheckFalse(FSUT.Grid[3][1]);
  CheckTrue(FSUT.Grid[3][2]);
  CheckFalse(FSUT.Grid[3][3]);
  CheckTrue(FSUT.Grid[3][4]);
end;

procedure TGameTests.NovaInstancia_GridCriado_GridMultiDimensional;
var
  i: Integer;
  i2: Integer;
begin
  for i := 0 to Length(FSUT.Grid) - 1 do
    for i2 := 0 to Length(FSUT.Grid[i]) - 1 do
      CheckFalse(FSUT.Grid[i][i2]);
end;

procedure TGameTests.ObterGrid_CelulaMortasEVivas_RetornarStringCorreta;
begin
  FSUT.DefinirLinha(0, '11000');
  FSUT.DefinirLinha(1, '11000');
  FSUT.DefinirLinha(2, '10000');

  CheckEquals('**   ' + sLineBreak +
              '**   ' + sLineBreak +
              '*    ' + sLineBreak +
              '     ' + sLineBreak +
              '     ' + sLineBreak, FSUT.ObterGrid);
end;

procedure TGameTests.SetUp;
begin
  FSUT := TGame.Create;
end;

procedure TGameTests.TearDown;
begin
  FSUT.Free;
  FSUT := nil;
end;

initialization

// Register any test cases with the test runner
RegisterTest(TGameTests.Suite);

end.
