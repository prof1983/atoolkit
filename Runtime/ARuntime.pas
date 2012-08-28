{**
@Abstract ARuntime
@Author Prof1983 <prof1983@ya.ru>
@Created 20.08.2007
@LastMod 28.08.2012
}
unit ARuntime;

interface

uses
  ABase, ABaseTypes, ARuntimeBase, ARuntimeData, ARuntimeMain;

// --- AModule ---

function AModule_Register(const Module: AModule_Type): AInteger; stdcall;

// ----

function Done(): AError; stdcall; deprecated; // Use ARuntime_Fin()

function GetIsShutdown: ABoolean; stdcall;

function GetOnAfterRun: AProc; stdcall;

function GetOnBeforeRun: AProc; stdcall;

procedure SetOnAfterRun(Value: AProc); stdcall;

procedure SetOnBeforeRun(Value: AProc); stdcall;

procedure SetOnRun(Value: AProc); stdcall;

procedure SetOnRun02(Value: AProc02); stdcall;

procedure SetOnShutdown(Value: AProc03); stdcall;

procedure SetOnShutdown02(Value: AProc02); stdcall;

function Run(): AError; stdcall;

function Shutdown(): AError; stdcall;

procedure Shutdown02(); stdcall;

function IsShutdown(): ABoolean; stdcall; deprecated; // Use ARuntime_GetIsShutdown()

{$ifdef ADepr}

// --- Set event functions ---
function OnAfterRun_Get(): AProc; stdcall; deprecated; // Use ARuntime_GetOnAfterRun()
procedure OnAfterRun_Set(Value: AProc); stdcall; deprecated; // Use ARuntime_SetOnAfterRun()
function OnBeforeRun_Get(): AProc; stdcall; deprecated; // Use ARuntime_GetOnBeforeRun()
procedure OnBeforeRun_Set(Value: AProc); stdcall; deprecated; // Use ARuntime_SetOnBeforeRun()
procedure OnRun_Set(Value: AProc); stdcall; deprecated; // Use ARuntime_SetOnRun()

function Module_Register(const Module: AModule_Type): AInteger; stdcall; deprecated; // Use AModule_Register()

function Modules_AddModule(const Module: AModule_Type): AInteger; stdcall; deprecated; // Use ARuntime_AddModule()

function Modules_DeleteByUid(Uid: AModuleUid): AInteger; stdcall; deprecated; // Use ARuntime_DeleteModuleByUid()

function Modules_FindByName(Name: PAnsiChar): AInteger; stdcall; deprecated; // Use ARuntime_FindModuleByName()

function Modules_FindByUid(Uid: AModuleUid): AInteger; stdcall; deprecated; // Use ARuntime_FindModuleByUid()

function Modules_GetByName(Name: PAnsiChar; out Module: AModule_Type): AInteger; stdcall; deprecated; // Use ARuntime_GetModuleByName()

function Modules_GetByUid(Uid: AModuleUid; out Module: AModule_Type): AInteger; stdcall; deprecated; // Use ARuntime_GetModuleByUid()

function Modules_InitByName(Name: PAnsiChar): AInteger; stdcall; deprecated; // Use ARuntime_InitModuleByName()

function Modules_InitByUid(Uid: AModuleUid): AInteger; stdcall; deprecated; // Use ARuntime_InitModuleByUid()

