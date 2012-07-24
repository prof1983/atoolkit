{**
@Abstract ARuntime
@Author Prof1983 <prof1983@ya.ru>
@Created 20.08.2007
@LastMod 24.07.2012
}
unit ARuntime;

{$IFNDEF A02} {$DEFINE A03} {$ENDIF}

interface

uses
  ABase, ABaseTypes, ARuntimeBase, ARuntimeData;

function Done(): AError; stdcall;

function ARuntime_IsShutdown(): ABoolean; stdcall;
function ARuntime_OnAfterRun_Get(): AProc; stdcall;
function ARuntime_OnAfterRun_Set(Value: AProc): AError; stdcall;
function ARuntime_OnBeforeRun_Get(): AProc; stdcall;
function ARuntime_OnBeforeRun_Set(Value: AProc): AError; stdcall;
function ARuntime_OnRun_Set(Value: AProc): AError; stdcall;
function ARuntime_Shutdown(): AError; stdcall;

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

function IsShutdown: ABoolean; stdcall;

// --- Set event functions ---
function OnAfterRun_Get: AProc; stdcall;
function OnBeforeRun_Get: AProc; stdcall;
procedure OnAfterRun_Set(Value: AProc); stdcall;
procedure OnBeforeRun_Set(Value: AProc); stdcall;
procedure OnRun_Set(Value: AProc); stdcall;

{$IFDEF A03}

function Module_Register(const Module: AModule03_Type): AInteger; stdcall;

function Modules_AddModule(const Module: AModule03_Type): AInteger; stdcall;

function Modules_DeleteByUid(Uid: AModuleUid): AInteger; stdcall;

function Modules_FindByName(Name: PChar): AInteger; stdcall;

function Modules_FindByUid(Uid: AModuleUid): AInteger; stdcall;

function Modules_GetByName(Name: PChar; out Module: AModule03_Type): AInteger; stdcall;

function Modules_GetByUid(Uid: AModuleUid; out Module: AModule03_Type): AInteger; stdcall;

function Modules_InitByName(Name: PChar): AInteger; stdcall;

function Modules_InitByUid(Uid: AModuleUid): AInteger; stdcall;

{$ENDIF A03}


{$IFDEF A03}
function Runtime_Module_Register(const Module: AModule03_Type): AInteger; stdcall;
function Runtime_Module_Register02(const Module: AModule02_Type): AInteger; stdcall;
{$ENDIF A03}

{$IFDEF A03}
function Runtime_Modules_AddModule(const Module: AModule03_Type): AInteger; stdcall;
function Runtime_Modules_AddModuleP(Module: AModule): AInteger; stdcall;
function Runtime_Modules_Count: AInteger; stdcall;
function Runtime_Modules_DeleteByIndex(Index: AInteger): AInteger; stdcall;
function Runtime_Modules_DeleteByName(Name: PChar): AInteger; stdcall;
function Runtime_Modules_DeleteByNameWS(const Name: AWideString): AInteger; stdcall;
function Runtime_Modules_DeleteByUid(Uid: AModuleUid): AInteger; stdcall;
function Runtime_Modules_FindByName(Name: PChar): AInteger; stdcall;
function Runtime_Modules_FindByNameWS(const Name: AWideString): AInteger; stdcall;
function Runtime_Modules_FindByUid(Uid: AModuleUid): AInteger; stdcall;
function Runtime_Modules_GetByName(Name: PChar; out Module: AModule03_Type): AInteger; stdcall;
function Runtime_Modules_GetByNameP(Name: PChar; Module: AModule): AInteger; stdcall; //deprecated;
function Runtime_Modules_GetByName02(const Name: AWideString; out Module: AModule02_Type): ABoolean; stdcall; //deprecated;
function Runtime_Modules_GetByUid(Uid: AModuleUid; out Module: AModule03_Type): AInteger; stdcall;
function Runtime_Modules_GetByUidP(Uid: AModuleUid; Module: AModule): AInteger; stdcall; //deprecated;
function Runtime_Modules_GetNameByIndex(Index: AInteger; Name: PChar; MaxLen: AInteger): AInteger; stdcall;
function Runtime_Modules_GetNameByIndex02(Index: AInteger): AWideString; stdcall; //deprecated;
function Runtime_Modules_GetProcsByUid(Uid: AModuleUid): Pointer; stdcall;
function Runtime_Modules_GetUidByIndex(Index: AInteger): AModuleUid; stdcall;
function Runtime_Modules_InitByName(Name: PChar): AInteger; stdcall;
function Runtime_Modules_InitByNameWS(const ModuleName: AWideString): AInteger; stdcall;
function Runtime_Modules_InitByUid(Uid: AModuleUid): AInteger; stdcall;
{$ENDIF A03}

