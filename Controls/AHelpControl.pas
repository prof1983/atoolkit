{**
@Abstract(Контрол сообщений с выводом в Memo)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.01.2007)
@LastMod(02.05.2012)
@Version(0.5)
}
unit AHelpControl;

interface

uses
  Classes, Controls, StdCtrls,
  AControlImpl, ATypes;

type
  THelpControl = class(TProfControl)
  private
    FmemMain: TMemo;
  public
    property memMain: TMemo read FmemMain;
  public
    function Initialize(): TProfError; override;
  end;

implementation

{ THelpControl }

function THelpControl.Initialize(): TProfError;
begin
  FmemMain := TMemo.Create(FControl);
  FmemMain.Parent := FControl;
  //FmemMain.Height := 20;
  FmemMain.Align := alClient;
  FmemMain.ScrollBars := ssBoth;
  //FmemMain.OnKeyDown := memInputKeyDown;
  //FmemMain.OnKeyUp := memInputKeyUp;

  Result := 0;
end;

end.
