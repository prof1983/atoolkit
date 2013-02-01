{**
@Abstract AUi Splash
@Author Prof1983 <prof1983@ya.ru>
@Created 08.12.2009
@LastMod 31.01.2013
}
unit AUiSplashMain;

{define AStdCall}

interface

uses
  ABase,
  ASettingsMain,
  AStringMain,
  AStringUtils,
  ASystemEvents,
  ASystemMain,
  AUiBase,
  AUiBox,
  AUiControls,
  AUiImages,
  AUiLabels,
  AUiProgressBar,
  AUiTextView,
  AUiWindows,
  AUtilsMain;

{** Finalize splash }
function AUiSplash_Fin(): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Hide splash }
function AUiSplash_Hide(): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Initialize splash }
function AUiSplash_Init(): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Wait 1 sec }
function AUiSplash_Sleep(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiSplash_StepIt(const Text: AString_Type): AInt; {$ifdef AStdCall}stdcall;{$endif}

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

{ Private }

function _ReadNoSplash(): Boolean;
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
      Result := ASettings_ReadBoolDefP(Config, 'App', 'NoSplash', False);
  end;
end;

{ Events }

function DoBeforeRun(Obj, Data: AInteger): AError; stdcall;
begin
  if not(NoSplash) then
    AUiSplash_Hide();
  Result := 0;
end;

// --- AUiSplash ---

function AUiSplash_Fin(): AError;
begin
  try
    ASystem_OnBeforeRun_Disconnect(DoBeforeRun);
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
      AUiControl_SetVisible(SplashWin, True);
      ASystem_ProcessMessages();
      AUtils_Sleep(50);
    end;
    AUiControl_Free(SplashWin);
    SplashWin := 0;
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
    ASystem_OnBeforeRun_Connect(DoBeforeRun);

    if (SplashWin = 0) then
    begin
      SplashWin := AUiWindow_New();
      AUiControl_SetColor(SplashWin, 0{AInteger(clBlack)});
      AUiWindow_SetBorderStyle(SplashWin, 0{AInteger(bsNone)});
      AUiWindow_SetFormStyle(SplashWin, 3{AInteger(fsStayOnTop)});
      AUiWindow_SetPosition(SplashWin, 4{AInteger(poScreenCenter)});
      AUiControl_SetClientSize(SplashWin, 573, 295);

        Box1 := AUiBox_New(SplashWin, 0);
        AUiControl_SetSize(Box1, 557, 49);
        AUiControl_SetPosition(Box1, 8, 8);
        AUiControl_SetColor(Box1, $FFFFFF{clWhite});

          Image := AUiImage_New(Box1);
          AUiControl_SetAlign(Image, uiAlignLeft);
          AUiControl_SetSize(Image, 168, 47);

          S := ASystem_GetTitleP();
          TextLabel := AUiLabel_New(Box1);
          AUiControl_SetColor(TextLabel, $FFFFFF{clWhite});
          AUiControl_SetTextP(TextLabel, S);
          if (Length(s) > 40) then
          begin
            AUiControl_SetPosition(TextLabel, 10, 0);
            AUiControl_SetFont1A(TextLabel, 'Calisto MT', 16);
          end
          else if (Length(s) > 20) then
          begin
            AUiControl_SetPosition(TextLabel, 50, 0);
            AUiControl_SetFont1A(TextLabel, 'Calisto MT', 20);
          end
          else
          begin
            AUiControl_SetPosition(TextLabel, 176, 0);
            AUiControl_SetFont1A(TextLabel, 'Calisto MT', 24);
          end;

        Box2 := AUiBox_New(SplashWin, 0);
        AUiControl_SetSize(Box2, 557, 226);
        AUiControl_SetPosition(Box2, 8, 63);
        AUiControl_SetColor(Box2, $FFFFFF{clWhite});

          ProgressBar := AUiProgressBar_New(Box2, 100);
          AUiControl_SetAlign(ProgressBar, uiAlignBottom);
          AUiControl_SetSize(ProgressBar, 556, 14);
          AUiControl_SetPosition(ProgressBar, 8, 272);

          TextView := AUiTextView_New(Box2, 1);
          AUiControl_SetAlign(TextView, uiAlignClient);
          AUiControl_SetSize(TextView, 557, 210);
          AUiControl_SetPosition(TextView, 8, 63);
          AUiTextView_SetReadOnly(TextView, True);
          AUiTextView_SetScrollBars(TextView, 3{ssBoth});
          AUiTextView_SetWordWrap(TextView, False);
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
        AUiImage_LoadFromFileP(Image, FImageFileName);
    end;

    NoSplash := _ReadNoSplash();

    if NoSplash then
      AUiControl_SetVisible(SplashWin, False)
    else
    begin
      AUiControl_SetVisible(SplashWin, True);
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
  Result := AUiSplash_StepItP(AString_ToPascalString(Text));
end;

function AUiSplash_StepItP(const Text: APascalString): AInt;
begin
  if (SplashWin = 0) then
  begin
    Result := -1;
    Exit;
  end;
  try
    Result := AUiProgressBar_StepIt(ProgressBar);
    if (Text <> '') then
      AUiTextView_AddLineP(TextView, Text);
  except
    Result := -1;
  end;
end;

end.

