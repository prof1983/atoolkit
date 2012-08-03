{**
@Abstract ARuntime
@Author Prof1983 <prof1983@ya.ru>
@Created 20.08.2007
@LastMod 03.08.2012
}
unit ARuntime;

interface

uses
  ABase, ABaseTypes, ARuntimeBase, ARuntimeData;

// --- AModule ---  

function AModule_Register(const Module: AModule_Type): AInteger; stdcall;

// --- ARuntime ---

function ARuntime_AddModule(const Module: AModule_Type): AInteger; stdcall;

function ARuntime_DeleteModuleByIndex(Index: AInteger): AInteger; stdcall;

function ARuntime_DeleteModuleByName(Name: PAnsiChar): AInteger; stdcall;

function ARuntime_DeleteModuleByNameWS(const Name: AWideString): AInteger; stdcall;

function ARuntime_DeleteModuleByUid(Uid: AModuleUid): AInteger; stdcall;

{** Finalize Runtime (Shutdown, Work end, Unloading of modules) }
function ARuntime_Fin(): AError; stdcall;

function ARuntime_FindModuleByName(Name: PAnsiChar): AInteger; stdcall;

function ARuntime_FindModuleByNameWS(const Name: AWideString): AInteger; stdcall;

function ARuntime_FindModuleByUid(Uid: AModuleUid): AInteger; stdcall;

function ARuntime_GetIsShutdown(): ABoolean; stdcall;

function ARuntime_GetModuleByName(Name: PAnsiChar; out Module: AModule_Type): AInteger; stdcall;

function ARuntime_GetModuleByUid(Uid: AModuleUid; out Module: AModule_Type): AInteger; stdcall;

function ARuntime_GetModuleNameByIndex(Index: AInteger; Name: PAnsiChar; MaxLen: AInteger): AInteger; stdcall;

function ARuntime_GetModuleNameByUid(Uid: AInteger; Name: PAnsiChar; MaxLen: AInteger): AInteger; stdcall;

function ARuntime_GetModuleProcsByUid(Uid: AModuleUid): Pointer; stdcall;

function ARuntime_GetModulesCount(): AInteger; stdcall;

function ARuntime_GetModuleUidByIndex(Index: AInteger): AModuleUid; stdcall;

function ARuntime_GetOnAfterRun(): AProc; stdcall;

function ARuntime_GetOnBeforeRun(): AProc; stdcall;

function ARuntime_InitModuleByName(Name: PAnsiChar): AInteger; stdcall;

function ARuntime_InitModuleByNameWS(const ModuleName: AWideString): AInteger; stdcall;

function ARuntime_InitModuleByUid(Uid: AModuleUid): AInteger; stdcall;

function ARuntime_IsShutdown(): ABoolean; stdcall; deprecated; // Use ARuntime_GetIsShutdown()

function ARuntime_OnAfterRun_Get(): AProc; stdcall; deprecated; // Use ARuntime_GetOnAfterRun()

function ARuntime_OnAfterRun_Set(Value: AProc): AError; stdcall; deprecated; // Use ARuntime_SetOnAfterRun()

function ARuntime_OnBeforeRun_Get(): AProc; stdcall; deprecated; // Use ARuntime_GetOnBeforeRun()

function ARuntime_OnBeforeRun_Set(Value: AProc): AError; stdcall; deprecated; // Use ARuntime_SetOnBeforeRun()

function ARuntime_OnRun_Set(Value: AProc): AError; stdcall; deprecated; // Use ARuntime_SetOnRun()

function ARuntime_Run(): AError; stdcall;

function ARuntime_SetOnAfterRun(Value: AProc): AError; stdcall;

function ARuntime_SetOnBeforeRun(Value: AProc): AError; stdcall;

function ARuntime_SetOnRun(Value: AProc): AError; stdcall;

function ARuntime_SetOnShutdown(Value: AProc): AError; stdcall;

