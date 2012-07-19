{**
@Abstract AUi Splash
@Author Prof1983 <prof1983@ya.ru>
@Created 08.12.2009
@LastMod 19.07.2012
}
unit AUiSplash;

interface

uses
  ABase, ASettings, ASystem, AUi, AUiBase, AUtils;

function Init(): AError; stdcall;
function Done(): AError; stdcall;

procedure Hide; stdcall;
procedure Sleep; stdcall;
function StepIt(const Text: APascalString): AInteger; stdcall;


function UISplash_Init(): AError; stdcall;
function UISplash_Done(): AError; stdcall;

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

function ReadNoSplash: Boolean;
var
  I: Integer;
  S: string;
  Config: AConfig;
begin
  Result := False;
  I := 1;
  repeat
    S := ASystem.ParamStrWS(I);
    if (AUtils.String_ToUpperWS(S) = '-NOSPLASH') then
    begin
      Result := True;
      Exit;
    end;
    Inc(I);
  until (S = '');

  if not(NoSplash) then
  begin
    Config := ASystem.GetConfig();
    if (Config <> 0) then
      Result := ASettings.Config_ReadBoolDefP(Config, 'App', 'NoSplash', False);
  end;
end;

{ Events }

function DoBeforeRun(Obj, Data: AInteger): AError; stdcall;
begin
  if not(NoSplash) then
    Hide;
  Result := 0;
end;

procedure DoBeforeRun02(Obj, Data: AInteger); stdcall;
begin
  DoBeforeRun(Obj, Data);
end;

{ UISplash }

function UISplash_Done(): AError; stdcall;
begin
  {$IFDEF A02}
  ASystem.OnBeforeRun_Disconnect(DoBeforeRun02);
  {$ELSE}
  ASystem.OnBeforeRun_Disconnect(DoBeforeRun);
  {$ENDIF}

  AUI.Window_Free(SplashWin);
  SplashWin := 0;
  FInitialized := False;
  Result := 0;
end;

function UISplash_Init(): AError; stdcall;
var
  S: string;
begin
  if FInitialized then
  begin
    Result := 0;
    Exit;
  end;

  // --- Init modules ---

  if (ASystem.Init < 0) then
  begin
    Result := -2;
    Exit;
  end;

  if (AUI.Init < 0) then
  begin
    Result := -3;
    Exit;
  end;

  if (AUtils.Init < 0) then
  begin
    Result := -4;
    Exit;
  end;

  // --- Init recomended modules ---

  {if (ARuntime.Modules_GetByUid(ASettings_Uid, Addr(Module)) < 0) then
  begin
    Settings_SetProcs(Module.Procs);
    ARuntime.Modules_InitByName(ASettings_Name);
  end;}

  // --- Run ---

  {$IFDEF A02}
  ASystem.OnBeforeRun_Connect(DoBeforeRun02);
  {$ELSE}
  ASystem.OnBeforeRun_Connect(DoBeforeRun);
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

        S := ASystem.GetTitleWS();
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

  FStartTime := AUtils.Time_Now;

  if (FImageFileName = '') then
  begin
    S := ASystem.GetDataDirectoryPathWS() + ASystem.GetProgramNameWS() + '.png';
    if AUtils.FileExistsWS(S) then
      FImageFileName := S;
  end;

  if (FImageFileName = '') then
  begin
    S := ASystem.GetDataDirectoryPathWS() + ASystem.GetProgramNameWS() + '.bmp';
    if AUtils.FileExistsWS(S) then
      FImageFileName := S;
  end;

  if (FImageFileName <> '') then
  begin
    if AUtils.FileExistsWS(FImageFileName) then
      AUI.Image_LoadFromFileWS(Image, FImageFileName);
  end;

  NoSplash := ReadNoSplash;

  if NoSplash then
    AUI.Control_SetVisible(SplashWin, False)
  else
  begin
    AUI.Control_SetVisible(SplashWin, True);
    ASystem.ProcessMessages();
  end;

  FInitialized := True;
  Result := 0;
end;

{ Public }

function Done(): AError; stdcall;
begin
  try
    Result := UISplash_Done();
  except
    Result := -1;
  end;
end;

procedure Hide; stdcall;
const
  cTime = 1;
begin
  if (SplashWin = 0) then Exit;
  while (AUtils.Time_Now - FStartTime < cTime/(24*60*60)) do
  begin
    AUI.Control_SetVisible(SplashWin, True);
    ASystem.ProcessMessages();
    AUtils.Sleep(50);
  end;
  AUI.Control_Free(SplashWin);
  SplashWin := 0;
  {$IFNDEF FPC}
  //UI_Control_SetFocus(UI_MainWindow);
  {$ENDIF}
end;

function Init(): AError; stdcall;
begin
  try
    Result := UISplash_Init();
  except
    Result := -1;
  end;
end;

procedure Sleep; stdcall;
begin
  AUtils.Sleep(1000);
end;

function StepIt(const Text: APascalString): AInteger; stdcall;
begin
  if (SplashWin = 0) then
  begin
    Result := -1;
    Exit;
  end;
  Result := AUI.ProgressBar_StepIt(ProgressBar);
  if (Text <> '') then
    AUI.TextView_AddLineWS(TextView, Text);
end;

end.
 