{$IFDEF A03}
var
  FModules: array of AModule_Type;
{$ENDIF A03}

implementation

{ Private }

{$IFDEF A03}
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
{$ENDIF A03}

{$IFDEF A03}
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
{$ENDIF A03}

// --- ARuntime ---

function ARuntime_IsShutdown(): ABoolean;
begin
  try
    Result := IsShutdown;
  except
    Result := False;
  end;
end;

function ARuntime_OnAfterRun_Get(): AProc;
begin
  try
    Result := FOnAfterRun;
  except
    Result := nil;
  end;
end;

function ARuntime_OnAfterRun_Set(Value: AProc): AError;
begin
  try
    OnAfterRun_Set(Value);
    Result := 0;
  except
    Result := -1;
  end;
end;

function ARuntime_OnBeforeRun_Get(): AProc;
begin
  try
    Result := FOnBeforeRun;
  except
    Result := nil;
  end;
end;

function ARuntime_OnBeforeRun_Set(Value: AProc): AError;
begin
  try
    OnBeforeRun_Set(Value);
    Result := 0;
  except
    Result := -1;
  end;
end;

function ARuntime_OnRun_Set(Value: AProc): AError;
begin
  try
    OnRun_Set(Value);
    Result := 0;
  except
    Result := -1;
  end;
end;

function ARuntime_Shutdown(): AError;
begin
  try
    Shutdown;
    Result := 0;
  except
    Result := -1;
  end;
end;

{ Runtime }

function Runtime_Done(): AError;
{$IFDEF A03}
var
  Uid: AInteger;
  I: AInteger;
{$ENDIF A03}
begin
  {$IFDEF A03}
  while (Length(FModules) > 0) do
  begin
    // Remove the modules from the end of the list. If you want to delete modules from the beginning of the list, then replace the: I := 0;
    I := High(FModules);
    Uid := FModules[I].Uid;
    if Assigned(FModules[I].Done) then
    try
      FModules[I].Done();
    except
    end;
    // Check, because when performing Module.Done could be done Runtime_Modules_DeleteByUid or Runtime_Modules_DeleteByName
    if (Length(FModules) >= I) and (FModules[I].Uid = Uid) then
      Runtime_Modules_DeleteByIndex(I);
  end;
  {$ENDIF A03}
  Result := 0;
end;

{ Runtime_Modules }

{$IFDEF A03}
function Runtime_Modules_AddModule(const Module: AModule03_Type): AInteger; stdcall;
begin
  Result := Length(FModules);
  SetLength(FModules, Result+1);
  //FModules[Result] := Module^;
  FModules[Result].Version := Module.Version;
  FModules[Result].Uid := Module.Uid;
  FModules[Result].Name := Module.Name;
  FModules[Result].Description := Module.Description;
  FModules[Result].Init := Module.Init;
  FModules[Result].Done := Module.Done;
  FModules[Result].Reserved06 := Module.Reserved06;
  FModules[Result].Procs := Module.Procs;
end;
{$ENDIF A03}

{$IFDEF A03}
function Runtime_Modules_AddModuleP(Module: AModule): AInteger; stdcall;
begin
  if Assigned(Module) then
    Result := Runtime_Modules_AddModule(Module^)
  else
    Result := -1;
end;
{$ENDIF A03}

{$IFDEF A03}
function Runtime_Modules_Count: AInteger; stdcall;
begin
  Result := Length(FModules);
end;
{$ENDIF A03}

{$IFDEF A03}
function Runtime_Modules_DeleteByIndex(Index: AInteger): AInteger; stdcall;
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
{$ENDIF A03}

{$IFDEF A03}
function Runtime_Modules_DeleteByName(Name: PChar): AInteger; stdcall;
var
  Index: Integer;
begin
  Index := Runtime_Modules_FindByName(Name);
  Result := Runtime_Modules_DeleteByIndex(Index);
end;
{$ENDIF A03}

{$IFDEF A03}
function Runtime_Modules_DeleteByNameWS(const Name: AWideString): AInteger; stdcall;
var
  Index: Integer;
begin
  Index := Runtime_Modules_FindByNameWS(Name);
  Result := Runtime_Modules_DeleteByIndex(Index);
end;
{$ENDIF A03}

{$IFDEF A03}
function Runtime_Modules_DeleteByUid(Uid: AModuleUid): AInteger; stdcall;
var
  Index: Integer;
begin
  Index := Runtime_Modules_FindByUID(UID);
  Result := Runtime_Modules_DeleteByIndex(Index);
end;
{$ENDIF A03}

{$IFDEF A03}
function Runtime_Modules_FindByName(Name: PChar): AInteger; stdcall;
begin
  Result := _FindModuleByName(Name);