function ARuntime_Shutdown(): AError; stdcall;

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
function Runtime_Modules_GetByNameP(Name: PChar; Module: AModule): AInteger; stdcall; //deprecated;
function Runtime_Modules_GetByUid(Uid: AModuleUid; out Module: AModule_Type): AInteger; stdcall; deprecated; // Use ARuntime_GetModuleByUid()
function Runtime_Modules_GetByUidP(Uid: AModuleUid; Module: AModule): AInteger; stdcall; //deprecated;
function Runtime_Modules_GetNameByIndex(Index: AInteger; Name: PAnsiChar; MaxLen: AInteger): AInteger; stdcall; deprecated; // Use ARuntime_GetModuleNameByIndex()
function Runtime_Modules_GetNameByIndex02(Index: AInteger): AWideString; stdcall; //deprecated;
function Runtime_Modules_GetProcsByUid(Uid: AModuleUid): Pointer; stdcall; deprecated; // Use ARuntime_GetModuleProcsByUid()
function Runtime_Modules_GetUidByIndex(Index: AInteger): AModuleUid; stdcall; deprecated; // Use ARuntime_GetModuleUidByIndex()
function Runtime_Modules_InitByName(Name: PAnsiChar): AInteger; stdcall; deprecated; // Use ARuntime_InitModuleByName()
function Runtime_Modules_InitByNameWS(const ModuleName: AWideString): AInteger; stdcall; deprecated; // Use ARuntime_InitModuleByNameWS()
function Runtime_Modules_InitByUid(Uid: AModuleUid): AInteger; stdcall; deprecated; // Use ARuntime_InitModuleByUid()

implementation

var
  FModules: array of AModule_Type;

{ Private }

function _FindModuleByUid(Uid: AModuleUid): AInteger;
var
  I: Integer;
begin
  for I := 0 to High(FModules) do
  begin
    if (FModules[I].UID = UID) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

function _FindModuleByName(const Name: string): AInteger;
var
  I: Integer;
begin
  for I := 0 to High(FModules) do
  begin
    if (string(FModules[I].Name) = Name) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

// --- AModule ---

function AModule_Register(const Module: AModule_Type): AInteger; stdcall;
begin
  try
    if (_FindModuleByUid(Module.Uid) >= 0) then
    begin
      Result := -2;
      Exit;
    end;
    if (_FindModuleByName(Module.Name) >= 0) then
    begin
      Result := -3;
      Exit;
    end;
    Result := ARuntime_AddModule(Module);
  except
    Result := -1;
  end;
end;

// --- ARuntime ---

function ARuntime_AddModule(const Module: AModule_Type): AInteger;
begin
  try
    Result := Length(FModules);
    SetLength(FModules, Result+1);
    //FModules[Result] := Module^;
    FModules[Result].Version := Module.Version;
    FModules[Result].Uid := Module.Uid;
    FModules[Result].Name := Module.Name;
    FModules[Result].Description := Module.Description;
    FModules[Result].Init := Module.Init;
    FModules[Result].Fin := Module.Fin;
    FModules[Result].GetProc := Module.GetProc;
    FModules[Result].Procs := Module.Procs;
  except
    Result := -1;
  end;
end;

function ARuntime_DeleteModuleByIndex(Index: AInteger): AInteger; 
var
  I: Integer;
begin
  if (Index >= 0) and (Length(FModules) > 0) then
  begin
    for I := Index to High(FModules)-1 do
      FModules[I] := FModules[I+1];
    SetLength(FModules, High(FModules));
  end;
  Result := 0;
end;

function ARuntime_DeleteModuleByName(Name: PAnsiChar): AInteger; 
var
  Index: Integer;
begin
  Index := ARuntime_FindModuleByName(Name);
  Result := ARuntime_DeleteModuleByIndex(Index);
end;

function ARuntime_DeleteModuleByNameWS(const Name: AWideString): AInteger;
var
  Index: Integer;
begin
  Index := ARuntime_FindModuleByNameWS(Name);
  Result := ARuntime_DeleteModuleByIndex(Index);
