{**
@Abstract ARuntime
@Author Prof1983 <prof1983@ya.ru>
@Created 20.08.2007
}
unit ARuntime;

{define A02}

{$ifdef A02}
  {$define ADepr}
{$endif}

{$ifdef A03}
  {$define ADepr}
{$endif}

interface

uses
  ABase, ABaseTypes, ARuntimeBase, ARuntimeData, ARuntimeMain;

// --- AModule ---

{$ifndef A02}
function AModule_Register(const Module: AModule_Type): AInteger; stdcall;
{$endif}

// ----

function Done(): AError; stdcall; deprecated; // Use ARuntime_Fin()

function GetIsShutdown: ABoolean; stdcall;

function GetOnAfterRun: AProc; stdcall;

function GetOnBeforeRun: AProc; stdcall;

procedure SetOnAfterRun(Value: AProc); stdcall;

procedure SetOnBeforeRun(Value: AProc); stdcall;

procedure SetOnRun(Value: AProc); stdcall;

procedure SetOnRun02(Value: AProc02); stdcall;

procedure SetOnShutdown(Value: AProc); stdcall;

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

{$ifndef A02}
function Module_Register(const Module: AModule_Type): AInteger; stdcall; deprecated; // Use AModule_Register()
{$endif}

// --- Modules ---

{$ifndef A02}
function Modules_AddModule(const Module: AModule_Type): AInteger; stdcall; deprecated; // Use ARuntime_AddModule()
{$endif}

{$ifndef A02}
function Modules_DeleteByUid(Uid: AModuleUid): AInteger; stdcall; deprecated; // Use ARuntime_DeleteModuleByUid()
{$endif}

function Modules_FindByName(Name: PAnsiChar): AInteger; stdcall; deprecated; // Use ARuntime_FindModuleByName()

{$ifndef A02}
function Modules_FindByUid(Uid: AModuleUid): AInteger; stdcall; deprecated; // Use ARuntime_FindModuleByUid()
{$endif}

function Modules_GetByName(Name: PAnsiChar; out Module: AModule_Type): AInteger; stdcall; deprecated; // Use ARuntime_GetModuleByName()

{$ifndef A02}
function Modules_GetByUid(Uid: AModuleUid; out Module: AModule_Type): AInteger; stdcall; deprecated; // Use ARuntime_GetModuleByUid()
{$endif}

function Modules_InitByName(Name: PAnsiChar): AInteger; stdcall; deprecated; // Use ARuntime_InitModuleByName()

{$ifndef A02}
function Modules_InitByUid(Uid: AModuleUid): AInteger; stdcall; deprecated; // Use ARuntime_InitModuleByUid()
{$endif}

// --- Runtime ---

{$ifndef A02}
function Runtime_Module_Register(const Module: AModule_Type): AInteger; stdcall; deprecated; // Use AModule_Register()
{$endif}

function Runtime_Module_Register02(const Module: AModule02_Type): AInt; stdcall;

{$ifndef A02}
function Runtime_Modules_AddModule(const Module: AModule_Type): AInteger; stdcall; deprecated; // Use ARuntime_AddModule()
{$endif}

{$ifndef A02}
function Runtime_Modules_AddModuleP(Module: AModule): AInteger; stdcall;
{$endif}

function Runtime_Modules_Count(): AInteger; stdcall; deprecated; // Use ARuntime_GetModulesCount()

function Runtime_Modules_DeleteByIndex(Index: AInteger): AInteger; stdcall; deprecated; // Use ARuntime_DeleteModuleByIndex()

function Runtime_Modules_DeleteByName(Name: PAnsiChar): AInteger; stdcall; deprecated; // Use ARuntime_DeleteModuleByName()

function Runtime_Modules_DeleteByNameWS(const Name: AWideString): AInteger; stdcall; deprecated; // Use ARuntime_DeleteModuleByNameWS()

{$ifndef A02}
function Runtime_Modules_DeleteByUid(Uid: AModuleUid): AInteger; stdcall; deprecated; // Use ARuntime_DeleteModuleByUid()
{$endif}

function Runtime_Modules_FindByName(Name: PAnsiChar): AInteger; stdcall; deprecated; // Use ARuntime_FindModuleByName()

function Runtime_Modules_FindByNameWS(const Name: AWideString): AInteger; stdcall; deprecated; // Use ARuntime_FindModuleByNameWS()

