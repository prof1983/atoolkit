{**
@Abstract AUiDialogs
@Author Prof1983 <prof1983@ya.ru>
@Created 16.02.2009
@LastMod 22.08.2012
}
unit AUiDialogs;

{DEFINE USE_JEDI}

interface

uses
  {$IFDEF USE_JEDI}JvBaseDlg, JvSelectDirectory,{$ENDIF}
  Controls, Dialogs,
  ABase, ABaseTypes,
  AUiBase, AUiBox, AUiButton, AUiConsts, AUiControls, AUiData, AUiWindows,
  fAbout, fCalendar, fDateFilter, fError;

// --- AUi ---

function AUi_ExecuteAboutDialog(): AError;

function AUi_ExecuteCalendarDialog(var Date: TDateTime; CenterX, CenterY: AInt): ABoolean;

function AUi_ExecuteColorDialog(var Color: AColor): ABoolean;

function AUi_ExecuteDateFilterDialog(var Group: AInt; var DateBegin, DateEnd: TDateTime): ABoolean;

function AUi_ExecuteErrorDialogP(const Caption, UserMessage, ExceptMessage: APascalString): AError;

function AUi_ExecuteFontDialog(var FontName: APascalString; var FontSize: AInt; var FontColor: AColor): ABoolean;

function AUi_NewAboutDialog(): AWindow;

// --- AUiDialog ---

function AUiDialog_AddButtonP(Win: AWindow; Left, Width: AInt; const Text: APascalString;
    OnClick: ACallbackProc): AControl;

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

  FButtonsBox := AUIBox.UI_Box_New(FWindow, 0);
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
  Result := AUi_ExecuteFontDialog(FontName, FontSize, FontColor);
end;

function ExecuteOpenDialogA(const InitialDir, Filter, DefaultExt, Title: APascalString;
    var FileName: APascalString; var FilterIndex: AInteger): ABoolean;
var
  Open: TOpenDialog;
begin
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
    Result := Open.Execute;
    if Result then
    begin
      FileName := Open.FileName;
      FilterIndex := Open.FilterIndex;
    end;
  finally
    Open.Free;
  end;
end;

function ExecuteSaveFileDialog(const InitialDir, DefExt, DefFileName: APascalString): APascalString;
var
  FilterIndex: Integer;
begin
  FilterIndex := 0;
  Result := ExecuteSaveFileDialogA(InitialDir, DefExt, DefFileName, '', FilterIndex);
end;

function ExecuteSaveFileDialogA(const InitialDir, DefExt, DefFileName, Filter: APascalString;
    var FilterIndex: AInteger): APascalString;
var
  Dialog: TSaveDialog;
begin
  Dialog := TSaveDialog.Create(nil);
  try
    Dialog.InitialDir := InitialDir;
    Dialog.DefaultExt := DefExt;
    Dialog.Options := Dialog.Options + [ofNoChangeDir];
    Dialog.FileName := DefFileName;
    Dialog.Filter := Filter;
    Dialog.FilterIndex := FilterIndex;
    Dialog.Options := Dialog.Options + [ofOverwritePrompt];
    if Dialog.Execute then
    begin
      Result := Dialog.FileName;
      FilterIndex := Dialog.FilterIndex;
    end
    else
      Result := '';
  finally
    Dialog.Free();
  end;
end;

function ExecuteSelectDirectoryDialog(var Directory: APascalString): ABoolean;
{$IFDEF USE_JEDI}
var
  Dialog: TJvSelectDirectory;
{$ENDIF USE_JEDI}
begin
  {$IFDEF USE_JEDI}
  Dialog := TJvSelectDirectory.Create(nil);
  try
    Dialog.InitialDir := Directory;
    if Dialog.Execute then
    begin
      Directory := Dialog.Directory;
      Result := True;
    end
    else
      Result := False;
  finally
    Dialog.Free;
  end;
  {$ELSE}
  Result := False;
  {$ENDIF USE_JEDI}
end;

// --- AUi ---

function AUi_ExecuteAboutDialog(): AError;
begin
  try
    ShowAboutWinA(UiAboutWinMemoWidthDefault, UiAboutWinMemoHeightDefault);
    Result := 0;
  except
    Result := -1;
  end;
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

