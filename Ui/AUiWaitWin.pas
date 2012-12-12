{**
@Author Prof1983 <prof1983@ya.ru>
@Created 12.12.2012
@LastMod 12.12.2012
}
unit AUiWaitWin;

{$define AStdCall}

interface

uses
  ABase, AStrings, AUiBase, AUiData, fWait;

// --- AUiWaitWin ---

function AUiWaitWin_New(const Caption, Text: AString_Type; MaxPosition: AInteger): AWindow; {$ifdef AStdCall}stdcall;{$endif}

function AUiWaitWin_NewP(const Caption, Text: APascalString; MaxPosition: AInteger): AWindow;

function AUiWaitWin_SetMaxPosition(WaitWin: AWindow; MaxPosition: AInteger): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiWaitWin_StepBy(Window: AWindow; Step: AInteger): AInteger; {$ifdef AStdCall}stdcall;{$endif}

// --- UI_WaitWin ---

function UI_WaitWin_New(const Caption, Text: APascalString; MaxPosition: Integer): AWindow; stdcall; deprecated; // Use AUiWaitWin_NewP()

function UI_WaitWin_StepBy(Window: AWindow; Step: AInteger): AInteger; stdcall; deprecated; // Use AUiWaitWin_StepBy()

implementation

uses
  AUiMain;

// --- AUiWaitWin ---

function AUiWaitWin_New(const Caption, Text: AString_Type; MaxPosition: AInteger): AWindow;
begin
  Result := AUiWaitWin_NewP(
      AString_ToPascalString(Caption),
      AString_ToPascalString(Text),
      MaxPosition);
end;

function AUiWaitWin_NewP(const Caption, Text: APascalString; MaxPosition: AInteger): AWindow;
var
  WaitForm: TWaitForm;
begin
  try
    WaitForm := TWaitForm.Create(nil);
    WaitForm.Init(Caption, Text, MaxPosition);
    AUiData.AddObject(WaitForm);
    Result := AWindow(WaitForm);
  except
    Result := 0;
  end;
end;

function AUiWaitWin_SetMaxPosition(WaitWin: AWindow; MaxPosition: AInteger): AError;
begin
  try
    TWaitForm(WaitWin).ProgressBar.Max := MaxPosition;
    AUi_ProcessMessages();
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiWaitWin_StepBy(Window: AWindow; Step: AInteger): AInteger;
begin
  try
    TWaitForm(Window).Step;
  except
  end;
  Result := 0;
end;

// --- UI_WaitWin ---

function UI_WaitWin_New(const Caption, Text: APascalString; MaxPosition: AInteger): AWindow;
begin
  Result := AUiWaitWin_NewP(Caption, Text, MaxPosition);
end;

procedure UI_WaitWin_SetText(Window: AWindow; const Text: AWideString);
begin
  TWaitForm(Window).lblText.Caption := Text;
end;

function UI_WaitWin_StepBy(Window: AWindow; Step: AInteger): AInteger;
begin
  Result := AUiWaitWin_StepBy(Window, Step);
end;

end.
 