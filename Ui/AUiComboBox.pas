{**
@Abstract AUiComboBox
@Author Prof1983 <prof1983@ya.ru>
@Created 06.09.2012
@LastMod 16.04.2013
}
unit AUiComboBox;

{$define AStdCall}

interface

uses
  Controls, StdCtrls,
  ABase,
  AStringMain,
  AUiBase, AUiData;

// --- AUiComboBox ---

function AUiComboBox_Add(ComboBox: AControl; const Value: AString_Type): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function AUiComboBox_AddA(ComboBox: AControl; Value: AStr): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function AUiComboBox_AddP(ComboBox: AControl; const Value: APascalString): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function AUiComboBox_GetItemIndex(ComboBox: AControl): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function AUiComboBox_New(Parent: AControl): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiComboBox_New2(Parent: AControl; Left, Top, Width: AInteger): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiComboBox_SetItemIndex(ComboBox: AControl; Value: AInteger): AError; {$ifdef AStdCall}stdcall;{$endif}

// --- UI_ComboBox ---

function UI_ComboBox_Add(ComboBox: AControl; const Value: APascalString): AInteger; stdcall; deprecated; // Use AUiComboBox_Add()

function UI_ComboBox_GetItemIndex(ComboBox: AControl): AInteger; stdcall; deprecated; // Use AUiComboBox_GetItemIndex()

function UI_ComboBox_New(Parent: AControl): AControl; stdcall; deprecated; // Use AUiComboBox_New()

function UI_ComboBox_NewA(Parent: AControl; Left, Top, Width: AInteger): AControl; stdcall; deprecated; // Use AUiComboBox_New2()

procedure UI_ComboBox_SetItemIndex(ComboBox: AControl; Value: AInteger); stdcall; deprecated; // Use AUiComboBox_SetItemIndex()

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

{ UI_ComboBox }

function UI_ComboBox_Add(ComboBox: AControl; const Value: APascalString): AInteger;
begin
  Result := AUiComboBox_AddP(ComboBox, Value);
end;

function UI_ComboBox_GetItemIndex(ComboBox: AControl): AInteger;
begin
  Result := AUiComboBox_GetItemIndex(ComboBox);
end;

function UI_ComboBox_New(Parent: AControl): AControl;
begin
  Result := AUiComboBox_New(Parent);
end;

function UI_ComboBox_NewA(Parent: AControl; Left, Top, Width: AInteger): AControl;
begin
  Result := AUiComboBox_New2(Parent, Left, Top, Width);
end;

procedure UI_ComboBox_SetItemIndex(ComboBox: AControl; Value: AInteger);
begin
  AUiComboBox_SetItemIndex(ComboBox, Value);
end;

end.