end;

function ARuntime_DeleteModuleByUid(Uid: AModuleUid): AInteger;
var
  Index: Integer;
begin
  try
    Index := ARuntime_FindModuleByUid(Uid);
    Result := ARuntime_DeleteModuleByIndex(Index);
  except
    Result := -1;
  end;
end;

function ARuntime_Fin(): AError;
var
  Uid: AInteger;
  I: AInteger;
begin
  try
    while (Length(FModules) > 0) do
    begin
      // Remove the modules from the end of the list. If you want to delete modules from the beginning of the list, then replace the: I := 0;
      I := High(FModules);
      Uid := FModules[I].Uid;
      if Assigned(FModules[I].Fin) then
      try
        FModules[I].Fin();
      except
      end;
      // Check, because when performing Module.Done could be done Runtime_Modules_DeleteByUid or Runtime_Modules_DeleteByName
      if (Length(FModules) >= I) and (FModules[I].Uid = Uid) then
        ARuntime_DeleteModuleByIndex(I);
    end;
    Result := 0;
  except
    Result := -1;
  end;
end;

function ARuntime_FindModuleByName(Name: PAnsiChar): AInteger;
begin
  try
    Result := _FindModuleByName(Name);
  except
    Result := -1;
  end;
end;

function ARuntime_FindModuleByNameWS(const Name: AWideString): AInteger; 
begin
  Result := _FindModuleByName(Name);
end;

function ARuntime_FindModuleByUid(Uid: AModuleUid): AInteger;
begin
  try
    Result := _FindModuleByUid(Uid);
  except
    Result := -1;
  end;
end;

function ARuntime_GetIsShutdown(): ABoolean;
begin
  try
    Result := FIsShutdown;
  except
    Result := False;
  end;
end;

function ARuntime_GetModuleByName(Name: PAnsiChar; out Module: AModule_Type): AInteger;
var
  I: Integer;
begin
  try
    I := ARuntime_FindModuleByName(Name);
    if (I >= 0) then
    begin
      Module := FModules[I];
      Result := I;
    end
    else
      Result := -2;
  except
    Result := -1;
  end;
end;

function ARuntime_GetModuleByUid(Uid: AModuleUid; out Module: AModule_Type): AInteger;
var
  I: Integer;
begin
  try
    I := ARuntime_FindModuleByUid(Uid);
    if (I >= 0) then
    begin
      Module := FModules[I];
      Result := I;
    end
    else
      Result := -2;
  except
    Result := -1;
  end;
end;

function ARuntime_GetModuleNameByIndex(Index: AInteger; Name: PAnsiChar; MaxLen: AInteger): AInteger;
begin
  FillChar(Name^, MaxLen, 0);
  if (Index >= 0) and (Index < Length(FModules)) then
  begin
    Result := Length(FModules[Index].Name);
    if (Result < MaxLen) then
      Move(FModules[Index].Name^, Name^, Result);
  end
  else
    Result := 0;
end;

function ARuntime_GetModuleNameByUid(Uid: AInteger; Name: PAnsiChar; MaxLen: AInteger): AInteger;
var
  Index: Integer;
begin
  Index := ARuntime_FindModuleByUid(Uid);
  if (Index >= 0) and (Index < Length(FModules)) then
  begin
    Result := Length(FModules[Index].Name);
    if (Result < MaxLen) then
      Name := PAnsiChar(FModules[Index].Name);
  end
  else
  begin
    Name := PAnsiChar('');
    Result := 0;
  end;
end;

function ARuntime_GetModuleProcsByUid(Uid: AModuleUid): Pointer;
var
  Index: Integer;
begin
  Index := ARuntime_FindModuleByUid(Uid);
  if (Index >= 0) and (Index < Length(FModules)) then
    Result := FModules[Index].Procs
  else
    Result := nil;
end;

function ARuntime_GetModulesCount(): AInteger;
begin
  Result := Length(FModules);
