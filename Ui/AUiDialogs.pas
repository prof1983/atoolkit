{**
@Abstract AUiDialogs
@Author Prof1983 <prof1983@ya.ru>
@Created 16.02.2009
@LastMod 20.02.2013
}
unit AUiDialogs;

{define AStdCall}

interface

uses
  Controls,
  Forms,
  Graphics,
  ABase,
  ABaseTypes,
  AStringMain,
  AUiAboutDialog,
  AUiBase,
  AUiBox,
  AUiButtons,
  AUiConsts,
  AUiControls,
  AUiTextView,
  AUiWindows;

// --- AUi ---

function AUi_ExecuteMessageDialog1(const Text, Caption: AString_Type;
    Flags: AMessageBoxFlags): ADialogBoxCommands; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteMessageDialog1A(Text, Caption: AStr;
    Flags: AMessageBoxFlags): ADialogBoxCommands; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteMessageDialog1P(const Text, Caption: APascalString;
    Flags: AMessageBoxFlags): ADialogBoxCommands;

// --- AUiDialog ---

function AUiDialog_AddButton1(Dialog: ADialog; Left, Width: AInt;
      const Text: AString_Type; OnClick: ACallbackProc): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiDialog_AddButton1P(Dialog: ADialog; Left, Width: AInt; const Text: APascalString;
    OnClick: ACallbackProc): AControl;

function AUiDialog_AddButtonWin(Win: AWindow; Left, Width: AInt;
      const Text: AString_Type; OnClick: ACallbackProc): AControl; {$ifdef AStdCall}stdcall;{$endif} deprecated {$ifdef ADeprText}'Use AUiDialog_AddButton1'{$endif};

function AUiDialog_AddButtonWinP(Win: AWindow; Left, Width: AInt; const Text: APascalString;
    OnClick: ACallbackProc): AControl; deprecated {$ifdef ADeprText}'Use AUiDialog_AddButton1P'{$endif};

function AUiDialog_Free(Dialog: ADialog): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiDialog_GetButtonsBox(Dialog: ADialog): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiDialog_GetWindow(Dialog: ADialog): AWindow; {$ifdef AStdCall}stdcall;{$endif}

function AUiDialog_New(Buttons: AUiWindowButtons): ADialog; {$ifdef AStdCall}stdcall;{$endif}

function AUiDialog_ShowModal(Dialog: ADialog): ABool; {$ifdef AStdCall}stdcall;{$endif}

const
  DialogButtonsBoxHeight = 36;

implementation

type
  AUiDialog_Type = record
    DialogId: ADialog;
    Window: AWindow;
    ButtonsBox: AControl;
    Button1: AButton;
    Button2: AButton;
    Button3: AButton;
  end;

var
  _DialogArray: array of AUiDialog_Type;

// --- Private ---

function _AddButton(I, Left, Width: AInt; const Text: APascalString; OnClick: ACallbackProc): AButton;
var
  Button: AButton;
begin
  Button := AUiButton_New(_DialogArray[I].ButtonsBox);
  if (Button <> 0) then
  begin
    AUiControl_SetPosition(Button, Left, 4);
    AUiControl_SetSize(Button, Width, 25);
    AUiControl_SetTextP(Button, Text);
    AUiControl_SetOnClick(Button, OnClick);
    AUiControl_SetAnchors(Button, uiakRight + uiakBottom);
  end;
  Result := Button;
end;

function _FindDialog(Dialog: ADialog): AInt;
var
  I: AInt;
begin
  for I := 0 to High(_DialogArray) do
  begin
    if (_DialogArray[I].DialogId = Dialog) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

function _FindDialogByWin(Win: AWindow): AInt;
var
  I: AInt;
begin
  for I := 0 to High(_DialogArray) do
  begin
    if (_DialogArray[I].Window = Win) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

function _FreeDialog(Index: AInt): AError;
begin
  try
    AUiControl_Free(_DialogArray[Index].ButtonsBox);
    AUiControl_Free(_DialogArray[Index].Window);
    _DialogArray[Index].DialogId := 0;
    _DialogArray[Index].ButtonsBox := 0;
    _DialogArray[Index].Window := 0;
    Result := 0;
  except
    Result := -1;
  end;
end;

// --- AUi ---

function AUi_ExecuteMessageDialog1(const Text, Caption: AString_Type;
    Flags: AMessageBoxFlags): ADialogBoxCommands;
begin
  Result := AUi_ExecuteMessageDialog1P(
      AString_ToPascalString(Text),
      AString_ToPascalString(Caption),
      Flags);
end;

function AUi_ExecuteMessageDialog1A(Text, Caption: AStr;
    Flags: AMessageBoxFlags): ADialogBoxCommands;
begin
  Result := AUi_ExecuteMessageDialog1P(AnsiString(Text), AnsiString(Caption), Flags);
end;

function AUi_ExecuteMessageDialog1P(const Text, Caption: APascalString; Flags: AMessageBoxFlags): ADialogBoxCommands;
var
  PrevCursor: TCursor;
begin
  try
    PrevCursor := Screen.Cursor;
    Screen.Cursor := crDefault;
    Result := Application.MessageBox(PChar(string(Text)), PChar(string(Caption)), Flags);
    Screen.Cursor := PrevCursor;
  except
    Result := 0;
  end;
end;

// --- AUiDialog ---

