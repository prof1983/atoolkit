{**
@Abstract User Interface box functions
@Author Prof1983 <prof1983@ya.ru>
@Created 11.08.2011
@LastMod 12.11.2012
}
unit AUiBox;

interface

uses
  Controls, ExtCtrls,
  ABase, AUiBase, AUiData;

{** Creates a new panel
    @param BoxType: 0 - Simple; 1 - HBox; 2 - VBox }
function AUiBox_New(Parent: AControl; BoxType: AInteger): AControl; stdcall;

implementation

function AUiBox_New(Parent: AControl; BoxType: AInt): AControl;
var
  Panel: TPanel;
begin
  try
    Panel := TPanel.Create(TWinControl(Parent));
    Panel.Parent := TWinControl(Parent);
    AddObject(Panel);
    Result := AControl(Panel);
  except
    Result := 0;
  end;
end;

end.
 