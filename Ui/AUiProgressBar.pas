{**
@Author Prof1983 <prof1983@ya.ru>
@Created 22.11.2012
@LastMod 11.01.2013
}
unit AUiProgressBar;

{$define AStdCall}

interface

uses
  ComCtrls, Controls,
  ABase, AUiBase, AUiData;

// --- AUiProgressBar ---

function AUiProgressBar_New(Parent: AControl; Max: AInteger): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiProgressBar_SetMaxPosition(ProgressBar: AControl; MaxPosition: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiProgressBar_SetPosition(ProgressBar: AControl; Position: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiProgressBar_StepBy(ProgressBar: AControl; Step: AInt): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AUiProgressBar_StepIt(ProgressBar: AControl): AInteger; {$ifdef AStdCall}stdcall;{$endif}

// --- UI_ProgressBar ---

function UI_ProgressBar_New(Parent: AControl; Max: AInteger): AControl; deprecated; // Use AUiProgressBar_New()

function UI_ProgressBar_StepIt(ProgressBar: AControl): AInteger; deprecated; // Use AUiProgressBar_StepIt()

implementation

// --- AUiProgressBar ---

function AUiProgressBar_New(Parent: AControl; Max: AInteger): AControl;
var
  ProgressBar: TProgressBar;
begin
  try
    ProgressBar := TProgressBar.Create(TWinControl(Parent));
    ProgressBar.Parent := TWinControl(Parent);
    ProgressBar.Max := Max;
    Result := AddObject(ProgressBar);
  except
    Result := 0;
  end;
end;

function AUiProgressBar_SetMaxPosition(ProgressBar: AControl; MaxPosition: AInt): AError;
begin
  if not(TObject(ProgressBar) is TProgressBar) then
  begin
    Result := -2;
    Exit;
  end;
  try
    TProgressBar(ProgressBar).Max := MaxPosition;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiProgressBar_SetPosition(ProgressBar: AControl; Position: AInt): AError;
begin
  if not(TObject(ProgressBar) is TProgressBar) then
  begin
    Result := -2;
    Exit;
  end;
  try
    TProgressBar(ProgressBar).Position := Position;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiProgressBar_StepBy(ProgressBar: AControl; Step: AInt): AInt;
begin
  if not(TObject(ProgressBar) is TProgressBar) then
  begin
    Result := -2;
    Exit;
  end;
  try
    TProgressBar(ProgressBar).Position := TProgressBar(ProgressBar).Position + Step;
    Result := TProgressBar(ProgressBar).Position;
  except
    Result := -1;
  end;
end;

function AUiProgressBar_StepIt(ProgressBar: AControl): AInteger;
begin
  Result := AUiProgressBar_StepBy(ProgressBar, 1);
end;

{ ProgressBar }

function UI_ProgressBar_New(Parent: AControl; Max: AInteger): AControl;
begin
  Result := AUiProgressBar_New(Parent, Max);
end;

function UI_ProgressBar_StepIt(ProgressBar: AControl): AInteger;
begin
  Result := AUiProgressBar_StepIt(ProgressBar);
end;

end.
 