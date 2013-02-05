{**
@Author Prof1983 <prof1983@ya.ru>
@Created 25.01.2007
@LastMod 17.12.2012
}
unit AHelpControl;

interface

uses
  Classes, Controls, StdCtrls,
  ABase,
  AControlImpl, ATypes;

type
  THelpControl = class(TAControl)
  private
    FmemMain: TMemo;
  public
    property memMain: TMemo read FmemMain;
  public
    function Initialize(): AError; override;
  end;

implementation

{ THelpControl }

function THelpControl.Initialize(): AError;
begin
  FmemMain := TMemo.Create(FControl);
  FmemMain.Parent := FControl;
  FmemMain.Align := alClient;
  FmemMain.ScrollBars := ssBoth;

  Result := 0;
end;

end.