{$ifndef A02}
function Runtime_Modules_FindByUid(Uid: AModuleUid): AInteger; stdcall; deprecated; // Use ARuntime_FindModuleByUid()
{$endif}

function Runtime_Modules_GetByName(Name: PAnsiChar; out Module: AModule_Type): AInteger; stdcall; deprecated; // Use ARuntime_GetModuleByName()

function Runtime_Modules_GetByName02(const Name: AWideString; out Module: AModule02_Type): ABoolean; stdcall; //deprecated;

function Runtime_Modules_GetByNameP(Name: PAnsiChar; Module: AModule): AInteger; stdcall; //deprecated;

{$ifndef A02}
function Runtime_Modules_GetByUid(Uid: AModuleUid; out Module: AModule_Type): AInteger; stdcall; deprecated; // Use ARuntime_GetModuleByUid()
{$endif}

{$ifndef A02}
function Runtime_Modules_GetByUidP(Uid: AModuleUid; Module: AModule): AInteger; stdcall; //deprecated;
{$endif}

{$ifndef A02}
function Runtime_Modules_GetNameByIndex(Index: AInteger; Name: PAnsiChar; MaxLen: AInteger): AInteger; stdcall; deprecated; // Use ARuntime_GetModuleNameByIndex()
{$endif}

function Runtime_Modules_GetNameByIndex02(Index: AInteger): AWideString; stdcall; //deprecated;

{$ifndef A02}
function Runtime_Modules_GetProcsByUid(Uid: AModuleUid): Pointer; stdcall; deprecated; // Use ARuntime_GetModuleProcsByUid()
{$endif}

{$ifndef A02}
function Runtime_Modules_GetUidByIndex(Index: AInteger): AModuleUid; stdcall; deprecated; // Use ARuntime_GetModuleUidByIndex()
{$endif}

function Runtime_Modules_InitByName(Name: PAnsiChar): AInteger; stdcall; deprecated; // Use ARuntime_InitModuleByName()

function Runtime_Modules_InitByNameWS(const ModuleName: AWideString): AInteger; stdcall; deprecated; // Use ARuntime_InitModuleByNameWS()

{$ifndef A02}
function Runtime_Modules_InitByUid(Uid: AModuleUid): AInteger; stdcall; deprecated; // Use ARuntime_InitModuleByUid()
{$endif}

{$endif ADepr}

implementation

// --- AModule ---

{$ifndef A02}
function AModule_Register(const Module: AModule_Type): AInteger; stdcall;
begin
  Result := ARuntime_RegisterModule(Module);
end;
{$endif}

{ Runtime_Modules }

{$ifndef A02}
function Runtime_Modules_AddModule(const Module: AModule_Type): AInteger; stdcall;
begin
  Result := ARuntime_AddModule(Module);
end;
{$endif}

{$ifndef A02}
function Runtime_Modules_AddModuleP(Module: AModule): AInteger; stdcall;
begin
  if Assigned(Module) then
    Result := ARuntime_AddModule(Module^)
  else
    Result := -1;
end;
{$endif}

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

{$ifndef A02}
function Runtime_Modules_DeleteByUid(Uid: AModuleUid): AInteger; stdcall;
begin
  Result := ARuntime_DeleteModuleByUid(Uid);
end;
{$endif}

function Runtime_Modules_FindByName(Name: PAnsiChar): AInteger;
begin
  Result := ARuntime_FindModuleByName(Name);
end;

function Runtime_Modules_FindByNameWS(const Name: AWideString): AInteger; stdcall;
begin
  Result := ARuntime_FindModuleByNameWS(Name);
end;

{$ifndef A02}
function Runtime_Modules_FindByUid(Uid: AModuleUid): AInteger; stdcall;
begin
  Result := ARuntime_FindModuleByUid(Uid);
end;
{$endif}

function Runtime_Modules_GetByName(Name: PAnsiChar; out Module: AModule_Type): AInteger;
begin
  Result := ARuntime_GetModuleByName(Name, Module);
end;

function Runtime_Modules_GetByName02(const Name: AWideString; out Module: AModule02_Type): ABoolean;
begin
  Result := False;
end;

function Runtime_Modules_GetByNameP(Name: PAnsiChar; Module: AModule): AInteger;
begin
  Result := ARuntime_GetModuleByName(Name, Module^);
