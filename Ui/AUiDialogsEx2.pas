{**
@Author Prof1983 <prof1983@ya.ru>
@Created 16.02.2009
@LastMod 16.04.2013
}
unit AUiDialogsEx2;

{DEFINE USE_JEDI}
{$define AStdCall}

interface

uses
  {$IFDEF USE_JEDI}JvBaseDlg, JvSelectDirectory,{$ENDIF}
  Controls, Dialogs,
  ABase,
  ABaseTypes,
  AStringBaseUtils,
  AStringMain,
  AUiAboutDialog,
  AUiAboutDialog1,
  AUiAboutDialog2,
  AUiBase,
  AUiBox,
  AUiControls,
  AUiData,
  AUiDialogs,
  AUiListBox,
  AUiWindows,
  fAbout, fCalendar, fDateFilter, fError;

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

function AUi_ExecuteInputBox4P(const Caption, Prompt: APascalString;
    var Value: APascalString): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteInputQueryP(const Caption, Prompt: APascalString;
    var Value: APascalString): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteMessageDialog2P(const Msg: APascalString; MsgDlgTypeFlag: AMessageBoxFlags;
    Flags: AMessageBoxFlags): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteOpenDialogP(const InitialDir, Filter, DefaultExt, Title: APascalString;
    var FileName: APascalString; var FilterIndex: AInteger): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteOpenFileDialog(const InitialDir, Filter, Title: AString_Type;
    var FileName: AString_Type): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteOpenFileDialogP(const InitialDir, Filter, Title: APascalString;
    var FileName: APascalString): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecutePrinterSetupDialog(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteSaveFileDialog1(const InitialDir, DefExt, DefFileName: AString_Type;
      out Value: AString_Type): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteSaveFileDialog1P(const InitialDir, DefExt, DefFileName: APascalString): APascalString; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ExecuteSaveFileDialog2P(const InitialDir, DefExt, DefFileName, Filter: APascalString;
    var FilterIndex: AInteger): APascalString; {$ifdef AStdCall}stdcall;{$endif}

{** Select one item by SelectList
    @SelectList - Example: "Item 1;Item 2;Item 3" }
function AUi_ExecuteSelectDialogP(DialogType: AInt; const SelectList: APascalString;
    out Res: AInt): ABoolean;

function AUi_ExecuteSelectDirectoryDialogP(var Directory: APascalString): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function AUi_InitAboutDialog1(AboutDialog: AWindow): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_InitAboutDialog2(AboutDialog: AWindow): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_NewAboutDialog(): AWindow; {$ifdef AStdCall}stdcall;{$endif}

// --- UI_Dialog ---

procedure UI_Dialog_About(); stdcall;

function UI_Dialog_About_New(): AWindow; stdcall;

function UI_Dialog_Calendar(var Date: TDateTime; CenterX, CenterY: AInteger): ABoolean; stdcall;

function UI_Dialog_Color(var Color: AColor): ABoolean; stdcall;

function UI_Dialog_DateFilter(var Group: Integer; var DateBegin, DateEnd: TDateTime): Boolean; stdcall;

procedure UI_Dialog_Error(const Caption, UserMessage, ExceptMessage: APascalString); stdcall;

function UI_Dialog_Font(var FontName: APascalString; var FontSize: AInteger; FontColor: AColor): ABoolean; stdcall;

function UI_Dialog_GetWindow(Dialog: ADialog): AWindow; stdcall; deprecated; // Use AUiDialog_GetWindow()

function UI_Dialog_MessageDlg(const Msg: string; MsgDlgTypeFlag: AMessageBoxFlags;
    Flags: AMessageBoxFlags): AInteger;

function UI_Dialog_New(Buttons: AUIWindowButtons): ADialog; stdcall; deprecated; // Use AUiDialog_New()

function UI_Dialog_OpenFile(const InitialDir, Filter, Title: APascalString;
    var FileName: APascalString): ABoolean; stdcall;

function UI_Dialog_OpenFileA(const InitialDir, Filter, DefaultExt, Title: APascalString;
    var FileName: APascalString; var FilterIndex: AInteger): ABoolean; stdcall;

// ���������� ���� ������ � ��������� ������.
procedure UI_Dialog_PrinterSetup();

function UI_Dialog_SaveFile(const Dir, Ext, DefFileName: APascalString): APascalString; stdcall;

function UI_Dialog_SaveFileA(const InitialDir, DefExt, DefFileName, Filter: APascalString;
    var FilterIndex: AInteger): APascalString; stdcall;

function UI_Dialog_SelectDirectory(var Directory: APascalString): ABoolean; stdcall;

// --- UI_Dialogs ---

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

function AUi_ExecuteMessageDialog2P(const Msg: APascalString; MsgDlgTypeFlag: AMessageBoxFlags;
    Flags: AMessageBoxFlags): AInteger;
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
        Open.Title := '�������'
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
    var FileName: AString_Type): ABoolean;
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

function AUi_ExecuteSaveFileDialog1(const InitialDir, DefExt, DefFileName: AString_Type;
      out Value: AString_Type): AInteger;
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

function AUi_ExecuteSelectDialogP(DialogType: AInt; const SelectList: APascalString;
    out Res: AInt): ABoolean;
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

// --- UI_Dialogs ---

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

function UI_Dialog_MessageDlg(const Msg: string; MsgDlgTypeFlag: AMessageBoxFlags; Flags: AMessageBoxFlags): AInteger;
begin
  Result := AUi_ExecuteMessageDialog2P(Msg, MsgDlgTypeFlag, Flags);
end;

function UI_Dialog_New(Buttons: AUIWindowButtons): ADialog;
begin
  Result := AUiDialog_New(Buttons);
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
