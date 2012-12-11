{**
@Abstract ARuntime
@Author Prof1983 <prof1983@ya.ru>
@Created 28.08.2012
@LastMod 11.12.2012
}
unit ARuntimeMain;

{$define AStdCall}

interface

uses
  ABase, ABaseTypes, ARuntimeBase, ARuntimeData, AStringBaseUtils;

// --- ARuntime ---

function ARuntime_AddModule(const Module: AModule_Type): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_DeleteModuleByIndex(Index: AInteger): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_DeleteModuleByName(Name: AStr): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_DeleteModuleByNameWS(const Name: AWideString): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_DeleteModuleByUid(Uid: AModuleUid): AInteger; {$ifdef AStdCall}stdcall;{$endif}

{** Finalize Runtime (Shutdown, Work end, Unloading of modules) }
function ARuntime_Fin(): AError; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_FindModuleByName(Name: AStr): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_FindModuleByNameWS(const Name: AWideString): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_FindModuleByUid(Uid: AModuleUid): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_GetIsShutdown(): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_GetModuleByName(Name: AStr; out Module: AModule_Type): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_GetModuleByUid(Uid: AModuleUid; out Module: AModule_Type): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_GetModuleNameByIndex(Index: AInteger; Name: AStr; MaxLen: AInteger): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_GetModuleNameByIndexP(Index: AInteger): APascalString;

function ARuntime_GetModuleNameByIndexWS(Index: AInteger): AWideString; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_GetModuleNameByUid(Uid: AInteger; Name: AStr; MaxLen: AInteger): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_GetModuleProcsByUid(Uid: AModuleUid): Pointer; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_GetModulesCount(): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_GetModuleUidByIndex(Index: AInteger): AModuleUid; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_GetOnAfterRun(): AProc; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_GetOnBeforeRun(): AProc; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_GetProcByName(ModuleName, ProcName: AStr): Pointer; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_InitModuleByName(Name: AStr): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_InitModuleByNameWS(const ModuleName: AWideString): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_InitModuleByUid(Uid: AModuleUid): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_IsShutdown(): ABoolean; stdcall; deprecated; // Use ARuntime_GetIsShutdown()

function ARuntime_OnAfterRun_Get(): AProc; stdcall; deprecated; // Use ARuntime_GetOnAfterRun()

function ARuntime_OnAfterRun_Set(Value: AProc): AError; stdcall; deprecated; // Use ARuntime_SetOnAfterRun()

function ARuntime_OnBeforeRun_Get(): AProc; stdcall; deprecated; // Use ARuntime_GetOnBeforeRun()

function ARuntime_OnBeforeRun_Set(Value: AProc): AError; stdcall; deprecated; // Use ARuntime_SetOnBeforeRun()

function ARuntime_OnRun_Set(Value: AProc): AError; stdcall; deprecated; // Use ARuntime_SetOnRun()

function ARuntime_RegisterModule(const Module: AModule_Type): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_Run(): AError; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_SetOnAfterRun(Value: AProc): AError; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_SetOnBeforeRun(Value: AProc): AError; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_SetOnRun(Value: AProc): AError; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_SetOnShutdown(Value: AProc): AError; {$ifdef AStdCall}stdcall;{$endif}

function ARuntime_Shutdown(): AError; {$ifdef AStdCall}stdcall;{$endif}

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

function ARuntime_GetModuleNameByUid(Uid: AInteger; Name: AStr; MaxLen: AInteger): AInteger;
var
  Index: Integer;
begin
  if (MaxLen <= 0) then
  begin
    Result := 0;
    Exit;
  end;
  Index := ARuntime_FindModuleByUid(Uid);
  if (Index >= 0) and (Index < Length(FModules)) then
  begin
    Result := Length(FModules[Index].Name);
    AStr_AssignA(Name, FModules[Index].Name, MaxLen);
  end
  else
  begin
    Name[0] := #0;
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

function ARuntime_GetProcByName(ModuleName, ProcName: AStr): Pointer;
begin
  if (ModuleName = 'ARuntime') then
  begin
    if ProcName = 'ARuntime_AddModule' then
      Result := Addr(ARuntime_AddModule)
    else if ProcName = 'ARuntime_DeleteModuleByIndex' then
      Result := Addr(ARuntime_DeleteModuleByIndex)
    else if ProcName = 'ARuntime_DeleteModuleByName' then
      Result := Addr(ARuntime_DeleteModuleByName)
    else if ProcName = 'ARuntime_DeleteModuleByUid' then
      Result := Addr(ARuntime_DeleteModuleByUid)
    else if ProcName = 'ARuntime_Fin' then
      Result := Addr(ARuntime_Fin)
    else if ProcName = 'ARuntime_FindModuleByName' then
      Result := Addr(ARuntime_FindModuleByName)
    else if ProcName = 'ARuntime_FindModuleByUid' then
      Result := Addr(ARuntime_FindModuleByUid)
    else if ProcName = 'ARuntime_GetIsShutdown' then
      Result := Addr(ARuntime_GetIsShutdown)
    else if ProcName = 'ARuntime_GetModuleByName' then
      Result := Addr(ARuntime_GetModuleByName)
    else if ProcName = 'ARuntime_GetModuleByUid' then
      Result := Addr(ARuntime_GetModuleByUid)
    else if ProcName = 'ARuntime_GetModuleNameByIndex' then
      Result := Addr(ARuntime_GetModuleNameByIndex)
    else if ProcName = 'ARuntime_GetModuleNameByUid' then
      Result := Addr(ARuntime_GetModuleNameByUid)
    else if ProcName = 'ARuntime_GetModuleProcsByUid' then
      Result := Addr(ARuntime_GetModuleProcsByUid)
    else if ProcName = 'ARuntime_GetModulesCount' then
      Result := Addr(ARuntime_GetModulesCount)
    else if ProcName = 'ARuntime_GetModuleUidByIndex' then
      Result := Addr(ARuntime_GetModuleUidByIndex)
    else if ProcName = 'ARuntime_GetOnAfterRun' then
      Result := Addr(ARuntime_GetOnAfterRun)
    else if ProcName = 'ARuntime_GetOnBeforeRun' then
      Result := Addr(ARuntime_GetOnBeforeRun)
    else if ProcName = 'ARuntime_InitModuleByName' then
      Result := Addr(ARuntime_InitModuleByName)
    else if ProcName = 'ARuntime_InitModuleByUid' then
      Result := Addr(ARuntime_InitModuleByUid)
    else if ProcName = 'ARuntime_RegisterModule' then
      Result := Addr(ARuntime_RegisterModule)
    else if ProcName = 'ARuntime_Run' then
      Result := Addr(ARuntime_Run)
    else if ProcName = 'ARuntime_SetOnAfterRun' then
      Result := Addr(ARuntime_SetOnAfterRun)
    else if ProcName = 'ARuntime_SetOnBeforeRun' then
      Result := Addr(ARuntime_SetOnBeforeRun)
    else if ProcName = 'ARuntime_SetOnRun' then
      Result := Addr(ARuntime_SetOnRun)
    else if ProcName = 'ARuntime_SetOnShutdown' then
      Result := Addr(ARuntime_SetOnShutdown)
    else if ProcName = 'ARuntime_Shutdown' then
      Result := Addr(ARuntime_Shutdown)
    else
      Result := nil;
  end
  else
  begin
    //I := _FindModuleByName(ModuleName);
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
