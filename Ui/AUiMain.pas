{**
@Abstract AUi common functions
@Author Prof1983 <prof1983@ya.ru>
@Created 26.10.2011
@LastMod 19.04.2013
}
unit AUiMain;

{$I A.inc}
{$I Defines.inc}

{define AStdCall}
{define UseMainTrayIcon}

{$IFDEF OLDMAINFORM2}
  {$DEFINE OLDMAINFORM}
{$ENDIF}

{$ifndef NoEvents}
  {$define UseEvents}
{$endif}

{$ifndef NoMainWindow}
  {$define UseMainWindow}
{$endif}

{$ifndef NoRuntime}
  {$define UseRuntime}
{$endif}

{$ifndef NoSettings}
  {$define UseSettings}
{$endif}

interface

uses
  Controls,
  Forms,
  Graphics,
  ShellApi,
  Windows,
  ABase,
  ABaseTypes,
  {$ifdef UseEvents}AEventsMain,{$endif}
  {$ifdef UseRuntime}ARuntimeMain,{$endif}
  {$ifdef UseSettings}ASettingsMain,{$endif}
  AStringMain,
  ASystemMain,
  {$IFDEF OLDMAINFORM}fMain,{$ENDIF}
  AUiBase,
  AUiData,
  AUiDialogsEx1,
  AUiErrorDialog,
  {$ifdef UseMainWindow}
  AUiMainWindow,
  AUiMainWindowData,
  AUiMainWindowEventsObj,
  {$endif}
  {$ifdef UseMainTrayIcon}AUiTrayIcon,{$endif}
  AUtilsMain;

// --- AUi ---

