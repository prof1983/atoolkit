{**
@Abstract AUiComboBox
@Author Prof1983 <prof1983@ya.ru>
@Created 06.09.2012
@LastMod 30.01.2013
}
unit AUiComboBox;

{define AStdCall}

interface

uses
  Controls, StdCtrls,
  ABase,
  AStringMain,
  AUiBase,
  AUiData;

function AUiComboBox_Add(ComboBox: AControl; const Value: AString_Type): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function AUiComboBox_AddA(ComboBox: AControl; Value: AStr): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function AUiComboBox_AddP(ComboBox: AControl; const Value: APascalString): AInteger; 

function AUiComboBox_GetItemIndex(ComboBox: AControl): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function AUiComboBox_New(Parent: AControl): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiComboBox_New2(Parent: AControl; Left, Top, Width: AInteger): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiComboBox_SetItemIndex(ComboBox: AControl; Value: AInteger): AError; {$ifdef AStdCall}stdcall;{$endif}

implementation

// --- AUiComboBox ---

function AUiComboBox_Add(ComboBox: AControl; const Value: AString_Type): AInteger;
begin
  try
    Result := AUiComboBox_AddP(ComboBox, AString_ToPascalString(Value));
  except
    Result := -1;
  end;
end;

function AUiComboBox_AddA(ComboBox: AControl; Value: AStr): AInteger;
begin
  Result := AUiComboBox_AddP(ComboBox, AnsiString(Value));
end;

function AUiComboBox_AddP(ComboBox: AControl; const Value: APascalString): AInteger;
begin
  try
    Result := TComboBox(ComboBox).Items.Add(Value);
  except
    Result := -1;
  end;
end;

function AUiComboBox_GetItemIndex(ComboBox: AControl): AInteger;
begin
  try
    Result := TComboBox(ComboBox).ItemIndex;
  except
    Result := -1;
  end;
end;

function AUiComboBox_New(Parent: AControl): AControl;
var
  ComboBox: TComboBox;
begin
  try
    ComboBox := TComboBox.Create(TWinControl(Parent));
    ComboBox.Parent := TWinControl(Parent);
    Result := AddObject(ComboBox);
  except
    Result := 0;
  end;
end;

function AUiComboBox_New2(Parent: AControl; Left, Top, Width: AInteger): AControl;
var
  ComboBox: TComboBox;
begin
  try
    ComboBox := TComboBox.Create(TWinControl(Parent));
    ComboBox.Parent := TWinControl(Parent);
    ComboBox.Left := Left;
    ComboBox.Top := Top;
    ComboBox.Width := Width;
    Result := AddObject(ComboBox);
  except
    Result := 0;
  end;
end;

function AUiComboBox_SetItemIndex(ComboBox: AControl; Value: AInteger): AError;
begin
  try
    TComboBox(ComboBox).ItemIndex := Value;
    Result := 0
  except
    Result := -1;
  end;
end;

end.