function AUiDialog_AddButton1(Dialog: ADialog; Left, Width: AInt;
      const Text: AString_Type; OnClick: ACallbackProc): AControl;
begin
  Result := AUiDialog_AddButton1P(Dialog, Left, Width, AString_ToPascalString(Text), OnClick);
end;

function AUiDialog_AddButton1P(Dialog: ADialog; Left, Width: AInt; const Text: APascalString;
    OnClick: ACallbackProc): AControl;
var
  I: AInt;
begin
  if (Dialog = 0) then
  begin
    Result := 0;
    Exit;
  end;
  try
    I := _FindDialog(Dialog);
    if (I < 0) then
    begin
      Result := 0;
      Exit;
    end;
    Result := _AddButton(I, Left, Width, Text, OnClick);
  except
    Result := 0;
  end;
end;

function AUiDialog_AddButtonWin(Win: AWindow; Left, Width: AInt;
      const Text: AString_Type; OnClick: ACallbackProc): AControl;
begin
  Result := AUiDialog_AddButtonWinP(Win, Left, Width, AString_ToPascalString(Text), OnClick);
end;

function AUiDialog_AddButtonWinP(Win: AWindow; Left, Width: AInt; const Text: APascalString;
    OnClick: ACallbackProc): AControl;
var
  I: AInt;
begin
  if (Win = 0) then
  begin
    Result := 0;
    Exit;
  end;
  try
    I := _FindDialogByWin(Win);
    if (I < 0) then
    begin
      Result := 0;
      Exit;
    end;
    Result := _AddButton(I, Left, Width, Text, OnClick);
  except
    Result := 0;
  end;
end;

function AUiDialog_Free(Dialog: ADialog): AError;
var
  I: AInt;
begin
  try
    I := _FindDialog(Dialog);
    if (I < 0) then
    begin
      Result := -2;
      Exit;
    end;
    Result := _FreeDialog(I);
  except
    Result := -1;
  end;
end;

function AUiDialog_GetButtonsBox(Dialog: ADialog): AControl;
var
  I: AInt;
begin
  try
    I := _FindDialog(Dialog);
    if (I < 0) then
    begin
      Result := 0;
      Exit;
    end;
    Result := _DialogArray[I].ButtonsBox;
  except
    Result := 0;
  end;
end;

function AUiDialog_GetWindow(Dialog: ADialog): AWindow;
var
  I: AInt;
begin
  try
    I := _FindDialog(Dialog);
    if (I < 0) then
    begin
      Result := 0;
      Exit;
    end;
    Result := _DialogArray[I].Window;
  except
    Result := 0;
  end;
end;

function AUiDialog_New(Buttons: AUiWindowButtons): ADialog;
var
  Button: AControl;
  Window: AControl;
  Box: AControl;
  I: AInt;
begin
  try
    Window := AUiWindow_New();
    Box := AUiBox_New(Window, 0);
    AUiControl_SetAlign(Box, uiAlignBottom);
    AUiControl_SetSize(Box, 100, DialogButtonsBoxHeight);

    I := Length(_DialogArray);
    SetLength(_DialogArray, I + 1);
    _DialogArray[I].DialogId := I + 1;
    _DialogArray[I].Window := Window;
    _DialogArray[I].ButtonsBox := Box;

    AUiWindow_SetPosition(Window, AUiWindowPosition_OwnerFormCenter);
    if (Buttons = MB_OK) then
    begin
      Button := AUiButton_New(Box);
      AUiControl_SetTextP(Button, cOkText);
      AUiControl_SetPosition(Button, 5, 5);
      AUiButton_SetKind(Button, uibkOk);
      _DialogArray[I].Button1 := Button;
    end
    else if (Buttons = MB_OKCANCEL) then
    begin
      Button := AUiButton_New(Box);
      AUiControl_SetTextP(Button, cOkText);
      AUiControl_SetPosition(Button, 5, 5);
      AUiButton_SetKind(Button, uibkOk);
      _DialogArray[I].Button1 := Button;

      Button := AUiButton_New(Box);
      AUiControl_SetTextP(Button, cCancelText);
      AUiControl_SetPosition(Button, 90, 5);
      AUiButton_SetKind(Button, uibkCancel);
      _DialogArray[I].Button2 := Button;
    end
    else if (Buttons = MB_ApplyOkCancel) then
    begin
      Button := AUiButton_New(Box);
      AUiControl_SetPosition(Button, 5, 5);
      AUiControl_SetTextP(Button, cApplyText);
      _DialogArray[I].Button1 := Button;

      Button := AUiButton_New(Box);
      AUiControl_SetPosition(Button, 90, 5);
      AUiButton_SetKind(Button, uibkOk);
      AUiControl_SetTextP(Button, cOkText);
      _DialogArray[I].Button2 := Button;

      Button := AUiButton_New(Box);
      AUiControl_SetPosition(Button, 175, 5);
      AUiButton_SetKind(Button, uibkCancel);
      AUiControl_SetTextP(Button, cCancelText);
      _DialogArray[I].Button3 := Button;
    end;
    Result := ADialog(I + 1);
  except
    Result := 0;
  end;
end;

function AUiDialog_ShowModal(Dialog: ADialog): ABool;
var
  I: AInt;
begin
  I := _FindDialog(Dialog);
  if (I < 0) then
  begin
    Result := False;
    Exit;
  end;
  Result := AUiWindow_ShowModal(_DialogArray[I].Window);
end;

end.

