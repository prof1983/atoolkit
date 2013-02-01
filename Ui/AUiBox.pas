{**
@Abstract User Interface box functions
@Author Prof1983 <prof1983@ya.ru>
@Created 11.08.2011
@LastMod 28.01.2013
}
unit AUiBox;

{define AStdCall}

interface

uses
  Controls,
  ExtCtrls,
  StdCtrls,
  ABase, AUiBase, AUiData;

type
  ABoxType = AInt;
const
  ABoxType_Simple = 0;
  ABoxType_HBox = 1;
  ABoxType_VBox = 2;
  ABoxType_GroupBox = 3;

{** Creates a new panel
    @param BoxType: 0 - Simple; 1 - HBox; 2 - VBox; 3 - GroupBox }
function AUiBox_New(Parent: AControl; BoxType: ABoxType): AControl; {$ifdef AStdCall}stdcall;{$endif}

implementation

function AUiBox_New(Parent: AControl; BoxType: ABoxType): AControl;
var
  GroupBox: TGroupBox;
  Panel: TPanel;
begin
  try
    if (BoxType = ABoxType_GroupBox) then
    begin
      GroupBox := TGroupBox.Create(TWinControl(Parent));
      GroupBox.Parent := TWinControl(Parent);
      Result := AddObject(GroupBox);
      Exit;
    end;

    Panel := TPanel.Create(TWinControl(Parent));
    Panel.Parent := TWinControl(Parent);
    Result := AddObject(Panel);
  except
    Result := 0;
  end;
end;

end.
 