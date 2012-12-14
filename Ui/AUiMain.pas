{**
@Abstract AUi common functions
@Author Prof1983 <prof1983@ya.ru>
@Created 26.10.2011
@LastMod 14.12.2012
}
unit AUiMain;

{$I A.inc}
{$I Defines.inc}

{$define AStdCall}

{$IFDEF OLDMAINFORM2}
  {$DEFINE OLDMAINFORM}
{$ENDIF}

{$ifndef NoEvents}
  {$DEFINE USE_EVENTS}
{$endif}

{$ifndef NoSettings}
  {$DEFINE USE_SETTINGS}
{$endif}

interface

uses
  Controls, Forms, ShellApi, SysUtils, Windows,
  ABase, ABaseTypes, AEvents, ARuntimeMain, ASettings, AStrings, ASystemMain, AUtilsMain,
  {$IFDEF OLDMAINFORM}fMain,{$ENDIF}
  AUiBase, AUiData, AUiDialogs, AUiEventsObj, AUiMainWindow, AUiTrayIcon;

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

function AUi_SetHideOnClose(Value: ABoolean): AError; {$ifdef AStdCall}stdcall;{$endif}

procedure AUi_SetHideOnClose_Old(Value: ABoolean); {$ifdef AStdCall}stdcall;{$endif} deprecated; // Use AUi_SetHideOnClose()

function AUi_SetIsShowApp(Value: ABoolean): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_SetMainToolBar(ToolBar: AControl): AError; {$ifdef AStdCall}stdcall;{$endif}

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

{** Отображает справочную информацию }
function AUi_ShowHelp2WS(const FileName: AWideString): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_Shutdown(): AError; {$ifdef AStdCall}stdcall;{$endif}

// --- UI ---

function UI_GetIsShowApp(): ABoolean; stdcall; deprecated; // Use AUi_GetIsShowApp()

function UI_Init(): AError; stdcall; deprecated; // Use AUi_Init()

function UI_MainMenuItem(): AMenuItem; stdcall; deprecated; // Use AUi_GetMainMenuItem()

function UI_MainTrayIcon(): ATrayIcon; stdcall; deprecated; // Use AUi_GetMainTrayIcon()

function UI_Object_Add(Value: AInteger): AInteger; stdcall;

procedure UI_OnMainFormCreate_Set(Value: AProc); stdcall; deprecated; // Use AUi_SetOnMainFormCreate()

function UI_ProcessMessages: AInteger; stdcall; deprecated; // Use AUi_ProcessMessages()

procedure UI_ProcessMessages02(); stdcall; deprecated; // Use AUi_ProcessMessages()

function UI_Run(): AInteger; stdcall; deprecated; // Use AUi_Run()

procedure UI_Run02(); stdcall; deprecated; // Use AUi_Run()

procedure UI_SetHideOnClose(Value: ABoolean); stdcall; deprecated; // Use AUi_SetHideOnClose()

procedure UI_SetIsShowApp(Value: ABoolean); stdcall; deprecated; // Use AUi_SetIsShowApp()

function UI_ShellExecute(const Operation, FileName, Parameters,
    Directory: APascalString): AInteger; stdcall; deprecated; // Use AUi_ShellExecuteP()

procedure UI_ShowHelp(); deprecated; // Use AUi_ShowHelp()

procedure UI_ShowHelp2(const FileName: string); deprecated; // Use AUi_ShowHelp2()

function UI_Shutdown(): AInteger; stdcall; deprecated; // Use AUi_Shutdown()

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
  _MainWindow_Init();
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

function AUi_CreateMainForm(): AError; stdcall;
var
  MainForm: TForm;
begin
  Application.CreateForm({$IFDEF OLDMAINFORM}TMainForm{$ELSE}TForm{$ENDIF}, MainForm);
  MainForm.Left := 0;
  MainForm.Top := 0;
  {$IFDEF OLDMAINFORM}
    {$IFDEF OLDMAINFORM2}
    _MainWindow_Create(MainForm, 0, Runtime_GetConfig);
    {$ELSE}
    _MainWindow_Create(MainForm, MainWindowFormatCreateMenu or MainWindowFormatCreateToolBar or MainWindowFormatCreateStatusBar, ASystem_GetConfig());
    {$ENDIF}
    FMainWindow := AddObject(MainForm);
  {$ELSE}
    FMainWindow := AddObject(MainForm);
    MainForm.Name := 'MainForm';
    MainForm.Caption := ASystem_GetProgramNameP();
    _MainWindow_Create(MainForm, MainWindowFormatCreateAll, ASystem_GetConfig());
    MainForm.OnCloseQuery := UI_.MainFormCloseQuery;
  {$ENDIF}
  AddObject(MainForm.Menu);
  Result := 0;
end;