function Runtime_Module_Register(const Module: AModule_Type): AInteger; stdcall; deprecated; // Use AModule_Register()
function Runtime_Modules_AddModule(const Module: AModule_Type): AInteger; stdcall; deprecated; // Use ARuntime_AddModule()
function Runtime_Modules_AddModuleP(Module: AModule): AInteger; stdcall;
function Runtime_Modules_Count(): AInteger; stdcall; deprecated; // Use ARuntime_GetModulesCount()
function Runtime_Modules_DeleteByIndex(Index: AInteger): AInteger; stdcall; deprecated; // Use ARuntime_DeleteModuleByIndex()
function Runtime_Modules_DeleteByName(Name: PAnsiChar): AInteger; stdcall; deprecated; // Use ARuntime_DeleteModuleByName()
function Runtime_Modules_DeleteByNameWS(const Name: AWideString): AInteger; stdcall; deprecated; // Use ARuntime_DeleteModuleByNameWS()
function Runtime_Modules_DeleteByUid(Uid: AModuleUid): AInteger; stdcall; deprecated; // Use ARuntime_DeleteModuleByUid()
function Runtime_Modules_FindByName(Name: PAnsiChar): AInteger; stdcall; deprecated; // Use ARuntime_FindModuleByName()
function Runtime_Modules_FindByNameWS(const Name: AWideString): AInteger; stdcall; deprecated; // Use ARuntime_FindModuleByNameWS()
function Runtime_Modules_FindByUid(Uid: AModuleUid): AInteger; stdcall; deprecated; // Use ARuntime_FindModuleByUid()
function Runtime_Modules_GetByName(Name: PAnsiChar; out Module: AModule_Type): AInteger; stdcall; deprecated; // Use ARuntime_GetModuleByName()
function Runtime_Modules_GetByNameP(Name: PAnsiChar; Module: AModule): AInteger; stdcall; //deprecated;
function Runtime_Modules_GetByUid(Uid: AModuleUid; out Module: AModule_Type): AInteger; stdcall; deprecated; // Use ARuntime_GetModuleByUid()
function Runtime_Modules_GetByUidP(Uid: AModuleUid; Module: AModule): AInteger; stdcall; //deprecated;
function Runtime_Modules_GetNameByIndex(Index: AInteger; Name: PAnsiChar; MaxLen: AInteger): AInteger; stdcall; deprecated; // Use ARuntime_GetModuleNameByIndex()
function Runtime_Modules_GetNameByIndex02(Index: AInteger): AWideString; stdcall; //deprecated;
function Runtime_Modules_GetProcsByUid(Uid: AModuleUid): Pointer; stdcall; deprecated; // Use ARuntime_GetModuleProcsByUid()
function Runtime_Modules_GetUidByIndex(Index: AInteger): AModuleUid; stdcall; deprecated; // Use ARuntime_GetModuleUidByIndex()
function Runtime_Modules_InitByName(Name: PAnsiChar): AInteger; stdcall; deprecated; // Use ARuntime_InitModuleByName()
function Runtime_Modules_InitByNameWS(const ModuleName: AWideString): AInteger; stdcall; deprecated; // Use ARuntime_InitModuleByNameWS()
function Runtime_Modules_InitByUid(Uid: AModuleUid): AInteger; stdcall; deprecated; // Use ARuntime_InitModuleByUid()

{$endif ADepr}

implementation

// --- AModule ---

function AModule_Register(const Module: AModule_Type): AInteger; stdcall;
begin
  Result := ARuntime_RegisterModule(Module);
end;

{ Runtime_Modules }

function Runtime_Modules_AddModule(const Module: AModule_Type): AInteger; stdcall;
begin
  Result := ARuntime_AddModule(Module);
end;

function Runtime_Modules_AddModuleP(Module: AModule): AInteger; stdcall;
begin
  if Assigned(Module) then
    Result := ARuntime_AddModule(Module^)
  else
    Result := -1;
end;

function Runtime_Modules_Count: AInteger; stdcall;
begin
  Result := ARuntime_GetModulesCount();
end;

function Runtime_Modules_DeleteByIndex(Index: AInteger): AInteger; stdcall;
begin
  Result := ARuntime_DeleteModuleByIndex(Index);
end;

function Runtime_Modules_DeleteByName(Name: PAnsiChar): AInteger;
begin
  Result := ARuntime_DeleteModuleByName(Name);
end;

function Runtime_Modules_DeleteByNameWS(const Name: AWideString): AInteger; stdcall;
begin
  Result := ARuntime_DeleteModuleByNameWS(Name);
end;

function Runtime_Modules_DeleteByUid(Uid: AModuleUid): AInteger; stdcall;
begin
  Result := ARuntime_DeleteModuleByUid(Uid);
end;

function Runtime_Modules_FindByName(Name: PAnsiChar): AInteger;
begin
  Result := ARuntime_FindModuleByName(Name);
end;

function Runtime_Modules_FindByNameWS(const Name: AWideString): AInteger; stdcall;
begin
  Result := ARuntime_FindModuleByNameWS(Name);
end;

function Runtime_Modules_FindByUid(Uid: AModuleUid): AInteger; stdcall;
begin
  Result := ARuntime_FindModuleByUid(Uid);
end;

function Runtime_Modules_GetByName(Name: PAnsiChar; out Module: AModule_Type): AInteger;
begin
  Result := ARuntime_GetModuleByName(Name, Module);
end;

function Runtime_Modules_GetByNameP(Name: PAnsiChar; Module: AModule): AInteger;
begin
  Result := ARuntime_GetModuleByName(Name, Module^);
end;

function Runtime_Modules_GetByUid(Uid: AModuleUid; out Module: AModule_Type): AInteger;
begin
  Result := ARuntime_GetModuleByUid(Uid, Module);
end;

function Runtime_Modules_GetByUidP(Uid: AModuleUid; Module: AModule): AInteger; stdcall;
begin
  Result := ARuntime_GetModuleByUid(Uid, Module^);
end;

function Runtime_Modules_GetNameByIndex(Index: AInteger; Name: PAnsiChar; MaxLen: AInteger): AInteger;
begin
  Result := ARuntime_GetModuleNameByIndex(Index, Name, MaxLen);
end;

function Runtime_Modules_GetNameByIndex02(Index: AInteger): AWideString; stdcall;
begin
  Result := ARuntime_GetModuleNameByIndexP(Index);
