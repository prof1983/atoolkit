{**
@Abstract AUi common functions
@Author Prof1983 <prof1983@ya.ru>
@Created 26.10.2011
@LastMod 30.01.2013
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
  AUiDialogs,
  AUiErrorDialog,
  {$ifdef UseMainWindow}
  AUiMainWindow,
  AUiMainWindowData,
  AUiMainWindowEventsObj,
  {$endif}
  {$ifdef UseMainTrayIcon}AUiTrayIcon,{$endif}
  AUtilsMain;

// --- AUi ---

function AUi_CreateMainForm(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_Fin(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_GetIsShowApp(): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function AUi_GetMainMenuItem(): AMenuItem; {$ifdef AStdCall}stdcall;{$endif}

function AUi_GetMainToolBar(): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUi_GetMainTrayIcon(): ATrayIcon; {$ifdef AStdCall}stdcall;{$endif}

{** Возвращает идентификатор главного окна программы }
function AUi_GetMainWindow(): AWindow; {$ifdef AStdCall}stdcall;{$endif}

function AUi_Init(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ProcessMessages(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_Run(): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function AUi_SetAboutMemoDefaultSize(Width, Height: AInteger): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_SetHideOnClose(Value: ABoolean): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_SetIsShowApp(Value: ABoolean): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_SetMainToolBar(ToolBar: AControl): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_SetOnAboutClick(Value: AProc): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_SetOnMainFormCreate(Value: AProc): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_SetProgramState(State: AInteger): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ShellExecute(const Operation, FileName, Parameters, Directory: AString_Type): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ShellExecuteA(Operation, FileName, Parameters, Directory: AStr): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ShellExecuteP(const Operation, FileName, Parameters, Directory: APascalString): AInteger;

{** Отображает справочную информацию }
function AUi_ShowHelp(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ShowHelp2(const FileName: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Отображает справочную информацию }
function AUi_ShowHelp2P(const FileName: APascalString): AError;

function AUi_Shutdown(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_TextWidthP(const S, FontName: APascalString; FontSize: AInt): AInt;

// --- UI ---

function UI_Object_Add(Value: AInteger): AInteger; stdcall;

implementation

// --- Events ---

function DoProcessMessages(): AInteger; stdcall;
begin
  try
    Application.ProcessMessages();
    Result := 0;
  except
    Result := -1;
  end;
end;

function DoRun(): AInteger; stdcall;
begin
  {$ifdef UseSettings}
  if (FConfig <> 0) then
    _MainWindow_LoadConfig(FConfig);
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

function DoShutdown(): AInteger; stdcall;
begin
  Result := AUi_Shutdown();
end;

// --- AUi ---

function AUi_CreateMainForm(): AError;
var
  MainForm: TForm;
begin
  Application.CreateForm({$IFDEF OLDMAINFORM}TMainForm{$ELSE}TForm{$ENDIF}, MainForm);
  MainForm.Left := 0;
  MainForm.Top := 0;
  {$IFDEF OLDMAINFORM}
    {$IFDEF OLDMAINFORM2}
    _MainWindow_Create(MainForm, 0, ASystem_GetConfig());
    {$ELSE}
    _MainWindow_Create(MainForm, MainWindowFormatCreateMenu or MainWindowFormatCreateToolBar or MainWindowFormatCreateStatusBar, ASystem_GetConfig());
    {$ENDIF}
    FMainWindow := AddObject(MainForm);
  {$ELSE}
    FMainWindow := AddObject(MainForm);
    MainForm.Name := 'MainForm';
    MainForm.Caption := ASystem_GetProgramNameP();
    {$ifdef UseMainWindow}
    _MainWindow_Create(MainForm, MainWindowFormatCreateAll, ASystem_GetConfig());
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
  _MainWindow_Shutdown();
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

function AUi_GetIsShowApp(): ABoolean;
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
  Result := _MainWindow_ToolBar;
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
    ASystem_ShowMessageP('Ошибка при загрузке изображения '+S);
  end;

  try
    if Assigned(FOnMainFormCreate) then
      FOnMainFormCreate
    else
      AUi_CreateMainForm();
  except
    ASystem_ShowMessageP('Произошла ошибка при создании главного окна');
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

function AUi_Run(): AInteger;
begin
  try
    {$ifdef UseMainWindow}
    if (FConfig <> 0) then
      _MainWindow_LoadConfig(FConfig);
    {$endif}
    Application.Run();
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUi_SetAboutMemoDefaultSize(Width, Height: AInteger): AError;
begin
  UiAboutWinMemoWidthDefault := Width;
  UiAboutWinMemoHeightDefault := Height;
  Result := 0;
end;

function AUi_SetHideOnClose(Value: ABoolean): AError;
begin
  FHideOnClose := Value;
  Result := 0;
end;

function AUi_SetIsShowApp(Value: ABoolean): AError;
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
  try
    _MainWindow_ToolBar_Set(ToolBar);
    Result := 0;
  except
    Result := -1;
  end;
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

function AUi_SetProgramState(State: AInteger): AError;
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

function AUi_ShellExecute(const Operation, FileName, Parameters, Directory: AString_Type): AInteger;
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

function AUi_ShellExecuteP(const Operation, FileName, Parameters, Directory: APascalString): AInteger;
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
  try
    {$ifdef UseMainWindow}
    _MainWindow_Shutdown();
    {$endif}
    Result := 0;
  except
    Result := -1;
  end;
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
  Result := AddObject(TObject(Value));
end;

end.
 