{**
@Abstract()
@Author(Prof1983 prof1983@ya.ru)
@Created(16.02.2009)
@LastMod(25.10.2011)
@Version(0.5)
}
unit AUiDialogs;

{DEFINE USE_JEDI}

interface

uses
  {$IFDEF USE_JEDI}JvBaseDlg, JvSelectDirectory,{$ENDIF}
  Dialogs, ABase, ABaseTypes,
  AUiBase, AUiBox, AUiButton, AUiControls, AUiWindows;

function ExecuteColorDialog(var Color: AColor): ABoolean; stdcall;
function ExecuteFontDialog(var FontName: APascalString; var FontSize: AInteger; var FontColor: AColor): ABoolean; stdcall;
function ExecuteOpenDialogA(const InitialDir, Filter, DefaultExt, Title: APascalString; var FileName: APascalString; var FilterIndex: AInteger): ABoolean; stdcall;
function ExecuteSaveFileDialog(const InitialDir, DefExt, DefFileName: APascalString): APascalString; stdcall;
//function ExecuteSaveFileDialogA(const InitialDir, DefExt, DefFileName, Filter: AString_Type; var FilterIndex: AInteger; out Value: AString_Type): AInteger;
function ExecuteSaveFileDialogA(const InitialDir, DefExt, DefFileName, Filter: APascalString; var FilterIndex: AInteger): APascalString; stdcall;
//function ExecuteSelectDirectoryDialog(var Directory: AString): ABoolean;
function ExecuteSelectDirectoryDialog(var Directory: APascalString): ABoolean; stdcall;

function UI_Dialog_GetWindow(Dialog: ADialog): AWindow;
function UI_Dialog_New(Buttons: AUIWindowButtons): ADialog;

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

function ExecuteColorDialog(var Color: AColor): ABoolean; stdcall;
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

function ExecuteFontDialog(var FontName: APascalString; var FontSize: AInteger; var FontColor: AColor): ABoolean; stdcall;
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

function ExecuteOpenDialogA(const InitialDir, Filter, DefaultExt, Title: APascalString; var FileName: APascalString; var FilterIndex: AInteger): ABoolean; stdcall;
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

function ExecuteSaveFileDialog(const InitialDir, DefExt, DefFileName: APascalString): APascalString; stdcall;
var
  FilterIndex: Integer;
begin
  FilterIndex := 0;
  Result := ExecuteSaveFileDialogA(InitialDir, DefExt, DefFileName, '', FilterIndex);
end;

{
function ExecuteSaveFileDialogA(const InitialDir, DefExt, DefFileName, Filter: AString_Type; var FilterIndex: AInteger; out Value: AString_Type): AInteger;
begin
  Result := String_AssignW(Value, ExecuteSaveFileDialogAW(
      String_ToWideString(InitialDir),
      String_ToWideString(DefExt),
      String_ToWideString(DefFileName),
      String_ToWideString(Filter),
      FilterIndex));
end;
}

function ExecuteSaveFileDialogA(const InitialDir, DefExt, DefFileName, Filter: APascalString; var FilterIndex: AInteger): APascalString; stdcall;
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

function ExecuteSelectDirectoryDialog(var Directory: APascalString): ABoolean; stdcall;
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

function UI_Dialog_GetWindow(Dialog: ADialog): AWindow;
begin
  Result := TAUIDialog(Dialog).GetWindow;
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

end.
 
