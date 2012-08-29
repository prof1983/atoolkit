{**
@Abstract AUi common functions
@Author Prof1983 <prof1983@ya.ru>
@Created 26.10.2011
@LastMod 28.08.2012
}
unit AUiMain;

{$define AStdCall}

interface

uses
  Controls, Forms, ShellApi, SysUtils, Windows,
  ABase, ABaseTypes, ARuntimeMain, AStrings, ASystem, AUtils,
  AUiBase, AUiData, AUiDialogs, AUiEventsObj, AUiMainWindow;

// --- AUi ---

function AUi_CreateMainForm(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_GetMainMenuItem(): AMenuItem; {$ifdef AStdCall}stdcall;{$endif}

function AUi_GetMainTrayIcon(): ATrayIcon; {$ifdef AStdCall}stdcall;{$endif}

function AUi_GetMainWindow(): AWindow; {$ifdef AStdCall}stdcall;{$endif}

function AUi_Init(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_Run(): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function AUi_SetHideOnClose(Value: ABoolean): AError; {$ifdef AStdCall}stdcall;{$endif}

procedure AUi_SetHideOnClose_Old(Value: ABoolean); {$ifdef AStdCall}stdcall;{$endif}

function AUi_SetProgramState(State: AInteger): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ShellExecute(const Operation, FileName, Parameters, Directory: AString_Type): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function AUi_ShellExecuteP(const Operation, FileName, Parameters, Directory: APascalString): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function AUi_Shutdown(): AError; {$ifdef AStdCall}stdcall;{$endif}

// --- UI ---

procedure UI_ShowHelp();

procedure UI_ShowHelp2(const FileName: string);

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

procedure DoShowError(const Caption, UserMessage, ExceptMessage: AWideString); stdcall;
begin
  AUi_ExecuteErrorDialogP(Caption, UserMessage, ExceptMessage);
end;

function DoShowMessage(const Text, Caption: AWideString; Flags: AMessageBoxFlags): ADialogBoxCommands; stdcall;
begin
  Result := AUi_ExecuteMessageDialog1P(Text, Caption, Flags);
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
    _MainWindow_Create(MainForm, MainWindowFormatCreateMenu or MainWindowFormatCreateToolBar or MainWindowFormatCreateStatusBar, ASystem.GetConfig);
    {$ENDIF}
    FMainWindow := AddObject(MainForm);
  {$ELSE}
    FMainWindow := AddObject(MainForm);
    MainForm.Name := 'MainForm';
    MainForm.Caption := ASystem.Info_GetProgramNameP;
    _MainWindow_Create(MainForm, MainWindowFormatCreateAll, ASystem.GetConfig);
    MainForm.OnCloseQuery := UI_.MainFormCloseQuery;
  {$ENDIF}
  AddObject(MainForm.Menu);
end;

function AUi_GetMainMenuItem(): AMenuItem;
begin
  Result := miMain;
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

  if (ASystem.Init() < 0) then
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
  ASystem.SetOnProcessMessages(DoProcessMessages);
  {$ENDIF A02}
  ASystem.SetOnShowError(DoShowError);
  ASystem.SetOnShowMessage(DoShowMessage);

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
  Application.Title := ASystem.Info_GetTitleWS();
  S := ASystem.Info_GetDataDirectoryPathP() + ASystem.Info_GetProgramNameWS() + '.ico';

  if SysUtils.FileExists(S) then
  try
    Application.Icon.LoadFromFile(S);
  except
    ASystem.ShowMessageP('Ошибка при загрузке изображения '+S);
  end;

  try
    if Assigned(FOnMainFormCreate) then
      FOnMainFormCreate
    else
      AUi_CreateMainForm();
  except
    ASystem.ShowMessageP('Произошла ошибка при создании главного окна');
    Result := -100;
    Exit;
  end;
  {
  if (FMainWindow <> 0) then
    miMain := AddObject(TForm(FMainWindow).Menu.Items);
  }

  Result := 0;
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
end;

procedure AUi_SetHideOnClose_Old(Value: ABoolean);
begin
  FHideOnClose := Value;
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

function AUi_ShellExecuteP(const Operation, FileName, Parameters, Directory: APascalString): AInteger;
begin
  {$IFNDEF UNIX}
  Result := ShellApi.ShellExecute(0{Handle}, PChar(string(Operation)), PChar(string(FileName)), PChar(string(Parameters)), PChar(string(Directory)), SW_SHOW);
  {$ENDIF}
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

procedure UI_ShowHelp();
begin
  UI_ShowHelp2(ASystem.Info_GetDirectoryPathP + AUtils_ChangeFileExtP(ASystem.Info_GetProgramNameP, '.hlp'));
end;

procedure UI_ShowHelp2(const FileName: string);
begin
{$IFNDEF UNIX}
  Application.HelpFile := FileName;
  Application.HelpCommand(HELP_FINDER, 1);
{$ENDIF}
end;

end.
 