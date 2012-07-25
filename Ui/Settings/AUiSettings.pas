{**
@Abstract AUiSettings
@Author Prof1983 <prof1983@ya.ru>
@Created 13.03.2009
@LastMod 25.07.2012
}
unit AUiSettings;

interface

uses
  ABase, ABaseTypes,
  AUi, AUiBase,
  AUiSettingsBase;

// --- AUiSettings ---

function AUiSettings_Fin(): AError; stdcall;

function AUiSettings_GetMainSettingsWin(): AWindow; stdcall;

function AUiSettings_Init(): AError; stdcall;

function AUiSettings_NewItemP(Parent: AUiSettingsItem;
    const Text: APascalString): AUiSettingsItem; stdcall;

function AUiSettings_NewItemWS(Parent: AUiSettingsItem;
    const Text: AWideString): AUiSettingsItem; stdcall;

function AUiSettings_NewSettingsWin(): AWindow; stdcall;

function AUiSettings_ShowSettingsWin(): AError; stdcall;

// --- AUiSettingsItem ---

function AUiSettingsItem_GetPage(Item: AUiSettingsItem): AControl; stdcall;

// ----

function Init(): AError; stdcall; deprecated; // Use AUiSettings_Init()
function Done(): AError; stdcall; deprecated; // Use AUiSettings_Fin()

function Init03(): AInteger; stdcall;
function Done03(): AInteger; stdcall;

function MainSettingsWin(): AWindow; stdcall; deprecated; // Use AUiSettings_GetMainSettingsWin()

function NewItemWS(Parent: AUISettingsItem; const Text: APascalString): AUISettingsItem; stdcall; deprecated; // Use AUiSettings_NewItemWS()

function SettingsWin_New(): AWindow; stdcall; deprecated; // Use AUiSettings_NewSettingsWin()

procedure ShowSettingsWin(); stdcall; deprecated; // Use AUiSettings_ShowSettingsWin()


function UISettings_MainSettingsWin: AWindow; stdcall; deprecated; // Use AUiSettings_GetMainSettingsWin()
function UISettings_SettingsWin_New: AWindow; stdcall; deprecated; // Use AUiSettings_NewSettingsWin()
procedure UISettings_ShowSettingsWin; stdcall; deprecated; // Use AUiSettings_ShowSettingsWin()
function UISettings_NewItem(Parent: AUISettingsItem; const Text: APascalString): AUISettingsItem; stdcall; deprecated; // Use AUiSettings_NewItemP()
function UISettings_Item_GetPage(Item: AUISettingsItem): AControl; stdcall; deprecated; // Use AUiSettingsItem_GetPage()

implementation

{$IFDEF FPC}
  {$I AUISettingsConsts.en.inc}
{$ELSE}
  {$I AUISettingsConsts.ru.inc}
{$ENDIF}

type
  TUISettingsItem = record
    TreeNode: ATreeNode;
    Page: AControl;
  end;

var
  FInitialized: Boolean;
  FItems: array of TUISettingsItem;
  SettingsWin: AWindow;
  FPageControl: AControl;
  FTreeView: AControl;

{ Private }

function AddSettingsItem(TreeNode: ATreeNode; Page: AControl): Integer;
begin
  Result := Length(FItems);
  SetLength(FItems, Result + 1);
  FItems[Result].TreeNode := TreeNode;
  FItems[Result].Page := Page;
end;

procedure InitSettingsWin();
begin
  if (SettingsWin = 0) then
    SettingsWin := AUiSettings_NewSettingsWin();
end;

{ Events }

function DoUIDone(Obj, Data: AInteger): AError; stdcall;
begin
  Result := AUiSettings_Fin();
end;

procedure DoUIDone02(Obj, Data: AInteger); stdcall;
begin
  AUiSettings_Fin();
end;

function miSettingsClick(Obj, Data: AInteger): AError; stdcall;
begin
  try
    AUiSettings_ShowSettingsWin();
    Result := 0;
  except
    Result := -1;
  end;
end;

procedure miSettingsClick02(Obj, Data: Integer); stdcall;
begin
  AUiSettings_ShowSettingsWin();
end;

// --- AUiSettingsItem ---

function AUiSettingsItem_GetPage(Item: AUiSettingsItem): AControl;
begin
  Result := FItems[Item - 1].Page;
end;

// --- AUiSettings ---

function AUiSettings_Fin(): AError;
var
  I: Integer;
begin
  {$IFDEF A01}
    AUI.OnDone_Disconnect(DoUIDone02);
  {$ELSE}
    {$IFDEF A02}
    AUI.OnDone_Disconnect(DoUIDone02);
    {$ELSE}
    AUI.OnDone_Disconnect(DoUIDone);
    {$ENDIF A02}
  {$ENDIF A01}

  if FInitialized then
  begin
    for I := 0 to High(FItems) do
      AUI.Control_Free(FItems[I].Page);
    SetLength(FItems, 0);
    AUI.Control_Free(FTreeView);
    FTreeView := 0;
    AUI.Control_Free(FPageControl);
    FPageControl := 0;
    AUI.Window_Free(SettingsWin);
    SettingsWin := 0;
    FInitialized := False;
  end;
  Result := 0;
end;

function AUiSettings_GetMainSettingsWin(): AWindow;
begin
  Result := SettingsWin;
end;