function AUi_AddObject(Value: AInt): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AUi_CreateMainForm(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_Fin(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_GetIsShowApp(): ABool; {$ifdef AStdCall}stdcall;{$endif}

function AUi_GetMainMenuItem(): AMenuItem; {$ifdef AStdCall}stdcall;{$endif}

function AUi_GetMainToolBar(): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUi_GetMainTrayIcon(): ATrayIcon; {$ifdef AStdCall}stdcall;{$endif}

{** ���������� ������������� �������� ���� ��������� }
function AUi_GetMainWindow(): AWindow; {$ifdef AStdCall}stdcall;{$endif}

function AUi_Init(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ProcessMessages(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_Run(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_SetAboutMemoDefaultSize(Width, Height: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_SetHideOnClose(Value: ABool): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_SetIsShowApp(Value: ABool): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_SetMainToolBar(ToolBar: AControl): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_SetOnAboutClick(Value: AProc): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_SetOnMainFormCreate(Value: AProc): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_SetProgramState(State: AUiProgramState): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ShellExecute(const Operation, FileName, Parameters, Directory: AString_Type): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ShellExecuteA(Operation, FileName, Parameters, Directory: AStr): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ShellExecuteP(const Operation, FileName, Parameters, Directory: APascalString): AInt;

{** ���������� ���������� ���������� }
function AUi_ShowHelp(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ShowHelp2(const FileName: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

{** ���������� ���������� ���������� }
function AUi_ShowHelp2P(const FileName: APascalString): AError;

function AUi_Shutdown(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_TextWidthP(const S, FontName: APascalString; FontSize: AInt): AInt;

// --- UI ---

function UI_Object_Add(Value: AInteger): AInteger; stdcall; deprecated {$ifdef ADeprText}'Use AUi_AddObject()'{$endif};

implementation

// --- Events ---

function DoProcessMessages(): AError; stdcall;
begin
  try
    Application.ProcessMessages();
    Result := 0;
  except
    Result := -1;
  end;
end;

function DoRun(): AError; stdcall;
begin
  {$ifdef UseSettings}
  if (FConfig <> 0) then
    AUiMainWindow_LoadConfig(FConfig);
  {$endif}
  Application.Run();
  Result := 0;
end;

function DoShowErrorA(Caption, UserMessage, ExceptMessage: AStr): AError; stdcall;
begin
  Result := AUi_ExecuteErrorDialogA(Caption, UserMessage, ExceptMessage);
end;

function DoShowMessageA(Text, Caption: AStr; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;
begin
  Result := AUi_ExecuteMessageDialog1A(Text, Caption, Flags);
end;

function DoShutdown(): AError; stdcall;
begin
  Result := AUi_Shutdown();
end;

// --- AUi ---

function AUi_AddObject(Value: AInt): AInt;
begin
  if (Value = 0) then
  begin
    Result := 0;
    Exit;
  end;
  try
    if not(TObject(Value) is TObject) then
    begin
      Result := 0;
      Exit;
    end;
    Result := AddObject(TObject(Value));
  except
    Result := 0;
  end;
end;

function AUi_CreateMainForm(): AError;
var
  MainForm: TForm;
begin
  Application.CreateForm({$IFDEF OLDMAINFORM}TMainForm{$ELSE}TForm{$ENDIF}, MainForm);
  MainForm.Left := 0;
  MainForm.Top := 0;
  {$IFDEF OLDMAINFORM}
    _MainWindow_Create(MainForm, MainWindowFormatCreateMenu or MainWindowFormatCreateToolBar or MainWindowFormatCreateStatusBar, ASystem_GetConfig());
    FMainWindow := AddObject(MainForm);
  {$ELSE}
    FMainWindow := AddObject(MainForm);
    MainForm.Name := 'MainForm';
    MainForm.Caption := ASystem_GetProgramNameP();
    {$ifdef UseMainWindow}
    AUiMainWindow_Create(AWindow(MainForm), MainWindowFormatCreateAll, ASystem_GetConfig());
    if not(Assigned(UiEventsObj)) then
      UiEventsObj := TUiEventsObj.Create();
    MainForm.OnCloseQuery := UiEventsObj.MainFormCloseQuery;
    {$endif}
  {$ENDIF}
  AddObject(MainForm.Menu);
  Result := 0;
end;

function AUi_Fin(): AError;
begin
  {$ifdef UseEvents}
  AEvent_Invoke(FOnDone, 0);
  {$endif}

  try
    if (FMainTrayIcon <> 0) then
    begin
      {$ifdef UseMainTrayIcon}
      AUiTrayIcon_Free(FMainTrayIcon);
      {$endif}
      FMainTrayIcon := 0;
    end;
    SetLength(FObjects, 0);
    SetLength(FMenuItems, 0);
  except
  end;

  {$ifdef UseMainWindow}
  AUiMainWindow_Shutdown();
  {$endif}

  ASystem_SetOnProcessMessages(nil);
  ASystem_SetOnShowErrorA(nil);
  ASystem_SetOnShowMessageA(nil);
  {$ifdef UseRuntime}
  ARuntime_SetOnShutdown(nil);
  ARuntime_SetOnRun(nil);
  {$endif}

  {$ifdef UseEvents}
  AEvent_Free(FOnDone);
  {$endif}
  FOnDone := 0;

  Result := 0;
end;

function AUi_GetIsShowApp(): ABool;
begin
  Result := FIsShowApp;
end;

function AUi_GetMainMenuItem(): AMenuItem;
begin
  Result := miMain;
end;

function AUi_GetMainToolBar(): AControl;
begin
  {$ifdef UseMainWindow}
  Result := AUiMainWindow_GetToolBar();
  {$else}
  Result := 0;
  {$endif}
end;

function AUi_GetMainTrayIcon(): ATrayIcon;
begin
  Result := FMainTrayIcon;
end;

function AUi_GetMainWindow(): AWindow;
begin
  Result := FMainWindow;
end;

function AUi_Init(): AError;
var
  S: string;
begin
  if (FMainWindow <> 0) then
  begin
    Result := 0;
    Exit;
  end;

  {$ifdef UseEvents}
  if (AEvents_Init() < 0) then
  begin
    Result := -4;
    Exit;
  end;
  {$endif}

  {$ifdef UseSettings}
  if (ASettings_Init() < 0) then
  begin
    Result := -5;
    Exit;
  end;
  {$endif}

  if (ASystem_Init() < 0) then
  begin
    Result := -3;
    Exit;
  end;

  {$ifdef UseEvents}
  FOnDone := AEvent_NewP(0, '');
  {$endif}

  FHideOnClose := False;
  FIsShowApp := True;

  ASystem_SetOnProcessMessages(DoProcessMessages);
  ASystem_SetOnShowErrorA(DoShowErrorA);
  ASystem_SetOnShowMessageA(DoShowMessageA);

  {$ifdef UseRuntime}
  ARuntime_SetOnShutdown(DoShutdown);
  ARuntime_SetOnRun(DoRun);
  {$endif}

  {$IFNDEF FPC}
  Application.CreateHandle();
  {$ENDIF}

  Application.Initialize();
  Application.Title := ASystem_GetTitleP();
  S := ASystem_GetDataDirectoryPathP() + ASystem_GetProgramNameP() + '.ico';

  if AUtils_FileExistsP(S) then
  try
    Application.Icon.LoadFromFile(S);
  except
    ASystem_ShowMessageP('������ ��� �������� ����������� '+S);
  end;

  try
    if Assigned(FOnMainFormCreate) then
      FOnMainFormCreate
    else
      AUi_CreateMainForm();
  except
    ASystem_ShowMessageP('��������� ������ ��� �������� �������� ����');
    Result := -100;
    Exit;
  end;

  Result := 0;
end;

function AUi_ProcessMessages(): AError;
begin
  try
    Application.ProcessMessages;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUi_Run(): AError;
begin
  try
    {$ifdef UseMainWindow}
    if (FConfig <> 0) then
      AUiMainWindow_LoadConfig(FConfig);
    {$endif}
    Application.Run();
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUi_SetAboutMemoDefaultSize(Width, Height: AInt): AError;
begin
  UiAboutWinMemoWidthDefault := Width;
  UiAboutWinMemoHeightDefault := Height;
  Result := 0;
end;

function AUi_SetHideOnClose(Value: ABool): AError;
begin
  FHideOnClose := Value;
  Result := 0;
end;

function AUi_SetIsShowApp(Value: ABool): AError;
begin
  try
    if (Value <> FIsShowApp) then
      FIsShowApp := Value;

    if Value then
    begin
      {$IFNDEF FPC}
      ShowWindow(Application.Handle, SW_SHOW);
      {$ENDIF}
      Application.Restore;
      Application.ShowMainForm := True;
      if Assigned(Application.MainForm) then
        Application.MainForm.Show;
      Application.BringToFront;
    end
    else
    begin
      if Assigned(Application.MainForm) then
        Application.MainForm.Hide;
      Application.ShowMainForm := False;
      Application.Minimize;
      {$IFNDEF FPC}
      ShowWindow(Application.Handle, SW_HIDE);
      {$ENDIF}
    end;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUi_SetMainToolBar(ToolBar: AControl): AError;
begin
  {$ifdef UseMainWindow}
  Result := AUiMainWindow_SetToolBar(ToolBar);
  {$else}
  Result := 0;
  {$endif}
end;

function AUi_SetOnAboutClick(Value: AProc): AError;
begin
  UiAboutClick := Value;
  Result := 0;
end;

function AUi_SetOnMainFormCreate(Value: AProc): AError;
begin
  FOnMainFormCreate := Value;
  Result := 0;
end;

function AUi_SetProgramState(State: AUiProgramState): AError;
begin
  try
    if (State = AUiProgramState_None) then
      Screen.Cursor := crNone
    else if (State = AUiProgramState_HourGlass) then
      Screen.Cursor := crHourGlass
    else
      Screen.Cursor := crDefault;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUi_ShellExecute(const Operation, FileName, Parameters, Directory: AString_Type): AInt;
begin
  try
    Result := AUi_ShellExecuteP(
        AString_ToPascalString(Operation),
        AString_ToPascalString(FileName),
        AString_ToPascalString(Parameters),
        AString_ToPascalString(Directory));
  except
    Result := -1;
  end;
end;

function AUi_ShellExecuteA(Operation, FileName, Parameters, Directory: AStr): AInt;
begin
  Result := AUi_ShellExecuteP(
      APascalString(AnsiString(Operation)),
      APascalString(AnsiString(FileName)),
      APascalString(AnsiString(Parameters)),
      APascalString(AnsiString(Directory)));
end;

function AUi_ShellExecuteP(const Operation, FileName, Parameters, Directory: APascalString): AInt;
begin
  {$IFNDEF UNIX}
  Result := ShellApi.ShellExecute(0{Handle}, PChar(string(Operation)), PChar(string(FileName)),
      PChar(string(Parameters)), PChar(string(Directory)), SW_SHOW);
  {$ENDIF}
end;

function AUi_ShowHelp(): AError;
begin
  try
    Result := AUi_ShowHelp2P(ASystem_GetExePathP() + AUtils_ChangeFileExtP(ASystem_GetProgramNameP(), '.hlp'));
  except
    Result := -1;
  end;
end;

function AUi_ShowHelp2(const FileName: AString_Type): AError;
begin
  Result := AUi_ShowHelp2P(AString_ToPascalString(FileName));
end;

function AUi_ShowHelp2P(const FileName: APascalString): AError;
begin
  try
    {$IFNDEF UNIX}
    Application.HelpFile := FileName;
    Application.HelpCommand(HELP_FINDER, 1);
    {$ENDIF}
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUi_Shutdown(): AError;
begin
  {$ifdef UseMainWindow}
  Result := AUiMainWindow_Shutdown();
  {$else}
  Result := 0;
  {$endif}
end;

function AUi_TextWidthP(const S, FontName: APascalString; FontSize: AInt): AInt;
var
  G: Graphics.TBitmap;
begin
  try
    G := Graphics.TBitmap.Create();
    try
      G.Canvas.Font.Name := FontName;
      G.Canvas.Font.Size := FontSize;
      Result := G.Canvas.TextWidth(S);
    finally
      G.Free();
    end;
  except
    Result := 0;
  end;
end;

// --- UI ---

function UI_Object_Add(Value: AInteger): AInteger;
begin
  Result := AUi_AddObject(Value);
end;

end.
 