function AUi_Fin(): AError;
begin
  {$IFDEF USE_EVENTS}
  AEvents.Event_Invoke(FOnDone, 0);
  {$ENDIF}

  try
    if (FMainTrayIcon <> 0) then
    begin
      {$IFNDEF FPC}
      TrayIcon_Free(FMainTrayIcon);
      {$ENDIF}
      FMainTrayIcon := 0;
    end;
    SetLength(FObjects, 0);
    SetLength(FMenuItems, 0);
  except
  end;

  _MainWindow_Shutdown;

  ASystem_SetOnProcessMessages(nil);
  ASystem_SetOnShowErrorA(nil);
  ASystem_SetOnShowMessageA(nil);
  ASystem_SetOnShowMessageWS(nil);
  ARuntime_SetOnShutdown(nil);
  ARuntime_SetOnRun(nil);

  {$IFDEF USE_EVENTS}
  AEvents.Event_Free(FOnDone);
  {$ENDIF}
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
  Result := _MainWindow_ToolBar;
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

  {$IFDEF USE_EVENTS}
  if (AEvents.Init() < 0) then
  begin
    Result := -4;
    Exit;
  end;
  {$ENDIF}

  {$IFDEF USE_SETTINGS}
  ASettings.Init();
  {$ENDIF}

  if (AStrings_Init() < 0) then
  begin
    Result := -2;
    Exit;
  end;

  if (ASystem_Init() < 0) then
  begin
    Result := -3;
    Exit;
  end;

  {$IFDEF USE_EVENTS}
  FOnDone := AEvents.Event_NewW(0, nil);
  {$ENDIF}

  FHideOnClose := False;
  FIsShowApp := True;

  {$IFDEF A02}
  ASystem.SetOnProcessMessages02(UI_ProcessMessages02);
  {$ELSE}
  ASystem_SetOnProcessMessages(DoProcessMessages);
  {$ENDIF A02}
  ASystem_SetOnShowErrorA(DoShowErrorA);
  ASystem_SetOnShowMessageA(DoShowMessageA);

  ARuntime_SetOnShutdown(DoShutdown);
  {$IFDEF A01}
    ARuntime.OnRun_Set(UI_Run02);
  {$ELSE}
    {$IFDEF A02}
    ARuntime.OnRun_Set(UI_Run02);
    {$ELSE}
    ARuntime_SetOnRun(DoRun);
    {$ENDIF A02}
  {$ENDIF A01}

  {$IFNDEF FPC}
  Application.CreateHandle();
  {$ENDIF}

  Application.Initialize();
  Application.Title := ASystem_GetTitleP();
  S := ASystem_GetDataDirectoryPathP() + ASystem_GetProgramNameP() + '.ico';

  if SysUtils.FileExists(S) then
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
  {
  if (FMainWindow <> 0) then
    miMain := AddObject(TForm(FMainWindow).Menu.Items);
  }

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
    _MainWindow_Init();
    Application.Run();
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUi_SetHideOnClose(Value: ABoolean): AError;
begin
  FHideOnClose := Value;
  Result := 0;
end;

procedure AUi_SetHideOnClose_Old(Value: ABoolean);
begin
  FHideOnClose := Value;
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
  try
    _MainWindow_ToolBar_Set(ToolBar);
    Result := 0;
  except
    Result := -1;
  end;
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
        AStrings.String_ToWideString(Operation),
        AStrings.String_ToWideString(FileName),
        AStrings.String_ToWideString(Parameters),
        AStrings.String_ToWideString(Directory));
  except
    Result := -1;
  end;
end;

function AUi_ShellExecuteA(Operation, FileName, Parameters, Directory: AStr): AInt;
begin
  Result := AUi_ShellExecuteP(AnsiString(Operation), AnsiString(FileName),
      AnsiString(Parameters), AnsiString(Directory));
end;

function AUi_ShellExecuteP(const Operation, FileName, Parameters, Directory: APascalString): AInteger;
begin
  {$IFNDEF UNIX}
  Result := ShellApi.ShellExecute(0{Handle}, PChar(string(Operation)), PChar(string(FileName)), PChar(string(Parameters)), PChar(string(Directory)), SW_SHOW);
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

function AUi_ShowHelp2WS(const FileName: AWideString): AError;
begin
  Result := AUi_ShowHelp2P(FileName);
end;

function AUi_Shutdown(): AError;
begin
  try
    _MainWindow_Shutdown();
    Result := 0;
  except
    Result := -1;
  end;
end;

// --- UI ---

function UI_GetIsShowApp(): ABoolean;
begin
  Result := AUi_GetIsShowApp();
end;

function UI_Init(): AError;
begin
  Result := AUi_Init();
end;

function UI_MainMenuItem(): AMenuItem;
begin
  Result := AUi_GetMainMenuItem();
end;

function UI_MainTrayIcon(): ATrayIcon;
begin
  Result := AUi_GetMainTrayIcon();
end;

function UI_Object_Add(Value: AInteger): AInteger;
begin
  Result := AddObject(TObject(Value));
end;

procedure UI_OnMainFormCreate_Set(Value: AProc);
begin
  AUi_SetOnMainFormCreate(Value);
end;

function UI_ProcessMessages(): AInteger;
begin
  Result := AUi_ProcessMessages();
end;

procedure UI_ProcessMessages02();
begin
  AUi_ProcessMessages();
end;

function UI_Run(): AInteger;
begin
  Result := AUi_Run();
end;

procedure UI_Run02();
begin
  AUi_Run();
end;

procedure UI_SetHideOnClose(Value: ABoolean);
begin
  AUi_SetHideOnClose(Value);
end;

procedure UI_SetIsShowApp(Value: ABoolean);
begin
  AUi_SetIsShowApp(Value);
end;

function UI_ShellExecute(const Operation, FileName, Parameters, Directory: APascalString): AInteger;
begin
  Result := AUi_ShellExecuteP(Operation, FileName, Parameters, Directory);
end;

procedure UI_ShowHelp();
begin
  AUi_ShowHelp();
end;

procedure UI_ShowHelp2(const FileName: string);
begin
  AUi_ShowHelp2P(FileName);
end;

function UI_Shutdown(): AInteger;
begin
  Result := AUi_Shutdown();
end;

end.
 