function AUi_ExecuteFontDialog(var FontName: APascalString; var FontSize: AInt; var FontColor: AColor): ABoolean;
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

function AUi_NewAboutDialog(): AWindow;
var
  Form: TAboutForm;
begin
  try
    Form := TAboutForm.Create(nil);
    try
      Form.InitA(UIAboutWinMemoWidthDefault, UIAboutWinMemoHeightDefault);
    except
      Form.Free;
      Form := nil;
    end;
    Result := AWindow(Form);
  except
    Result := 0;
  end;
end;

// --- AUiDialog ---

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

// --- UI_Dialogs ---

function UI_Dialogs_InputBox(const Caption, Prompt, Default: APascalString): APascalString;
begin
  Result := Dialogs.InputBox(Caption, Prompt, Default);
end;

function UI_Dialogs_InputQuery(const Caption, Prompt: APascalString;
    var Value: APascalString): ABoolean;
var
  TmpValue: string;
begin
  TmpValue := Value;
  if not(Dialogs.InputQuery(Caption, Prompt, TmpValue)) then
  begin
    Result := False;
    Exit;
  end;
  Value := TmpValue;
  Result := True;
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
  if (Win <> 0) and (TObject(Win) is TAboutForm) then
    Result := TAboutForm(Win).AddButton02(Left, Width, Text, OnClick)
  else
    Result := 0;
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
  Result := Dialog_FontP(FontName, FontSize, FontColor);
end;

function UI_Dialog_GetWindow(Dialog: ADialog): AWindow;
begin
  Result := TAUIDialog(Dialog).GetWindow;
end;

function UI_Dialog_InputBox(const Text: APascalString; var Value: APascalString): Boolean;
begin
  Result := UI_Dialog_InputBox3(ASystem.Info_GetTitleWS(), Text, Value);
end;

function UI_Dialog_InputBox2(const Caption, Text1, Text2: APascalString; var Value1, Value2: APascalString): ABoolean;
begin
  {$IFNDEF FPC}
  Result := fPasswordDialog.InputBox2(Caption, Text1, Text2, Value1, Value2);
  {$ENDIF}
end;

function UI_Dialog_InputBox3(const Caption, Text: APascalString; var Value: APascalString): Boolean;
begin
  {$IFNDEF FPC}
  Result := fInputDialog.InputBox(Caption, Text, Value);
  {$ENDIF}
end;

function UI_Dialog_InputBoxA(const Caption, Text: APascalString; var Value: APascalString): Boolean;
begin
  Result := UI_Dialog_InputBox3(Caption, Text, Value);
end;

function UI_Dialog_Login(var UserName, Password: APascalString; IsSave: ABoolean): ABoolean;
{$IFNDEF FPC}
var
  fmLogin: TLoginForm;
{$ENDIF}
begin
  {$IFNDEF FPC}
  fmLogin := TLoginForm.Create(nil);
  try
    fmLogin.UserName := UserName;
    Result := (fmLogin.ShowModal = mrOk);
    if Result then
    begin
      UserName := fmLogin.UserName;
      Password := fmLogin.UserPassword;
    end;
  finally
    fmLogin.Free();
  end;
  {$ENDIF}
end;

function UI_Dialog_Message(const Text, Caption: APascalString; Flags: AMessageBoxFlags): ADialogBoxCommands;
var
  PrevCursor: TCursor;
begin
  PrevCursor := Screen.Cursor;
  Screen.Cursor := crDefault;
  Result := Application.MessageBox(PChar(string(Text)), PChar(string(Caption)), Flags);
  {$IFNDEF UNIX}
  //Result := Windows.MessageBox(Application.Handle{0}, PChar(string(Text)), PChar(string(Caption)), Flags);
  {$ENDIF}
  Screen.Cursor := PrevCursor;
end;

