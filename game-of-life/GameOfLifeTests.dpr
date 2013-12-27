program GameOfLifeTests;

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  DUnitTestRunner,
  Game in 'Game.pas',
  GameTests in 'GameTests.pas';

{$R *.RES}

begin
  DUnitTestRunner.RunRegisteredTests;
end.

