{**
@abstract AUi Menus
@author Prof1983 <prof1983@ya.ru>
@created 16.08.2011
@lastmod 19.07.2012
}
unit AUIMenus;

interface

uses
  Menus, ABase, AUiBase, AUiData, AUiEvents;

// --- Menu ---

function UI_Menu_AddItem(Menu: AMenu; const Name, Text: APascalString;
    OnClick: ACallbackProc; ImageId, Weight: AInteger): AMenuItem;

function UI_Menu_GetItems(Menu: AMenu): AMenuItem;

function UI_Menu_New(MenuType: AInteger): AMenu;

// --- MenuItem ---

function UI_MenuItem_Add(ParentMenuItem: AMenuItem; const Name, Text: APascalString;
    OnClick: ACallbackProc; ImageID, Weight, Tag: Integer): AMenuItem;

function UI_MenuItem_Add02(ParentMenuItem: AMenuItem; const Name, Text: APascalString;
    OnClick: ACallbackProc02; ImageID, Weight: Integer): AMenuItem;

function UI_MenuItem_Add03(ParentMenuItem: AMenuItem; const Name, Text: APascalString;
    OnClick: ACallbackProc03; ImageID, Weight, Tag: Integer): AMenuItem;

function UI_MenuItem_Add2(Parent: AMenuItem; MenuItem: AMenuItem; Weight: AInteger): AMenuItem;

function UI_MenuItem_AddEx(ParentMenuItem: AMenuItem; const Name, Text: APascalString;
    ImageID, Weight, Tag: AInteger; out ResIndex: AInteger): AError;

function UI_MenuItem_FindByName(MenuItem: AMenuItem; const Name: APascalString): AMenuItem;

implementation

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

{ Menu }

function UI_Menu_AddItem(Menu: AMenu; const Name, Text: APascalString;
    OnClick: ACallbackProc; ImageId, Weight: Integer): AMenuItem;
var
  MenuItems: AMenuItem;
begin
  MenuItems := AUIMenus.UI_Menu_GetItems(Menu);

  if (MenuItems = 0) then
  begin
    Result := 0;
    Exit;
  end;

  Result := AUIMenus.UI_MenuItem_Add(MenuItems, Name, Text, OnClick, ImageId, Weight, 0);
end;

function UI_Menu_GetItems(Menu: AMenu): AMenuItem;
var
  O: TObject;
begin
  O := AUIData.GetObject(Menu);
  if Assigned(O) and (O is TMenu) then
  begin
    Result := Integer(TMenu(O).Items);
  end
  else
    Result := 0;
end;

function UI_Menu_New(MenuType: AInteger): AMenu;
begin
  Result := AMenu(TPopupMenu.Create(nil));
end;

{ MenuItem }

function UI_MenuItem_Add(ParentMenuItem: AMenuItem; const Name, Text: APascalString;
    OnClick: ACallbackProc; ImageID, Weight, Tag: Integer): AMenuItem;
var
  Res: AError;
  ResIndex: AInteger;
begin
  Res := UI_MenuItem_AddEx(ParentMenuItem, Name, Text, ImageID, Weight, Tag, ResIndex);
  if (Res < 0) then
  begin
    Result := 0;
    Exit;
  end;
  if (Res = 0) then
  begin
    {$IFDEF A01}
      FMenuItems[ResIndex].OnClick02 := OnClick;
    {$ELSE}
      {$IFDEF A02}
      FMenuItems[ResIndex].OnClick02 := OnClick;
      {$ELSE}
      FMenuItems[ResIndex].OnClick03 := OnClick;
      {$ENDIF A02}
    {$ENDIF A01}
  end;
  Result := FMenuItems[ResIndex].MenuItem;
end;

function UI_MenuItem_Add02(ParentMenuItem: AMenuItem; const Name, Text: APascalString;
    OnClick: ACallbackProc02; ImageID, Weight: Integer): AMenuItem;
var
  Res: AError;
  ResIndex: AInteger;
begin
  Res := UI_MenuItem_AddEx(ParentMenuItem, Name, Text, ImageID, Weight, 0, ResIndex);
  if (Res < 0) then
  begin
    Result := 0;
    Exit;
  end;
  if (Res = 0) then
    FMenuItems[ResIndex].OnClick02 := OnClick;
  Result := FMenuItems[ResIndex].MenuItem;
end;

function UI_MenuItem_Add03(ParentMenuItem: AMenuItem; const Name, Text: APascalString;
    OnClick: ACallbackProc03; ImageID, Weight, Tag: Integer): AMenuItem;
var
  Res: AError;
  ResIndex: AInteger;
begin
  Res := UI_MenuItem_AddEx(ParentMenuItem, Name, Text, ImageID, Weight, 0, ResIndex);
  if (Res < 0) then
  begin
    Result := 0;
    Exit;
  end;
  if (Res = 0) then
    FMenuItems[ResIndex].OnClick03 := OnClick;
  Result := FMenuItems[ResIndex].MenuItem;
end;

function UI_MenuItem_Add2(Parent: AMenuItem; MenuItem: AMenuItem; Weight: Integer): AMenuItem;
var
  I: Integer;
begin
  Result := AddObject(TMenuItem(MenuItem));

  I := Length(FMenuItems);
  SetLength(FMenuItems, I + 1);
  FMenuItems[I].Parent := Parent;
  FMenuItems[I].MenuItem := Result;
  FMenuItems[I].Weight := Weight;
end;

function UI_MenuItem_AddEx(ParentMenuItem: AMenuItem; const Name, Text: APascalString;
    ImageID, Weight, Tag: AInteger; out ResIndex: AInteger): AError;
var
  I: Integer;
  Index: Integer;
  IndexMax: Integer;
  WeightMax: Integer;
  Item: TMenuItem;
  mi: TMenuItem;
  Value: AMenuItem;
begin
  Item := TMenuItem(ParentMenuItem);

  if not(Assigned(Item)) then
  begin
    Result := -2;
    Exit;
  end;

  Value := UI_MenuItem_FindByName(ParentMenuItem, 'mi'+Name);

  if (Value <> 0) then
  begin
    ResIndex := FindMenuItem(Value);
    if (ResIndex < 0) then
      ResIndex := _AddMenuItem(ParentMenuItem, Value, 0);
    Result := 1;
    Exit;
  end;

  // Узнаем индекс элемента для вставки
  IndexMax := -1;
  WeightMax := High(Integer);
  for I := 0 to High(FMenuItems) do
  begin
    if (FMenuItems[I].Parent = ParentMenuItem) and (FMenuItems[I].Weight > Weight) and (FMenuItems[I].Weight < WeightMax) then
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
  ResIndex := _AddMenuItem(ParentMenuItem, Value, Weight);
  Result := 0;
end;

function UI_MenuItem_FindByName(MenuItem: AMenuItem; const Name: APascalString): AMenuItem;
var
  I: Integer;
begin
  I := _FindByName(MenuItem, Name);
  if (I >= 0) then
    Result := AMenuItem(TMenuItem(MenuItem).Items[I])
  else
    Result := 0;
end;

end.
 