function AUiSettings_Init(): AError;
begin
  if FInitialized then
  begin
    Result := 0;
    Exit;
  end;

  // --- Init request modules ---

  if (AUI.Init < 0) then
  begin
    Result := -1;
    Exit;
  end;

  try
    {$IFDEF A01}
      AUI.OnDone_Connect(DoUIDone02);
    {$ELSE}
      {$IFDEF A02}
      AUI.OnDone_Connect(DoUIDone02);
      {$ELSE}
      AUI.OnDone_Connect(DoUIDone);
      {$ENDIF A02}
    {$ENDIF A01}

    AUI.MainWindow_AddMenuItem('', 'Tools', miToolsText, nil, 0, 900);

    {$IFDEF A01}
      AUI.MainWindow_AddMenuItem('Tools', 'Settings', miSettingsText, miSettingsClick02, 0, 1000);
    {$ELSE}
      {$IFDEF A02}
      AUI.MainWindow_AddMenuItem('Tools', 'Settings', miSettingsText, miSettingsClick02, 0, 1000);
      {$ELSE}
      AUI.MainWindow_AddMenuItem('Tools', 'Settings', miSettingsText, miSettingsClick, 0, 1000);
      {$ENDIF A02}
    {$ENDIF A01}

    InitSettingsWin;

    FInitialized := True;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiSettings_NewItemP(Parent: AUiSettingsItem;
    const Text: APascalString): AUiSettingsItem;
var
  ParentTreeNode: ATreeNode;
  TreeNode: ATreeNode;
  Page: AControl;
begin
  if (Parent > 0) then
    ParentTreeNode := FItems[Parent-1].TreeNode
  else
    ParentTreeNode := 0;

  TreeNode := AUI.TreeView_AddItemWS(FTreeView, ParentTreeNode, Text);
  Page := AUI.PageControl_AddPageWS(FPageControl, '', Text);

  Result := AddSettingsItem(TreeNode, Page)+1;
end;

function AUiSettings_NewItemWS(Parent: AUiSettingsItem;
    const Text: AWideString): AUiSettingsItem;
begin
  try
    Result := AUiSettings_NewItemP(Parent, Text);
  except
    Result := 0;
  end;
end;

function AUiSettings_NewSettingsWin(): AWindow;
var
  Dialog: ADialog;
begin
  Dialog := AUI.Dialog_New(MB_ApplyOkCancel);
  Result := AUI.Dialog_GetWindow(Dialog);
  if (Result <> 0) then
  begin
    AUI.Control_SetTextWS(Result, wndName);
    AUI.Control_SetPosition(Result, 100, 100);
    AUI.Control_SetSize(Result, 500, 400);

    FTreeView := AUI.TreeView_New(Result);
    AUI.Control_SetSize(FTreeView, 150, 400);

    AUI.Splitter_New(Result, 1);

    FPageControl := AUI.PageControl_New(Result);
  end;
end;

function AUiSettings_ShowSettingsWin(): AError;
begin
  InitSettingsWin();
  Result := AUI.Control_SetVisible(SettingsWin, True);
end;

{ Public }

function Done(): AError; stdcall;
begin
  Result := AUiSettings_Fin();
end;

function Done03(): AInteger; stdcall;
begin
  Result := AUiSettings_Fin();
end;

function Init(): AError; stdcall;
begin
  Result := AUiSettings_Init();
end;

function Init03(): AInteger; stdcall;
begin
  Result := AUiSettings_Init();
end;

function MainSettingsWin(): AWindow; stdcall;
begin
  Result := SettingsWin;
end;

function NewItemWS(Parent: AUISettingsItem; const Text: APascalString): AUISettingsItem; stdcall;
begin
  try
    Result := UISettings_NewItem(Parent, Text);
  except
    Result := 0;
  end;
end;

function SettingsWin_New(): AWindow; stdcall;
begin
  try
    Result := UISettings_SettingsWin_New();
  except
    Result := 0;
  end;
end;

procedure ShowSettingsWin(); stdcall;
begin
  try
    UISettings_ShowSettingsWin();
  except
  end;
end;

{ UISettings }

function UISettings_Item_GetPage(Item: AUISettingsItem): AControl; stdcall;
begin
  Result := AUiSettingsItem_GetPage(Item);
end;

{function UISettings_Item_New(Parent: AUISettingsItem; const Text: AString; ...): AUISettingsItem; stdcall;
var
  ParentTreeNode: ATreeNode;
  TreeNode: ATreeNode;
  Page: AControl;
begin
  if (Parent > 0) then
    ParentTreeNode := FItems[Parent-1].TreeNode
  else
    ParentTreeNode := 0;

  TreeNode := UI_TreeView_AddItem(FTreeView, ParentTreeNode, Text);
  Page := UI_PageControl_AddPage(FPageControl, '', Text);

  Result := AddSettingsItem(TreeNode, Page)+1;
end;}

function UISettings_MainSettingsWin: AWindow; stdcall;
begin
  Result := AUiSettings_GetMainSettingsWin();
end;

function UISettings_NewItem(Parent: AUISettingsItem; const Text: APascalString): AUISettingsItem; stdcall;
begin
  Result := AUiSettings_NewItemP(Parent, Text);
end;

function UISettings_SettingsWin_New(): AWindow; stdcall;
begin
  Result := AUiSettings_NewSettingsWin();
end;

procedure UISettings_ShowSettingsWin(); stdcall;
begin
  AUiSettings_ShowSettingsWin();
end;

end.
