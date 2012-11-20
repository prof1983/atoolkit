{**
@Abstract AModuleManager
@Author Prof1983 <prof1983@ya.ru>
@Created 20.08.2009
@LastMod 20.11.2012
}
unit AModuleManager;

interface

uses
  ABase,
  ARuntime, ARuntimeBase,
  ASettings,
  ASystem,
  AUi, AUiBase,
  AUiWorkbenchMain, AUiWorkbenchModClient;

function Init(): AError; stdcall;
function Done(): AError; stdcall;

function Init02(): AInteger; stdcall;
procedure Done02(); stdcall;

function ModuleManager_Init(): AError;
function ModuleManager_Done(): AError;

implementation

var
  FInitialized: Boolean;
  FPage: AControl;
  FModuleManagerControl: AControl;

{ Private }

function ModuleManagerControl_New(Parent: AControl): AControl;
var
  c: Integer;
  i: Integer;
  lbModules: AControl;
begin
  lbModules := AUI.ListBox_New(Parent);

  c := ARuntime.Modules_Count();
  for i := 0 to c - 1 do
  begin
    AUI.ListBox_AddP(lbModules, ARuntime.Modules_GetNameByIndexWS(i));
  end;

  Result := lbModules;
end;

{ Events }

function DoMenuModuleClick(Obj, Data: Integer): AError; stdcall;
var
  Win: AWindow;
begin
  Win := AUI.Window_New();
  ModuleManagerControl_New(Win);
  AUI.Window_ShowModal(Win);
  AUI.Window_Free(Win);
  Result := 0;
end;

procedure DoMenuModuleClick02(Obj, Data: Integer); stdcall;
begin
  DoMenuModuleClick(Obj, Data);
end;

{ ModuleManager }

function ModuleManager_Done(): AError;
begin
  AUI.Control_Free(FModuleManagerControl);
  FModuleManagerControl := 0;
  AUI.Control_Free(FPage);
  FPage := 0;
  FInitialized := False;
  Result := 0;
end;

function ModuleManager_Init(): AError;
var
  miHelp: AMenuItem;
  SModules: string;
begin
  if FInitialized then
  begin
    Result := 0;
    Exit;
  end;

  FModuleManagerControl := 0;
  FPage := 0;

  // --- Init reguest modules ---

  if (AUI.Init() < 0) then
  begin
    Result := -2;
    Exit;
  end;

  {$IFDEF A03}
  if (ASettings.Init() < 0) then
  begin
    Result := -3;
    Exit;
  end;
  {$ENDIF A03}

  {$IFDEF A03}
  if (ASystem.Init() < 0) then
  begin
    Result := -4;
    Exit;
  end;
  {$ENDIF A03}

  SModules := ASystem.GetResourceStringWS('', 'Modules', 'Модули');

  miHelp := AUI.MainWindow_AddMenuItem('', 'Help', '?', nil, 0, 10000);
  {$IFDEF A02}
  AUI.Menu_AddItem2WS02(miHelp, 'Modules', SModules, DoMenuModuleClick02, 0, 10);
  {$ELSE}
  AUI.Menu_AddItem2WS(miHelp, 'Modules', SModules, DoMenuModuleClick, 0, 10);
  {$ENDIF}

  // --- Init recomended modules ---

  if AUiWorkbench_IsBoot then
  begin
    if (AUiWorkbench_Init() >= 0) then
    begin
      FPage := AUiWorkbench_AddPageP('ModuleManager', SModules);
      FModuleManagerControl := ModuleManagerControl_New(FPage);
    end;
  end;

  FInitialized := True;
  Result := 0;
end;

{ Public }

function Done(): AError; stdcall;
begin
  Result := ModuleManager_Done();
end;

procedure Done02(); stdcall;
begin
  ModuleManager_Done();
end;

function Init(): AError; stdcall;
begin
  Result := ModuleManager_Init();
end;

function Init02(): AInteger; stdcall;
begin
  Result := ModuleManager_Init();
end;

end.
