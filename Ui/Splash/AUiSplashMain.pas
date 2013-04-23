{**
@Abstract AUi Splash
@Author Prof1983 <prof1983@ya.ru>
@Created 08.12.2009
@LastMod 23.04.2013
}
unit AUiSplashMain;

interface

uses
  ABase,
  ASettings,
  AStringMain,
  AStringUtils,
  ASystemEvents,
  ASystemMain,
  AUi,
  AUiBase,
  AUiControls,
  AUtilsMain;

// --- AUiSplash ---

{** Finalize splash }
function AUiSplash_Fin(): AError; stdcall;

{** Hide splash }
function AUiSplash_Hide(): AError; stdcall;

{** Initialize splash }
function AUiSplash_Init(): AError; stdcall;

{** Wait 1 sec }
function AUiSplash_Sleep(): AError; stdcall;

{** Do step progress bar in splash }
function AUiSplash_StepIt(const Text: AString_Type): AInt; stdcall;

{** Do step progress bar in splash }
function AUiSplash_StepItP(const Text: APascalString): AInt;

implementation

var
  FInitialized: Boolean;
  FImageFileName: APascalString;
  FStartTime: TDateTime;
  NoSplash: Boolean;
var
  Box1: AControl;
  Box2: AControl;
  SplashWin: AWindow;
  TextView: AControl;
  TextLabel: AControl;
  ProgressBar: AControl;
  Image: AControl;

// --- Events ---

function DoBeforeRun(Obj, Data: AInt): AError; stdcall;
begin
  if not(NoSplash) then
    AUiSplash_Hide();
  Result := 0;
end;

procedure DoBeforeRun02(Obj, Data: AInt); stdcall;
begin
  DoBeforeRun(Obj, Data);
end;

// --- Private ---

function ReadNoSplash: Boolean;
var
  I: Integer;
  S: string;
  Config: AConfig;
begin
  Result := False;
  I := 1;
  repeat
    S := ASystem_ParamStrP(I);
    if (AString_ToUpperP(S) = '-NOSPLASH') then
    begin
      Result := True;
      Exit;
    end;
    Inc(I);
  until (S = '');

  if not(NoSplash) then
  begin
    Config := ASystem_GetConfig();
    if (Config <> 0) then
      Result := ASettings.Config_ReadBoolDefP(Config, 'App', 'NoSplash', False);
  end;
end;

// --- AUiSplash ---

function AUiSplash_Fin(): AError;
begin
  try
    {$IFDEF A02}
    ASystem.OnBeforeRun_Disconnect(DoBeforeRun02);
    {$ELSE}
    ASystem_OnBeforeRun_Disconnect(DoBeforeRun);
    {$ENDIF}

    AUiControl_Free(SplashWin);
    SplashWin := 0;
    FInitialized := False;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiSplash_Hide(): AError;
const
  cTime = 1;