end;

{$ifndef A02}
function Runtime_Modules_GetByUid(Uid: AModuleUid; out Module: AModule_Type): AInteger;
begin
  Result := ARuntime_GetModuleByUid(Uid, Module);
end;
{$endif}

{$ifndef A02}
function Runtime_Modules_GetByUidP(Uid: AModuleUid; Module: AModule): AInteger; stdcall;
begin
  Result := ARuntime_GetModuleByUid(Uid, Module^);
end;
{$endif}

{$ifndef A02}
function Runtime_Modules_GetNameByIndex(Index: AInteger; Name: PAnsiChar; MaxLen: AInteger): AInteger;
begin
  Result := ARuntime_GetModuleNameByIndex(Index, Name, MaxLen);
end;
{$endif}

function Runtime_Modules_GetNameByIndex02(Index: AInteger): AWideString; stdcall;
begin
  Result := ARuntime_GetModuleNameByIndexP(Index);
end;

{$ifndef A02}
function Runtime_Modules_GetNameByUid(Uid: AInteger; Name: PAnsiChar; MaxLen: AInteger): AInteger;
begin
  Result := ARuntime_GetModuleNameByUid(Uid, Name, MaxLen);
end;
{$endif}

{$ifndef A02}
function Runtime_Modules_GetProcsByUid(Uid: AModuleUid): Pointer; stdcall;
begin
  Result := ARuntime_GetModuleProcsByUid(Uid);
end;
{$endif}

{$ifndef A02}
function Runtime_Modules_GetUidByIndex(Index: AInteger): AModuleUid; stdcall;
begin
  Result := ARuntime_GetModuleUidByIndex(Index);
end;
{$endif}

function Runtime_Modules_InitByName(Name: PAnsiChar): AInteger;
begin
  Result := ARuntime_InitModuleByName(Name);
end;

function Runtime_Modules_InitByNameWS(const ModuleName: AWideString): AInteger; stdcall;
begin
  Result := ARuntime_InitModuleByNameWS(ModuleName);
end;

{$ifndef A02}
function Runtime_Modules_InitByUid(Uid: AModuleUid): AInteger; stdcall;
begin
  Result := ARuntime_InitModuleByUid(Uid);
end;
{$endif}

{ Runtime_Module }

{$ifndef A02}
function Runtime_Module_Register(const Module: AModule_Type): AInteger;
begin
  Result := AModule_Register(Module);
end;
{$endif}

function Runtime_Module_Register02(const Module: AModule02_Type): AInt;
begin
  Result := -1;
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

procedure SetOnShutdown(Value: AProc); stdcall;
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

{$ifndef A02}
function Module_Register(const Module: AModule_Type): AInteger;
begin
  Result := AModule_Register(Module);
end;
{$endif}

{ Modules }

{$ifndef A02}
function Modules_AddModule(const Module: AModule_Type): AInteger;
begin
  Result := ARuntime_AddModule(Module);
end;
{$endif}

{$ifndef A02}
function Modules_DeleteByUid(Uid: AModuleUid): AInteger; stdcall;
begin
  Result := ARuntime_DeleteModuleByUid(Uid);
end;
{$endif}

function Modules_FindByName(Name: PAnsiChar): AInteger;
begin
  Result := ARuntime_FindModuleByName(Name);
end;

{$ifndef A02}
function Modules_FindByUid(Uid: AModuleUid): AInteger; stdcall;
begin
  Result := ARuntime_FindModuleByUid(Uid);
end;
{$endif}

function Modules_GetByName(Name: PAnsiChar; out Module: AModule_Type): AInteger;
begin
  Result := ARuntime_GetModuleByName(Name, Module);
end;

{$ifndef A02}
function Modules_GetByUid(Uid: AModuleUid; out Module: AModule_Type): AInteger;
begin
  Result := ARuntime_GetModuleByUid(Uid, Module);
end;
{$endif}

function Modules_InitByName(Name: PAnsiChar): AInteger; stdcall;
begin
  Result := ARuntime_InitModuleByName(Name);
end;

{$ifndef A02}
function Modules_InitByUid(Uid: AModuleUid): AInteger; stdcall;
begin
  Result := ARuntime_InitModuleByUid(Uid);
end;
{$endif}

end.
