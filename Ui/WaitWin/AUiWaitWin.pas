{**
@Author Prof1983 <prof1983@ya.ru>
@Created 12.12.2012
@LastMod 19.02.2013
}
unit AUiWaitWin;

{define AStdCall}
{define UseWaitForm}

interface

uses
  {$ifdef UseWaitForm}fWait,{$endif}
  ABase,
  AStringMain,
  AUiBase,
  AUiControls,
  AUiData,
  AUiLabels,
  AUiProgressBar,
  AUiWindows;

// --- AUiWaitWin ---

function AUiWaitWin_New(const Caption, Text: AString_Type; MaxPosition: AInt): AWindow; {$ifdef AStdCall}stdcall;{$endif}

function AUiWaitWin_NewP(const Caption, Text: APascalString; MaxPosition: AInt): AWindow;

function AUiWaitWin_SetMaxPosition(WaitWin: AWindow; MaxPosition: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiWaitWin_SetPosition(WaitWin: AWindow; Position: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiWaitWin_SetText(Window: AWindow; const Text: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiWaitWin_SetTextP(Window: AWindow; const Text: APascalString): AError;

function AUiWaitWin_StepBy(Window: AWindow; Step: AInt): AInt; {$ifdef AStdCall}stdcall;{$endif}

implementation

uses
  AUiMain;

type
  TWaitWin = record
    Window: AWindow;
    TextLabel: AControl;
    ProgressBar: AControl;
  end;

var
  FWaitWin: array of TWaitWin;

// --- Private ---

function _FindWaitWin(Window: AWindow): Integer;
var
  I: Integer;
begin
  for I := 0 to High(FWaitWin) do
  begin
    if (FWaitWin[I].Window = Window) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

function _Init(Window: AWindow; const Caption, Text: APascalString; MaxPosition: AInteger): AError;
var
  I: Integer;
  W: Integer;
  TextLabel: AControl;
  ProgressBar: AControl;
begin
  I := _FindWaitWin(Window);
  if (I >= 0) then
  begin
    Result := 1;
    Exit;
  end;

  W := AUiControl_GetClientWidth(Window);

  AUiControl_SetTextP(Window, Caption);

  TextLabel := AUiLabel_New(Window);
  AUiLabel_SetAlignment(TextLabel, uitaCenter + uitlCenter);
  AUiLabel_SetWordWrap(TextLabel, True);
  AUiControl_SetFontSize(TextLabel, 11);
  AUiControl_SetFontStyle(TextLabel, uifsBold);
  AUiControl_SetPosition(TextLabel, 0, 0);
  AUiControl_SetTextP(TextLabel, Text);
  AUiControl_SetSize(TextLabel, W, 40);

  if (MaxPosition > 0) then
  begin
    ProgressBar := AUiProgressBar_New(Window, MaxPosition);
    I := (W div 10);
    AUiControl_SetPosition(ProgressBar, I, 40);
    AUiControl_SetWidth(ProgressBar, W - I * 2);
  end
  else
    ProgressBar := 0;

  I := Length(FWaitWin);
  SetLength(FWaitWin, I + 1);
  FWaitWin[I].Window := Window;
  FWaitWin[I].TextLabel := TextLabel;
  FWaitWin[I].ProgressBar := ProgressBar;

  Result := 0;
end;

// --- AUiWaitWin ---

function AUiWaitWin_New(const Caption, Text: AString_Type; MaxPosition: AInt): AWindow;
begin
  Result := AUiWaitWin_NewP(
      AString_ToPascalString(Caption),
      AString_ToPascalString(Text),
      MaxPosition);
end;

function AUiWaitWin_NewP(const Caption, Text: APascalString; MaxPosition: AInt): AWindow;
var
  {$ifdef UseWaitForm}
  WaitForm: TWaitForm;
  {$else}
  WaitWin: AWindow;
  {$endif}
begin
  {$ifdef UseWaitForm}
  try
    WaitForm := TWaitForm.Create(nil);
    WaitForm.Init(Caption, Text, MaxPosition);
    AUiData.AddObject(WaitForm);
    Result := AWindow(WaitForm);
  except
    Result := 0;
  end;
  {$else}
  WaitWin := AUiWindow_New();
  if (WaitWin = 0) then
  begin
    Result := 0;
    Exit;
  end;

  AUiControl_SetClientSize(WaitWin, 384, 80);
  AUiControl_SetPosition(WaitWin, 500, 230);

  _Init(WaitWin, Caption, Text, MaxPosition);
  Result := WaitWin;
  {$endif}
end;

function AUiWaitWin_SetMaxPosition(WaitWin: AWindow; MaxPosition: AInt): AError;
var
  I: Integer;
begin
  I := _FindWaitWin(WaitWin);
  if (I >= 0) then
  begin
    AUiProgressBar_SetMaxPosition(FWaitWin[I].ProgressBar, MaxPosition);
    AUi_ProcessMessages();
    Result := 0;
    Exit;
  end;
  {$ifdef UseWaitForm}
  if not(TObject(WaitWin) is TWaitForm) then
  begin
    Result := -3;
    Exit;
  end;
  try
    TWaitForm(WaitWin).ProgressBar.Max := MaxPosition;
    AUi_ProcessMessages();
    Result := 0;
  except
    Result := -1;
  end;
  {$else}
  Result := -2;
  {$endif}
end;

function AUiWaitWin_SetPosition(WaitWin: AWindow; Position: AInt): AError;
var
  I: Integer;
begin
  I := _FindWaitWin(WaitWin);
  if (I >= 0) then
  begin
    AUiProgressBar_SetPosition(FWaitWin[I].ProgressBar, Position);
    AUi_ProcessMessages();
    Result := 0;
    Exit;
  end;
  {$ifdef UseWaitForm}
  if not(TObject(WaitWin) is TWaitForm) then
  begin
    Result := -3;
    Exit;
  end;
  try
    TWaitForm(WaitWin).ProgressBar.Position := Position;
    AUi_ProcessMessages();
    Result := 0;
  except
    Result := -1;
  end;
  {$else}
  Result := -2;
  {$endif}
end;

function AUiWaitWin_SetText(Window: AWindow; const Text: AString_Type): AError;
begin
  Result := AUiWaitWin_SetTextP(Window, AString_ToPascalString(Text));
end;

function AUiWaitWin_SetTextP(Window: AWindow; const Text: APascalString): AError;
var
  I: Integer;
begin
  I := _FindWaitWin(Window);
  if (I >= 0) then
  begin
    AUiControl_SetTextP(FWaitWin[I].TextLabel, Text);
    AUi_ProcessMessages();
    Result := 0;
    Exit;
  end;
  {$ifdef UseWaitWin}
  if not(TObject(WaitWin) is TWaitForm) then
  begin
    Result := -3;
    Exit;
  end;
  try
    TWaitForm(Window).lblText.Caption := Text;
    AUi_ProcessMessages();
    Result := 0;
  except
    Result := -1;
  end;
  {$else}
  Result := -2;
  {$endif}
end;

function AUiWaitWin_StepBy(Window: AWindow; Step: AInt): AInt;
var
  I: Integer;
begin
  I := _FindWaitWin(Window);
  if (I >= 0) then
  begin
    Result := AUiProgressBar_StepBy(FWaitWin[I].ProgressBar, Step);
    AUi_ProcessMessages();
    Exit;
  end;
  {$ifdef UseWaitWin}
  if not(TObject(WaitWin) is TWaitForm) then
  begin
    Result := -3;
    Exit;
  end;
  try
    TWaitForm(Window).ProgressBar.Position := TWaitForm(Window).ProgressBar.Position + 1;
    AUi_ProcessMessages();
    Result := 0;
  except
    Result := -1;
  end;
  {$else}
  Result := -2;
  {$endif}
end;

end.
 