{**
@Abstract AUiDialogs
@Author Prof1983 <prof1983@ya.ru>
@Created 16.02.2009
@LastMod 14.11.2012
}
unit AUiDialogs;

{DEFINE USE_JEDI}
{$define AStdCall}

interface

uses
  {$IFDEF USE_JEDI}JvBaseDlg, JvSelectDirectory,{$ENDIF}
  Controls, Dialogs, Forms,
  ABase, ABaseTypes, AStrings, ASystem,
  AUiAboutDialog, AUiAboutDialog1, AUiAboutDialog2, AUiBase, AUiBox, AUiButtons,
  AUiConsts, AUiControls, AUiData, AUiWindows,
  fAbout, fCalendar, fDateFilter, fError, fInputDialog, fLogin, fPasswordDialog;

// --- AUi ---

function AUi_ExecuteAboutDialog(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteCalendarDialog(var Date: TDateTime; CenterX, CenterY: AInt): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteColorDialog(var Color: AColor): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteDateFilterDialog(var Group: AInt; var DateBegin, DateEnd: TDateTime): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteErrorDialog(const Caption, UserMessage,
    ExceptMessage: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteErrorDialogA(Caption, UserMessage,
    ExceptMessage: AStr): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteErrorDialogP(const Caption, UserMessage,
    ExceptMessage: APascalString): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteFontDialog(var FontName: AString_Type; var FontSize: AInt;
    var FontColor: AColor): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteFontDialogA(FontName: AStr; MaxLen: AInt; var FontSize: AInt;
    var FontColor: AColor): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteFontDialogP(var FontName: APascalString; var FontSize: AInt;
    var FontColor: AColor): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

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

function AUi_ExecuteInputBox4P(const Caption, Prompt: APascalString;
    var Value: APascalString): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteInputQueryP(const Caption, Prompt: APascalString;
    var Value: APascalString): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteLoginDialogP(var UserName, Password: APascalString;
    IsSave: ABoolean): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteMessageDialog1A(Text, Caption: AStr;
    Flags: AMessageBoxFlags): ADialogBoxCommands; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteMessageDialog1P(const Text, Caption: APascalString;
    Flags: AMessageBoxFlags): ADialogBoxCommands; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteMessageDialog2P(const Msg: APascalString; MsgDlgTypeFlag: AMessageBoxFlags;
    Flags: AMessageBoxFlags): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteOpenDialogP(const InitialDir, Filter, DefaultExt, Title: APascalString;
    var FileName: APascalString; var FilterIndex: AInteger): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteOpenFileDialogP(const InitialDir, Filter, Title: APascalString;
    var FileName: APascalString): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecutePrinterSetupDialog(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteSaveFileDialog1P(const InitialDir, DefExt, DefFileName: APascalString): APascalString; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteSaveFileDialog2P(const InitialDir, DefExt, DefFileName, Filter: APascalString;
    var FilterIndex: AInteger): APascalString; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteSelectDirectoryDialogP(var Directory: APascalString): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function AUi_InitAboutDialog1(AboutDialog: AWindow): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_InitAboutDialog2(AboutDialog: AWindow): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_NewAboutDialog(): AWindow; {$ifdef AStdCall}stdcall;{$endif}

function AUi_NewDialog(Buttons: AUiWindowButtons): ADialog; {$ifdef AStdCall}stdcall;{$endif}

// --- AUiDialog ---

function AUiDialog_AddButton02(Win: AWindow; Left, Width: AInteger; const Text: APascalString;
    OnClick: ACallbackProc02): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiDialog_AddButtonP(Win: AWindow; Left, Width: AInt; const Text: APascalString;
    OnClick: ACallbackProc): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiDialog_GetWindow(Dialog: ADialog): AWindow; {$ifdef AStdCall}stdcall;{$endif}

// --- UI_Dialog ---

procedure UI_Dialog_About(); stdcall;

function UI_Dialog_About_New(): AWindow; stdcall;

function UI_Dialog_AddButton(Win: AWindow; Left, Width: AInteger; const Text: APascalString;
    OnClick: ACallbackProc): AControl; stdcall;

function UI_Dialog_AddButton02(Win: AWindow; Left, Width: AInteger; const Text: APascalString;
    OnClick: ACallbackProc02): AControl; stdcall;

function UI_Dialog_Calendar(var Date: TDateTime; CenterX, CenterY: AInteger): ABoolean; stdcall;

function UI_Dialog_Color(var Color: AColor): ABoolean; stdcall;

function UI_Dialog_DateFilter(var Group: Integer; var DateBegin, DateEnd: TDateTime): Boolean; stdcall;

procedure UI_Dialog_Error(const Caption, UserMessage, ExceptMessage: APascalString); stdcall;

function UI_Dialog_Font(var FontName: APascalString; var FontSize: AInteger; FontColor: AColor): ABoolean; stdcall;

function UI_Dialog_GetWindow(Dialog: ADialog): AWindow; stdcall; deprecated; // Use AUiDialog_GetWindow()

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

function UI_Dialog_MessageDlg(const Msg: string; MsgDlgTypeFlag: AMessageBoxFlags;
    Flags: AMessageBoxFlags): AInteger;

function UI_Dialog_New(Buttons: AUIWindowButtons): ADialog; stdcall; deprecated; // Use AUiDialog_New()

function UI_Dialog_OpenFile(const InitialDir, Filter, Title: APascalString;
    var FileName: APascalString): ABoolean; stdcall;

function UI_Dialog_OpenFileA(const InitialDir, Filter, DefaultExt, Title: APascalString;
    var FileName: APascalString; var FilterIndex: AInteger): ABoolean; stdcall;

// Отображает окно выбора и настройки печати.
procedure UI_Dialog_PrinterSetup();

function UI_Dialog_SaveFile(const Dir, Ext, DefFileName: APascalString): APascalString; stdcall;

function UI_Dialog_SaveFileA(const InitialDir, DefExt, DefFileName, Filter: APascalString;
    var FilterIndex: AInteger): APascalString; stdcall;

function UI_Dialog_SelectDirectory(var Directory: APascalString): ABoolean; stdcall;

// --- UI_Dialogs ---

function UI_Dialogs_InputBox(const Caption, Prompt, Default: APascalString): APascalString;

function UI_Dialogs_InputQuery(const Caption, Prompt: APascalString;
    var Value: APascalString): ABoolean;

// --- Public ---

function ExecuteColorDialog(var Color: AColor): ABoolean; deprecated; // Use AUi_ExecuteColorDialog()

function ExecuteFontDialog(var FontName: APascalString; var FontSize: AInteger;
    var FontColor: AColor): ABoolean; deprecated; // Use AUi_ExecuteFontDialog()

function ExecuteOpenDialogA(const InitialDir, Filter, DefaultExt, Title: APascalString;
    var FileName: APascalString; var FilterIndex: AInteger): ABoolean; deprecated; // Use AUi_ExecuteOpenDialogA()

function ExecuteSaveFileDialog(const InitialDir, DefExt, DefFileName: APascalString): APascalString; deprecated; // Use AUi_ExecuteSaveFileDialog()

function ExecuteSaveFileDialogA(const InitialDir, DefExt, DefFileName, Filter: APascalString;
    var FilterIndex: AInteger): APascalString; deprecated; // Use AUi_ExecuteSaveFileDialog()

function ExecuteSelectDirectoryDialog(var Directory: APascalString): ABoolean; deprecated; // Use AUi_ExecuteSelectDirectoryDialog()

implementation

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
  UI_Control_SetAlign(FButtonsBox, uiAlignBottom);
  AUIControls.UI_Control_SetSize(FButtonsBox, 100, 35);
end;

function TAUiDialog.GetButtonsBox(): AControl;
begin
  Result := FButtonsBox;
end;

function TAUiDialog.GetWindow(): AControl;
begin
  Result := FWindow;
end;

{ Public }

function ExecuteColorDialog(var Color: AColor): ABoolean;
begin
  Result := AUi_ExecuteColorDialog(Color);
end;

function ExecuteFontDialog(var FontName: APascalString; var FontSize: AInteger; var FontColor: AColor): ABoolean;
begin
  Result := AUi_ExecuteFontDialogP(FontName, FontSize, FontColor);
end;

function ExecuteOpenDialogA(const InitialDir, Filter, DefaultExt, Title: APascalString;
    var FileName: APascalString; var FilterIndex: AInteger): ABoolean;
begin
  Result := AUi_ExecuteOpenDialogP(InitialDir, Filter, DefaultExt, Title, FileName, FilterIndex);
end;

function ExecuteSaveFileDialog(const InitialDir, DefExt, DefFileName: APascalString): APascalString;
begin
  Result := AUi_ExecuteSaveFileDialog1P(InitialDir, DefExt, DefFileName);
end;

function ExecuteSaveFileDialogA(const InitialDir, DefExt, DefFileName, Filter: APascalString;
    var FilterIndex: AInteger): APascalString;
begin
  Result := AUi_ExecuteSaveFileDialog2P(InitialDir, DefExt, DefFileName, Filter, FilterIndex);
end;

function ExecuteSelectDirectoryDialog(var Directory: APascalString): ABoolean;
begin
  Result := AUi_ExecuteSelectDirectoryDialogP(Directory);
end;

// --- AUi ---

function AUi_ExecuteAboutDialog(): AError;
var
  W: AWindow;
begin
  W := AUi_NewAboutDialog();
  Result := AUi_InitAboutDialog2(W);
  {try
    ShowAboutWinA(UiAboutWinMemoWidthDefault, UiAboutWinMemoHeightDefault);
    Result := 0;
  except
    Result := -1;
  end;}
end;

function AUi_ExecuteCalendarDialog(var Date: TDateTime; CenterX, CenterY: AInt): ABoolean;
begin
  try
    {$IFDEF FPC}
    Result := False;
    {$ELSE}
    Result := ShowCalendarWin(Date, CenterX, CenterY);
    {$ENDIF}
  except
    Result := False;
  end;
end;

function AUi_ExecuteColorDialog(var Color: AColor): ABoolean;
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

function AUi_ExecuteDateFilterDialog(var Group: AInt; var DateBegin, DateEnd: TDateTime): ABoolean;
{$IFNDEF FPC}
var
  FilterForm: TFilterForm;
{$ENDIF}
begin
  try
    {$IFNDEF FPC}
    FilterForm := TFilterForm.Create(nil);
    try
      FilterForm.RadioGroup1.ItemIndex := Group;
      FilterForm.DateTimePicker1.DateTime := DateBegin;
      FilterForm.DateTimePicker2.DateTime := DateEnd;
      Result := (FilterForm.ShowModal = mrOk);
      if Result then
      begin
        Group := FilterForm.RadioGroup1.ItemIndex;
        DateBegin := FilterForm.DateTimePicker1.DateTime;
        DateEnd := FilterForm.DateTimePicker2.DateTime;
      end;
    finally
      FilterForm.Free();
    end;
    {$ENDIF}
  except
    Result := False;
  end;
end;

function AUi_ExecuteErrorDialog(const Caption, UserMessage, ExceptMessage: AString_Type): AError;
begin
  Result := AUi_ExecuteErrorDialogP(
      AString_ToPascalString(Caption),
      AString_ToPascalString(UserMessage),
      AString_ToPascalString(ExceptMessage));
end;

function AUi_ExecuteErrorDialogA(Caption, UserMessage, ExceptMessage: AStr): AError;
begin
  Result := AUi_ExecuteErrorDialogP(AnsiString(Caption), AnsiString(UserMessage),
      AnsiString(ExceptMessage));
end;

function AUi_ExecuteErrorDialogP(const Caption, UserMessage, ExceptMessage: APascalString): AError;
begin
  try
    {$IFNDEF FPC}
    fError.ShowErrorA(Caption, UserMessage, ExceptMessage);
    {$ENDIF}
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUi_ExecuteFontDialog(var FontName: AString_Type; var FontSize: AInt;
    var FontColor: AColor): ABoolean;
var
  FontNameStr: APascalString;
begin
  FontNameStr := AString_ToPascalString(FontName);
  Result := AUi_ExecuteFontDialogP(FontNameStr, FontSize, FontColor);
  AString_AssignP(FontName, FontNameStr);
end;

function AUi_ExecuteFontDialogA(FontName: AStr; MaxLen: AInt; var FontSize: AInt;
    var FontColor: AColor): ABoolean;
var
  FontNameStr: APascalString;
begin
  FontNameStr := AStr_ToPascalString(FontName);
  Result := AUi_ExecuteFontDialogP(FontNameStr, FontSize, FontColor);
  AStr_AssignP(FontName, FontNameStr, MaxLen);
end;

function AUi_ExecuteFontDialogP(var FontName: APascalString; var FontSize: AInt;
    var FontColor: AColor): ABoolean;
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

function AUi_ExecuteInputBox4P(const Caption, Prompt: APascalString; var Value: APascalString): ABoolean;
begin
  try
    Value := Dialogs.InputBox(Caption, Prompt, Value);
    Result := True;
  except
    Result := False;
  end;
end;

function AUi_ExecuteInputQueryP(const Caption, Prompt: APascalString;
    var Value: APascalString): ABoolean;
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

function AUi_ExecuteMessageDialog2P(const Msg: APascalString; MsgDlgTypeFlag: AMessageBoxFlags;
    Flags: AMessageBoxFlags): AInteger;
//TMsgDlgType = (mtWarning, mtError, mtInformation, mtConfirmation, mtCustom);
//TMsgDlgBtn = (mbYes, mbNo, mbOK, mbCancel, mbAbort, mbRetry, mbIgnore, mbAll, mbNoToAll, mbYesToAll, mbHelp);
//TMsgDlgButtons = set of TMsgDlgBtn;
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
    var FileName: APascalString; var FilterIndex: AInteger): ABoolean;
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

function AUi_ExecuteOpenFileDialogP(const InitialDir, Filter, Title: APascalString;
    var FileName: APascalString): ABoolean;
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

function AUi_ExecuteSaveFileDialog1P(const InitialDir, DefExt, DefFileName: APascalString): APascalString;
var
  FilterIndex: Integer;
begin
  FilterIndex := 0;
  Result := AUi_ExecuteSaveFileDialog2P(InitialDir, DefExt, DefFileName, '', FilterIndex);
end;

function AUi_ExecuteSaveFileDialog2P(const InitialDir, DefExt, DefFileName, Filter: APascalString;
    var FilterIndex: AInteger): APascalString;
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

function AUi_ExecuteSelectDirectoryDialogP(var Directory: APascalString): ABoolean;
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

function AUi_InitAboutDialog1(AboutDialog: AWindow): AError;
begin
  if not(TObject(AboutDialog) is TAboutForm) then
  begin
    Result := -2;
    Exit;
  end;

  try
    Result := AboutForm_Init1(TAboutForm(AboutDialog).FAboutForm);
  except
    Result := -1;
  end;
end;

function AUi_InitAboutDialog2(AboutDialog: AWindow): AError;
begin
  if not(TObject(AboutDialog) is TAboutForm) then
  begin
    Result := -2;
    Exit;
  end;

  try
    Result := AboutForm_Init2(TAboutForm(AboutDialog).FAboutForm, AUiAboutFlags_ShowAll + AUiAboutFlags_NoShowComment,
        UiAboutWinMemoWidthDefault, UiAboutWinMemoHeightDefault);
  except
    Result := -1;
  end;
end;

function AUi_NewAboutDialog(): AWindow;
var
  Form: TAboutForm;
begin
  try
    Form := TAboutForm.Create(nil);
    Result := AWindow(Form);
  except
    Result := 0;
  end;
end;

function AUi_NewDialog(Buttons: AUiWindowButtons): ADialog;
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
    if (Buttons = MB_OK) then
    begin
      Button := AUiButton_New(Window);
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

// --- AUiDialog ---

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

function AUiDialog_GetWindow(Dialog: ADialog): AWindow;
begin
  try
    Result := TAUiDialog(Dialog).GetWindow();
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

function UI_Dialogs_InputQuery(const Caption, Prompt: APascalString;
    var Value: APascalString): ABoolean;
begin
  Result := AUi_ExecuteInputQueryP(Caption, Prompt, Value);
end;

// --- UI_Dialog  ---

procedure UI_Dialog_About();
begin
  AUi_ExecuteAboutDialog();
end;

function UI_Dialog_About_New(): AWindow;
begin
  Result := AUi_NewAboutDialog();
end;

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

function UI_Dialog_Calendar(var Date: TDateTime; CenterX, CenterY: AInteger): ABoolean;
begin
  Result := AUi_ExecuteCalendarDialog(Date, CenterX, CenterY);
end;

function UI_Dialog_Color(var Color: AColor): ABoolean;
begin
  Result := AUi_ExecuteColorDialog(Color);
end;

function UI_Dialog_DateFilter(var Group: Integer; var DateBegin, DateEnd: TDateTime): Boolean;
begin
  Result := AUi_ExecuteDateFilterDialog(Group, DateBegin, DateEnd);
end;

procedure UI_Dialog_Error(const Caption, UserMessage, ExceptMessage: APascalString);
begin
  AUi_ExecuteErrorDialogP(Caption, UserMessage, ExceptMessage);
end;

function UI_Dialog_Font(var FontName: APascalString; var FontSize: AInteger; FontColor: AColor): ABoolean;
begin
  Result := AUi_ExecuteFontDialogP(FontName, FontSize, FontColor);
end;

function UI_Dialog_GetWindow(Dialog: ADialog): AWindow;
begin
  Result := AUiDialog_GetWindow(Dialog);
end;

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

function UI_Dialog_MessageDlg(const Msg: string; MsgDlgTypeFlag: AMessageBoxFlags; Flags: AMessageBoxFlags): AInteger;
begin
  Result := AUi_ExecuteMessageDialog2P(Msg, MsgDlgTypeFlag, Flags);
end;

function UI_Dialog_New(Buttons: AUIWindowButtons): ADialog;
begin
  Result := AUi_NewDialog(Buttons);
end;

function UI_Dialog_OpenFile(const InitialDir, Filter, Title: APascalString;
    var FileName: APascalString): Boolean;
begin
  Result := AUi_ExecuteOpenFileDialogP(InitialDir, Filter, Title, FileName);
end;

function UI_Dialog_OpenFileA(const InitialDir, Filter, DefaultExt, Title: APascalString;
    var FileName: APascalString; var FilterIndex: AInteger): ABoolean;
begin
  Result := AUi_ExecuteOpenDialogP(InitialDir, Filter, DefaultExt, Title, FileName, FilterIndex);
end;

procedure UI_Dialog_PrinterSetup();
begin
  AUi_ExecutePrinterSetupDialog();
end;

function UI_Dialog_SaveFile(const Dir, Ext, DefFileName: APascalString): APascalString;
begin
  Result := AUi_ExecuteSaveFileDialog1P(Dir, Ext, DefFileName);
end;

function UI_Dialog_SaveFileA(const InitialDir, DefExt, DefFileName, Filter: APascalString; var FilterIndex: AInteger): APascalString;
begin
  Result := AUi_ExecuteSaveFileDialog2P(InitialDir, DefExt, DefFileName, Filter, FilterIndex);
end;

function UI_Dialog_SelectDirectory(var Directory: APascalString): ABoolean;
begin
  Result := AUi_ExecuteSelectDirectoryDialogP(Directory);
end;

end.

