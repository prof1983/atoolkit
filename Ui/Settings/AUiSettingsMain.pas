{**
@Author Prof1983 <prof1983@ya.ru>
@Created 13.12.2012
@LastMod 30.01.2013
}
unit AUiSettingsMain;

interface

uses
  ABase,
  ABaseTypes,
  AStringMain,
  AUiBase,
  AUiControls,
  AUiDialogs,
  AUiEvents,
  AUiMain,
  AUiMainWindow2,
  AUiPageControl, AUiSettingsBase, AUiSplitter, AUiTreeView, AUiWindows;

// --- AUiSettings ---

function AUiSettings_Fin(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiSettings_GetMainSettingsWin(): AWindow; {$ifdef AStdCall}stdcall;{$endif}

function AUiSettings_Init(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUiSettings_NewItem(Parent: AUiSettingsItem;
    const Text: AString_Type): AUiSettingsItem; {$ifdef AStdCall}stdcall;{$endif}

function AUiSettings_NewItemP(Parent: AUiSettingsItem;
    const Text: APascalString): AUiSettingsItem;

function AUiSettings_NewSettingsWin(): AWindow; {$ifdef AStdCall}stdcall;{$endif}

function AUiSettings_ShowSettingsWin(): AError; {$ifdef AStdCall}stdcall;{$endif}

// --- AUiSettingsItem ---

function AUiSettingsItem_GetPage(Item: AUiSettingsItem): AControl; {$ifdef AStdCall}stdcall;{$endif}

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
  FItems: array of TUiSettingsItem;
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

function DoUiDone(Obj, Data: AInteger): AError; stdcall;
begin
  Result := AUiSettings_Fin();
end;

procedure DoUiDone02(Obj, Data: AInteger); stdcall;
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

procedure miSettingsClick02(Obj, Data: AInteger); stdcall;
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
  AUi_OnDone_Disconnect(DoUiDone);

  if FInitialized then
  begin
    for I := 0 to High(FItems) do
      AUiControl_Free(FItems[I].Page);
    SetLength(FItems, 0);
    AUiControl_Free(FTreeView);
    FTreeView := 0;
    AUiControl_Free(FPageControl);
    FPageControl := 0;
    AUiWindow_Free(SettingsWin);
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

  if (AUi_Init < 0) then
  begin
    Result := -1;
    Exit;
  end;

  try
    AUi_OnDone_Connect(DoUiDone);
    AUiMainWindow_AddMenuItemP('', 'Tools', miToolsText, nil, 0, 900);
    AUiMainWindow_AddMenuItemP('Tools', 'Settings', miSettingsText, miSettingsClick, 0, 1000);
    InitSettingsWin();
    FInitialized := True;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUiSettings_NewItem(Parent: AUiSettingsItem;
    const Text: AString_Type): AUiSettingsItem;
begin
  Result := AUiSettings_NewItemP(Parent, AString_ToPascalString(Text));
end;

function AUiSettings_NewItemP(Parent: AUiSettingsItem;
    const Text: APascalString): AUiSettingsItem;
var
  ParentTreeNode: ATreeNode;
  TreeNode: ATreeNode;
  Page: AControl;
begin
  try
    if (Parent > 0) then
      ParentTreeNode := FItems[Parent-1].TreeNode
    else
      ParentTreeNode := 0;

    TreeNode := AUiTreeView_AddItemP(FTreeView, ParentTreeNode, Text);
    Page := AUiPageControl_AddPageP(FPageControl, '', Text);

    Result := AddSettingsItem(TreeNode, Page)+1;
  except
    Result := 0;
  end;
end;

function AUiSettings_NewSettingsWin(): AWindow;
var
  Dialog: ADialog;
  Res: AWindow;
begin
  try
    Dialog := AUiDialog_New(MB_ApplyOkCancel);
    Res := AUiDialog_GetWindow(Dialog);
    if (Res = 0) then
    begin
      Result := 0;
      Exit;
    end;

    AUiControl_SetTextP(Res, wndName);
    AUiControl_SetPosition(Res, 100, 100);
    AUiControl_SetSize(Res, 500, 400);

    FTreeView := AUiTreeView_New(Res);
    AUiControl_SetSize(FTreeView, 150, 400);

    AUiSplitter_New(Res, 1);

    FPageControl := AUiPageControl_New(Res);

    Result := Res;
  except
    Result := 0;
  end;
end;

function AUiSettings_ShowSettingsWin(): AError;
begin
  try
    InitSettingsWin();
    Result := AUiControl_SetVisible(SettingsWin, True);
  except
    Result := -1;
  end;
end;

end.
 