function UI_Dialog_MessageDlg(const Msg: string; MsgDlgTypeFlag: AMessageBoxFlags; Flags: AMessageBoxFlags): AInteger;
//TMsgDlgType = (mtWarning, mtError, mtInformation, mtConfirmation, mtCustom);
//TMsgDlgBtn = (mbYes, mbNo, mbOK, mbCancel, mbAbort, mbRetry, mbIgnore, mbAll, mbNoToAll, mbYesToAll, mbHelp);
//TMsgDlgButtons = set of TMsgDlgBtn;
var
  MsgDlgType: TMsgDlgType;
  MsgDlgButtons: TMsgDlgButtons;
begin
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
end;

function UI_Dialog_New(Buttons: AUIWindowButtons): ADialog;
var
  Button: AControl;
  Dialog: TAUIDialog;
  Window: AControl;
  Box: AControl;
begin
  Dialog := TAUIDialog.Create;
  Box := Dialog.GetButtonsBox;
  Window := UI_Dialog_GetWindow(ADialog(Dialog));
  if (Buttons = MB_OK) then
  begin
    Button := UI_Button_New(Window);
    AUIControls.UI_Control_SetTextP(Button, cOkText);
    AUIControls.UI_Control_SetPosition(Button, 5, 5);
    UI_Button_SetKind(Button, uibkOk);
  end
  else if (Buttons = MB_OKCANCEL) then
  begin
    Button := UI_Button_New(Box);
    AUIControls.UI_Control_SetTextP(Button, cOkText);
    AUIControls.UI_Control_SetPosition(Button, 5, 5);
    UI_Button_SetKind(Button, uibkOk);

    Button := UI_Button_New(Box);
    AUIControls.UI_Control_SetTextP(Button, cCancelText);
    AUIControls.UI_Control_SetPosition(Button, 90, 5);
    UI_Button_SetKind(Button, uibkCancel);
  end
  else if (Buttons = MB_ApplyOkCancel) then
  begin
    Button := UI_Button_New(Box);
    AUIControls.UI_Control_SetPosition(Button, 5, 5);
    AUIControls.UI_Control_SetTextP(Button, cApplyText);

    Button := UI_Button_New(Box);
    AUIControls.UI_Control_SetPosition(Button, 90, 5);
    UI_Button_SetKind(Button, uibkOk);
    AUIControls.UI_Control_SetTextP(Button, cOkText);

    Button := UI_Button_New(Box);
    AUIControls.UI_Control_SetPosition(Button, 175, 5);
    UI_Button_SetKind(Button, uibkCancel);
    AUIControls.UI_Control_SetTextP(Button, cCancelText);
  end;
  Result := ADialog(Dialog);
end;

function UI_Dialog_OpenFile(const InitialDir, Filter, Title: APascalString; var FileName: APascalString): Boolean;
var
  FilterIndex: Integer;
begin
  FilterIndex := 0;
  Result := AUIDialogs.ExecuteOpenDialogA(InitialDir, Filter, '', Title, FileName, FilterIndex);
end;

function UI_Dialog_OpenFileA(const InitialDir, Filter, DefaultExt, Title: APascalString; var FileName: APascalString; var FilterIndex: AInteger): ABoolean;
begin
  Result := AUIDialogs.ExecuteOpenDialogA(InitialDir, Filter, DefaultExt, Title, FileName, FilterIndex);
end;

procedure UI_Dialog_PrinterSetup();
var
  PrinterSetupDialog: TPrinterSetupDialog;
begin
  PrinterSetupDialog := TPrinterSetupDialog.Create(nil);
  try
    PrinterSetupDialog.Execute();
  finally
    PrinterSetupDialog.Free();
  end;
end;

function UI_Dialog_SaveFile(const Dir, Ext, DefFileName: APascalString): APascalString;
begin
  Result := AUIDialogs.ExecuteSaveFileDialog(Dir, Ext, DefFileName);
end;

function UI_Dialog_SaveFileA(const InitialDir, DefExt, DefFileName, Filter: APascalString; var FilterIndex: AInteger): APascalString;
begin
  Result := ExecuteSaveFileDialogA(InitialDir, DefExt, DefFileName, Filter, FilterIndex);
end;

function UI_Dialog_SelectDirectory(var Directory: APascalString): ABoolean;
begin
  Result := Dialog_SelectDirectoryP(Directory);
end;

end.
 
