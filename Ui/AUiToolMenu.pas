{**
@abstract AUi ToolMenu
@author Prof1983 <prof1983@ya.ru>
@created 28.02.2012
@lastmod 19.07.2012
}
unit AUiToolMenu;

interface

uses
  ComCtrls, Menus,
  ABase, AUiBase, AUiData, AUiMenus, AUiPageControl;

function UI_ToolMenu_AddNewItem(Parent: AToolMenu; const Name, Text: AWideString;
    OnClick: ACallbackProc; ImageId, Weight: AInteger): AToolMenu;

function UI_ToolMenu_AddNewSubMenu(Parent: AToolMenu; const Name, Text: APascalString;
    ImageId, Weight: AInteger): AToolMenu;

function UI_ToolMenu_GetSubMenu(Parent: AToolMenu; const Name, Text: APascalString;
    ImageId, Weight: AInteger): AToolMenu;

implementation

// --- Private ---

function _FindToolMenuByName(Parent: AToolMenu; const Name: APascalString): AInteger;
var
  I: Integer;
  ParentName: APascalString;
begin
  for I := 0 to High(FToolMenus) do
  begin
    if (FToolMenus[I].PageControl = Parent) and (FToolMenus[I].Page <> 0) then
    begin
      ParentName := TPageControl(FToolMenus[I].PageControl).Name;
      if (TTabSheet(FToolMenus[I].Page).Name = ParentName+'_'+Name) then
      begin
        Result := I;
        Exit;
      end;
    end;
  end;
  Result := -1;
end;

// --- Public ---

function UI_ToolMenu_AddNewItem(Parent: AToolMenu; const Name, Text: AWideString;
    OnClick: ACallbackProc; ImageId, Weight: AInteger): AToolMenu;
var
  Index: AInteger;
  I: Integer;
  O: TObject;
  Page: AControl;
  //CoolBar: TCoolBar;
begin
  if (Parent = 0) then
  begin
    Result := 0;
    Exit;
  end;

  Index := AUIData.FindToolMenu(Parent);
  if (Index >= 0) then
  begin

    Page := UI_PageControl_AddPage(FToolMenus[Index].PageControl,
        TPageControl(FToolMenus[Index].PageControl).Name+'_'+Name, Text);
    I := Length(FToolMenus);
    SetLength(FToolMenus, I + 1);
    FToolMenus[I].PageControl := FToolMenus[Index].PageControl;
    FToolMenus[I].Page := Page;

    {
    CoolBar := TCoolBar.Create(TComponent(Page));
    CoolBar.Parent := TWinControl(Page);
    CoolBar.Align := alClient;

    UI_ToolBar_New(AControl(CoolBar));
    }

    Result := Page;
    Exit;
  end;

  Index := AUIData.FindMenuItem(Parent);
  if (Index >= 0) then
  begin
    Result := AToolMenu(AUIMenus.UI_MenuItem_Add(AMenuItem(Parent), Name, Text, OnClick, ImageId, Weight, 0));
    Exit;
  end;

  O := TObject(Parent);

  if (O is TMenu) then
  begin
    Result := AToolMenu(UI_Menu_AddItem(AMenu(Parent), Name, Text, OnClick, ImageId, Weight));
    Exit;
  end;

  if (O is TToolBar) then
  begin
    Result := Parent;
    Exit;
  end;

  Result := 0;
end;

function UI_ToolMenu_AddNewSubMenu(Parent: AToolMenu; const Name, Text: APascalString;
    ImageId, Weight: AInteger): AToolMenu;
begin
  Result := UI_ToolMenu_AddNewItem(Parent, Name, Text, nil, ImageId, Weight);
end;

function UI_ToolMenu_GetSubMenu(Parent: AToolMenu; const Name, Text: APascalString;
    ImageId, Weight: AInteger): AToolMenu;
var
  Index: Integer;
begin
  Index := _FindToolMenuByName(Parent, Name);
  if (Index >= 0) then
  begin
    Result := FToolMenus[Index].Page;
    Exit;
  end;
  Result := UI_ToolMenu_AddNewSubMenu(Parent, Name, Text, ImageId, Weight);
end;

end.
 