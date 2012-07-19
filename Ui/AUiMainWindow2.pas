{**
@Abstract AUi MainWindow2
@Author Prof1983 <prof1983@ya.ru>
@Created 28.06.2011
@LastMod 19.07.2012
}
unit AUIMainWindow2;

interface

uses
  Forms,
  ABase, AUiBase, AUiData, AUiMainWindow, AUiMenus;

function UI_MainWindow_AddMenuItem(const ParentItemName, Name, Text: APascalString;
    OnClick: ACallbackProc; ImageID, Weight: Integer): AMenuItem; stdcall;

function UI_MainWindow_AddMenuItem02(const ParentItemName, Name, Text: APascalString;
    OnClick: ACallbackProc02; ImageID, Weight: Integer): AMenuItem; stdcall;

function UI_MainWindow_AddMenuItem03(const ParentItemName, Name, Text: APascalString;
    OnClick: ACallbackProc03; ImageID, Weight: Integer): AMenuItem; stdcall;

implementation

function UI_MainWindow_AddMenuItem(const ParentItemName, Name, Text: APascalString;
    OnClick: ACallbackProc; ImageID, Weight: Integer): AMenuItem; stdcall;
begin
  {$IFDEF A01}
    Result := UI_MainWindow_AddMenuItem02(ParentItemName, Name, Text, OnClick, ImageID, Weight);
  {$ELSE}
    {$IFDEF A02}
    Result := UI_MainWindow_AddMenuItem02(ParentItemName, Name, Text, OnClick, ImageID, Weight);
    {$ELSE}
    Result := UI_MainWindow_AddMenuItem03(ParentItemName, Name, Text, OnClick, ImageID, Weight);
    {$ENDIF A02}
  {$ENDIF A01}
end;

function UI_MainWindow_AddMenuItem02(const ParentItemName, Name, Text: APascalString;
    OnClick: ACallbackProc02; ImageID, Weight: Integer): AMenuItem; stdcall;
var
  Items: AMenuItem;
  Parent: AMenuItem;
begin
  if (FMainWindow = 0) then
  begin
    Result := 0;
    Exit;
  end;
  if not(Assigned(TForm(FMainWindow).Menu)) then
  begin
    Result := 0;
    Exit;
  end;

  Items := AMenu(TForm(FMainWindow).Menu.Items);
  if (ParentItemName = '') then
  begin
    Result := UI_MenuItem_FindByName(Items, 'mi'+Name);
    Parent := Items;
  end
  else
  begin
    Parent := UI_MenuItem_FindByName(Items, 'mi'+ParentItemName);
    if (Parent = 0) then
    begin
      Result := 0;
      Exit;
    end;
    Result := UI_MenuItem_FindByName(Parent, 'mi'+Name)
  end;

  if (Result = 0) then
    Result := AUIMenus.UI_MenuItem_Add02(Parent, Name, Text, OnClick, ImageID, Weight);
end;

function UI_MainWindow_AddMenuItem03(const ParentItemName, Name, Text: APascalString;
    OnClick: ACallbackProc03; ImageID, Weight: Integer): AMenuItem; stdcall;
var
  Items: AMenuItem;
  Parent: AMenuItem;
begin
  if (FMainWindow = 0) then
  begin
    Result := 0;
    Exit;
  end;
  if not(Assigned(TForm(FMainWindow).Menu)) then
  begin
    Result := 0;
    Exit;
  end;

  Items := AMenu(TForm(FMainWindow).Menu.Items);
  if (ParentItemName = '') then
  begin
    Result := UI_MenuItem_FindByName(Items, 'mi'+Name);
    Parent := Items;
  end
  else
  begin
    Parent := UI_MenuItem_FindByName(Items, 'mi'+ParentItemName);
    if (Parent = 0) then
    begin
      Result := 0;
      Exit;
    end;
    Result := UI_MenuItem_FindByName(Parent, 'mi'+Name)
  end;

  if (Result = 0) then
    Result := AUIMenus.UI_MenuItem_Add03(Parent, Name, Text, OnClick, ImageID, Weight, 0);
end;

end.
