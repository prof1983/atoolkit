{**
@Abstract AUi Menus
@Author Prof1983 <prof1983@ya.ru>
@Created 16.08.2011
@LastMod 19.02.2013
}
unit AUiMenus;

{define AStdCall}
{define UseToolMenu}

interface

uses
  Menus,
  ABase,
  AStringMain,
  AUiBase, AUiData, AUiEventsObj;

// --- AUiMenu ---

function AUiMenu_AddItem0(Parent: AMenuItem; MenuItem: AMenuItem;
    Weight: AInt): AMenuItem; {$ifdef AStdCall}stdcall;{$endif}

function AUiMenu_AddItem1(Menu: AMenu; const Name, Text: AString_Type;
    OnClick: ACallbackProc; ImageId, Weight: AInt): AMenuItem; {$ifdef AStdCall}stdcall;{$endif}

function AUiMenu_AddItem1P(Menu: AMenu; const Name, Text: APascalString;
    OnClick: ACallbackProc; ImageId, Weight: AInt): AMenuItem;

function AUiMenu_AddItem2(Parent: AMenuItem; const Name, Text: AString_Type;
    OnClick: ACallbackProc; ImageId, Weight: AInt): AMenuItem; {$ifdef AStdCall}stdcall;{$endif}

function AUiMenu_AddItem2P(ParentMenuItem: AMenuItem; const Name, Text: APascalString;
    OnClick: ACallbackProc; ImageId, Weight: AInt): AMenuItem;

function AUiMenu_AddItem3(Parent: AMenuItem; MenuItem: AMenuItem;
    Weight: AInt): AMenuItem; {$ifdef AStdCall}stdcall;{$endif}

function AUiMenu_AddItem4P(ParentMenuItem: AMenuItem; const Name, Text: APascalString;
    OnClick: ACallbackProc; ImageId, Weight, Tag: AInt): AMenuItem;

function AUiMenu_AddItemExP(ParentMenuItem: AMenuItem; const Name, Text: APascalString;
    ImageId, Weight, Tag: AInt; out ResIndex: AInt): AError;

{** Добавляет элемент меню
    @param Name - имя компонента
    @param TextMin - для MenuItem не используется, для Button - Text
    @param Text - текст (Hint для Button)
    @param ItemType - для MenuItem не используется, для ToolMenu: 0 - Button, 1 - Item }
function AUiMenu_AddItemEx2P(Parent: AMenuItem; const Name, TextMin, Text: APascalString;
    OnClick: ACallbackProc; ItemType, ImageId, Weight, Tag: AInt): AMenuItem;

function AUiMenu_Clear(MenuItem: AMenuItem): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiMenu_FindItemByName(MenuItem: AMenuItem; const Name: AString_Type): AMenuItem; {$ifdef AStdCall}stdcall;{$endif}

function AUiMenu_FindItemByNameP(MenuItem: AMenuItem; const Name: APascalString): AMenuItem;

function AUiMenu_GetItems(Menu: AMenu): AMenuItem; {$ifdef AStdCall}stdcall;{$endif}

function AUiMenu_GetSubMenuP(Parent: AMenuItem; const Name, Text: APascalString;
    ImageId, Weight: AInt): AMenuItem;

function AUiMenu_New(MenuType: AInt): AMenu; {$ifdef AStdCall}stdcall;{$endif}

{ MenuType: 0 - MainMenu, 1 - PopupMenu, 2 - ToolMenu }
function AUiMenu_New2(Parent: AControl; MenuType: AInt): AMenu; {$ifdef AStdCall}stdcall;{$endif}

function AUiMenu_SetChecked(MenuItem: AMenuItem; Checked: ABoolean): AError; {$ifdef AStdCall}stdcall;{$endif}

implementation

{$ifdef UseToolMenu}
uses
  AUiToolMenu;
{$endif}

{ Private }

function _AddMenuItem(Parent, Value: AMenuItem; Weight: AInteger): AInteger;
var
  I: Integer;
begin
  I := Length(FMenuItems);
  SetLength(FMenuItems, I + 1);
  FMenuItems[I].Parent := Parent;
  FMenuItems[I].MenuItem := Value;
  FMenuItems[I].Weight := Weight;
  Result := I;
end;

function _Find(Parent, Item: AMenuItem): AInt;
var
  I: Integer;
begin
  for I := 0 to TMenuItem(Parent).Count - 1 do
  begin
    if (AMenuItem(TMenuItem(Parent).Items[I]) = Item) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

function _FindByName(MenuItem: AMenuItem; const Name: APascalString): AInteger;
var
  I: Integer;
begin
  for I := 0 to TMenuItem(MenuItem).Count - 1 do
  begin
    if (TMenuItem(MenuItem).Items[I].Name = Name) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