end;
{$ENDIF A03}

{$IFDEF A03}
function Runtime_Modules_FindByNameWS(const Name: AWideString): AInteger; stdcall;
begin
  Result := _FindModuleByName(Name);
end;
{$ENDIF A03}

{$IFDEF A03}
function Runtime_Modules_FindByUid(Uid: AModuleUid): AInteger; stdcall;
begin
  Result := _FindModuleByUid(Uid);
end;
{$ENDIF A03}

{$IFDEF A03}
function Runtime_Modules_GetByName(Name: PChar; out Module: AModule03_Type): AInteger; stdcall;
var
  I: Integer;
begin
  I := Runtime_Modules_FindByName(Name);
  if (I >= 0) then
  begin
    Module := FModules[I];
    Result := I;
  end
  else
    Result := -1;
end;
{$ENDIF A03}

{$IFDEF A03}
function Runtime_Modules_GetByNameP(Name: PChar; Module: AModule): AInteger; stdcall;
begin
  Result := Runtime_Modules_GetByName(Name, Module^);
end;
{$ENDIF A03}

{$IFDEF A03}
function Runtime_Modules_GetByName02(const Name: AWideString; out Module: AModule02_Type): ABoolean; stdcall;
begin
  Result := False;
end;
{$ENDIF A03}

{$IFDEF A03}
function Runtime_Modules_GetByUid(Uid: AModuleUid; out Module: AModule03_Type): AInteger; stdcall;
var
  I: Integer;
begin
  I := Runtime_Modules_FindByUid(Uid);
  if (I >= 0) then
  begin
    Module := FModules[I];
    Result := I;
  end
  else
    Result := -1;
end;
{$ENDIF A03}

{$IFDEF A03}
function Runtime_Modules_GetByUidP(Uid: AModuleUid; Module: AModule): AInteger; stdcall;
begin
  Result := Runtime_Modules_GetByUid(Uid, Module^);
end;
{$ENDIF A03}

{$IFDEF A03}
function Runtime_Modules_GetNameByIndex(Index: AInteger; Name: PChar; MaxLen: AInteger): AInteger; stdcall;
begin
  FillChar(Name^, MaxLen, 0);
  if (Index >= 0) and (Index < Length(FModules)) then
  begin
    Result := Length(FModules[Index].Name);
    if (Result < MaxLen) then
      Move(FModules[Index].Name^, Name^, Result); //Name := PChar(FModules[Index].Name);
  end
  else
    Result := 0;
end;
{$ENDIF A03}

{$IFDEF A03}
function Runtime_Modules_GetNameByIndex02(Index: AInteger): AWideString; stdcall;
begin
  if (Index >= 0) and (Index < Length(FModules)) then
    Result := FModules[Index].Name
  else
    Result := '';
end;
{$ENDIF A03}

{$IFDEF A03}
function Runtime_Modules_GetNameByUid(Uid: AInteger; Name: PChar; MaxLen: AInteger): AInteger; stdcall;
var
  Index: Integer;
begin
  Index := Runtime_Modules_FindByUid(Uid);
  if (Index >= 0) and (Index < Length(FModules)) then
  begin
    Result := Length(FModules[Index].Name);
    if (Result < MaxLen) then
      Name := PChar(FModules[Index].Name);
  end
  else
  begin
    Name := PChar('');
    Result := 0;
  end;
end;
{$ENDIF A03}

{$IFDEF A03}
function Runtime_Modules_GetProcsByUid(Uid: AModuleUid): Pointer; stdcall;
var
  Index: Integer;
begin
  Index := Runtime_Modules_FindByUid(Uid);
  if (Index >= 0) and (Index < Length(FModules)) then
    Result := FModules[Index].Procs
  else
    Result := nil;
end;
{$ENDIF A03}

{$IFDEF A03}
function Runtime_Modules_GetUidByIndex(Index: AInteger): AModuleUid; stdcall;
begin
  if (Index >= 0) and (Index < Length(FModules)) then
    Result := FModules[Index].Uid
  else
    Result := 0;
end;
{$ENDIF A03}

{$IFDEF A03}
function Runtime_Modules_InitByName(Name: PChar): AInteger; stdcall;
var
  I: Integer;
begin
  I := Runtime_Modules_FindByName(Name);
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
{$ENDIF A03}

{$IFDEF A03}
function Runtime_Modules_InitByNameWS(const ModuleName: AWideString): AInteger; stdcall;
var
  I: Integer;
begin
  I := Runtime_Modules_FindByNameWS(ModuleName);
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
{$ENDIF A03}

{$IFDEF A03}
function Runtime_Modules_InitByUid(Uid: AModuleUid): AInteger; stdcall;
var
  I: Integer;
