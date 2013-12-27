unit Main;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Game;

type
  TFormMain = class(TForm)
    Memo1: TMemo;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private
    FGame: TGame;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

constructor TFormMain.Create(AOwner: TComponent);
begin
  inherited;
  FGame := TGame.Create;
  FGame.RandomizarGrid;
end;

destructor TFormMain.Destroy;
begin
  FGame.Free;
  inherited;
end;

procedure TFormMain.Timer1Timer(Sender: TObject);
begin
  FGame.Avancar;
  Memo1.Lines.Text := FGame.ObterGrid;
end;

end.