// --- AUiMenu ---

function AUiMenu_AddItem0(Parent: AMenuItem; MenuItem: AMenuItem;
    Weight: AInt): AMenuItem;
begin
  Result := AUiMenu_AddItem3(Parent, MenuItem, Weight);
end;

function AUiMenu_AddItem1(Menu: AMenu; const Name, Text: AString_Type;
    OnClick: ACallbackProc; ImageId, Weight: AInt): AMenuItem;
begin
  Result := AUiMenu_AddItemEx2P(Menu,
      AString_ToPascalString(Name), '', AString_ToPascalString(Text),
      OnClick, 0, ImageId, Weight, 0);
end;

function AUiMenu_AddItem1P(Menu: AMenu; const Name, Text: APascalString;
    OnClick: ACallbackProc; ImageId, Weight: AInt): AMenuItem;
begin
  Result := AUiMenu_AddItemEx2P(Menu, Name, '', Text, OnClick, 0, ImageId, Weight, 0);
end;

function AUiMenu_AddItem2(Parent: AMenuItem; const Name, Text: AString_Type;
    OnClick: ACallbackProc; ImageId, Weight: AInt): AMenuItem;
begin
  Result := AUiMenu_AddItemEx2P(Parent,
      AString_ToPascalString(Name), '', AString_ToPascalString(Text),
      OnClick, 0, ImageId, Weight, 0);
end;

function AUiMenu_AddItem2P(ParentMenuItem: AMenuItem; const Name, Text: APascalString;
    OnClick: ACallbackProc; ImageId, Weight: AInt): AMenuItem;
begin
  Result := AUiMenu_AddItemEx2P(ParentMenuItem, Name, '', Text, OnClick, 0, ImageId, Weight, 0);
end;

function AUiMenu_AddItem3(Parent: AMenuItem; MenuItem: AMenuItem;
    Weight: AInt): AMenuItem;
var
  I: Integer;
  Res: AMenuItem;
begin
  try
    if not(TObject(Parent) is TMenu) and not(TObject(Parent) is TMenuItem) then
    begin
      Result := 0;
      Exit;
    end;

    Res := AddObject(TMenuItem(MenuItem));
    I := Length(FMenuItems);
    SetLength(FMenuItems, I + 1);
    FMenuItems[I].Parent := Parent;
    FMenuItems[I].MenuItem := Res;
    FMenuItems[I].Weight := Weight;
    Result := Res;
  except
    Result := 0;
  end;
end;

function AUiMenu_AddItem4P(ParentMenuItem: AMenuItem; const Name, Text: APascalString;
    OnClick: ACallbackProc; ImageId, Weight, Tag: AInt): AMenuItem;
begin
  try
    Result := AUiMenu_AddItemEx2P(ParentMenuItem, Name, '', Text, OnClick, 0, ImageId, Weight, Tag);
  except
    Result := 0;
  end;
end;

function AUiMenu_AddItemExP(ParentMenuItem: AMenuItem; const Name, Text: APascalString;
    ImageId, Weight, Tag: AInt; out ResIndex: AInt): AError;
begin
  Result := AUiMenu_AddItemEx2P(ParentMenuItem, Name, '', Text, nil, 0, ImageId, Weight, Tag);
  ResIndex := _Find(ParentMenuItem, Result);
end;

function AUiMenu_AddItemEx2P(Parent: AMenuItem; const Name, TextMin, Text: APascalString;
    OnClick: ACallbackProc; ItemType, ImageId, Weight, Tag: AInt): AMenuItem;
var
  I: Integer;
  Index: Integer;
  IndexMax: Integer;
  WeightMax: Integer;
  Item: TMenuItem;
  mi: TMenuItem;
  Value: AMenuItem;
  ResIndex: AInt;
