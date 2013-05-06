{**
@Abstract ARuntime
@Author Prof1983 <prof1983@ya.ru>
@Created 28.08.2012
}
unit ARuntimeMain;

{define A02}
{$define AStdCall}

interface

uses
  ABase, ABaseTypes, ARuntimeBase, ARuntimeData;

// --- ARuntime ---

{$ifndef A02}
function ARuntime_AddModule(const Module: AModule_Type): AInteger; {$ifdef AStdCall}stdcall;{$endif}
{$endif}

function ARuntime_DeleteModuleByIndex(Index: AInteger): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_DeleteModuleByName(Name: AStr): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_DeleteModuleByNameWS(const Name: AWideString): AInteger; {$ifdef AStdCall}stdcall;{$endif}

{$ifndef A02}
function ARuntime_DeleteModuleByUid(Uid: AModuleUid): AInteger; {$ifdef AStdCall}stdcall;{$endif}
{$endif}

{** Finalize Runtime (Shutdown, Work end, Unloading of modules) }
function ARuntime_Fin(): AError; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_FindModuleByName(Name: AStr): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_FindModuleByNameWS(const Name: AWideString): AInteger; {$ifdef AStdCall}stdcall;{$endif}

{$ifndef A02}
function ARuntime_FindModuleByUid(Uid: AModuleUid): AInteger; {$ifdef AStdCall}stdcall;{$endif}
{$endif}

function ARuntime_GetIsShutdown(): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_GetModuleByName(Name: AStr; out Module: AModule_Type): AInteger; {$ifdef AStdCall}stdcall;{$endif}

{$ifndef A02}
function ARuntime_GetModuleByUid(Uid: AModuleUid; out Module: AModule_Type): AInteger; {$ifdef AStdCall}stdcall;{$endif}
{$endif}

{$ifndef A02}
function ARuntime_GetModuleNameByIndex(Index: AInteger; Name: AStr; MaxLen: AInteger): AInteger; {$ifdef AStdCall}stdcall;{$endif}
{$endif}

function ARuntime_GetModuleNameByIndexP(Index: AInteger): APascalString;

function ARuntime_GetModuleNameByIndexWS(Index: AInteger): AWideString; {$ifdef AStdCall}stdcall;{$endif}

{$ifndef A02}
function ARuntime_GetModuleNameByUid(Uid: AInteger; Name: AStr; MaxLen: AInteger): AInteger; {$ifdef AStdCall}stdcall;{$endif}
{$endif}

{$ifndef A02}
function ARuntime_GetModuleProcsByUid(Uid: AModuleUid): Pointer; {$ifdef AStdCall}stdcall;{$endif}
{$endif}

function ARuntime_GetModulesCount(): AInteger; {$ifdef AStdCall}stdcall;{$endif}

{$ifndef A02}
function ARuntime_GetModuleUidByIndex(Index: AInteger): AModuleUid; {$ifdef AStdCall}stdcall;{$endif}
{$endif}

function ARuntime_GetOnAfterRun(): AProc; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_GetOnBeforeRun(): AProc; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_InitModuleByName(Name: AStr): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_InitModuleByNameWS(const ModuleName: AWideString): AInteger; {$ifdef AStdCall}stdcall;{$endif}

{$ifndef A02}
function ARuntime_InitModuleByUid(Uid: AModuleUid): AInteger; {$ifdef AStdCall}stdcall;{$endif}
{$endif}

function ARuntime_IsShutdown(): ABoolean; stdcall; deprecated; // Use ARuntime_GetIsShutdown()

function ARuntime_OnAfterRun_Get(): AProc; stdcall; deprecated; // Use ARuntime_GetOnAfterRun()

function ARuntime_OnAfterRun_Set(Value: AProc): AError; stdcall; deprecated; // Use ARuntime_SetOnAfterRun()

function ARuntime_OnBeforeRun_Get(): AProc; stdcall; deprecated; // Use ARuntime_GetOnBeforeRun()

function ARuntime_OnBeforeRun_Set(Value: AProc): AError; stdcall; deprecated; // Use ARuntime_SetOnBeforeRun()

function ARuntime_OnRun_Set(Value: AProc): AError; stdcall; deprecated; // Use ARuntime_SetOnRun()