begin
  I := Runtime_Modules_FindByUid(Uid);
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
{$ENDIF A03}

{ Runtime_Module }

{$IFDEF A03}
function Runtime_Module_Register(const Module: AModule03_Type): AInteger; stdcall;
begin
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
  Result := Runtime_Modules_AddModule(Module);
end;
{$ENDIF A03}

{$IFDEF A03}
function Runtime_Module_Register02(const Module: AModule02_Type): AInteger; stdcall;
begin
  Result := -1;
end;
{$ENDIF A03}

{ Public }

function Done(): AError; stdcall;
begin
  try
    Result := Runtime_Done();
  except
    Result := -1;
  end;
end;

function GetIsShutdown: ABoolean; stdcall;
begin
  Result := FIsShutdown;
end;

function GetOnAfterRun: AProc; stdcall;
begin
  Result := FOnAfterRun;
end;

function GetOnBeforeRun: AProc; stdcall;
begin
  Result := FOnBeforeRun;
end;

function IsShutdown: ABoolean; stdcall;
begin
  Result := FIsShutdown;
end;

function OnAfterRun_Get: AProc; stdcall;
begin
  Result := FOnAfterRun;
end;

procedure OnAfterRun_Set(Value: AProc); stdcall;
begin
  FOnAfterRun := Value;
end;

function OnBeforeRun_Get: AProc; stdcall;
begin
  Result := FOnBeforeRun;
end;

procedure OnBeforeRun_Set(Value: AProc); stdcall;
begin
  FOnBeforeRun := Value;
end;

procedure OnRun_Set(Value: AProc); stdcall;
begin
  FOnRun := Value;
end;

function Run(): AError; stdcall;
begin
  if Assigned(FOnBeforeRun) then
    FOnBeforeRun;
  if Assigned(FOnRun) then
    FOnRun;
  if Assigned(FOnRun02) then
    FOnRun02;
  if Assigned(FOnAfterRun) then
    FOnAfterRun;
  Result := 0;
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
  FOnShutdown := Value;
end;

procedure SetOnShutdown02(Value: AProc02); stdcall;
begin
  FOnShutdown02 := Value;
end;

function Shutdown(): AError; stdcall;
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

procedure Shutdown02(); stdcall;
begin
  Shutdown();
end;

{ Module }

{$IFDEF A03}
function Module_Register(const Module: AModule03_Type): AInteger; stdcall;
begin
  try
    Result := Runtime_Module_Register(Module);
  except
    Result := -1;
  end;
end;
{$ENDIF A03}

{ Modules }

{$IFDEF A03}
function Modules_AddModule(const Module: AModule03_Type): AInteger; stdcall;
begin
  try
    Result := Runtime_Modules_AddModule(Module);
  except
    Result := -1;
  end;
end;
{$ENDIF A03}

{$IFDEF A03}
function Modules_DeleteByUid(Uid: AModuleUid): AInteger; stdcall;
begin
  try
    Result := Runtime_Modules_DeleteByUid(Uid);
  except
    Result := -1;
  end;
end;
{$ENDIF A03}

{$IFDEF A03}
function Modules_FindByName(Name: PChar): AInteger; stdcall;
begin
  try
    Result := _FindModuleByName(Name);
  except
    Result := -1;
  end;
end;
{$ENDIF A03}

{$IFDEF A03}
function Modules_FindByUid(Uid: AModuleUid): AInteger; stdcall;
begin
  try
    Result := Runtime_Modules_FindByUid(Uid);
  except
    Result := -1;
  end;
end;
{$ENDIF A03}

{$IFDEF A03}
function Modules_GetByName(Name: PChar; out Module: AModule03_Type): AInteger; stdcall;
begin
  try
    Result := Runtime_Modules_GetByName(Name, Module);
  except
    Result := -1;
  end;
end;
{$ENDIF A03}

{$IFDEF A03}
function Modules_GetByUid(Uid: AModuleUid; out Module: AModule03_Type): AInteger; stdcall;
begin
  try
    Result := Runtime_Modules_GetByUid(Uid, Module);
  except
    Result := -1;
  end;
end;
{$ENDIF A03}

{$IFDEF A03}
function Modules_InitByName(Name: PChar): AInteger; stdcall;
begin
  try
    Result := Runtime_Modules_InitByName(Name);
  except
    Result := -1;
  end;
end;
{$ENDIF A03}

{$IFDEF A03}
function Modules_InitByUid(Uid: AModuleUid): AInteger; stdcall;
begin
  try
    Result := Runtime_Modules_InitByUid(Uid);
  except
    Result := -1;
  end;
end;
{$ENDIF A03}

end.
