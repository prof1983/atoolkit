{**
@Abstract ASystem
@Author Prof1983 <prof1983@ya.ru>
@Created 20.08.2007
@LastMod 23.04.2013
}
unit ASystemMod;

interface

uses
  ABase,
  ARuntimeBase,
  ARuntimeMain,
  ASystemBase,
  ASystemEvents,
  ASystemMain,
  ASystemResourceString;

// --- Module ---

function ASystemMod_Boot(): AError; stdcall;

function ASystemMod_Fin(): AError; stdcall;

function ASystemMod_GetProc(ProcName: AStr): Pointer; stdcall;

function ASystemMod_Init(): AError; stdcall

implementation

const
  ASystem_Version = $00060200;

const
  SystemModule: AModule_Type = (
    Version: ASystem_Version;
    Uid: ASystem_Uid;
    Name: ASystem_Name;
    Description: nil;
    Init: ASystemMod_Init;
    Fin: ASystemMod_Fin;
    GetProc: ASystemMod_GetProc;
    Procs: nil;
    );

// --- ASystemMod ---

function ASystemMod_Boot(): AError;
begin
  Result := ARuntime_RegisterModule(SystemModule);
end;

function ASystemMod_Fin(): AError;
begin
  Result := ASystem_Fin();
end;

function ASystemMod_GetProc(ProcName: AStr): Pointer;
begin
  if (ProcName = 'ASystem_Fin') then
    Result := Addr(ASystem_Fin)
  else if (ProcName = 'ASystem_GetComments') then
    Result := Addr(ASystem_GetComments)
  else if (ProcName = 'ASystem_GetCompanyName') then
    Result := Addr(ASystem_GetCompanyName)
  else if (ProcName = 'ASystem_GetConfig') then
    Result := Addr(ASystem_GetConfig)
  else if (ProcName = 'ASystem_GetConfigDirectoryPath') then
    Result := Addr(ASystem_GetConfigDirectoryPath)
  else if (ProcName = 'ASystem_GetCopyright') then
    Result := Addr(ASystem_GetCopyright)
  else if (ProcName = 'ASystem_GetDataDirectoryPath') then
    Result := Addr(ASystem_GetDataDirectoryPath)
  else if (ProcName = 'ASystem_GetDescription') then
    Result := Addr(ASystem_GetDescription)
  else if (ProcName = 'ASystem_GetDirectoryPath') then
    Result := Addr(ASystem_GetDirectoryPath)
  else if (ProcName = 'ASystem_GetExeName') then
    Result := Addr(ASystem_GetExeName)
  else if (ProcName = 'ASystem_GetExePath') then
    Result := Addr(ASystem_GetExePath)
  else if (ProcName = 'ASystem_GetParamStr') then
    Result := Addr(ASystem_GetParamStr)
  else if (ProcName = 'ASystem_GetProgramName') then
    Result := Addr(ASystem_GetProgramName)
  else if (ProcName = 'ASystem_GetProductVersionStr') then
    Result := Addr(ASystem_GetProductVersionStr)
  else if (ProcName = 'ASystem_GetProgramName') then
    Result := Addr(ASystem_GetProgramName)
  else if (ProcName = 'ASystem_GetProgramVersionStr') then
    Result := Addr(ASystem_GetProgramVersionStr)
  else if (ProcName = 'ASystem_GetResourceString') then
    Result := Addr(ASystem_GetResourceString)
  else if (ProcName = 'ASystem_GetTitle') then
    Result := Addr(ASystem_GetTitle)
  else if (ProcName = 'ASystem_GetUrl') then
    Result := Addr(ASystem_GetUrl)
  else if (ProcName = 'ASystem_Init') then
    Result := Addr(ASystem_Init)
  else if (ProcName = 'ASystem_OnAfterRun_Connect') then
    Result := Addr(ASystem_OnAfterRun_Connect)
  else if (ProcName = 'ASystem_OnAfterRun_Disconnect') then
    Result := Addr(ASystem_OnAfterRun_Disconnect)
  else if (ProcName = 'ASystem_OnBeforeRun_Connect') then
    Result := Addr(ASystem_OnBeforeRun_Connect)
  else if (ProcName = 'ASystem_OnBeforeRun_Disconnect') then
    Result := Addr(ASystem_OnBeforeRun_Disconnect)
  else if (ProcName = 'ASystem_Prepare') then
    Result := Addr(ASystem_Prepare)
  else if (ProcName = 'ASystem_PrepareA') then
    Result := Addr(ASystem_PrepareA)
  else if (ProcName = 'ASystem_ProcessMessages') then
    Result := Addr(ASystem_ProcessMessages)
  else if (ProcName = 'ASystem_SetConfig') then
    Result := Addr(ASystem_SetConfig)
  else if (ProcName = 'ASystem_SetDataDirectoryPath') then
    Result := Addr(ASystem_SetDataDirectoryPath)
  else if (ProcName = 'ASystem_SetOnProcessMessages') then
    Result := Addr(ASystem_SetOnProcessMessages)
  else if (ProcName = 'ASystem_SetOnShowErrorA') then
    Result := Addr(ASystem_SetOnShowErrorA)
  else if (ProcName = 'ASystem_SetOnShowMessageA') then
    Result := Addr(ASystem_SetOnShowMessageA)
  else if (ProcName = 'ASystem_ShellExecute') then
    Result := Addr(ASystem_ShellExecute)
  else if (ProcName = 'ASystem_ShowError') then
    Result := Addr(ASystem_ShowError)
  else if (ProcName = 'ASystem_ShowErrorA') then
    Result := Addr(ASystem_ShowErrorA)
  else if (ProcName = 'ASystem_ShowMessage') then
    Result := Addr(ASystem_ShowMessage)
  else if (ProcName = 'ASystem_ShowMessageA') then
    Result := Addr(ASystem_ShowMessageA)
  else if (ProcName = 'ASystem_ShowMessageEx') then
    Result := Addr(ASystem_ShowMessageEx)
  else if (ProcName = 'ASystem_ShowMessageExA') then
    Result := Addr(ASystem_ShowMessageExA)
  else
    Result := nil;
end;

function ASystemMod_Init(): AError;
begin
  Result := ASystem_Init();
end;

end.
