{**
@Abstract AUiComboBox
@Author Prof1983 <prof1983@ya.ru>
@Created 06.09.2012
@LastMod 19.02.2013
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

// --- AUiComboBox ---

function AUiComboBox_Add(ComboBox: AControl; const Value: AString_Type): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AUiComboBox_AddA(ComboBox: AControl; Value: AStr): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AUiComboBox_AddP(ComboBox: AControl; const Value: APascalString): AInt; 

function AUiComboBox_GetItemIndex(ComboBox: AControl): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AUiComboBox_New(Parent: AControl): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiComboBox_New2(Parent: AControl; Left, Top, Width: AInt): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiComboBox_SetItemIndex(ComboBox: AControl; Value: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

implementation

// --- AUiComboBox ---

function AUiComboBox_Add(ComboBox: AControl; const Value: AString_Type): AInt;
begin
  try
    Result := AUiComboBox_AddP(ComboBox, AString_ToPascalString(Value));
  except
    Result := -1;
  end;
end;

function AUiComboBox_AddA(ComboBox: AControl; Value: AStr): AInt;
begin
  Result := AUiComboBox_AddP(ComboBox, AnsiString(Value));
end;

function AUiComboBox_AddP(ComboBox: AControl; const Value: APascalString): AInt;
begin
  try
    Result := TComboBox(ComboBox).Items.Add(Value);
  except
    Result := -1;
  end;
end;

function AUiComboBox_GetItemIndex(ComboBox: AControl): AInt;
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

function AUiComboBox_New2(Parent: AControl; Left, Top, Width: AInt): AControl;
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

function AUiComboBox_SetItemIndex(ComboBox: AControl; Value: AInt): AError;
begin
  try
    TComboBox(ComboBox).ItemIndex := Value;
    Result := 0
  except
    Result := -1;
  end;
end;

end.
