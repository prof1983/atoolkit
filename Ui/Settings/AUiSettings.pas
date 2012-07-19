{**
@Abstract AUiSettings
@Author Prof1983 <prof1983@ya.ru>
@Created 13.03.2009
@LastMod 19.07.2012
}
unit AUiSettings;

interface

uses
  ABase, ABaseTypes,
  AUi, AUiBase,
  AUiSettingsBase;

function Init(): AError; stdcall;
function Done(): AError; stdcall;

function Init03(): AInteger; stdcall;
function Done03(): AInteger; stdcall;

function MainSettingsWin(): AWindow; stdcall;

function NewItemWS(Parent: AUISettingsItem; const Text: APascalString): AUISettingsItem; stdcall;

function SettingsWin_New(): AWindow; stdcall;

procedure ShowSettingsWin(); stdcall;


function UISettings_MainSettingsWin: AWindow; stdcall;
function UISettings_SettingsWin_New: AWindow; stdcall;
procedure UISettings_ShowSettingsWin; stdcall;
function UISettings_NewItem(Parent: AUISettingsItem; const Text: APascalString): AUISettingsItem; stdcall;
function UISettings_Item_GetPage(Item: AUISettingsItem): AControl; stdcall;

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
    SettingsWin := UISettings_SettingsWin_New;
end;

{ Events }

function DoUIDone(Obj, Data: AInteger): AError; stdcall;
begin
  Result := Done();
end;

procedure DoUIDone02(Obj, Data: AInteger); stdcall;
begin
  Done();
end;

function miSettingsClick(Obj, Data: AInteger): AError; stdcall;
begin
  try
    UISettings_ShowSettingsWin;
    Result := 0;
  except
    Result := -1;
  end;
end;

procedure miSettingsClick02(Obj, Data: Integer); stdcall;
begin
  UISettings_ShowSettingsWin;
end;

{ Public }

function Done(): AError; stdcall;
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

function Done03(): AInteger; stdcall;
begin
  Result := Done();
end;

function Init(): AError; stdcall;
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
end;

function Init03(): AInteger; stdcall;
begin
  Result := Init();
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
  Result := FItems[Item - 1].Page;
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
  Result := SettingsWin;
end;

function UISettings_NewItem(Parent: AUISettingsItem; const Text: APascalString): AUISettingsItem; stdcall;
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

function UISettings_SettingsWin_New(): AWindow; stdcall;
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

procedure UISettings_ShowSettingsWin(); stdcall;
begin
  InitSettingsWin();
  AUI.Control_SetVisible(SettingsWin, True);
end;

end.
