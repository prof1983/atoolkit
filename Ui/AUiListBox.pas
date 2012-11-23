{**
@Abstract AUiListBox
@Author Prof1983 <prof1983@ya.ru>
@Created 05.09.2012
@LastMod 15.11.2012
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

function AUiListBox_GetItemP(ListBox: AControl; Index: AInteger): APascalString; {$ifdef AStdCall}stdcall;{$endif}

function AUiListBox_GetItemIndex(ListBox: AControl): AInteger; {$ifdef AStdCall}stdcall;{$endif}

{** Создает новый элемент ListBox }
function AUiListBox_New(Parent: AControl): AControl; {$ifdef AStdCall}stdcall;{$endif}

{** Создает новый элемент ListBox }
function AUiListBox_New2(Parent: AControl; Typ: AInteger): AControl; {$ifdef AStdCall}stdcall;{$endif}

function AUiListBox_SetItem(ListBox: AControl; Index: AInteger; const Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiListBox_SetItemHeight(ListBox: AControl; Value: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiListBox_SetItemP(ListBox: AControl; Index: AInteger; const Value: APascalString): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiListBox_SetItemIndex(ListBox: AControl; Index: AInteger): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiListBox_SetOnDblClick(ListBox: AControl; Value: ACallbackProc): AError; {$ifdef AStdCall}stdcall;{$endif}

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
function UI_ListBox_Add(ListBox: AControl; const Text: APascalString): Integer; stdcall; deprecated;

procedure UI_ListBox_Clear(ListBox: AControl); stdcall; deprecated;

//** Создает новый элемент ListBox.
function UI_ListBox_New(Parent: AControl): AControl; stdcall; deprecated;

{ Typ:
  0 - ListBox
  1 - RadioGroup }
function UI_ListBox_NewA(Parent: AControl; Typ: AInteger): AControl; stdcall; deprecated;

function UI_ListBox_GetCount(ListBox: AControl): AInteger; stdcall; deprecated;

function UI_ListBox_GetItem(ListBox: AControl; Index: AInteger): APascalString; stdcall; deprecated;

function UI_ListBox_GetItemIndex(ListBox: AControl): AInteger; stdcall; deprecated;

procedure UI_ListBox_SetItemIndex(ListBox: AControl; Index: AInteger); stdcall; deprecated;

procedure UI_ListBox_DeleteItem(ListBox: AControl; Index: AInteger); stdcall; deprecated;

procedure UI_ListBox_SetItem(ListBox: AControl; Index: AInteger; const Value: APascalString); stdcall; deprecated;

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
var
  O: TObject;
begin
  try
    O := AUIData.GetObject(ListBox);
    if Assigned(O) and (O is TListBox) then
      TListBox(O).Clear
    else if Assigned(O) and (O is TRadioGroup) then
      TRadioGroup(O).Items.Clear;
    {if (ListBox <> 0) then
      TListBox(ListBox).Clear;}
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiListBox_DeleteItem(ListBox: AControl; Index: AInteger): AError;
begin
  try
    TListBox(ListBox).Items.Delete(Index);
    if (TListBox(ListBox).Items.Count > Index) then
      TListBox(ListBox).ItemIndex := Index
    else
      TListBox(ListBox).ItemIndex := Index-1;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiListBox_GetCount(ListBox: AControl): AInteger;
var
  Obj: TObject;
begin
  try
    Obj := AUIData.GetObject(ListBox);
    if Assigned(Obj) and (Obj is TListBox) then
      Result := TListBox(Obj).Items.Count
    else if Assigned(Obj) and (Obj is TRadioGroup) then
      Result := TRadioGroup(Obj).Items.Count
    else
      Result := 0;
  except
    Result := 0;
  end;
end;

function AUiListBox_GetItem(ListBox: AControl; Index: AInteger; out Value: AString_Type): AInteger;
begin
  try
    Result := AString_AssignP(Value, AUiListBox_GetItemP(ListBox, Index));
  except
    Result := 0;
  end;
end;

function AUiListBox_GetItemP(ListBox: AControl; Index: AInteger): APascalString;
var
  O: TObject;
begin
  O := AUiData.GetObject(ListBox);
  if Assigned(O) and (O is TListBox) then
    Result := TListBox(O).Items[Index]
  else if Assigned(O) and (O is TRadioGroup) then
    Result := TRadioGroup(O).Items[Index]
  else
    Result := '';
end;

function AUiListBox_GetItemIndex(ListBox: AControl): AInteger;
var
  O: TObject;
begin
  try
    O := AUiData.GetObject(ListBox);
    if Assigned(O) and (O is TListBox) then
      Result := TListBox(O).ItemIndex
    else if Assigned(O) and (O is TRadioGroup) then
      Result := TRadioGroup(O).ItemIndex
    else
      Result := 0;
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
  Result := AUiListBox_SetItemP(ListBox, Index, AStrings.String_ToWideString(Value));
end;

function AUiListBox_SetItemHeight(ListBox: AControl; Value: AInt): AError;
var
  Obj: TObject;
begin
  try
    Obj := GetObject(ListBox);
    if not(Assigned(Obj)) then
    begin
      Result := -2;
      Exit;
    end;

    if (Obj is TListBox) then
      TListBox(Obj).ItemHeight := Value;

    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiListBox_SetItemP(ListBox: AControl; Index: AInteger; const Value: APascalString): AError;
begin
  try
    TListBox(ListBox).Items[Index] := Value;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiListBox_SetItemIndex(ListBox: AControl; Index: AInteger): AError;
var
  Obj: TObject;
begin
  try
    Obj := AUIData.GetObject(ListBox);
    if Assigned(Obj) and (Obj is TListBox) then
      TListBox(Obj).ItemIndex := Index
    else if Assigned(Obj) and (Obj is TRadioGroup) then
      TRadioGroup(Obj).ItemIndex := Index;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiListBox_SetOnDblClick(ListBox: AControl; Value: ACallbackProc): AError;
var
  I: AInt;
begin
  try
    I := FindListBox(ListBox);
    if (I >= 0) then
      FListBoxs[I].OnDblClick := Value;
    Result := 0;
  except
    Result := -2;
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

function UI_ListBox_Add(ListBox: AControl; const Text: APascalString): Integer;
begin
  Result := AUiListBox_AddP(ListBox, Text);
end;

procedure UI_ListBox_Clear(ListBox: AControl);
begin
  AUiListBox_Clear(ListBox);
end;

procedure UI_ListBox_DeleteItem(ListBox: AControl; Index: AInteger);
begin
  AUiListBox_DeleteItem(ListBox, Index);
end;

function UI_ListBox_GetCount(ListBox: AControl): AInteger;
begin
  Result := AUiListBox_GetCount(ListBox);
end;

function UI_ListBox_GetItem(ListBox: AControl; Index: AInteger): APascalString;
begin
  Result := AUiListBox_GetItemP(ListBox, Index);
end;

function UI_ListBox_GetItemIndex(ListBox: AControl): AInteger;
begin
  Result := AUiListBox_GetItemIndex(ListBox);
end;

function UI_ListBox_New(Parent: AControl): AControl;
begin
  Result := AUiListBox_New(Parent);
end;

function UI_ListBox_NewA(Parent: AControl; Typ: AInteger): AControl;
begin
  Result := AUiListBox_New2(Parent, Typ);
end;

procedure UI_ListBox_SetItem(ListBox: AControl; Index: AInteger; const Value: APascalString);
begin
  AUiListBox_SetItemP(ListBox, Index, Value);
end;

procedure UI_ListBox_SetItemIndex(ListBox: AControl; Index: AInteger);
begin
  AUiListBox_SetItemIndex(ListBox, Index);
end;

end.
