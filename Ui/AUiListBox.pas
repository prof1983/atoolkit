{**
@Abstract AUiListBox
@Author Prof1983 <prof1983@ya.ru>
@Created 05.09.2012
@LastMod 05.09.2012
}
unit AUiListBox;

{$define AStdCall}

interface

uses
  Controls, ExtCtrls, StdCtrls,
  ABase, AStrings,
  AUiBase, AUiData, AUiEventsObj;

// --- AUiListBox ---

function AUiListBox_Add(ListBox: AControl; const Text: AString_Type): Integer; {$ifdef AStdCall}stdcall;{$endif}

{** Добавляет строку в список }
function AUiListBox_AddP(ListBox: AControl; const Text: APascalString): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function AUiListBox_Clear(ListBox: AControl): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiListBox_DeleteItem(ListBox: AControl; Index: AInteger): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiListBox_GetCount(ListBox: AControl): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function AUiListBox_GetItem(ListBox: AControl; Index: AInteger; out Value: AString_Type): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function AUiListBox_GetItemIndex(ListBox: AControl): AInteger; {$ifdef AStdCall}stdcall;{$endif}

{** Создает новый элемент ListBox }
function AUiListBox_New(Parent: AControl): AControl; {$ifdef AStdCall}stdcall;{$endif}

