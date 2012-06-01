{**
@Abstract()
@Author(Prof1983 prof1983@ya.ru)
@Created(28.06.2011)
@LastMod(12.10.2011)
@Version(0.5)
}
unit AUiMainWindow2;

interface

uses
  Forms,
  ABase, AUiBase, AUiData, AUiMainWindow, AUiMenus;

function UI_MainWindow_AddMenuItem(const ParentItemName, Name, Text: APascalString;
    OnClick: ACallbackProc; ImageID, Weight: Integer): AMenuItem; stdcall;

function UI_MainWindow_AddMenuItem2(const ParentItemName, Name, Text: APascalString;
    OnClick: ACallbackProc; ImageID, Weight: Integer): AMenuItem; stdcall;

implementation

uses
  AUi;

function UI_MainWindow_AddMenuItem(const ParentItemName, Name, Text: APascalString;
    OnClick: ACallbackProc; ImageID, Weight: Integer): AMenuItem; stdcall;
begin
  Result := UI_MainWindow_AddMenuItem2(ParentItemName, Name, Text, OnClick, ImageID, Weight);
end;

function UI_MainWindow_AddMenuItem2(const ParentItemName, Name, Text: APascalString;
    OnClick: ACallbackProc; ImageID, Weight: Integer): AMenuItem; stdcall;
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
    //Result := UI_MainWindow_AddMenuItem(ParentItemName, Name, Text, OnClick, ImageID, Weight);
    Result := AUIMenus.UI_MenuItem_Add(Parent, Name, Text, OnClick, ImageID, Weight);
end;

end.
 