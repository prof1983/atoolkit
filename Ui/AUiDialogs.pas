{**
@Abstract AUiDialogs
@Author Prof1983 <prof1983@ya.ru>
@Created 16.02.2009
@LastMod 30.07.2012
}
unit AUiDialogs;

{DEFINE USE_JEDI}

interface

uses
  {$IFDEF USE_JEDI}JvBaseDlg, JvSelectDirectory,{$ENDIF}
  Dialogs, ABase, ABaseTypes, 
  AUiBase, AUiBox, AUiButton, AUiConsts, AUiControls, AUiWindows;

// TODO: Убрать stdcall

function ExecuteColorDialog(var Color: AColor): ABoolean;
function ExecuteFontDialog(var FontName: APascalString; var FontSize: AInteger; var FontColor: AColor): ABoolean;
function ExecuteOpenDialogA(const InitialDir, Filter, DefaultExt, Title: APascalString; var FileName: APascalString; var FilterIndex: AInteger): ABoolean;
function ExecuteSaveFileDialog(const InitialDir, DefExt, DefFileName: APascalString): APascalString;
function ExecuteSaveFileDialogA(const InitialDir, DefExt, DefFileName, Filter: APascalString; var FilterIndex: AInteger): APascalString;
function ExecuteSelectDirectoryDialog(var Directory: APascalString): ABoolean;

function UI_Dialog_GetWindow(Dialog: ADialog): AWindow;

function UI_Dialog_MessageDlg(const Msg: string; MsgDlgTypeFlag: AMessageBoxFlags; Flags: AMessageBoxFlags): AInteger;

function UI_Dialog_New(Buttons: AUIWindowButtons): ADialog;

function UI_Dialogs_InputBox(const Caption, Prompt, Default: APascalString): APascalString;

function UI_Dialogs_InputQuery(const Caption, Prompt: APascalString;
    var Value: APascalString): ABoolean;

// Отображает окно выбора и настройки печати.
procedure UI_Dialog_PrinterSetup();

implementation

{ TAUIDialog }

type
  TAUIDialog = class
  private
    FButtonsBox: AControl;
    FWindow: AControl;
  public
    function GetButtonsBox: AControl;
    function GetWindow: AControl;
  public
    constructor Create;
  end;

{ TAUIDialog }

constructor TAUIDialog.Create;
begin
  FWindow := UI_Window_New();

  FButtonsBox := AUIBox.UI_Box_New(FWindow, 0);
  UI_Control_SetAlign(FButtonsBox, uiAlignBottom);
  AUIControls.UI_Control_SetSize(FButtonsBox, 100, 35);
end;

function TAUIDialog.GetButtonsBox: AControl;
begin
  Result := FButtonsBox;
end;

function TAUIDialog.GetWindow: AControl;
begin
  Result := FWindow;
end;

{ Public }

function ExecuteColorDialog(var Color: AColor): ABoolean;
var
  ColorDialog: TColorDialog;
begin
  ColorDialog := TColorDialog.Create(nil);
  try
    ColorDialog.Color := Color;
    Result := ColorDialog.Execute;
    if Result then
      Color := ColorDialog.Color;
  finally
    ColorDialog.Free;
  end;
end;

function ExecuteFontDialog(var FontName: APascalString; var FontSize: AInteger; var FontColor: AColor): ABoolean;
var
  FontDialog: TFontDialog;
begin
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

{ UI_Dialog }

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

function UI_Dialog_GetWindow(Dialog: ADialog): AWindow;
begin
  Result := TAUIDialog(Dialog).GetWindow;
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

end.
 
