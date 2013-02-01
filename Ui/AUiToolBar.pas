{**
@Abstract AUi ToolBar
@Author Prof1983 <prof1983@ya.ru>
@Created 25.08.2011
@LastMod 29.01.2013
}
unit AUiToolBar;

{define AStdCall}

interface

uses
  Classes,
  ComCtrls,
  Controls,
  ABase,
  AStringMain,
  AUiBase,
  AUiButtons,
  AUiControls,
  AUiData;

// --- AUiToolBar ---

function AUiToolBar_AddButton(ToolBar: AControl; const Name, Text, Hint: AString_Type;
    OnClick: ACallbackProc; ImageId, Weight: AInteger): AButton; {$ifdef AStdCall}stdcall;{$endif}

function AUiToolBar_AddButtonP(ToolBar: AControl; const Name, Text, Hint: APascalString;
    OnClick: ACallbackProc; ImageId, Weight: AInteger): AButton;

function AUiToolBar_AddButton1(ToolBar: AControl; const Name, Text, Hint: AString_Type;
    ImageId, Weight: AInteger): AButton; {$ifdef AStdCall}stdcall;{$endif}

function AUiToolBar_AddButton1P(ToolBar: AControl; const Name, Text, Hint: APascalString;
    ImageId, Weight: AInteger): AButton;

function AUiToolBar_AddButton2P(ToolBar: AControl; const Name, Text, Hint: APascalString;
    ButtonType, ImageId, Weight: AInt): AButton;

function AUiToolBar_New(Parent: AControl): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiToolBar_Register(ToolBar: TToolBar): AControl;

implementation

{ Private }

type
  TAUiToolBarButton = record
    Button: AButton;
    Weight: Integer;
  end;
  TAUiToolBar = record
    ToolBar: AControl;
    Buttons: array of TAUiToolBarButton;
  end;

var
  FToolBar: array of TAUiToolBar;

// --- Private ---

function _Find(ToolBar: AControl): AInt;
var
  I: AInt;
begin
  for I := 0 to High(FToolBar) do
  begin
    if (FToolBar[I].ToolBar = ToolBar) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

function _GetButtonIndexByWeight(ToolBarIndex, Weight: AInt): AInt;
var
  I: Integer;
  Min: Integer;
  MinIndex: Integer;
  W: Integer;
begin
  Min := Low(Integer);
  MinIndex := -1;
  for I := 0 to High(FToolBar[ToolBarIndex].Buttons) do
  begin
    W := FToolBar[ToolBarIndex].Buttons[I].Weight;
    if (W > Min) and (W < Weight) then
    begin
      Min := W;
      MinIndex := I;
    end;
  end;
  Result := MinIndex;
end;

// --- AUiToolBar ---

function AUiToolBar_AddButton(ToolBar: AControl; const Name, Text, Hint: AString_Type;
    OnClick: ACallbackProc; ImageId, Weight: AInteger): AButton;
begin
  Result := AUiToolBar_AddButtonP(
      ToolBar,
      AString_ToPascalString(Name),
      AString_ToPascalString(Text),
      AString_ToPascalString(Hint),
      OnClick,
      ImageId,
      Weight);
end;

function AUiToolBar_AddButtonP(ToolBar: AControl; const Name, Text, Hint: APascalString;
    OnClick: ACallbackProc; ImageId, Weight: AInteger): AButton;
var
  Button: AButton;
begin
  Button := AUiToolBar_AddButton1P(ToolBar, Name, Text, Hint, ImageID, Weight);
  AUiControl_SetOnClick(Button, OnClick);
  Result := Button;
end;

function AUiToolBar_AddButton1(ToolBar: AControl; const Name, Text, Hint: AString_Type;
    ImageId, Weight: AInteger): AButton;
begin
  Result := AUiToolBar_AddButton1P(
      ToolBar,
      AString_ToPascalString(Name),
      AString_ToPascalString(Text),
      AString_ToPascalString(Hint),
      ImageId,
      Weight);
end;

function AUiToolBar_AddButton1P(ToolBar: AControl; const Name, Text, Hint: APascalString;
    ImageId, Weight: AInteger): AButton;
begin
  Result := AUiToolBar_AddButton2P(ToolBar, Name, Text, Hint, 0, ImageId, Weight);
end;

function AUiToolBar_AddButton2P(ToolBar: AControl; const Name, Text, Hint: APascalString;
    ButtonType, ImageId, Weight: AInt): AButton;
var
  Button: AButton;
  I: Integer;
  Left: Integer;
  Top: Integer;
  ToolBarIndex: AInt;
  B: TToolButton;
begin
  try
    ToolBarIndex := _Find(ToolBar);
    if (ToolBarIndex < 0) then
    begin
      Result := 0;
      Exit;
    end;

    if (ButtonType = 1) then
    begin
      B := TToolButton.Create(TComponent(ToolBar));
      B.Parent := TWinControl(ToolBar);
      B.ImageIndex := ImageId;
      B.Name := Name;
      B.Height := 38;
      B.Width := 23;
      B.Hint := Hint;
      B.ShowHint := (Hint <> '');
      Button := AButton(B);
    end
    else
    begin
      Button := AUiButton_New(ToolBar);
      AUiControl_SetNameP(Button, Name);
      AUiControl_SetSize(Button, 24, 24);
      AUiControl_SetTextP(Button, Text);
      AUiControl_SetHintP(Button, Hint);
    end;

    // –асполагаем в нужном месте в зависимости от веса
    I := _GetButtonIndexByWeight(ToolBarIndex, Weight);
    if (I >= 0) then
    begin
      AUiControl_GetPosition(FToolBar[ToolBarIndex].Buttons[I].Button, Left, Top);
      AUiControl_SetPosition(Button, Left + 10, Top);
    end
    else
      AUiControl_SetPosition(Button, 0, 0);

    I := Length(FToolBar[ToolBarIndex].Buttons);
    SetLength(FToolBar[ToolBarIndex].Buttons, I + 1);
    FToolBar[ToolBarIndex].Buttons[I].Button := Button;
    FToolBar[ToolBarIndex].Buttons[I].Weight := Weight;

    Result := Button;
  except
    Result := 0;
  end;
end;

function AUiToolBar_New(Parent: AControl): AControl;
var
  ToolBar: TToolBar;
begin
  try
    ToolBar := TToolBar.Create(TWinControl(Parent));
    ToolBar.Parent := TWinControl(Parent);
    ToolBar.Align := alTop;
    Result := AUiToolBar_Register(ToolBar);
  except
    Result := 0;
  end;
end;

function AUiToolBar_Register(ToolBar: TToolBar): AControl;
var
  I: AInt;
begin
  try
    I := Length(FToolBar);
    SetLength(FToolBar, I + 1);
    FToolBar[I].ToolBar := AddObject(ToolBar);
    Result := FToolBar[I].ToolBar;
  except
    Result := 0;
  end;
end;

end.
 