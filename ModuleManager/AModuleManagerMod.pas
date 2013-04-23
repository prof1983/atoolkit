{**
@Abstract AModuleManager module
@Author Prof1983 <prof1983@ya.ru>
@Created 20.08.2009
@LastMod 23.04.2013
}
unit AModuleManagerMod;

{define Debug}

interface

uses
  ABase,
  AModuleManagerBase,
  AModuleManagerMain,
  ARuntimeBase,
  ARuntimeMain,
  ASettingsModClient,
  AStringsModClient,
  {$ifdef Debug}
  ASystemMain,
  {$endif}
  ASystemModClient,
  AUiMain,
  AUiModClient,
  AUiWorkbenchModClient;

// --- AModuleManagerMod ---

function AModuleManagerMod_Boot(): AError; stdcall;

function AModuleManagerMod_Fin(): AError; stdcall;

function AModuleManagerMod_GetProc(ProcName: AStr): Pointer; stdcall;

function AModuleManagerMod_Init(): AError; stdcall;

implementation

const
  AModuleManager_Version = $00060200;

const
  Module: AModule_Type = (
    Version: AModuleManager_Version;
    Uid: AModuleManager_Uid;
    Name: AModuleManager_Name;
    Description: nil;
    Init: AModuleManagerMod_Init;
    Fin: AModuleManagerMod_Fin;
    GetProc: AModuleManagerMod_GetProc;
    Procs: nil;
    );

var
  FInitialized: Boolean;

// --- AModuleManagerMod ---

function AModuleManagerMod_Boot(): AError;
begin
  if (ARuntime_FindModuleByUid(AModuleManager_Uid) >= 0) then
  begin
    Result := -1;
    Exit;
  end;

  if (ARuntime_FindModuleByName(AModuleManager_Name) >= 0) then
  begin
    Result := -2;
    Exit;
  end;

  Result := ARuntime_RegisterModule(Module);
end;

function AModuleManagerMod_Fin(): AError;
begin
  AModuleManager_Fin();
  ARuntime_DeleteModuleByUid(AModuleManager_Uid);
  FInitialized := False;
  Result := 0;
end;

function AModuleManagerMod_GetProc(ProcName: AStr): Pointer;
begin
  if (ProcName = 'AModuleManager_Fin') then
    Result := Addr(AModuleManager_Fin)
  else if (ProcName = 'AModuleManager_Init') then
    Result := Addr(AModuleManager_Init)
  else
    Result := nil;
end;

function AModuleManagerMod_Init(): AError;
begin
  if FInitialized then
  begin
    Result := 0;
    Exit;
  end;

  // --- Boot reguest modules ---

  if (AStrings_Boot() < 0) then
  begin
    Result := -3;
    Exit;
  end;

  if (ASettings_Boot() < 0) then
  begin
    Result := -3;
    Exit;
  end;

  if (ASystem_Boot() < 0) then
  begin
    Result := -4;
    Exit;
  end;

  if (AUi_Boot() < 0) then
  begin
    {$ifdef Debug}
    ASystem_ShowMessageA('AUi_Boot() < 0 in AModuleManagerMod_Init()');
    {$endif}
    Result := -5;
    Exit;
  end;

  // --- Boot recomended modules ---

  AUiWorkbench_Boot();

  // --- Init reguest modules ---

  if (AUi_Init() < 0) then
  begin
    {$ifdef Debug}
    ASystem_ShowMessageA('AUi_Init() < 0 in AModuleManagerMod_Init()');
    {$endif}
    Result := -6;
    Exit;
  end;

  // --- Init ---

  {$ifdef Debug}
  ASystem_ShowMessageA('AModuleManager initializing...');
  {$endif}

  if (AModuleManager_Init() < 0) then
  begin
    {$ifdef Debug}
    ASystem_ShowMessageA('AModuleManager_Init() < 0 in AModuleManagerMod_Init()');
    {$endif}
    Result := -7;
    Exit;
  end;

  {$ifdef Debug}
  ASystem_ShowMessageA('AModuleManagerMod is initialized ok');
  {$endif}

  FInitialized := True;
  Result := 0;
end;

end.
