{**
@Abstract AUiDialogs
@Author Prof1983 <prof1983@ya.ru>
@Created 16.02.2009
@LastMod 28.03.2013
}
unit AUiDialogs2;

{DEFINE USE_JEDI}
{define AStdCall}

interface

uses
  {$IFDEF USE_JEDI}JvBaseDlg, JvSelectDirectory,{$ENDIF}
  ComCtrls,
  Controls,
  Dialogs,
  ExtCtrls,
  Graphics,
  StdCtrls,
  ABase,
  ABaseTypes,
  AStringBaseUtils,
  AStringMain,
  ASystemMain,
  AUiBase,
  AUiBox,
  AUiControls,
  AUiDialogs,
  AUiLabels,
  AUiListBox,
  AUiTextView,
  AUiWindows;

// --- AUi ---

function AUi_ExecuteColorDialog(var Color: AColor): ABool; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteFontDialog(var FontName: AString_Type; var FontSize: AInt;
    var FontColor: AColor): ABool; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteFontDialogA(FontName: AStr; MaxLen: AInt; var FontSize: AInt;
    var FontColor: AColor): ABool; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteFontDialogP(var FontName: APascalString; var FontSize: AInt;
    var FontColor: AColor): ABool; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteInputBox1(const Text: AString_Type;
    var Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteInputBox1A(Text: AStr; Value: AStr;
    ValueMaxLen: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteInputBox1P(const Text: APascalString;
    var Value: APascalString): ABool; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteInputBox2(const Caption, Text1, Text2: AString_Type;
    var Value1, Value2: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteInputBox2A(Caption, Text1, Text2: AStr;
    Value1: AStr; MaxLenValue1: AInt; Value2: AStr; MaxLenValue2: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteInputBox2P(const Caption, Text1, Text2: APascalString;
    var Value1, Value2: APascalString): ABool; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteInputBox3P(const Caption, Text: APascalString;
    var Value: APascalString): ABool; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteInputBox4P(const Caption, Prompt: APascalString;
    var Value: APascalString): ABool; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteInputQueryP(const Caption, Prompt: APascalString;
    var Value: APascalString): ABool; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteLoginDialog(var UserName, Password: AString_Type;
    IsSave: ABool): ABool; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteLoginDialogP(var UserName, Password: APascalString;
    IsSave: ABool): ABool; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteMessageDialog2P(const Msg: APascalString; MsgDlgTypeFlag: AMessageBoxFlags;
    Flags: AMessageBoxFlags): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteOpenDialogP(const InitialDir, Filter, DefaultExt, Title: APascalString;
    var FileName: APascalString; var FilterIndex: AInt): ABool; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteOpenFileDialog(const InitialDir, Filter, Title: AString_Type;
    var FileName: AString_Type): ABool; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteOpenFileDialogP(const InitialDir, Filter, Title: APascalString;
    var FileName: APascalString): ABool; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecutePrinterSetupDialog(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteSaveFileDialog1(const InitialDir, DefExt, DefFileName: AString_Type;
      out Value: AString_Type): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteSaveFileDialog1P(const InitialDir, DefExt, DefFileName: APascalString): APascalString; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteSaveFileDialog2P(const InitialDir, DefExt, DefFileName, Filter: APascalString;
    var FilterIndex: AInt): APascalString; {$ifdef AStdCall}stdcall;{$endif}

{** Select one item by SelectList
    @SelectList - Example: "Item 1;Item 2;Item 3" }
function AUi_ExecuteSelectDialogP(DialogType: AInt; const SelectList: APascalString;
    out Res: AInt): ABool;

function AUi_ExecuteSelectDirectoryDialogP(var Directory: APascalString): ABool; {$ifdef AStdCall}stdcall;{$endif}

implementation

uses
  Buttons,
  Forms;

type
  TInputDialog = class
    Form: TForm;
    Edit1: TEdit;
    Panel1: TPanel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    Memo: TMemo;
  end;

  TLoginDialog = class
    Form: TForm;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtUserName: TEdit;
    edtPassword: TEdit;
    pnlButtons: TPanel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    cbSavePassword: TCheckBox;
  end;

  TPasswordDialog = record
    Form: TForm;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    lblValue1: TLabel;
    edtValue1: TEdit;
    lblValue2: TLabel;
    edtValue2: TEdit;
  end;

// --- Private ---

procedure _InputDialog_Init(var Dialog: TInputDialog);
var
  Form: TForm;
begin
  Form := Dialog.Form;

  Form.Left := 252;
  Form.Top := 176;
  Form.BorderStyle := bsToolWindow;
  Form.ClientHeight := 138;
  Form.ClientWidth := 277;
  Form.Color := clBtnFace;
  Form.Font.Color := clWindowText;

  Dialog.Edit1 := TEdit.Create(Form);
  Dialog.Edit1.Parent := Form;
  Dialog.Edit1.Left := 12;
  Dialog.Edit1.Top := 66;
  Dialog.Edit1.Width := 249;
  Dialog.Edit1.Height := 24;
  Dialog.Edit1.CharCase := ecUpperCase;
  Dialog.Edit1.TabOrder := 0;

  Dialog.Panel1 := TPanel.Create(Form);
  Dialog.Panel1.Parent := Form;
  Dialog.Panel1.Left := 0;
  Dialog.Panel1.Top := 105;
  Dialog.Panel1.Width := 277;
  Dialog.Panel1.Height := 33;
  Dialog.Panel1.Align := alBottom;
  Dialog.Panel1.TabOrder := 1;

  Dialog.btnOk := TBitBtn.Create(Dialog.Panel1);
  Dialog.btnOk.Parent := Dialog.Panel1;
  Dialog.btnOk.Left := 40;
  Dialog.btnOk.Top := 4;
  Dialog.btnOk.Width := 75;
  Dialog.btnOk.Height := 25;
  Dialog.btnOk.TabOrder := 0;
  Dialog.btnOk.Kind := bkOK;

  Dialog.btnCancel := TBitBtn.Create(Dialog.Panel1);
  Dialog.btnCancel.Parent := Dialog.Panel1;
  Dialog.btnCancel.Left := 152;
  Dialog.btnCancel.Top := 4;
  Dialog.btnCancel.Width := 75;
  Dialog.btnCancel.Height := 25;
  Dialog.btnCancel.Caption := 'Cancel';
  Dialog.btnCancel.TabOrder := 1;
  Dialog.btnCancel.Kind := bkCancel;

  Dialog.Memo := TMemo.Create(Form);
  Dialog.Memo.Parent := Form;
  Dialog.Memo.Left := 0;
  Dialog.Memo.Top := 0;
  Dialog.Memo.Width := 277;
  Dialog.Memo.Height := 49;
  Dialog.Memo.Align := alTop;
  Dialog.Memo.BorderStyle := bsNone;
  Dialog.Memo.Color := clBtnFace;
  Dialog.Memo.ReadOnly := True;
  Dialog.Memo.TabOrder := 2;
end;

function _InputDialog_InputBox(const Caption, Text: APascalString; var Value: APascalString): ABool;
var
  InputDialog: TInputDialog;
begin
  InputDialog.Form := TForm.Create(nil);
  _InputDialog_Init(InputDialog);
  try
    InputDialog.Form.Caption := Caption;
    InputDialog.Edit1.Text := Value;
    Result := (InputDialog.Form.ShowModal() = mrOk);
    if Result then
      Value := InputDialog.Edit1.Text;
  finally
    InputDialog.Form.Free();
  end;
end;

function _LoginDialog_Init(var Dialog: TLoginDialog): AError;
var
  Form: TForm;
begin
  Form := Dialog.Form;

  Form.BorderIcons := [biSystemMenu];
  Form.BorderStyle := bsDialog;
  Form.ClientHeight := 118;
  Form.ClientWidth := 248;
  Form.Position := poScreenCenter;

  Dialog.Panel2 := TPanel.Create(Form);
  Dialog.Panel2.Parent := Form;
  Dialog.Panel2.Left := 0;
  Dialog.Panel2.Top := 0;
  Dialog.Panel2.Width := 248;
  Dialog.Panel2.Height := 77;
  Dialog.Panel2.Align := alClient;
  Dialog.Panel2.TabOrder := 0;

    Dialog.Label1 := TLabel.Create(Dialog.Panel2);
    Dialog.Label1.Parent := Dialog.Panel2;
    Dialog.Label1.Left := 8;
    Dialog.Label1.Top := 12;
    Dialog.Label1.Width := 99;
    Dialog.Label1.Height := 13;
    Dialog.Label1.Caption := 'User name';

    Dialog.Label2 := TLabel.Create(Dialog.Panel2);
    Dialog.Label2.Parent := Dialog.Panel2;
    Dialog.Label2.Left := 8;
    Dialog.Label2.Top := 39;
    Dialog.Label2.Width := 115;
    Dialog.Label2.Height := 13;
    Dialog.Label2.Caption := 'User password';

    Dialog.edtUserName := TEdit.Create(Dialog.Panel2);
    Dialog.edtUserName.Parent := Dialog.Panel2;
    Dialog.edtUserName.Left := 128;
    Dialog.edtUserName.Top := 9;
    Dialog.edtUserName.Width := 110;
    Dialog.edtUserName.Height := 21;
    Dialog.edtUserName.TabOrder := 0;

    Dialog.edtPassword := TEdit.Create(Dialog.Panel2);
    Dialog.edtPassword.Parent := Dialog.Panel2;
    Dialog.edtPassword.Left := 128;
    Dialog.edtPassword.Top := 36;
    Dialog.edtPassword.Width := 110;
    Dialog.edtPassword.Height := 21;
    Dialog.edtPassword.PasswordChar := '*';
    Dialog.edtPassword.TabOrder := 1;

    Dialog.cbSavePassword := TCheckBox.Create(Dialog.Panel2);
    Dialog.cbSavePassword.Parent := Dialog.Panel2;
    Dialog.cbSavePassword.Left := 8;
    Dialog.cbSavePassword.Top := 56;
    Dialog.cbSavePassword.Width := 129;
    Dialog.cbSavePassword.Height := 17;
    Dialog.cbSavePassword.Caption := 'Запомнить пароль';
    Dialog.cbSavePassword.TabOrder := 2;
    Dialog.cbSavePassword.Visible := False;

  Dialog.pnlButtons := TPanel.Create(Form);
  Dialog.pnlButtons.Parent := Form;
  Dialog.pnlButtons.Left := 0;
  Dialog.pnlButtons.Top := 77;
  Dialog.pnlButtons.Width := 248;
  Dialog.pnlButtons.Height := 41;
  Dialog.pnlButtons.Align := alBottom;
  Dialog.pnlButtons.TabOrder := 1;

    Dialog.btnOk := TBitBtn.Create(Dialog.pnlButtons);
    Dialog.btnOk.Parent := Dialog.pnlButtons;
    Dialog.btnOk.Left := 9;
    Dialog.btnOk.Top := 6;
    Dialog.btnOk.Width := 90;
    Dialog.btnOk.Height := 30;
    Dialog.btnOk.Caption := 'OK';
    Dialog.btnOk.Default := True;
    Dialog.btnOk.ModalResult := 1;
    Dialog.btnOk.TabOrder := 0;

    Dialog.btnCancel := TBitBtn.Create(Dialog.pnlButtons);
    Dialog.btnCancel.Parent := Dialog.pnlButtons;
    Dialog.btnCancel.Left := 149;
    Dialog.btnCancel.Top := 5;
    Dialog.btnCancel.Width := 90;
    Dialog.btnCancel.Height := 30;
    Dialog.btnCancel.Caption := 'Cancel';
    Dialog.btnCancel.TabOrder := 1;
    Dialog.btnCancel.Kind := bkCancel;

  Form.ActiveControl := Dialog.edtUserName;
end;

function _PasswordDialog_Init(var Dialog: TPasswordDialog; const Caption, Label1, Label2, Value1, Value2: string): AError;
var
  Form: TForm;
begin
  Form := Dialog.Form;
  Form.BorderStyle := bsDialog;
  Form.Caption := Caption;
  Form.ClientHeight := 135;
  Form.ClientWidth := 221;
  Form.Font.Style := [fsBold];
  Form.Position := poScreenCenter;

  Dialog.lblValue1 := TLabel.Create(Form);
  Dialog.lblValue1.Parent := Form;
  Dialog.lblValue1.Left := 14;
  Dialog.lblValue1.Top := 17;
  Dialog.lblValue1.Caption := Label1;

  Dialog.lblValue2 := TLabel.Create(Form);
  Dialog.lblValue2.Parent := Form;
  Dialog.lblValue2.Left := 12;
  Dialog.lblValue2.Top := 55;
  Dialog.lblValue2.Caption := Label2;

  Dialog.edtValue1 := TEdit.Create(Form);
  Dialog.edtValue1.Parent := Form;
  Dialog.edtValue1.Left := 80;
  Dialog.edtValue1.Top := 13;
  Dialog.edtValue1.Width := 100;
  Dialog.edtValue1.Height := 21;
  Dialog.edtValue1.TabOrder := 0;
  Dialog.edtValue1.Text := Value1;

  Dialog.edtValue2 := TEdit.Create(Form);
  Dialog.edtValue2.Parent := Form;
  Dialog.edtValue2.Left := 80;
  Dialog.edtValue2.Top := 48;
  Dialog.edtValue2.Width := 100;
  Dialog.edtValue2.Height := 21;
  Dialog.edtValue2.TabOrder := 1;
  Dialog.edtValue2.Text := Value2;

  Dialog.btnOk := TBitBtn.Create(Form);
  Dialog.btnOk.Parent := Form;
  Dialog.btnOk.Left := 12;
  Dialog.btnOk.Top := 96;
  Dialog.btnOk.Width := 77;
  Dialog.btnOk.Height := 27;
  Dialog.btnOk.TabOrder := 2;
  Dialog.btnOk.Kind := bkOK;
  Dialog.btnOk.Margin := 2;
  Dialog.btnOk.Spacing := -1;

  Dialog.btnCancel := TBitBtn.Create(Form);
  Dialog.btnCancel.Parent := Form;
  Dialog.btnCancel.Left := 115;
  Dialog.btnCancel.Top := 96;
  Dialog.btnCancel.Width := 78;
  Dialog.btnCancel.Height := 27;
  Dialog.btnCancel.Caption := 'Cancel';
  Dialog.btnCancel.TabOrder := 3;
  Dialog.btnCancel.Kind := bkCancel;
  Dialog.btnCancel.Margin := 2;
  Dialog.btnCancel.Spacing := -1;

  Form.ActiveControl := Dialog.edtValue1;
end;

function _PasswordDialog_InputBox1(const Caption, Text: APascalString;
    var Value: APascalString): ABool;
var
  Dialog: TPasswordDialog;
begin
  Dialog.Form := TForm.Create(nil);
  _PasswordDialog_Init(Dialog, Caption, Text, '', '', Value);
  try
    Dialog.lblValue2.Visible := False;
    Dialog.edtValue1.Visible := False;
    Result := (Dialog.Form.ShowModal() = mrOk);
    if Result then
    begin
      Value := Dialog.edtValue2.Text;
    end;
  finally
    Dialog.Form.Free();
  end;
end;

function _PasswordDialog_InputBox2(const Caption, Text1, Text2: APascalString;
    var Value1, Value2: APascalString): ABool;
var
  Dialog: TPasswordDialog;
begin
  Dialog.Form := TForm.Create(nil);
  _PasswordDialog_Init(Dialog, Caption, Text1, Text2, Value1, Value2);
  try
    if (Dialog.edtValue1.Text <> '') then
      Dialog.Form.ActiveControl := Dialog.edtValue2;

    Result := (Dialog.Form.ShowModal() = mrOk);
    if Result then
    begin
      Value1 := Dialog.edtValue1.Text;
      Value2 := Dialog.edtValue2.Text;
    end;
  finally
    Dialog.Form.Free();
  end;
end;

// --- AUi ---

function AUi_ExecuteColorDialog(var Color: AColor): ABool;
var
  ColorDialog: TColorDialog;
begin
  try
    ColorDialog := TColorDialog.Create(nil);
    try
      ColorDialog.Color := Color;
      Result := ColorDialog.Execute;
      if Result then
        Color := ColorDialog.Color;
    finally
      ColorDialog.Free();
    end;
  except
    Result := False;
  end;
end;

function AUi_ExecuteFontDialog(var FontName: AString_Type; var FontSize: AInt;
    var FontColor: AColor): ABool;
var
  FontNameStr: APascalString;
begin
  FontNameStr := AString_ToPascalString(FontName);
  Result := AUi_ExecuteFontDialogP(FontNameStr, FontSize, FontColor);
  AString_AssignP(FontName, FontNameStr);
end;

function AUi_ExecuteFontDialogA(FontName: AStr; MaxLen: AInt; var FontSize: AInt;
    var FontColor: AColor): ABool;
var
  FontNameStr: APascalString;
begin
  FontNameStr := AStr_ToPascalString(FontName);
  Result := AUi_ExecuteFontDialogP(FontNameStr, FontSize, FontColor);
  AStr_AssignP(FontName, FontNameStr, MaxLen);
end;

function AUi_ExecuteFontDialogP(var FontName: APascalString; var FontSize: AInt;
    var FontColor: AColor): ABool;
var
  FontDialog: TFontDialog;
begin
  try
    FontDialog := TFontDialog.Create(nil);
    try
      FontDialog.Font.Color := FontColor;
      FontDialog.Font.Name := FontName;
      FontDialog.Font.Size := FontSize;
      Result := FontDialog.Execute;
      if Result then
      begin
        FontColor := FontDialog.Font.Color;
        FontName := FontDialog.Font.Name;
        FontSize := FontDialog.Font.Size;
      end;
    finally
      FontDialog.Free;
    end;
  except
    Result := False;
  end;
end;

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
    Result := _PasswordDialog_InputBox2(Caption, Text1, Text2, Value1, Value2);
  except
    Result := False;
  end;
end;

function AUi_ExecuteInputBox3P(const Caption, Text: APascalString; var Value: APascalString): ABool;
begin
  try
    Result := _InputDialog_InputBox(Caption, Text, Value);
  except
    Result := False;
  end;
end;

function AUi_ExecuteInputBox4P(const Caption, Prompt: APascalString; var Value: APascalString): ABool;
begin
  try
    Value := Dialogs.InputBox(Caption, Prompt, Value);
    Result := True;
  except
    Result := False;
  end;
end;

function AUi_ExecuteInputQueryP(const Caption, Prompt: APascalString;
    var Value: APascalString): ABool;
var
  TmpValue: string;
begin
  try
    TmpValue := Value;
    if not(Dialogs.InputQuery(Caption, Prompt, TmpValue)) then
    begin
      Result := False;
      Exit;
    end;
    Value := TmpValue;
    Result := True;
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
    LoginDialog.Form := TForm.Create(nil);
    _LoginDialog_Init(LoginDialog);
    try
      LoginDialog.edtUserName.Text := UserName;
      if (UserName <> '') then
        LoginDialog.Form.ActiveControl := LoginDialog.edtPassword;
      Result := (LoginDialog.Form.ShowModal() = mrOk);
      if Result then
      begin
        UserName := LoginDialog.edtUserName.Text;
        Password := LoginDialog.edtPassword.Text;
      end;
    finally
      LoginDialog.Form.Free();
    end;
  except
    Result := False;
  end;
end;

function AUi_ExecuteMessageDialog2P(const Msg: APascalString; MsgDlgTypeFlag: AMessageBoxFlags;
    Flags: AMessageBoxFlags): AInt;
var
  MsgDlgType: TMsgDlgType;
  MsgDlgButtons: TMsgDlgButtons;
begin
  try
    case MsgDlgTypeFlag of
      AMessageBoxFlags_IconError: MsgDlgType := mtError;
      AMessageBoxFlags_IconQuestion: MsgDlgType := mtConfirmation;
      AMessageBoxFlags_IconWarning: MsgDlgType := mtWarning;
      AMessageBoxFlags_IconInformation: MsgDlgType := mtInformation;
      //AMessageBoxFlags_UserIcon: MsgDlgType := mtCustom
    else
      MsgDlgType := mtCustom;
    end;

    if (Flags = AMessageBoxFlags_1) then
      MsgDlgButtons := [mbYes, mbYesToAll, mbNo, mbCancel]
    else
      MsgDlgButtons := [mbYes, mbNo, mbCancel];
    Result := MessageDlg(Msg, MsgDlgType, MsgDlgButtons, 0);
  except
    Result := -1;
  end;
end;

function AUi_ExecuteOpenDialogP(const InitialDir, Filter, DefaultExt, Title: APascalString;
    var FileName: APascalString; var FilterIndex: AInt): ABool;
var
  Open: TOpenDialog;
begin
  try
    Open := TOpenDialog.Create(nil);
    try
      Open.Options := [ofNoChangeDir,ofFileMustExist,ofPathMustExist];
      Open.Initialdir := InitialDir;
      Open.Filter := Filter;
      Open.DefaultExt := DefaultExt;
      if (Length(Title) = 0) then
        Open.Title := 'Открыть'
      else
        Open.Title := Title;
      Open.FilterIndex := FilterIndex;
      Result := Open.Execute();
      if Result then
      begin
        FileName := Open.FileName;
        FilterIndex := Open.FilterIndex;
      end;
    finally
      Open.Free();
    end;
  except
    Result := False;
  end;
end;

function AUi_ExecuteOpenFileDialog(const InitialDir, Filter, Title: AString_Type;
    var FileName: AString_Type): ABool;
var
  FileNameStr: APascalString;
begin
  FileNameStr := AString_ToPascalString(FileName);
  Result := AUi_ExecuteOpenFileDialogP(
      AString_ToPascalString(InitialDir),
      AString_ToPascalString(Filter),
      AString_ToPascalString(Title),
      FileNameStr);
  AString_AssignP(FileName, FileNameStr);
end;

function AUi_ExecuteOpenFileDialogP(const InitialDir, Filter, Title: APascalString;
    var FileName: APascalString): ABool;
var
  FilterIndex: AInteger;
begin
  FilterIndex := 0;
  Result := AUi_ExecuteOpenDialogP(InitialDir, Filter, '', Title, FileName, FilterIndex);
end;

function AUi_ExecutePrinterSetupDialog(): AError;
var
  PrinterSetupDialog: TPrinterSetupDialog;
begin
  try
    PrinterSetupDialog := TPrinterSetupDialog.Create(nil);
    try
      PrinterSetupDialog.Execute();
    finally
      PrinterSetupDialog.Free();
    end;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUi_ExecuteSaveFileDialog1(const InitialDir, DefExt, DefFileName: AString_Type;
      out Value: AString_Type): AInt;
var
  S: APascalString;
begin
  S := AUi_ExecuteSaveFileDialog1P(
      AString_ToPascalString(InitialDir),
      AString_ToPascalString(DefExt),
      AString_ToPascalString(DefFileName));
  Result := AString_AssignP(Value, S);
end;

function AUi_ExecuteSaveFileDialog1P(const InitialDir, DefExt, DefFileName: APascalString): APascalString;
var
  FilterIndex: Integer;
begin
  FilterIndex := 0;
  Result := AUi_ExecuteSaveFileDialog2P(InitialDir, DefExt, DefFileName, '', FilterIndex);
end;

function AUi_ExecuteSaveFileDialog2P(const InitialDir, DefExt, DefFileName, Filter: APascalString;
    var FilterIndex: AInt): APascalString;
var
  Dialog: TSaveDialog;
begin
  try
    Dialog := TSaveDialog.Create(nil);
    try
      Dialog.InitialDir := InitialDir;
      Dialog.DefaultExt := DefExt;
      Dialog.Options := Dialog.Options + [ofNoChangeDir];
      Dialog.FileName := DefFileName;
      Dialog.Filter := Filter;
      Dialog.FilterIndex := FilterIndex;
      Dialog.Options := Dialog.Options + [ofOverwritePrompt];
      if Dialog.Execute() then
      begin
        Result := Dialog.FileName;
        FilterIndex := Dialog.FilterIndex;
      end
      else
        Result := '';
    finally
      Dialog.Free();
    end;
  except
    Result := '';
  end;
end;

function AUi_ExecuteSelectDialogP(DialogType: AInt; const SelectList: APascalString;
    out Res: AInt): ABool;
var
  Dialog: ADialog;
  Window: AWindow;
  I: AInt;
  H: AInt;
  W: AInt;
  C: AControl;
  S: APascalString;
  SSelectList: APascalString;
  MaxW: AInt;
begin
  Dialog := AUiDialog_New(AMessageBoxFlags_OkCancel);
  Window := AUiDialog_GetWindow(Dialog);
  W := AUiControl_GetClientWidth(Window);
  H := AUiControl_GetClientHeight(Window);

  C := AUiListBox_New2(Window, 1);
  AUiControl_SetAlign(C, uiAlignClient);
  MaxW := W;

  SSelectList := SelectList;
  while (Length(SSelectList) > 0) do
  begin
    I := Pos(';', SSelectList);
    if (I > 0) then
    begin
      S := Copy(SSelectList, 1, I-1);
      Delete(SSelectList, 1, I);
    end
    else
    begin
      S := SSelectList;
      SSelectList := '';
    end;
    AUiListBox_AddP(C, S);
    I := AUiControl_TextWidthP(Window, S);
    if (I > MaxW) then
      MaxW := I;
  end;

  if (MaxW > W) then
    AUiControl_SetWidth(Window, MaxW + 50);
  I := AUiListBox_GetCount(C);
  if (I * 16 + DialogButtonsBoxHeight > H) then
    AUiControl_SetHeight(Window, I * 16 + DialogButtonsBoxHeight + 20);

  Result := (AUiWindow_ShowModal2(Window) = ID_OK);
  Res := AUiListBox_GetItemIndex(C);
  AUiControl_Free(C);
  AUiDialog_Free(Dialog);
end;

function AUi_ExecuteSelectDirectoryDialogP(var Directory: APascalString): ABool;
{$IFDEF USE_JEDI}
var
  Dialog: TJvSelectDirectory;
{$ENDIF USE_JEDI}
begin
  {$IFDEF USE_JEDI}
  try
    Dialog := TJvSelectDirectory.Create(nil);
    try
      Dialog.InitialDir := Directory;
      if Dialog.Execute() then
      begin
        Directory := Dialog.Directory;
        Result := True;
      end
      else
        Result := False;
    finally
      Dialog.Free;
    end;
  except
    Result := False;
  end;
  {$ELSE}
  Result := False;
  {$ENDIF USE_JEDI}
end;

end.

