{**
@Abstract AUiSpinEdit
@Author Prof1983 <prof1983@ya.ru>
@Created 05.09.2012
@LastMod 09.01.2013
}
unit AUiSpinEdit;

{$define AStdCall}

interface

uses
  Controls,
  ABase,
  AUiBase,
  AUiData,
  AUiSpin;

// --- AUiSpinEdit ---

function AUiSpinEdit_New(Parent: AControl): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiSpinEdit_NewEx(Parent: AControl; Value, MinValue, MaxValue: AInteger): AControl; {$ifdef AStdCall}stdcall;{$endif}

// --- AUi_SpinEdit ---

function AUi_SpinEdit_New(Parent: AControl): AControl; stdcall; deprecated; // Use AUiSpinEdit_New()

function AUi_SpinEdit_NewA(Parent: AControl; Value, MinValue, MaxValue: AInteger): AControl; stdcall; // Use AUiSpinEdit_NewEx()

// --- Ui_SpinEdit ---

function UI_SpinEdit_New(Parent: AControl): AControl; stdcall; deprecated; // Use AUiSpinEdit_New()

function UI_SpinEdit_NewA(Parent: AControl; Value, MinValue, MaxValue: AInteger): AControl; stdcall; // Use AUiSpinEdit_NewEx()

implementation

// --- AUiSpinEdit ---

function AUiSpinEdit_New(Parent: AControl): AControl;
var
  SpinEdit: TSpinEdit;
begin
  try
    SpinEdit := TSpinEdit.Create(TWinControl(Parent));
    SpinEdit.Parent := TWinControl(Parent);
    Result := AUiData.AddObject(SpinEdit);
  except
    Result := 0;
  end;
end;

function AUiSpinEdit_NewEx(Parent: AControl; Value, MinValue, MaxValue: AInteger): AControl;
var
  SpinEdit: TSpinEdit;
begin
  try
    SpinEdit := TSpinEdit.Create(TWinControl(Parent));
    SpinEdit.Parent := TWinControl(Parent);
    SpinEdit.Value := Value;
    SpinEdit.MinValue := MinValue;
    SpinEdit.MaxValue := MaxValue;
    Result := AUiData.AddObject(SpinEdit);
  except
    Result := 0;
  end;
end;

// --- AUi_SpinEdit ---

function AUi_SpinEdit_New(Parent: AControl): AControl;
begin
  Result := AUiSpinEdit_New(Parent);
end;

function AUi_SpinEdit_NewA(Parent: AControl; Value, MinValue, MaxValue: AInteger): AControl;
begin
  Result := AUiSpinEdit_NewEx(Parent, Value, MinValue, MaxValue);
end;

// --- UI_SpinEdit ---

function UI_SpinEdit_New(Parent: AControl): AControl; stdcall;
begin
  Result := AUiSpinEdit_New(Parent);
end;

function UI_SpinEdit_NewA(Parent: AControl; Value, MinValue, MaxValue: AInteger): AControl; stdcall;
begin
  Result := AUiSpinEdit_NewEx(Parent, Value, MinValue, MaxValue);
end;

end.
