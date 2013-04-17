{**
@Abstract AUiDialogs
@Author Prof1983 <prof1983@ya.ru>
@Created 16.02.2009
@LastMod 17.04.2013
}
unit AUiDialogs;

{$define AStdCall}

interface

uses
  ABase,
  ABaseTypes,
  AStringMain,
  AUiBase,
  AUiBox,
  AUiButtons,
  AUiConsts,
  AUiControls,
  AUiWindows,
  fAbout;

// --- AUiDialog ---

function AUiDialog_AddButton(Win: AWindow; Left, Width: AInt;
      const Text: AString_Type; OnClick: ACallbackProc): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiDialog_AddButton02(Win: AWindow; Left, Width: AInteger; const Text: APascalString;
    OnClick: ACallbackProc02): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiDialog_AddButton1P(Dialog: ADialog; Left, Width: AInt; const Text: APascalString;
    OnClick: ACallbackProc): AControl;

function AUiDialog_AddButtonP(Win: AWindow; Left, Width: AInt; const Text: APascalString;
    OnClick: ACallbackProc): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiDialog_Free(Dialog: ADialog): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiDialog_GetWindow(Dialog: ADialog): AWindow; {$ifdef AStdCall}stdcall;{$endif}

function AUiDialog_New(Buttons: AUiWindowButtons): ADialog; {$ifdef AStdCall}stdcall;{$endif}

function AUiDialog_ShowModal(Dialog: ADialog): ABool; {$ifdef AStdCall}stdcall;{$endif}

// --- AUi ---

function AUi_NewDialog(Buttons: AUiWindowButtons): ADialog; {$ifdef AStdCall}stdcall;{$endif}

// --- UI_Dialog ---

function UI_Dialog_AddButton(Win: AWindow; Left, Width: AInteger; const Text: APascalString;
    OnClick: ACallbackProc): AControl; stdcall;

function UI_Dialog_AddButton02(Win: AWindow; Left, Width: AInteger; const Text: APascalString;
    OnClick: ACallbackProc02): AControl; stdcall;

implementation

uses
  AUiMain;

const
  DialogButtonsBoxHeight = 36;

{ TAUIDialog }

type
  TAUiDialog = class
  private
    FButtonsBox: AControl;
    FWindow: AControl;
  public
    function GetButtonsBox: AControl;
    function GetWindow: AControl;
  public
    constructor Create;
  end;

{ TAUiDialog }

constructor TAUiDialog.Create();
begin
  FWindow := AUiWindow_New();

  FButtonsBox := AUiBox_New(FWindow, 0);
  AUiControl_SetAlign(FButtonsBox, uiAlignBottom);
  AUiControl_SetSize(FButtonsBox, 100, DialogButtonsBoxHeight);
end;

function TAUiDialog.GetButtonsBox(): AControl;
begin
  Result := FButtonsBox;
end;

function TAUiDialog.GetWindow(): AControl;
begin
  Result := FWindow;
end;

// --- AUiDialog ---

function AUiDialog_AddButton(Win: AWindow; Left, Width: AInt;
      const Text: AString_Type; OnClick: ACallbackProc): AControl;
begin
  Result := AUiDialog_AddButtonP(Win, Left, Width, AString_ToPascalString(Text), OnClick);
end;

function AUiDialog_AddButton02(Win: AWindow; Left, Width: AInteger; const Text: APascalString;
    OnClick: ACallbackProc02): AControl;
begin
  try
    if (Win = 0) or not(TObject(Win) is TAboutForm) then
    begin
      Result := 0;
      Exit;
    end;
    Result := TAboutForm(Win).AddButton02(Left, Width, Text, OnClick)
  except
    Result := 0;
  end;
end;

function AUiDialog_AddButton1P(Dialog: ADialog; Left, Width: AInt; const Text: APascalString;
    OnClick: ACallbackProc): AControl;
begin
  if (Dialog = 0) then
  begin
    Result := 0;
    Exit;
  end;
  try
    if not(TObject(Dialog) is TAUiDialog) then
    begin
      Result := 0;
      Exit;
    end;
    Result := AUiDialog_AddButtonP(TAUiDialog(Dialog).FWindow, Left, Width, Text, OnClick);
  except
    Result := 0;
  end;
