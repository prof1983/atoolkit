{**
@Author Prof1983 <prof1983@ya.ru>
@Created 16.02.2009
@LastMod 16.04.2013
}
unit AUiDialogsEx1;

{$define AStdCall}

interface

uses
  Controls, Forms,
  ABase,
  ABaseTypes,
  AStringBaseUtils,
  AStringMain,
  ASystem,
  AUiBase,
  AUiBox,
  AUiControls,
  AUiWindows,
  fInputDialog, fLogin, fPasswordDialog;

// --- AUi ---

function AUi_ExecuteInputBox1(const Text: AString_Type;
    var Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteInputBox1A(Text: AStr; Value: AStr;
    ValueMaxLen: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteInputBox1P(const Text: APascalString;
    var Value: APascalString): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteInputBox2(const Caption, Text1, Text2: AString_Type;
    var Value1, Value2: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteInputBox2A(Caption, Text1, Text2: AStr;
    Value1: AStr; MaxLenValue1: AInt; Value2: AStr; MaxLenValue2: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteInputBox2P(const Caption, Text1, Text2: APascalString;
    var Value1, Value2: APascalString): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteInputBox3P(const Caption, Text: APascalString;
    var Value: APascalString): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteLoginDialog(var UserName, Password: AString_Type;
    IsSave: ABoolean): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteLoginDialogP(var UserName, Password: APascalString;
    IsSave: ABoolean): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteMessageDialog1(const Text, Caption: AString_Type;
    Flags: AMessageBoxFlags): ADialogBoxCommands; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteMessageDialog1A(Text, Caption: AStr;
    Flags: AMessageBoxFlags): ADialogBoxCommands; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteMessageDialog1P(const Text, Caption: APascalString;
    Flags: AMessageBoxFlags): ADialogBoxCommands; {$ifdef AStdCall}stdcall;{$endif}

// --- UI_Dialog ---

function UI_Dialog_InputBox(const Text: APascalString;
    var Value: APascalString): ABoolean; stdcall;

function UI_Dialog_InputBox2(const Caption, Text1, Text2: APascalString;
    var Value1, Value2: APascalString): ABoolean; stdcall;

function UI_Dialog_InputBox3(const Caption, Text: APascalString;
    var Value: APascalString): Boolean; stdcall;

// Use UI_Dialog_InputBox3()
function UI_Dialog_InputBoxA(const Caption, Text: APascalString;
    var Value: APascalString): ABoolean; stdcall; deprecated;

function UI_Dialog_Login(var UserName, Password: APascalString;
    IsSave: ABoolean): ABoolean; stdcall;

function UI_Dialog_Message(const Text, Caption: APascalString;
    Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;

// --- UI_Dialogs ---

function UI_Dialogs_InputBox(const Caption, Prompt, Default: APascalString): APascalString;

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

function AUi_ExecuteInputBox1P(const Text: APascalString; var Value: APascalString): ABoolean;
begin
  Result := AUi_ExecuteInputBox3P(ASystem.Info_GetTitleWS(), Text, Value);
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
    var Value1, Value2: APascalString): ABoolean;
begin
  {$IFDEF FPC}
  Result := False;
  {$ELSE}
  try
    Result := fPasswordDialog.InputBox2(Caption, Text1, Text2, Value1, Value2);
  except
    Result := False;
  end;
  {$ENDIF}
end;

function AUi_ExecuteInputBox3P(const Caption, Text: APascalString; var Value: APascalString): ABoolean;
begin
  {$IFDEF FPC}
  Result := False;
  {$ELSE}
  try
    Result := fInputDialog.InputBox(Caption, Text, Value);
  except
    Result := False;
  end;
  {$ENDIF}
end;

function AUi_ExecuteLoginDialog(var UserName, Password: AString_Type;
    IsSave: ABoolean): ABoolean;
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

function AUi_ExecuteLoginDialogP(var UserName, Password: APascalString; IsSave: ABoolean): ABoolean;
{$IFNDEF FPC}
var
  fmLogin: TLoginForm;
{$ENDIF}
begin
  {$IFDEF FPC}
  Result := False;
  {$ELSE}
  try
    fmLogin := TLoginForm.Create(nil);
    try
      fmLogin.UserName := UserName;
      Result := (fmLogin.ShowModal() = mrOk);
      if Result then
      begin
        UserName := fmLogin.UserName;
        Password := fmLogin.UserPassword;
      end;
    finally
      fmLogin.Free();
    end;
  except
    Result := False;
  end;
  {$ENDIF}
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
    {$IFNDEF UNIX}
    //Result := Windows.MessageBox(Application.Handle{0}, PChar(string(Text)), PChar(string(Caption)), Flags);
    {$ENDIF}
    Screen.Cursor := PrevCursor;
  except
    Result := 0;
  end;
end;

// --- UI_Dialogs ---

function UI_Dialogs_InputBox(const Caption, Prompt, Default: APascalString): APascalString;
begin
  Result := Default;
  AUi_ExecuteInputBox3P(Caption, Prompt, Result);
end;

// --- UI_Dialog  ---

function UI_Dialog_InputBox(const Text: APascalString; var Value: APascalString): Boolean;
begin
  Result := AUi_ExecuteInputBox1P(Text, Value);
end;

function UI_Dialog_InputBox2(const Caption, Text1, Text2: APascalString; var Value1, Value2: APascalString): ABoolean;
begin
  Result := AUi_ExecuteInputBox2P(Caption, Text1, Text2, Value1, Value2);
end;

function UI_Dialog_InputBox3(const Caption, Text: APascalString; var Value: APascalString): Boolean;
begin
  Result := AUi_ExecuteInputBox3P(Caption, Text, Value);
end;

function UI_Dialog_InputBoxA(const Caption, Text: APascalString; var Value: APascalString): Boolean;
begin
  Result := AUi_ExecuteInputBox3P(Caption, Text, Value);
end;

function UI_Dialog_Login(var UserName, Password: APascalString; IsSave: ABoolean): ABoolean;
begin
  Result := AUi_ExecuteLoginDialogP(UserName, Password, IsSave);
end;

function UI_Dialog_Message(const Text, Caption: APascalString; Flags: AMessageBoxFlags): ADialogBoxCommands;
begin
  Result := AUi_ExecuteMessageDialog1P(Text, Caption, Flags);
end;

end.

