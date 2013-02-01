{**
@Abstract AUi MainWindow2
@Author Prof1983 <prof1983@ya.ru>
@Created 28.06.2011
@LastMod 30.01.2013
}
unit AUiMainWindow2;

{define AStdCall}

interface

uses
  Forms,
  ABase,
  AStringMain,
  AUiBase, AUiData, AUiMainWindow, AUiMenus;

// --- AUiMainWindow ---

{** Добавляет пункт меню в главное окно }
function AUiMainWindow_AddMenuItem(const ParentItemName, Name, Text: AString_Type;
    OnClick: ACallbackProc; ImageId, Weight: AInteger): AMenuItem; {$ifdef AStdCall}stdcall;{$endif}

{** Добавляет пункт меню в главное окно }
function AUiMainWindow_AddMenuItemA(ParentItemName, Name, Text: AStr;
    OnClick: ACallbackProc; ImageId, Weight: AInteger): AMenuItem; {$ifdef AStdCall}stdcall;{$endif}

{** Добавляет пункт меню в главное окно }
function AUiMainWindow_AddMenuItemP(const ParentItemName, Name, Text: APascalString;
    OnClick: ACallbackProc; ImageId, Weight: AInteger): AMenuItem;

implementation

// --- AUiMainWindow ---

function AUiMainWindow_AddMenuItem(const ParentItemName, Name, Text: AString_Type;
    OnClick: ACallbackProc; ImageId, Weight: AInteger): AMenuItem;
begin
  try
    Result := AUiMainWindow_AddMenuItemP(
        AString_ToPascalString(ParentItemName),
        AString_ToPascalString(Name),
        AString_ToPascalString(Text),
        OnClick, ImageId, Weight);
  except
    Result := 0;
  end;
end;

function AUiMainWindow_AddMenuItemA(ParentItemName, Name, Text: AStr;
    OnClick: ACallbackProc; ImageId, Weight: AInteger): AMenuItem;
begin
  Result := AUiMainWindow_AddMenuItemP(AnsiString(ParentItemName), AnsiString(Name),
      AnsiString(Text), OnClick, ImageId, Weight);
end;

function AUiMainWindow_AddMenuItemP(const ParentItemName, Name, Text: APascalString;
    OnClick: ACallbackProc; ImageId, Weight: AInteger): AMenuItem;
var
  Items: AMenuItem;
  Parent: AMenuItem;
begin
  try
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
      Result := AUiMenu_FindItemByNameP(Items, 'mi'+Name);
      Parent := Items;
    end
    else
    begin
      Parent := AUiMenu_FindItemByNameP(Items, 'mi'+ParentItemName);
      if (Parent = 0) then
      begin
        Result := 0;
        Exit;
      end;
      Result := AUiMenu_FindItemByNameP(Parent, 'mi'+Name)
    end;

    if (Result = 0) then
      Result := AUiMenu_AddItemEx2P(Parent, Name, '', Text, OnClick, 0, ImageId, Weight, 0);
  except
    Result := 0;
  end;
end;

end.
