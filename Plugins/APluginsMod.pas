{**
@Abstract APlugins
@Author Prof1983 <prof1983@ya.ru>
@Created 10.04.2009
@LastMod 16.04.2013
}
unit APluginsMod;

interface

uses
  ABase,
  APluginsBase,
  APluginsMain,
  ARuntimeBase,
  ARuntimeMain;

// --- APluginsMod ---

function APluginsMod_Boot(): AError; stdcall;

function APluginsMod_Fin(): AError; stdcall;

function APluginsMod_GetProc(ProcName: AStr): Pointer; stdcall;

function APluginsMod_Init(): AError; stdcall;

implementation

const
  APlugins_Version = $00060100;

const
  PluginsModule: AModule_Type = (
    Version: APlugins_Version;
    Uid: APlugins_Uid;
    Name: APlugins_Name;
    Description: nil;
    Init: APluginsMod_Init;
    Fin: APluginsMod_Fin;
    GetProc: APluginsMod_GetProc;
    Procs: nil;
    );

// --- APluginsMod ---

function APluginsMod_Boot(): AError;
begin
  Result := ARuntime_RegisterModule(PluginsModule);
end;

function APluginsMod_Fin(): AError;
begin
  Result := APlugins_Fin();
end;

function APluginsMod_GetProc(ProcName: AStr): Pointer;
begin
  if (ProcName = 'APlugins_AddPluginA') then
    Result := Addr(APlugins_AddPluginA)
  else if (ProcName = 'APlugins_Clear') then
    Result := Addr(APlugins_Clear)
  else if (ProcName = 'APlugins_Delete') then
    Result := Addr(APlugins_Delete)
  else if (ProcName = 'APlugins_Fin') then
    Result := Addr(APlugins_Fin)
  else if (ProcName = 'APlugins_FinAll') then
    Result := Addr(APlugins_FinAll)
  else if (ProcName = 'APlugins_Find2A') then
    Result := Addr(APlugins_Find2A)
  else if (ProcName = 'APlugins_FindA') then
    Result := Addr(APlugins_FindA)
  else if (ProcName = 'APlugins_GetCount') then
    Result := Addr(APlugins_GetCount)
  else if (ProcName = 'APlugins_Init') then
    Result := Addr(APlugins_Init)
  else if (ProcName = 'APlugins_Prepare') then
    Result := Addr(APlugins_Prepare)
  else if (ProcName = 'APlugins_SetOnCheckPlugin') then
    Result := Addr(APlugins_SetOnCheckPlugin)
  else
    Result := nil;
end;

function APluginsMod_Init(): AError;
begin
  Result := APlugins_Init();
end;

end.