begin
  if (SplashWin = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    while (AUtils_GetNowDateTime() - FStartTime < cTime/(24*60*60)) do
    begin
      AUI.Control_SetVisible(SplashWin, True);
      ASystem_ProcessMessages();
      AUtils_Sleep(50);
    end;
    AUI.Control_Free(SplashWin);
    SplashWin := 0;
    {$IFNDEF FPC}
    //UI_Control_SetFocus(UI_MainWindow);
    {$ENDIF}
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiSplash_Init(): AError;
var
  S: string;
begin
  if FInitialized then
  begin
    Result := 0;
    Exit;
  end;

  // --- Init recomended modules ---

  {if (ARuntime.Modules_GetByUid(ASettings_Uid, Addr(Module)) < 0) then
  begin
    Settings_SetProcs(Module.Procs);
    ARuntime.Modules_InitByName(ASettings_Name);
  end;}

  // --- Run ---

  try
    {$IFDEF A02}
    ASystem.OnBeforeRun_Connect(DoBeforeRun02);
    {$ELSE}
    ASystem_OnBeforeRun_Connect(DoBeforeRun);
    {$ENDIF}

    if (SplashWin = 0) then
    begin
      SplashWin := AUI.Window_New;
      AUI.Control_SetColor(SplashWin, 0{AInteger(clBlack)});
      AUI.Window_SetBorderStyle(SplashWin, 0{AInteger(bsNone)});
      AUI.Window_SetFormStyle(SplashWin, 3{AInteger(fsStayOnTop)});
      AUI.Window_SetPosition(SplashWin, 4{AInteger(poScreenCenter)});
      AUI.Control_SetClientSize(SplashWin, 573, 295);

        Box1 := AUI.Box_New(SplashWin, 0);
        AUI.Control_SetSize(Box1, 557, 49);
        AUI.Control_SetPosition(Box1, 8, 8);
        AUI.Control_SetColor(Box1, $FFFFFF{clWhite});

          Image := AUI.Image_New(Box1);
          AUI.Control_SetAlign(Image, uiAlignLeft);
          AUI.Control_SetSize(Image, 168, 47);

          S := ASystem_GetTitleP();
          TextLabel := AUI.Label_New(Box1);
          AUI.Control_SetColor(TextLabel, $FFFFFF{clWhite});
          AUI.Control_SetTextWS(TextLabel, S);
          if (Length(s) > 40) then
          begin
            AUI.Control_SetPosition(TextLabel, 10, 0);
            AUI.Control_SetFont1A(TextLabel, 'Calisto MT', 16);
          end
          else if (Length(s) > 20) then
          begin
            AUI.Control_SetPosition(TextLabel, 50, 0);
            AUI.Control_SetFont1A(TextLabel, 'Calisto MT', 20);
          end
          else
          begin
            AUI.Control_SetPosition(TextLabel, 176, 0);
            AUI.Control_SetFont1A(TextLabel, 'Calisto MT', 24);
          end;

        Box2 := AUI.Box_New(SplashWin, 0);
        AUI.Control_SetSize(Box2, 557, 226);
        AUI.Control_SetPosition(Box2, 8, 63);
        AUI.Control_SetColor(Box2, $FFFFFF{clWhite});

          ProgressBar := AUI.ProgressBar_New(Box2, 100);
          AUI.Control_SetAlign(ProgressBar, uiAlignBottom);
          AUI.Control_SetSize(ProgressBar, 556, 14);
          AUI.Control_SetPosition(ProgressBar, 8, 272);

          TextView := AUI.TextView_New(Box2, 1);
          AUI.Control_SetAlign(TextView, uiAlignClient);
          AUI.Control_SetSize(TextView, 557, 210);
          AUI.Control_SetPosition(TextView, 8, 63);
          AUI.TextView_SetReadOnly(TextView, True);
          AUI.TextView_SetScrollBars(TextView, 3{ssBoth});
          AUI.TextView_SetWordWrap(TextView, False);
    end;

    FStartTime := AUtils_GetNowDateTime();

    if (FImageFileName = '') then
    begin
      S := ASystem_GetDataDirectoryPathP() + ASystem_GetProgramNameP() + '.png';
      if AUtils_FileExistsP(S) then
        FImageFileName := S;
    end;

    if (FImageFileName = '') then
    begin
      S := ASystem_GetDataDirectoryPathP() + ASystem_GetProgramNameP() + '.bmp';
      if AUtils_FileExistsP(S) then
        FImageFileName := S;
    end;

    if (FImageFileName <> '') then
    begin
      if AUtils_FileExistsP(FImageFileName) then
        AUI.Image_LoadFromFileWS(Image, FImageFileName);
    end;

    NoSplash := ReadNoSplash;

    if NoSplash then
      AUI.Control_SetVisible(SplashWin, False)
    else
    begin
      AUI.Control_SetVisible(SplashWin, True);
      ASystem_ProcessMessages();
    end;

    FInitialized := True;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiSplash_Sleep(): AError;
begin
  try
    AUtils_Sleep(1000);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiSplash_StepIt(const Text: AString_Type): AInt;
begin
  Result := AUiSplash_StepItP(AString_ToP(Text));
end;

function AUiSplash_StepItP(const Text: APascalString): AInt;
begin
  if (SplashWin = 0) then
  begin
    Result := -1;
    Exit;
  end;
  try
    Result := AUI.ProgressBar_StepIt(ProgressBar);
    if (Text <> '') then
      AUI.TextView_AddLineWS(TextView, Text);
  except
    Result := -1;
  end;
end;

end.
 