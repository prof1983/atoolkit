{**
@Author Prof1983 <prof1983@ya.ru>
@Created 19.04.2013
@LastMod 19.04.2013
}
unit AUiTabControls;

{$I Defines.inc}

interface

uses
  ComCtrls,
  Controls,
  ABase,
  AUiBase,
  AUiData;

// --- Types ---

type
  AUiTabStyle = type AInt;
const
  AUiTabStyle_Tabs = 0;
  AUiTabStyle_Buttons = 1;
  AUiTabStyle_FlatButtons = 2;

// --- AUiTabControl ---

function AUiTabControl_AddTabP(TabControl: AControl; const Text: APascalString): AError;

function AUiTabControl_New(Parent: AControl): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiTabControl_SetStyle(TabControl: AControl; Style: AUiTabStyle): AError; {$ifdef AStdCall}stdcall;{$endif}

implementation

// --- AUiTabControl ---

function AUiTabControl_AddTabP(TabControl: AControl; const Text: APascalString): AError;
begin
  if (TabControl = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    TTabControl(TabControl).Tabs.Add(Text);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiTabControl_New(Parent: AControl): AControl;
var
  ParentObj: TObject;
  TabControl: TTabControl;
begin
  if (Parent = 0) then
  begin
    Result := 0;
    Exit;
  end;
  try
    ParentObj := AUiData.GetObject(Parent);
    if not(Assigned(ParentObj)) then
    begin
      Result := 0;
      Exit;
    end;
    if not(ParentObj is TWinControl) then
    begin
      Result := 0;
      Exit;
    end;

    TabControl := TTabControl.Create(TWinControl(Parent));
    TabControl.Parent := TWinControl(Parent);
    Result := AUiData.AddObject(TabControl);
  except
    Result := 0;
  end;
end;

function AUiTabControl_SetStyle(TabControl: AControl; Style: AUiTabStyle): AError;
var
  Control: TObject;
begin
  if (TabControl = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    Control := AUiData.GetObject(TabControl);
    if not(Assigned(Control)) then
    begin
      Result := -3;
      Exit;
    end;
    if not(Control is TTabControl) then
    begin
      Result := -4;
      Exit;
    end;
    TTabControl(Control).Style := TTabStyle(Style);
    Result := 0;
  except
    Result := -1;
  end;
end;

end.
