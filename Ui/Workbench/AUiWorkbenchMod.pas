{**
@Abstract AUiWorkbench
@Author Prof1983 <prof1983@ya.ru>
@Created 26.08.2009
@LastMod 04.04.2013
}
unit AUiWorkbenchMod;

interface

uses
  ABase,
  ARuntimeBase,
  ARuntimeMain,
  AUiBase,
  AUiMain,
  AUiWorkbenchBase,
  AUiWorkbenchMain;

// --- AUiWorkbenchMod ---

function AUiWorkbenchMod_Boot(): AError; stdcall;

function AUiWorkbenchMod_Fin(): AError; stdcall;

function AUiWorkbenchMod_GetProc(ProcName: AStr): Pointer; stdcall;

function AUiWorkbenchMod_Init(): AError; stdcall;

implementation

const
  AUiWorkbench_Version = $00070500;

const
  Module: AModule_Type = (
    Version: AUiWorkbench_Version;
    Uid: AUiWorkbench_Uid;
    Name: AUiWorkbench_Name;
    Description: nil;
    Init: AUiWorkbenchMod_Init;
    Fin: AUiWorkbenchMod_Fin;
    GetProc: AUiWorkbenchMod_GetProc;
    Procs: nil;
    );

var
  FInitialized: Boolean;

// --- AUiWorkbenchMod ---

function AUiWorkbenchMod_Boot(): AError;
begin
  if (ARuntime_FindModuleByUid(AUiWorkbench_Uid) >= 0) then
  begin
    Result := -2;
    Exit;
  end;

  if (ARuntime_FindModuleByName(AUiWorkbench_Name) >= 0) then
  begin
    Result := -3;
    Exit;
  end;

  Result := ARuntime_RegisterModule(Module);
end;

function AUiWorkbenchMod_Fin(): AError;
begin
  ARuntime_DeleteModuleByUid(AUIWorkbench_Uid);
  Result := AUiWorkbench_Fin();
end;

function AUiWorkbenchMod_GetProc(ProcName: AStr): Pointer;
begin
  if (ProcName = 'AUiWorkbench_AddPage') then
    Result := Addr(AUiWorkbench_AddPage)
  else if (ProcName = 'AUiWorkbench_Fin') then
    Result := Addr(AUiWorkbench_Fin)
  else if (ProcName = 'AUiWorkbench_Init') then
    Result := Addr(AUiWorkbench_Init)
  else if (ProcName = 'AUiWorkbench_SetOnChange') then
    Result := Addr(AUiWorkbench_SetOnChange)
  else
    Result := nil;
end;

function AUiWorkbenchMod_Init(): AError;
begin
  if FInitialized then
  begin
    Result := 0;
    Exit;
  end;

  // --- Init request modules ---

  if (ARuntime_InitModuleByUid(AUi_Uid) < 0) then
  begin
    Result := -4;
    Exit;
  end;

  Result := AUiWorkbench_Init();
end;

end.
