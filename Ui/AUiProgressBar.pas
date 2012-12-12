{**
@Author Prof1983 <prof1983@ya.ru>
@Created 22.11.2012
@LastMod 12.12.2012
}
unit AUiProgressBar;

{$define AStdCall}

interface

uses
  ComCtrls, Controls,
  ABase, AUiBase, AUiData;

// --- AUiProgressBar ---

function AUiProgressBar_New(Parent: AControl; Max: AInteger): AControl; {$ifdef AStdCall}stdcall;{$endif}

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

function AUiProgressBar_StepIt(ProgressBar: AControl): AInteger;
begin
  try
    TProgressBar(ProgressBar).StepIt;
    Result := TProgressBar(ProgressBar).Position;
  except
    Result := 0;
  end;
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
 