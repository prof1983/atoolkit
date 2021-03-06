{**
@Abstract User Interface box functions
@Author Prof1983 <prof1983@ya.ru>
@Created 11.08.2011
@LastMod 19.04.2013
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
  AUiDragMode = type AInt;
const
  AUiDragMode_Manual = 0;
  AUiDragMode_Automatic = 1;

// --- AUiBox ---

function AUiBox_GetBoxType(Box: AControl): AUiBoxType; {$ifdef AStdCall}stdcall;{$endif}

{** Creates a new panel
    @param BoxType: 0 - Simple; 1 - HBox; 2 - VBox; 3 - GroupBox }
function AUiBox_New(Parent: AControl; BoxType: AUiBoxType): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiBox_SetDockSite(Box: AControl; Value: ABool): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiBox_SetDragMode(Box: AControl; Value: AUiDragMode): AError; {$ifdef AStdCall}stdcall;{$endif}

implementation

// --- AUiBox ---

function AUiBox_GetBoxType(Box: AControl): AUiBoxType;
var
  Obj: TObject;
begin
  Obj := AUiData.GetObject(Box);
  if (Obj is TGroupBox) then
    Result := AUiBoxType_GroupBox
  else if (Obj is TPanel) then
    Result := AUiBoxType_Simple
  else
    Result := -1;
end;

function AUiBox_New(Parent: AControl; BoxType: AUiBoxType): AControl;
var
  GroupBox: TGroupBox;
  Panel: TPanel;
begin
  try
    if (BoxType = AUiBoxType_GroupBox) then
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

function AUiBox_SetDockSite(Box: AControl; Value: ABool): AError;
begin
  try
    TPanel(Box).DockSite := Value;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiBox_SetDragMode(Box: AControl; Value: AUiDragMode): AError;
begin
  try
    TPanel(Box).DragMode := TDragMode(Value);
    Result := 0;
  except
    Result := -1;
  end;
end;

end.
 