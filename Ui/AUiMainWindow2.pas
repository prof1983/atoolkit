{**
@Abstract AUi MainWindow2
@Author Prof1983 <prof1983@ya.ru>
@Created 28.06.2011
@LastMod 06.09.2012
}
unit AUiMainWindow2;

{$define AStdCall}

interface

uses
  Forms,
  ABase, AStrings,
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
    OnClick: ACallbackProc; ImageId, Weight: AInteger): AMenuItem; {$ifdef AStdCall}stdcall;{$endif}

{** Добавляет пункт меню в главное окно }
function AUiMainWindow_AddMenuItem02P(const ParentItemName, Name, Text: APascalString;
    OnClick: ACallbackProc02; ImageId, Weight: AInteger): AMenuItem; {$ifdef AStdCall}stdcall;{$endif}

{** Добавляет пункт меню в главное окно }
function AUiMainWindow_AddMenuItem03P(const ParentItemName, Name, Text: APascalString;
    OnClick: ACallbackProc03; ImageId, Weight: AInteger): AMenuItem; {$ifdef AStdCall}stdcall;{$endif}

// --- AUi_MainWindow ---

function AUi_MainWindow_AddMenuItem(const ParentItemName, Name, Text: AString_Type;
    OnClick: ACallbackProc; ImageID, Weight: Integer): AMenuItem; stdcall; deprecated; // Use AUiMainWindow_AddMenuItem()

// --- UI_MainWindow ---

function UI_MainWindow_AddMenuItem(const ParentItemName, Name, Text: APascalString;
    OnClick: ACallbackProc; ImageID, Weight: Integer): AMenuItem; stdcall; deprecated; // Use AUiMainWindow_AddMenuItemP()

function UI_MainWindow_AddMenuItem02(const ParentItemName, Name, Text: APascalString;
    OnClick: ACallbackProc02; ImageID, Weight: Integer): AMenuItem; stdcall;

function UI_MainWindow_AddMenuItem03(const ParentItemName, Name, Text: APascalString;
    OnClick: ACallbackProc03; ImageID, Weight: Integer): AMenuItem; stdcall;

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
begin
  try
    {$IFDEF A01}
      Result := UI_MainWindow_AddMenuItem02(ParentItemName, Name, Text, OnClick, ImageId, Weight);
    {$ELSE}
      {$IFDEF A02}
      Result := UI_MainWindow_AddMenuItem02(ParentItemName, Name, Text, OnClick, ImageId, Weight);
      {$ELSE}
      Result := UI_MainWindow_AddMenuItem03(ParentItemName, Name, Text, OnClick, ImageId, Weight);
      {$ENDIF A02}
    {$ENDIF A01}
  except
    Result := 0;
  end;
end;

function AUiMainWindow_AddMenuItem02P(const ParentItemName, Name, Text: APascalString;
    OnClick: ACallbackProc02; ImageId, Weight: AInteger): AMenuItem;
begin
  try
    Result := UI_MainWindow_AddMenuItem02(ParentItemName, Name, Text, OnClick, ImageID, Weight);
  except
    Result := 0;
  end;
end;

function AUiMainWindow_AddMenuItem03P(const ParentItemName, Name, Text: APascalString;
    OnClick: ACallbackProc03; ImageId, Weight: AInteger): AMenuItem;
begin
  try
    Result := UI_MainWindow_AddMenuItem03(ParentItemName, Name, Text, OnClick, ImageId, Weight);
  except
    Result := 0;
  end;
end;

// --- AUi_MainWindow ---

function AUi_MainWindow_AddMenuItem(const ParentItemName, Name, Text: AString_Type;
    OnClick: ACallbackProc; ImageId, Weight: Integer): AMenuItem;
begin
  Result := AUiMainWindow_AddMenuItem(ParentItemName, Name, Text, OnClick, ImageId, Weight);
end;

// --- UI_MainWindow ---

function UI_MainWindow_AddMenuItem(const ParentItemName, Name, Text: APascalString;
    OnClick: ACallbackProc; ImageID, Weight: Integer): AMenuItem; stdcall;
begin
  Result := AUiMainWindow_AddMenuItemP(ParentItemName, Name, Text, OnClick, ImageId, Weight);
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