end;

function ARuntime_GetModuleUidByIndex(Index: AInteger): AModuleUid; 
begin
  if (Index >= 0) and (Index < Length(FModules)) then
    Result := FModules[Index].Uid
  else
    Result := 0;
end;

function ARuntime_GetOnAfterRun(): AProc;
begin
  try
    Result := FOnAfterRun;
  except
    Result := nil;
  end;
end;

function ARuntime_GetOnBeforeRun(): AProc;
begin
  try
    Result := FOnBeforeRun;
  except
    Result := nil;
  end;
end;

function ARuntime_InitModuleByName(Name: PAnsiChar): AInteger; stdcall;
var
  I: Integer;
begin
  I := ARuntime_FindModuleByName(Name);
  if (I < 0) then
  begin
    Result := -1;
    Exit;
  end;
  try
    Result := FModules[I].Init;
  except
    Result := -1;
  end;
end;

function ARuntime_InitModuleByNameWS(const ModuleName: AWideString): AInteger;
var
  I: Integer;
begin
  I := ARuntime_FindModuleByNameWS(ModuleName);
  if (I < 0) then
  begin
    Result := -1;
    Exit;
  end;
  try
    Result := FModules[I].Init;
  except
    Result := -1;
  end;
end;

function ARuntime_InitModuleByUid(Uid: AModuleUid): AInteger;
var
  I: Integer;
begin
  I := ARuntime_FindModuleByUid(Uid);
  if (I < 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    Result := FModules[I].Init();
  except
    Result := -1;
  end;
end;

function ARuntime_IsShutdown(): ABoolean;
begin
  Result := ARuntime_GetIsShutdown();
end;

function ARuntime_OnAfterRun_Get(): AProc;
begin
  Result := ARuntime_GetOnAfterRun();
end;

function ARuntime_OnAfterRun_Set(Value: AProc): AError;
begin
  Result := ARuntime_SetOnAfterRun(Value);
end;

function ARuntime_OnBeforeRun_Get(): AProc;
begin
  Result := ARuntime_GetOnBeforeRun();
end;

function ARuntime_OnBeforeRun_Set(Value: AProc): AError;
begin
  Result := ARuntime_SetOnBeforeRun(Value);
end;

function ARuntime_OnRun_Set(Value: AProc): AError;
begin
  Result := ARuntime_SetOnRun(Value);
end;

function ARuntime_Run(): AError;
begin
  try
    if Assigned(FOnBeforeRun) then
      FOnBeforeRun;
    if Assigned(FOnRun) then
      FOnRun;
    if Assigned(FOnRun02) then
      FOnRun02;
    if Assigned(FOnAfterRun) then
      FOnAfterRun;
    Result := 0;
  except
    Result := -1;
  end;
end;

function ARuntime_SetOnAfterRun(Value: AProc): AError;
begin
  try
    FOnAfterRun := Value;
    Result := 0;
  except
    Result := -1;
  end;
end;

function ARuntime_SetOnBeforeRun(Value: AProc): AError;
begin
  try
    FOnBeforeRun := Value;
    Result := 0;
  except
    Result := -1;
  end;
end;

function ARuntime_SetOnRun(Value: AProc): AError;
begin
  try
    FOnRun := Value;
    Result := 0;
  except
    Result := -1;
  end;
end;

function ARuntime_SetOnShutdown(Value: AProc): AError;
begin
  FOnShutdown := Value;
  Result := 0;
end;

function ARuntime_Shutdown(): AError;
begin
  FIsShutdown := True;
  try
    if Assigned(FOnShutdown) then
      FOnShutdown;
    if Assigned(FOnShutdown02) then
      FOnShutdown02;
    Result := 0;
  except
    Result := -1;
  end;
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

function Runtime_Modules_GetByNameP(Name: PChar; Module: AModule): AInteger;
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
  if (Index >= 0) and (Index < Length(FModules)) then
    Result := FModules[Index].Name
  else
    Result := '';
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