{** Создает новый элемент ListBox }
function AUiListBox_New2(Parent: AControl; Typ: AInteger): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiListBox_SetItem(ListBox: AControl; Index: AInteger; const Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiListBox_SetItemIndex(ListBox: AControl; Index: AInteger): AError; {$ifdef AStdCall}stdcall;{$endif}

// --- AUi_ListBox ---

function AUi_ListBox_Add(ListBox: AControl; const Text: AString_Type): Integer; stdcall;

procedure AUi_ListBox_Clear(ListBox: AControl); stdcall;

procedure AUi_ListBox_DeleteItem(ListBox: AControl; Index: AInteger); stdcall;

function AUi_ListBox_GetCount(ListBox: AControl): AInteger; stdcall;

function AUi_ListBox_GetItem(ListBox: AControl; Index: AInteger; out Value: AString_Type): AInteger; stdcall;

function AUi_ListBox_GetItemIndex(ListBox: AControl): AInteger; stdcall;

function AUi_ListBox_New(Parent: AControl): AControl; stdcall;

{** Create net list box
    @param Typ: 0 - ListBox; 1 - RadioGroup }
function AUi_ListBox_NewA(Parent: AControl; Typ: AInteger): AControl; stdcall;

procedure AUi_ListBox_SetItem(ListBox: AControl; Index: AInteger; const Value: AString_Type); stdcall;

procedure AUi_ListBox_SetItemIndex(ListBox: AControl; Index: AInteger); stdcall;

// --- UI_ListBox ---

//** Добавляет строку в список.
function UI_ListBox_Add(ListBox: AControl; const Text: APascalString): Integer; stdcall;

procedure UI_ListBox_Clear(ListBox: AControl); stdcall;

//** Создает новый элемент ListBox.
function UI_ListBox_New(Parent: AControl): AControl; stdcall;

{ Typ:
  0 - ListBox
  1 - RadioGroup }
function UI_ListBox_NewA(Parent: AControl; Typ: AInteger): AControl; stdcall;

function UI_ListBox_GetCount(ListBox: AControl): AInteger; stdcall;

function UI_ListBox_GetItem(ListBox: AControl; Index: AInteger): APascalString; stdcall;

function UI_ListBox_GetItemIndex(ListBox: AControl): AInteger; stdcall;

procedure UI_ListBox_SetItemIndex(ListBox: AControl; Index: AInteger); stdcall;

procedure UI_ListBox_DeleteItem(ListBox: AControl; Index: AInteger); stdcall;

procedure UI_ListBox_SetItem(ListBox: AControl; Index: AInteger; const Value: APascalString); stdcall;

implementation

// --- AUiListBox ---

function AUiListBox_Add(ListBox: AControl; const Text: AString_Type): Integer;
begin
  try
    Result := AUiListBox_AddP(ListBox, AString_ToPascalString(Text));
  except
    Result := -1;
  end;
end;

function AUiListBox_AddP(ListBox: AControl; const Text: APascalString): AInteger; stdcall;
var
  O: TObject;
begin
  try
    O := AUiData.GetObject(ListBox);
    if Assigned(O) and (O is TListBox) then
      Result := TListBox(O).Items.Add(Text)
    else if Assigned(O) and (O is TRadioGroup) then
      Result := TRadioGroup(O).Items.Add(Text)
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function AUiListBox_Clear(ListBox: AControl): AError;
begin
  try
    UI_ListBox_Clear(ListBox);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiListBox_DeleteItem(ListBox: AControl; Index: AInteger): AError;
begin
  try
    UI_ListBox_DeleteItem(ListBox, Index);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiListBox_GetCount(ListBox: AControl): AInteger;
begin
  try
    Result := UI_ListBox_GetCount(ListBox);
  except
    Result := 0;
  end;
end;

function AUiListBox_GetItem(ListBox: AControl; Index: AInteger; out Value: AString_Type): AInteger;
begin
  try
    Result := AString_AssignP(Value, UI_ListBox_GetItem(ListBox, Index));
  except
    Result := 0;
  end;
end;

function AUiListBox_GetItemIndex(ListBox: AControl): AInteger;
begin
  try
    Result := UI_ListBox_GetItemIndex(ListBox);
  except
    Result := 0;
  end;
end;

function AUiListBox_New(Parent: AControl): AControl;
begin
  try
    Result := AUiListBox_New2(Parent, 0);
  except
    Result := 0;
  end;
end;

function AUiListBox_New2(Parent: AControl; Typ: AInteger): AControl;
var
  O: TObject;
  ListBox: TListBox;
  RadioGroup: TRadioGroup;
  I: Integer;
begin
  try
    O := AUIData.GetObject(Parent);
    if not(Assigned(O)) then
    begin
      Result := 0;
      Exit;
    end;
    if not(O is TWinControl) then
    begin
      Result := 0;
      Exit;
    end;
    if (Typ = 1) then
    begin
      RadioGroup := TRadioGroup.Create(TWinControl(O));
      RadioGroup.Parent := TWinControl(O);
      Result := AddObject(RadioGroup);
    end
    else
    begin
      ListBox := TListBox.Create(TWinControl(O));
      ListBox.Parent := TWinControl(O);
      ListBox.Align := alClient;
      Result := AddObject(ListBox);

      I := Length(FListBoxs);
      SetLength(FListBoxs, I+1);
      FListBoxs[I].ListBox := Result;
      ListBox.OnClick := UI_.ListBoxClick;
      FListBoxs[I].OnClick02 := nil;
      FListBoxs[I].OnClick03 := nil;
    end;
  except
    Result := 0;
  end;
end;

function AUiListBox_SetItem(ListBox: AControl; Index: AInteger; const Value: AString_Type): AError;
begin
  try
    UI_ListBox_SetItem(ListBox, Index, AStrings.String_ToWideString(Value));
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiListBox_SetItemIndex(ListBox: AControl; Index: AInteger): AError;
begin
  try
    UI_ListBox_SetItemIndex(ListBox, Index);
    Result := 0;
  except
    Result := -1;
  end;
end;

// --- AUi_ListBox ---

function AUi_ListBox_Add(ListBox: AControl; const Text: AString_Type): Integer;
begin
  Result := AUiListBox_Add(ListBox, Text);
end;

procedure AUi_ListBox_Clear(ListBox: AControl);
begin
  AUiListBox_Clear(ListBox);
end;

procedure AUi_ListBox_DeleteItem(ListBox: AControl; Index: AInteger);
begin
  AUiListBox_DeleteItem(ListBox, Index);
end;

function AUi_ListBox_GetCount(ListBox: AControl): AInteger;
begin
  Result := AUiListBox_GetCount(ListBox);
end;

function AUi_ListBox_GetItem(ListBox: AControl; Index: AInteger; out Value: AString_Type): AInteger;
begin
  Result := AUiListBox_GetItem(ListBox, Index, Value);
end;

function AUi_ListBox_GetItemIndex(ListBox: AControl): AInteger;
begin
  Result := AUiListBox_GetItemIndex(ListBox);
end;

function AUi_ListBox_New(Parent: AControl): AControl;
begin
  Result := AUiListBox_New(Parent);
end;

function AUi_ListBox_NewA(Parent: AControl; Typ: AInteger): AControl;
begin
  Result := AUiListBox_New2(Parent, Typ);
end;

procedure AUi_ListBox_SetItem(ListBox: AControl; Index: AInteger; const Value: AString_Type);
begin
  AUiListBox_SetItem(ListBox, Index, Value);
end;

procedure AUi_ListBox_SetItemIndex(ListBox: AControl; Index: AInteger);
begin
  AUiListBox_SetItemIndex(ListBox, Index);
end;

{ ListBox }

function UI_ListBox_Add(ListBox: AControl; const Text: APascalString): Integer; stdcall;
begin
  Result := AUiListBox_AddP(ListBox, Text);
end;

procedure UI_ListBox_Clear(ListBox: AControl); stdcall;
var
  O: TObject;
begin
  O := AUIData.GetObject(ListBox);
  if Assigned(O) and (O is TListBox) then
    TListBox(O).Clear
  else if Assigned(O) and (O is TRadioGroup) then
    TRadioGroup(O).Items.Clear;
  {if (ListBox <> 0) then
    TListBox(ListBox).Clear;}
end;

procedure UI_ListBox_DeleteItem(ListBox: AControl; Index: AInteger); stdcall;
begin
  TListBox(ListBox).Items.Delete(Index);
  if (TListBox(ListBox).Items.Count > Index) then
    TListBox(ListBox).ItemIndex := Index
  else
    TListBox(ListBox).ItemIndex := Index-1;
end;

function UI_ListBox_GetCount(ListBox: AControl): AInteger; stdcall;
var
  Obj: TObject;
begin
  Obj := AUIData.GetObject(ListBox);
  if Assigned(Obj) and (Obj is TListBox) then
    Result := TListBox(Obj).Items.Count
  else if Assigned(Obj) and (Obj is TRadioGroup) then
    Result := TRadioGroup(Obj).Items.Count
  else
    Result := 0;
end;

function UI_ListBox_GetItem(ListBox: AControl; Index: AInteger): APascalString; stdcall;
var
  O: TObject;
begin
  O := AUIData.GetObject(ListBox);
  if Assigned(O) and (O is TListBox) then
    Result := TListBox(O).Items[Index]
  else if Assigned(O) and (O is TRadioGroup) then
    Result := TRadioGroup(O).Items[Index]
  else
    Result := '';
end;

function UI_ListBox_GetItemIndex(ListBox: AControl): AInteger; stdcall;
var
  O: TObject;
begin
  O := AUIData.GetObject(ListBox);
  if Assigned(O) and (O is TListBox) then
    Result := TListBox(O).ItemIndex
  else if Assigned(O) and (O is TRadioGroup) then
    Result := TRadioGroup(O).ItemIndex
  else
    Result := 0;
end;

function UI_ListBox_New(Parent: AControl): AControl; stdcall;
begin
  Result := AUiListBox_New(Parent);
end;

function UI_ListBox_NewA(Parent: AControl; Typ: AInteger): AControl; stdcall;
begin
  Result := AUiListBox_New2(Parent, Typ);
end;

procedure UI_ListBox_SetItem(ListBox: AControl; Index: AInteger; const Value: APascalString); stdcall;
begin
  TListBox(ListBox).Items[Index] := Value;
end;

procedure UI_ListBox_SetItemIndex(ListBox: AControl; Index: AInteger); stdcall;
var
  Obj: TObject;
begin
  Obj := AUIData.GetObject(ListBox);
  if Assigned(Obj) and (Obj is TListBox) then
    TListBox(Obj).ItemIndex := Index
  else if Assigned(Obj) and (Obj is TRadioGroup) then
    TRadioGroup(Obj).ItemIndex := Index;
end;

end.