end;

function Runtime_Modules_GetNameByUid(Uid: AInteger; Name: PAnsiChar; MaxLen: AInteger): AInteger;
begin
  Result := ARuntime_GetModuleNameByUid(Uid, Name, MaxLen);
end;

function Runtime_Modules_GetProcsByUid(Uid: AModuleUid): Pointer; stdcall;
begin
  Result := ARuntime_GetModuleProcsByUid(Uid);
end;

function Runtime_Modules_GetUidByIndex(Index: AInteger): AModuleUid; stdcall;
begin
  Result := ARuntime_GetModuleUidByIndex(Index);
end;

function Runtime_Modules_InitByName(Name: PAnsiChar): AInteger;
begin
  Result := ARuntime_InitModuleByName(Name);
end;

function Runtime_Modules_InitByNameWS(const ModuleName: AWideString): AInteger; stdcall;
begin
  Result := ARuntime_InitModuleByNameWS(ModuleName);
end;

function Runtime_Modules_InitByUid(Uid: AModuleUid): AInteger; stdcall;
begin
  Result := ARuntime_InitModuleByUid(Uid);
end;

{ Runtime_Module }

function Runtime_Module_Register(const Module: AModule_Type): AInteger;
begin
  Result := AModule_Register(Module);
end;

{ Public }

function Done(): AError; stdcall;
begin
  Result := ARuntime_Fin();
end;

function GetIsShutdown: ABoolean; stdcall;
begin
  Result := FIsShutdown;
end;

function GetOnAfterRun: AProc; stdcall;
begin
  Result := ARuntime_GetOnAfterRun();
end;

function GetOnBeforeRun: AProc; stdcall;
begin
  Result := FOnBeforeRun;
end;

function IsShutdown: ABoolean; stdcall;
begin
  Result := ARuntime_GetIsShutdown();
end;

function OnAfterRun_Get: AProc; stdcall;
begin
  Result := ARuntime_GetOnAfterRun();
end;

procedure OnAfterRun_Set(Value: AProc); stdcall;
begin
  ARuntime_SetOnAfterRun(Value);
end;

function OnBeforeRun_Get: AProc; stdcall;
begin
  Result := ARuntime_GetOnBeforeRun();
end;

procedure OnBeforeRun_Set(Value: AProc); stdcall;
begin
  ARuntime_SetOnBeforeRun(Value);
end;

procedure OnRun_Set(Value: AProc); stdcall;
begin
  ARuntime_SetOnRun(Value);
end;

function Run(): AError; stdcall;
begin
  Result := ARuntime_Run();
end;

procedure SetOnAfterRun(Value: AProc); stdcall;
begin
  FOnAfterRun := Value;
end;

procedure SetOnBeforeRun(Value: AProc); stdcall;
begin
  FOnBeforeRun := Value;
end;

procedure SetOnRun(Value: AProc); stdcall;
begin
  FOnRun := Value;
end;

procedure SetOnRun02(Value: AProc02); stdcall;
begin
  FOnRun02 := Value;
end;

procedure SetOnShutdown(Value: AProc03); stdcall;
begin
  ARuntime_SetOnShutdown(Value);
end;

procedure SetOnShutdown02(Value: AProc02); stdcall;
begin
  FOnShutdown02 := Value;
end;

function Shutdown(): AError; stdcall;
begin
  Result := ARuntime_Shutdown();
end;

procedure Shutdown02(); stdcall;
begin
  ARuntime_Shutdown();
end;

{ Module }

function Module_Register(const Module: AModule_Type): AInteger;
begin
  Result := AModule_Register(Module);
end;

{ Modules }

function Modules_AddModule(const Module: AModule_Type): AInteger;
begin
  Result := ARuntime_AddModule(Module);
end;

function Modules_DeleteByUid(Uid: AModuleUid): AInteger; stdcall;
begin
  Result := ARuntime_DeleteModuleByUid(Uid);
end;

function Modules_FindByName(Name: PAnsiChar): AInteger;
begin
  Result := ARuntime_FindModuleByName(Name);
end;

function Modules_FindByUid(Uid: AModuleUid): AInteger; stdcall;
begin
  Result := ARuntime_FindModuleByUid(Uid);
end;

function Modules_GetByName(Name: PAnsiChar; out Module: AModule_Type): AInteger;
begin
  Result := ARuntime_GetModuleByName(Name, Module);
end;

function Modules_GetByUid(Uid: AModuleUid; out Module: AModule_Type): AInteger;
begin
  Result := ARuntime_GetModuleByUid(Uid, Module);
end;

function Modules_InitByName(Name: PAnsiChar): AInteger; stdcall;
begin
  Result := ARuntime_InitModuleByName(Name);
end;

function Modules_InitByUid(Uid: AModuleUid): AInteger; stdcall;
begin
  Result := ARuntime_InitModuleByUid(Uid);
end;

end.