end;

function AUiDialog_AddButtonP(Win: AWindow; Left, Width: AInt; const Text: APascalString;
    OnClick: ACallbackProc): AControl;
begin
  try
    if (Win <> 0) and (TObject(Win) is TAboutForm) then
      Result := TAboutForm(Win).AddButton(Left, Width, Text, OnClick)
    else
      Result := 0;
  except
    Result := 0;
  end;
end;

function AUiDialog_Free(Dialog: ADialog): AError;
begin
  try
    AUiControl_Free(TAUiDialog(Dialog).FButtonsBox);
    AUiControl_Free(TAUiDialog(Dialog).FWindow);
    TAUiDialog(Dialog).Free();
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiDialog_GetWindow(Dialog: ADialog): AWindow;
begin
  try
    Result := TAUiDialog(Dialog).GetWindow();
  except
    Result := 0;
  end;
end;

function AUiDialog_New(Buttons: AUiWindowButtons): ADialog;
var
  Button: AControl;
  Dialog: TAUIDialog;
  Window: AControl;
  Box: AControl;
begin
  try
    Dialog := TAUiDialog.Create();
    Box := Dialog.GetButtonsBox();
    Window := AUiDialog_GetWindow(ADialog(Dialog));
    AUiWindow_SetPosition(Window, AUiWindowPosition_OwnerFormCenter);
    if (Buttons = MB_OK) then
    begin
      Button := AUiButton_New(Box);
      AUiControl_SetTextP(Button, cOkText);
      AUiControl_SetPosition(Button, 5, 5);
      AUiButton_SetKind(Button, uibkOk);
    end
    else if (Buttons = MB_OKCANCEL) then
    begin
      Button := AUiButton_New(Box);
      AUiControl_SetTextP(Button, cOkText);
      AUiControl_SetPosition(Button, 5, 5);
      AUiButton_SetKind(Button, uibkOk);

      Button := AUiButton_New(Box);
      AUiControl_SetTextP(Button, cCancelText);
      AUiControl_SetPosition(Button, 90, 5);
      AUiButton_SetKind(Button, uibkCancel);
    end
    else if (Buttons = MB_ApplyOkCancel) then
    begin
      Button := AUiButton_New(Box);
      AUiControl_SetPosition(Button, 5, 5);
      AUiControl_SetTextP(Button, cApplyText);

      Button := AUiButton_New(Box);
      AUiControl_SetPosition(Button, 90, 5);
      AUiButton_SetKind(Button, uibkOk);
      AUiControl_SetTextP(Button, cOkText);

      Button := AUiButton_New(Box);
      AUiControl_SetPosition(Button, 175, 5);
      AUiButton_SetKind(Button, uibkCancel);
      AUiControl_SetTextP(Button, cCancelText);
    end;
    Result := ADialog(Dialog);
  except
    Result := 0;
  end;
end;

function AUiDialog_ShowModal(Dialog: ADialog): ABool;
var
  I: AInt;
begin
  if (Dialog = 0) then
  begin
    Result := False;
    Exit;
  end;
  try
    if not(TObject(Dialog) is TAUiDialog) then
    begin
      Result := False;
      Exit;
    end;
    Result := AUiWindow_ShowModal(TAUiDialog(Dialog).FWindow);
  except
    Result := False;
  end;
end;

// --- AUi ---

function AUi_NewDialog(Buttons: AUiWindowButtons): ADialog;
begin
  Result := AUiDialog_New(Buttons);
end;

// --- UI_Dialog  ---

function UI_Dialog_AddButton(Win: AWindow; Left, Width: AInteger; const Text: APascalString;
    OnClick: ACallbackProc): AControl;
begin
  Result := AUiDialog_AddButtonP(Win, Left, Width, Text, OnClick);
end;

function UI_Dialog_AddButton02(Win: AWindow; Left, Width: AInteger; const Text: APascalString;
    OnClick: ACallbackProc02): AControl;
begin
  Result := AUiDialog_AddButton02(Win, Left, Width, Text, OnClick);
end;

end.

