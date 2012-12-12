{**
@Abstract AUi ToolBar
@Author Prof1983 <prof1983@ya.ru>
@Created 25.08.2011
@LastMod 12.12.2012
}
unit AUiToolBar;

{$define AStdCall}

interface

uses
  ComCtrls, Controls,
  ABase, AStrings, AUiBase, AUiButtons, AUiControls, AUiData;

// --- AUiToolBar ---

function AUiToolBar_AddButton(ToolBar: AControl; const Name, Text, Hint: AString_Type;
    OnClick: ACallbackProc; ImageId, Weight: AInteger): AButton; {$ifdef AStdCall}stdcall;{$endif}

function AUiToolBar_AddButtonP(ToolBar: AControl; const Name, Text, Hint: APascalString;
    OnClick: ACallbackProc; ImageId, Weight: AInteger): AButton;

function AUiToolBar_AddButton1(ToolBar: AControl; const Name, Text, Hint: AString_Type;
    ImageId, Weight: AInteger): AButton; {$ifdef AStdCall}stdcall;{$endif}

function AUiToolBar_AddButton1P(ToolBar: AControl; const Name, Text, Hint: APascalString;
    ImageId, Weight: AInteger): AButton;

function AUiToolBar_New(Parent: AControl): AControl; {$ifdef AStdCall}stdcall;{$endif}

// --- UI_ToolBar ---

function UI_ToolBar_AddButton(ToolBar: AControl; const Name, Text, Hint: APascalString;
    OnClick: ACallbackProc; ImageID, Weight: AInteger): AButton; deprecated; // Use AUiToolBar_AddButtonP()

function UI_ToolBar_AddButton02(ToolBar: AControl; const Name, Text, Hint: APascalString;
    OnClick: ACallbackProc02; ImageID, Weight: AInteger): AButton;

function UI_ToolBar_AddButton03(ToolBar: AControl; const Name, Text, Hint: APascalString;
    OnClick: ACallbackProc03; ImageID, Weight: AInteger): AButton;

function UI_ToolBar_AddButton1(ToolBar: AControl; const Name, Text, Hint: APascalString;
    ImageID, Weight: AInteger): AButton; deprecated; // Use AUiToolBar_AddButton1P()

function UI_ToolBar_New(Parent: AControl): AControl; deprecated; // Use AUiToolBar_New()

implementation

{ Private }

type
  TAUIToolBarButton = record
    ToolBar: AControl;
    Button: AButton;
    Weight: Integer;
  end;

var
  FToolBarButtons: array of TAUIToolBarButton;

function ToolBar_GetButtonIndexByWeight(ToolBar: AControl; Weight: Integer): Integer;
var
  I: Integer;
  Min: Integer;
  //Max: Integer;
  MinIndex: Integer;
  //MaxIndex: Integer;
  W: Integer;
begin
  Min := Low(Integer);
  //Max := High(Integer);
  MinIndex := -1;
  //MaxIndex := -1;
  for I := 0 to High(FToolBarButtons) do
  if (FToolBarButtons[I].ToolBar = ToolBar) then
  begin
    W := FToolBarButtons[I].Weight;
    if (W > Min) and (W < Weight) then
    begin
      Min := W;
      MinIndex := I;
    end;
    {if (W < Max) and (W > Weight) then
    begin
      Max := W;
      MaxIndex := I;
    end;}
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
var
  Button: AButton;
  I: Integer;
  Left: Integer;
  Top: Integer;
begin
  try
    Button := AUiButton_New(ToolBar);
    AUiControl_SetNameP(Button, Name);
    AUiControl_SetSize(Button, 24, 24);
    AUiControl_SetTextP(Button, Text);
    AUiControl_SetHintP(Button, Hint);

    // –асполагаем в нужном месте в зависимости от веса
    I := ToolBar_GetButtonIndexByWeight(ToolBar, Weight);
    if (I >= 0) then
    begin
      AUiControl_GetPosition(FToolBarButtons[I].Button, Left, Top);
      AUiControl_SetPosition(Button, Left + 10, Top);
    end;

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
    Result := AddObject(ToolBar);
  except
    Result := 0;
  end;
end;

// --- UI_ToolBar ---

function UI_ToolBar_AddButton(ToolBar: AControl; const Name, Text, Hint: APascalString;
    OnClick: ACallbackProc; ImageID, Weight: AInteger): AButton;
begin
  Result := AUiToolBar_AddButtonP(ToolBar, Name, Text, Hint, OnClick, ImageId, Weight);
end;

function UI_ToolBar_AddButton02(ToolBar: AControl; const Name, Text, Hint: APascalString;
    OnClick: ACallbackProc02; ImageID, Weight: AInteger): AButton;
var
  Button: AButton;
begin
  Button := AUiToolBar_AddButton1P(ToolBar, Name, Text, Hint, ImageId, Weight);
  AUiControl_SetOnClick02(Button, OnClick);
  Result := Button;
end;

function UI_ToolBar_AddButton03(ToolBar: AControl; const Name, Text, Hint: APascalString;
    OnClick: ACallbackProc03; ImageID, Weight: AInteger): AButton;
var
  Button: AButton;
begin
  Button := AUiToolBar_AddButton1P(ToolBar, Name, Text, Hint, ImageId, Weight);
  AUiControl_SetOnClick03(Button, OnClick);
  Result := Button;
end;

function UI_ToolBar_AddButton1(ToolBar: AControl; const Name, Text, Hint: APascalString;
    ImageID, Weight: AInteger): AButton;
begin
  Result := AUiToolBar_AddButton1P(ToolBar, Name, Text, Hint, ImageId, Weight);
end;

function UI_ToolBar_New(Parent: AControl): AControl;
begin
  Result := AUiToolBar_New(Parent);
end;

end.
 