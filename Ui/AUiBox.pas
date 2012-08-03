{**
@Abstract User Interface box functions
@Author Prof1983 <prof1983@ya.ru>
@Created 11.08.2011
@LastMod 26.07.2012
}
unit AUiBox;

interface

uses
  Controls, ExtCtrls,
  ABase, AUiBase, AUiData;

{** Creates a new panel
    @param BoxType: 0 - Simple; 1 - HBox; 2 - VBox }
function UI_Box_New(Parent: AControl; BoxType: AInteger): AControl;

implementation

function UI_Box_New(Parent: AControl; BoxType: AInteger): AControl;
var
  Panel: TPanel;
begin
  Panel := TPanel.Create(TWinControl(Parent));
  Panel.Parent := TWinControl(Parent);
  AddObject(Panel);
  Result := AControl(Panel);
end;

end.
 