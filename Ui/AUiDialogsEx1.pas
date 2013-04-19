{**
@Author Prof1983 <prof1983@ya.ru>
@Created 16.02.2009
@LastMod 19.04.2013
}
unit AUiDialogsEx1;

{define AStdCall}

interface

uses
  Controls,
  Forms,
  ABase,
  ABaseTypes,
  AStringBaseUtils,
  AStringMain,
  ASystemMain,
  AUiBase,
  AUiBox,
  AUiCheckBox,
  AUiControls,
  AUiDialogs,
  AUiEdit,
  AUiLabels,
  AUiTextView,
  AUiWindows;

// --- AUi ---

function AUi_ExecuteInputBox1(const Text: AString_Type;
    var Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteInputBox1A(Text: AStr; Value: AStr;
    ValueMaxLen: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteInputBox1P(const Text: APascalString;
    var Value: APascalString): ABool;

function AUi_ExecuteInputBox2(const Caption, Text1, Text2: AString_Type;
    var Value1, Value2: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteInputBox2A(Caption, Text1, Text2: AStr;
    Value1: AStr; MaxLenValue1: AInt; Value2: AStr; MaxLenValue2: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteInputBox2P(const Caption, Text1, Text2: APascalString;
    var Value1, Value2: APascalString): ABool;

function AUi_ExecuteInputBox3P(const Caption, Text: APascalString;
    var Value: APascalString): ABool;

function AUi_ExecuteLoginDialog(var UserName, Password: AString_Type;
    IsSave: ABool): ABool; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteLoginDialogP(var UserName, Password: APascalString;
    IsSave: ABool): ABool; 

function AUi_ExecuteMessageDialog1(const Text, Caption: AString_Type;
    Flags: AMessageBoxFlags): ADialogBoxCommands; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteMessageDialog1A(Text, Caption: AStr;
    Flags: AMessageBoxFlags): ADialogBoxCommands; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteMessageDialog1P(const Text, Caption: APascalString;
    Flags: AMessageBoxFlags): ADialogBoxCommands;

implementation

type
  TInputDialog = record
    Dialog: ADialog;
    Edit: AControl;
    Memo: AControl;
  end;

  TLoginDialog = record
    Dialog: ADialog;
    Panel: AControl;
    Label1: AControl;
    Label2: AControl;
    edtUserName: AControl;
    edtPassword: AControl;
    cbSavePassword: AControl;
  end;

  TPasswordDialog = record
    Dialog: ADialog;
    ValueEdit1: AControl;
    ValueEdit2: AControl;
    ValueLabel1: AControl;
    ValueLabel2: AControl;
  end;

// --- Private ---

procedure _InputDialog1_Init(var Dialog: TInputDialog; const Caption: APascalString);
var
  Win: AWindow;
begin
  Win := AUiDialog_GetWindow(Dialog.Dialog);

  AUiControl_SetTextP(Win, Caption);
  AUiControl_SetPosition(Win, 250, 200);
  AUiControl_SetBorderStyle(Win, AUiBorderStyle_Dialog);
  AUiControl_SetClientSize(Win, 280, 140);

  Dialog.Edit := AUiEdit_New(Win);
  AUiControl_SetPosition(Dialog.Edit, 12, 66);
  AUiControl_SetSize(Dialog.Edit, 249, 24);
  AUiControl_SetTabOrder(Dialog.Edit, 0);
  //Dialog.Edit.CharCase := ecUpperCase;

  Dialog.Memo := AUiTextView_New(Win, 0);
  AUiControl_SetAlign(Dialog.Memo, AUiAlign_Top);
  AUiControl_SetBorderStyle(Dialog.Memo, AUiBorderStyle_None);
  AUiControl_SetColor(Dialog.Memo, $FF000000+15{clBtnFace});
  AUiControl_SetPosition(Dialog.Memo, 0, 0);
  AUiControl_SetSize(Dialog.Memo, 277, 49);
  AUiControl_SetTabStop(Dialog.Memo, False);
  AUiTextView_SetReadOnly(Dialog.Memo, True);
end;

function _InputDialog1_InputBox(const Caption, Text: APascalString;
    var Value: APascalString): ABool;
var
  InputDialog: TInputDialog;
begin
  InputDialog.Dialog := AUiDialog_New(AMessageBoxFlags_OkCancel);
  _InputDialog1_Init(InputDialog, Caption);
  try
    AUiControl_SetTextP(InputDialog.Memo, Text);
    AUiControl_SetTextP(InputDialog.Edit, Value);
    if not(AUiDialog_ShowModal(InputDialog.Dialog)) then
    begin
      Result := False;
      Exit;
    end;
    Value := AUiControl_GetTextP(InputDialog.Edit);
    Result := True;
  finally
    AUiDialog_Free(InputDialog.Dialog);
  end;
end;

function _InputDialog2_Init(var Dialog: TPasswordDialog; const Caption, Label1, Label2,
    Value1, Value2: string): AError;
var
  Win: AWindow;
begin
  Win := AUiDialog_GetWindow(Dialog.Dialog);

  AUiControl_SetBorderStyle(Win, AUiBorderStyle_Dialog);
  AUiControl_SetClientSize(Win, 220, 135);
  AUiControl_SetFontStyle(Win, AUiFontStyle_Bold);
  AUiControl_SetTextP(Win, Caption);
  AUiWindow_SetPosition(Win, AUiWindowPosition_ScreenCenter);

  Dialog.ValueLabel1 := AUiLabel_New(Win);
  AUiControl_SetPosition(Dialog.ValueLabel1, 12, 17);
  AUiControl_SetTextP(Dialog.ValueLabel1, Label1);

  Dialog.ValueLabel2 := AUiLabel_New(Win);
  AUiControl_SetPosition(Dialog.ValueLabel2, 12, 55);
  AUiControl_SetTextP(Dialog.ValueLabel2, Label2);

  Dialog.ValueEdit1 := AUiEdit_New(Win);
  AUiControl_SetPosition(Dialog.ValueEdit1, 80, 13);
  AUiControl_SetWidth(Dialog.ValueEdit1, 100);
  AUiControl_SetTabOrder(Dialog.ValueEdit1, 0);
  AUiControl_SetTextP(Dialog.ValueEdit1, Value1);

  Dialog.ValueEdit2 := AUiEdit_New(Win);
  AUiControl_SetPosition(Dialog.ValueEdit2, 80, 48);
  AUiControl_SetWidth(Dialog.ValueEdit2, 100);
  AUiControl_SetTabOrder(Dialog.ValueEdit2, 1);
  AUiControl_SetTextP(Dialog.ValueEdit2, Value2);

  if (Value1 = '') then
    AUiWindow_SetActiveControl(Win, Dialog.ValueEdit1)
  else
    AUiWindow_SetActiveControl(Win, Dialog.ValueEdit2);

  Result := 0;
end;

function _InputDialog2_InputBox(const Caption, Text1, Text2: APascalString;
    var Value1, Value2: APascalString): ABool;
var
  Dialog: TPasswordDialog;
begin
  Dialog.Dialog := AUiDialog_New(AMessageBoxFlags_OkCancel);
  _InputDialog2_Init(Dialog, Caption, Text1, Text2, Value1, Value2);
  try
    if not(AUiDialog_ShowModal(Dialog.Dialog)) then
    begin
      Result := False;
      Exit;
    end;

    Value1 := AUiControl_GetTextP(Dialog.ValueEdit1);
    Value2 := AUiControl_GetTextP(Dialog.ValueEdit2);
    Result := True;
  finally
    AUiDialog_Free(Dialog.Dialog);
  end;
end;

function _LoginDialog_Init(var Dialog: TLoginDialog; const UserName: APascalString;
    IsSave: ABool): AError;
var
  Win: AWindow;
begin
  Win := AUiDialog_GetWindow(Dialog.Dialog);

  AUiControl_SetBorderStyle(Win, AUiBorderStyle_Dialog);
  AUiControl_SetClientSize(Win, 250, 120);
  AUiWindow_SetPosition(Win, AUiWindowPosition_ScreenCenter);
  //Form.BorderIcons := [biSystemMenu];

  Dialog.Panel := AUiBox_New(Win, AUiBoxType_Simple);
  AUiControl_SetPosition(Dialog.Panel, 0, 0);
  AUiControl_SetSize(Dialog.Panel, 250, 77);
  AUiControl_SetAlign(Dialog.Panel, AUiAlign_Client);

    Dialog.Label1 := AUiLabel_New(Dialog.Panel);
    AUiControl_SetPosition(Dialog.Label1, 8, 12);
    AUiControl_SetSize(Dialog.Label1, 120, 14);
    AUiControl_SetTextP(Dialog.Label1, 'User name');

    Dialog.Label2 := AUiLabel_New(Dialog.Panel);
    AUiControl_SetPosition(Dialog.Label2, 8, 40);
    AUiControl_SetSize(Dialog.Label2, 120, 14);
    AUiControl_SetTextP(Dialog.Label2, 'User password');

    Dialog.edtUserName := AUiEdit_New(Dialog.Panel);
    AUiControl_SetPosition(Dialog.edtUserName, 128, 8);
    AUiControl_SetSize(Dialog.edtUserName, 110, 22);
    AUiControl_SetTabOrder(Dialog.edtUserName, 0);
    AUiControl_SetTextP(Dialog.edtUserName, UserName);

    Dialog.edtPassword := AUiEdit_New(Dialog.Panel);
    AUiControl_SetPosition(Dialog.edtPassword, 128, 36);
    AUiControl_SetSize(Dialog.edtPassword, 110, 22);
    AUiControl_SetTabOrder(Dialog.edtPassword, 1);
    AUiEdit_SetPasswordChar(Dialog.edtPassword, '*');

    Dialog.cbSavePassword := AUiCheckBox_New(Dialog.Panel);
    AUiControl_SetPosition(Dialog.cbSavePassword, 8, 60);
    AUiControl_SetSize(Dialog.cbSavePassword, 130, 18);
    AUiControl_SetTextP(Dialog.cbSavePassword, 'Запомнить пароль');
    AUiControl_SetTabOrder(Dialog.cbSavePassword, 2);
    if not(IsSave) then
      AUiControl_SetVisible(Dialog.cbSavePassword, False);

  if (UserName = '') then
    AUiWindow_SetActiveControl(Win, Dialog.edtUserName)
  else
    AUiWindow_SetActiveControl(Win, Dialog.edtPassword);

  Result := 0;
end;

// --- AUi ---

function AUi_ExecuteInputBox1(const Text: AString_Type; var Value: AString_Type): AError;
var
  V: APascalString;
begin
  V := AString_ToPascalString(Value);
  if AUi_ExecuteInputBox1P(AString_ToPascalString(Text), V) then
  begin
    AString_AssignP(Value, V);
    Result := 0;
    Exit;
  end;
  Result := 1;
end;

function AUi_ExecuteInputBox1A(Text: AStr; Value: AStr; ValueMaxLen: AInt): AError;
var
  V: APascalString;
begin
  V := AnsiString(Value);
  if AUi_ExecuteInputBox1P(AnsiString(Text), V) then
  begin
    AStr_AssignP(Value, V, ValueMaxLen);
    Result := 0;
    Exit;
  end;
  Result := 1;
end;

function AUi_ExecuteInputBox1P(const Text: APascalString; var Value: APascalString): ABool;
begin
  Result := AUi_ExecuteInputBox3P(ASystem_GetTitleP(), Text, Value);
end;

function AUi_ExecuteInputBox2(const Caption, Text1, Text2: AString_Type;
    var Value1, Value2: AString_Type): AError;
var
  V1: APascalString;
  V2: APascalString;
begin
  V1 := AString_ToPascalString(Value1);
  V2 := AString_ToPascalString(Value2);
  if AUi_ExecuteInputBox2P(
      AString_ToPascalString(Caption),
      AString_ToPascalString(Text1),
      AString_ToPascalString(Text2),
      V1, V2) then
  begin
    AString_AssignP(Value1, V1);
    AString_AssignP(Value2, V2);
    Result := 0;
    Exit;
  end;
  Result := 1;
end;

function AUi_ExecuteInputBox2A(Caption, Text1, Text2: AStr;
    Value1: AStr; MaxLenValue1: AInt; Value2: AStr; MaxLenValue2: AInt): AError;
var
  V1: APascalString;
  V2: APascalString;
begin
  V1 := AnsiString(Value1);
  V2 := AnsiString(Value2);
  if AUi_ExecuteInputBox2P(
      AnsiString(Caption),
      AnsiString(Text1),
      AnsiString(Text2),
      V1, V2) then
  begin
    AStr_AssignP(Value1, V1, MaxLenValue1);
    AStr_AssignP(Value2, V2, MaxLenValue2);
    Result := 0;
    Exit;
  end;
  Result := 1;
end;

function AUi_ExecuteInputBox2P(const Caption, Text1, Text2: APascalString;
    var Value1, Value2: APascalString): ABool;
begin
  try
    Result := _InputDialog2_InputBox(Caption, Text1, Text2, Value1, Value2);
  except
    Result := False;
  end;
end;

function AUi_ExecuteInputBox3P(const Caption, Text: APascalString; var Value: APascalString): ABool;
begin
  try
    Result := _InputDialog1_InputBox(Caption, Text, Value);
  except
    Result := False;
  end;
end;

function AUi_ExecuteLoginDialog(var UserName, Password: AString_Type;
    IsSave: ABool): ABool;
var
  UserNameStr: APascalString;
  PasswordStr: APascalString;
begin
  UserNameStr := AString_ToPascalString(UserName);
  PasswordStr := AString_ToPascalString(Password);
  Result := AUi_ExecuteLoginDialogP(UserNameStr, PasswordStr, IsSave);
  AString_AssignP(UserName, UserNameStr);
  AString_AssignP(Password, PasswordStr);
end;

function AUi_ExecuteLoginDialogP(var UserName, Password: APascalString; IsSave: ABool): ABool;
var
  LoginDialog: TLoginDialog;
begin
  try
    LoginDialog.Dialog := AUiDialog_New(AMessageBoxFlags_OkCancel);
    _LoginDialog_Init(LoginDialog, UserName, IsSave);
    try
      if not(AUiDialog_ShowModal(LoginDialog.Dialog)) then
      begin
        Result := False;
        Exit;
      end;
      UserName := AUiControl_GetTextP(LoginDialog.edtUserName);
      Password := AUiControl_GetTextP(LoginDialog.edtPassword);
      Result := True;
    finally
      AUiDialog_Free(LoginDialog.Dialog);
    end;
  except
    Result := False;
  end;
end;

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

end.

