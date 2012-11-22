{**
@Abstract AModuleManager main functions
@Author Prof1983 <prof1983@ya.ru>
@Created 20.11.2012
@LastMod 22.11.2012
}
unit AModuleManagerMain;

{$define AStdCall}

interface

uses
  ABase,
  ARuntimeMain,
  ASystemResourceString,
  AUiBase, AUiControls, AUiListBox, AUiMain, AUiMainWindow, AUiMenus, AUiWindows,
  AUiWorkbenchMain;

function AModuleManager_Fin(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AModuleManager_Init(): AError; {$ifdef AStdCall}stdcall;{$endif}

implementation

var
  FInitialized: Boolean;
  FPage: AControl;
  FModuleManagerControl: AControl;

// --- Private ---

function ModuleManagerControl_New(Parent: AControl): AControl;
var
  c: Integer;
  i: Integer;
  lbModules: AControl;
begin
  lbModules := AUiListBox_New(Parent);

  c := ARuntime_GetModulesCount();
  for i := 0 to c - 1 do
  begin
    AUiListBox_AddP(lbModules, ARuntime_GetModuleNameByIndexWS(i));
  end;

  Result := lbModules;
end;

// --- Events ---

function DoMenuModuleClick(Obj, Data: AInt): AError; stdcall;
var
  Win: AWindow;
begin
  Win := AUiWindow_New();
  ModuleManagerControl_New(Win);
  AUiWindow_ShowModal(Win);
  AUiWindow_Free(Win);
  Result := 0;
end;

procedure DoMenuModuleClick02(Obj, Data: AInt); stdcall;
begin
  DoMenuModuleClick(Obj, Data);
end;

// --- AModuleManager ---

function AModuleManager_Fin(): AError;
begin
  AUiControl_Free(FModuleManagerControl);
  FModuleManagerControl := 0;
  AUiControl_Free(FPage);
  FPage := 0;
  FInitialized := False;
  Result := 0;
end;

function AModuleManager_Init(): AError;
var
  miHelp: AMenuItem;
  SModules: APascalString;
begin
  if FInitialized then
  begin
    Result := 0;
    Exit;
  end;

  FModuleManagerControl := 0;
  FPage := 0;

  // --- Init reguest modules ---

  if (AUi_Init() < 0) then
  begin
    Result := -2;
    Exit;
  end;

  {$IFDEF A03}
  if (ASettings_Init() < 0) then
  begin
    Result := -3;
    Exit;
  end;
  {$ENDIF A03}

  {$IFDEF A03}
  if (ASystem_Init() < 0) then
  begin
    Result := -4;
    Exit;
  end;
  {$ENDIF A03}

  SModules := ASystem_GetResourceStringP('', 'Modules', 'Modules');

  miHelp := AUiMainWindow_AddMenuItemP('', 'Help', '?', nil, 0, 10000);
  {$IFDEF A02}
  AUiMenu_AddItem2WS02(miHelp, 'Modules', 'Modules'{SModules}, DoMenuModuleClick02, 0, 10);
  {$ELSE}
  AUiMenu_AddItem2P(miHelp, 'Modules', 'Modules'{SModules}, DoMenuModuleClick, 0, 10);
  {$ENDIF}

  // --- Init recomended modules ---

  //if AUiWorkbench_IsBoot then
  begin
    if (AUiWorkbench_Init() >= 0) then
    begin
      FPage := AUiWorkbench_AddPageP('ModuleManager', 'Modules'{SModules});
      FModuleManagerControl := ModuleManagerControl_New(FPage);
    end;
  end;

  FInitialized := True;
  Result := 0;
end;

end.
 