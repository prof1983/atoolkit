{**
@Abstract AUi ToolBar
@Author Prof1983 <prof1983@ya.ru>
@Created 25.08.2011
@LastMod 27.08.2012
}
unit AUiToolBar;

interface

uses
  ComCtrls, Controls,
  ABase, AUiBase, AUiButtons, AUiControls, AUiData;

function UI_ToolBar_AddButton(ToolBar: AControl; const Name, Text, Hint: APascalString;
    OnClick: ACallbackProc; ImageID, Weight: AInteger): AButton;

function UI_ToolBar_AddButton02(ToolBar: AControl; const Name, Text, Hint: APascalString;
    OnClick: ACallbackProc02; ImageID, Weight: AInteger): AButton;

function UI_ToolBar_AddButton03(ToolBar: AControl; const Name, Text, Hint: APascalString;
    OnClick: ACallbackProc03; ImageID, Weight: AInteger): AButton;

function UI_ToolBar_AddButton1(ToolBar: AControl; const Name, Text, Hint: APascalString;
    ImageID, Weight: AInteger): AButton;

function UI_ToolBar_New(Parent: AControl): AControl;

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

{ ToolBar }

function UI_ToolBar_AddButton(ToolBar: AControl; const Name, Text, Hint: APascalString;
    OnClick: ACallbackProc; ImageID, Weight: AInteger): AButton;
var
  Button: AButton;
begin
  Button := UI_ToolBar_AddButton1(ToolBar, Name, Text, Hint, ImageID, Weight);
  AUIControls.UI_Control_SetOnClick(Button, OnClick);
  Result := Button;
end;

function UI_ToolBar_AddButton02(ToolBar: AControl; const Name, Text, Hint: APascalString;
    OnClick: ACallbackProc02; ImageID, Weight: AInteger): AButton;
var
  Button: AButton;
begin
  Button := UI_ToolBar_AddButton1(ToolBar, Name, Text, Hint, ImageID, Weight);
  AUIControls.UI_Control_SetOnClick02(Button, OnClick);
  Result := Button;
end;

function UI_ToolBar_AddButton03(ToolBar: AControl; const Name, Text, Hint: APascalString;
    OnClick: ACallbackProc03; ImageID, Weight: AInteger): AButton;
var
  Button: AButton;
begin
  Button := UI_ToolBar_AddButton1(ToolBar, Name, Text, Hint, ImageID, Weight);
  AUIControls.UI_Control_SetOnClick03(Button, OnClick);
  Result := Button;
end;

function UI_ToolBar_AddButton1(ToolBar: AControl; const Name, Text, Hint: APascalString;
    ImageID, Weight: AInteger): AButton;
var
  Button: AButton;
  I: Integer;
  Left: Integer;
  Top: Integer;
begin
  Button := AUiButton_New(ToolBar);
  AUIControls.UI_Control_SetName(Button, Name);
  AUIControls.UI_Control_SetSize(Button, 24, 24);
  AUIControls.UI_Control_SetTextP(Button, Text);
  AUIControls.UI_Control_SetHint(Button, Hint);
  {if Assigned(Image) then
    IAUIclImage(Image).GetBitmap(Button.Glyph);}

  // –асполагаем в нужном месте в зависимости от веса
  I := ToolBar_GetButtonIndexByWeight(ToolBar, Weight);
  if (I >= 0) then
  begin
    AUIControls.UI_Control_GetPosition(FToolBarButtons[I].Button, Left, Top);
    AUIControls.UI_Control_SetPosition(Button, Left + 10, Top);
  end;

  Result := Button;
end;

function UI_ToolBar_New(Parent: AControl): AControl;
var
  ToolBar: TToolBar;
begin
  ToolBar := TToolBar.Create(TWinControl(Parent));
  ToolBar.Parent := TWinControl(Parent);
  ToolBar.Align := alTop;
  Result := AddObject(ToolBar);
end;

end.
 