{$ifndef A02}
function ARuntime_RegisterModule(const Module: AModule_Type): AInteger; {$ifdef AStdCall}stdcall;{$endif}
{$endif}

function ARuntime_Run(): AError; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_SetOnAfterRun(Value: AProc): AError; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_SetOnBeforeRun(Value: AProc): AError; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_SetOnRun(Value: AProc): AError; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_SetOnShutdown(Value: AProc): AError; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_Shutdown(): AError; {$ifdef AStdCall}stdcall;{$endif}

implementation

{ Private }

{$ifndef A02}
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
{$endif}

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

// --- ARuntime ---

{$ifndef A02}
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
    {$ifdef A03}
    FModules[Result].Done := Module.Done;
    FModules[Result].Reserved06 := Module.Reserved06;
    {$else}
    FModules[Result].Fin := Module.Fin;
    FModules[Result].GetProc := Module.GetProc;
    {$endif}
    FModules[Result].Procs := Module.Procs;
  except
    Result := -1;
  end;
end;
{$endif}

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

function ARuntime_DeleteModuleByName(Name: AStr): AInteger;
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

{$ifndef A02}
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
{$endif}

function ARuntime_Fin(): AError;
{$ifndef A02}
var
  Uid: AInteger;
  I: AInteger;
{$endif}
begin
  try
    {$ifndef A02}
    while (Length(FModules) > 0) do
    begin
      // Remove the modules from the end of the list. If you want to delete modules from the beginning of the list, then replace the: I := 0;
      I := High(FModules);
      Uid := FModules[I].Uid;
      {$ifdef A03}
      if Assigned(FModules[I].Done) then
      try
        FModules[I].Done();
      except
      end;
      {$else}
      if Assigned(FModules[I].Fin) then
      try
        FModules[I].Fin();
      except
      end;
      {$endif}
      // Check, because when performing Module.Done could be done Runtime_Modules_DeleteByUid or Runtime_Modules_DeleteByName
      if (Length(FModules) >= I) and (FModules[I].Uid = Uid) then
        ARuntime_DeleteModuleByIndex(I);
    end;
    {$endif}
    Result := 0;
  except
    Result := -1;
  end;
end;

function ARuntime_FindModuleByName(Name: AStr): AInteger;
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

{$ifndef A02}
function ARuntime_FindModuleByUid(Uid: AModuleUid): AInteger;
begin
  try
    Result := _FindModuleByUid(Uid);
  except
    Result := -1;
  end;
end;
{$endif}

function ARuntime_GetIsShutdown(): ABoolean;
begin
  try
    Result := FIsShutdown;
  except
    Result := False;
  end;
end;

function ARuntime_GetModuleByName(Name: AStr; out Module: AModule_Type): AInteger;
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

{$ifndef A02}
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
{$endif}

{$ifndef A02}
function ARuntime_GetModuleNameByIndex(Index: AInteger; Name: AStr; MaxLen: AInteger): AInteger;
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
{$endif}

function ARuntime_GetModuleNameByIndexP(Index: AInteger): APascalString;
begin
  if (Index >= 0) and (Index < Length(FModules)) then
    Result := FModules[Index].Name
  else
    Result := '';
end;

function ARuntime_GetModuleNameByIndexWS(Index: AInteger): AWideString;
begin
  if (Index >= 0) and (Index < Length(FModules)) then
    Result := FModules[Index].Name
  else
    Result := '';
end;

{$ifndef A02}
function ARuntime_GetModuleNameByUid(Uid: AInteger; Name: AStr; MaxLen: AInteger): AInteger;
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
{$endif}

{$ifndef A02}
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
{$endif}

function ARuntime_GetModulesCount(): AInteger;
begin
  Result := Length(FModules);
end;

{$ifndef A02}
function ARuntime_GetModuleUidByIndex(Index: AInteger): AModuleUid;
begin
  if (Index >= 0) and (Index < Length(FModules)) then
    Result := FModules[Index].Uid
  else
    Result := 0;
end;
{$endif}

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

function ARuntime_InitModuleByName(Name: AStr): AInteger;
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

{$ifndef A02}
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
{$endif}

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

{$ifndef A02}
function ARuntime_RegisterModule(const Module: AModule_Type): AInteger;
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
{$endif}

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

end.