begin
  if (Parent = 0) then
  begin
    Result := 0;
    Exit;
  end;

  try
    if (TObject(Parent) is TMenu) then
    begin
      Parent := AUiMenu_GetItems(Parent);
      if (Parent = 0) then
      begin
        Result := 0;
        Exit;
      end;
    end;

    if not(TObject(Parent) is TMenuItem) then
    begin
      {$ifdef UseToolMenu}
      if ItemType = 0 then
        Result := AUiToolMenu_AddButtonP(Parent, Name, Text, TextMin, OnClick, ImageId, Weight)
      else
        Result := AUiToolMenu_AddNewItemP(Parent, Name, TextMin, OnClick, ImageId, Weight);
      {$else}
      Result := 0;
      {$endif}
      Exit;
    end;

    Item := TMenuItem(Parent);

    if not(Assigned(Item)) then
    begin
      Result := 0;
      Exit;
    end;

    Value := AUiMenu_FindItemByNameP(Parent, 'mi'+Name);

    if (Value <> 0) then
    begin
      ResIndex := FindMenuItem(Value);
      if (ResIndex < 0) then
        _AddMenuItem(Parent, Value, 0);
      Result := FMenuItems[ResIndex].MenuItem;
      Exit;
    end;

    // Узнаем индекс элемента для вставки
    IndexMax := -1;
    WeightMax := High(Integer);
    for I := 0 to High(FMenuItems) do
    begin
      if (FMenuItems[I].Parent = Parent) and (FMenuItems[I].Weight > Weight) and (FMenuItems[I].Weight < WeightMax) then
      begin
        IndexMax := I;
        WeightMax := FMenuItems[I].Weight;
      end;
    end;
    Index := IndexMax;

    mi := TMenuItem.Create(nil);
    mi.Name := 'mi'+Name;
    mi.Caption := Text;
    mi.OnClick := UI_.MenuItemClick;
    mi.Tag := Tag;

    if (Index >= 0) then
      Item.Insert(TMenuItem(FMenuItems[Index].MenuItem).MenuIndex, mi)
    else
      Item.Add(mi);

    Value := AddObject(mi);
    ResIndex := _AddMenuItem(Parent, Value, Weight);

    FMenuItems[ResIndex].OnClick := OnClick;

    Result := Value;
  except
    Result := 0;
  end;
end;

function AUiMenu_Clear(MenuItem: AMenuItem): AError;
begin
  try
    if (TObject(MenuItem) is TMenu) then
    begin
      TMenu(MenuItem).Items.Clear();
      Result := 0;
    end
    else if (TObject(MenuItem) is TMenuItem) then
    begin
      TMenuItem(MenuItem).Clear();
      Result := 0;
    end
    else
      Result := -2;
  except
    Result := -1;
  end;
end;

function AUiMenu_FindItemByName(MenuItem: AMenuItem; const Name: AString_Type): AMenuItem;
begin
  Result := AUiMenu_FindItemByNameP(MenuItem, AString_ToPascalString(Name));
end;

function AUiMenu_FindItemByNameP(MenuItem: AMenuItem; const Name: APascalString): AMenuItem;
var
  I: Integer;
begin
  try
    if not(TObject(MenuItem) is TMenuItem) then
    begin
      Result := 0;
      Exit;
    end;

    I := _FindByName(MenuItem, Name);
    if (I >= 0) then
      Result := AMenuItem(TMenuItem(MenuItem).Items[I])
    else
      Result := 0;
  except
    Result := 0;
  end;
end;

function AUiMenu_GetItems(Menu: AMenu): AMenuItem;
var
  O: TObject;
begin
  try
    O := AUiData.GetObject(Menu);
    if Assigned(O) and (O is TMenu) then
    begin
      Result := Integer(TMenu(O).Items);
    end
    else
      Result := 0;
  except
    Result := 0;
  end;
end;

function AUiMenu_GetSubMenuP(Parent: AMenuItem; const Name, Text: APascalString;
    ImageId, Weight: AInt): AMenuItem;
var
  Index: Integer;
begin
  try
    if not(TObject(Parent) is TMenuItem) then
    begin
      {$ifdef UseToolMenu}
      Result := AUiToolMenu_GetSubMenuP(Parent, Name, Text, ImageId, Weight);
      {$else}
      Result := 0;
      {$endif}
      Exit;
    end;

    Index := _FindByName(Parent, Name);
    if (Index >= 0) then
    begin
      Result := AMenuItem(TMenuItem(Parent).Items[Index]);
      Exit;
    end;
    Result := AUiMenu_AddItem1P(Parent, Name, Text, nil, ImageId, Weight);
  except
    Result := 0;
  end;
end;

function AUiMenu_New(MenuType: AInt): AMenu;
begin
  Result := AUiMenu_New2(0, MenuType);
end;

function AUiMenu_New2(Parent: AControl; MenuType: AInt): AMenu;
begin
  try
    if (MenuType = 1) then
      Result := AMenu(TPopupMenu.Create(nil))
    {$ifdef UseToolMenu}
    else if (MenuType = 2) then
      Result := AUiToolMenu_New(Parent)
    {$endif}
    else
      Result := AMenu(TMainMenu.Create(nil));
  except
    Result := 0;
  end;
end;

function AUiMenu_SetChecked(MenuItem: AMenuItem; Checked: ABoolean): AError;
begin
  try
    if not(TObject(MenuItem) is TMenuItem) then
    begin
      Result := 0;
      Exit;
    end;

    TMenuItem(MenuItem).Checked := Checked;
    Result := -1;
  except
    Result := 0;
  end;
end;

end.
 