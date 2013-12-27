program GameOfLife;

uses
  Vcl.Forms,
  Main in 'Main.pas' {FormMain},
  Game in 'Game.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
