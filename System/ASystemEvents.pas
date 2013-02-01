{**
@Abstract ASystem event function
@Author Prof1983 <prof1983@ya.ru>
@Created 16.11.2012
@LastMod 31.01.2013
}
unit ASystemEvents;

{define AStdCall}

{$ifndef NoRuntime}
  {$define UseRuntime}
{$endif}

interface

uses
  ABase,
  AEventsMain,
  {$ifdef UseRuntime}ARuntimeMain,{$endif}
  ASystemData;

function ASystem_OnAfterRun_Connect(Callback: ACallbackProc; Weight: AInt = High(AInt)): AInt; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_OnAfterRun_Disconnect(Callback: ACallbackProc): AInt; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_OnBeforeRun_Connect(Callback: ACallbackProc; Weight: AInt = High(AInt)): AInt; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_OnBeforeRun_Disconnect(Callback: ACallbackProc): AInt; {$ifdef AStdCall}stdcall;{$endif}

// --- Private ---

function ASystemEvents_Init(): AError;

implementation

// --- Events ---

function DoAfterRun(): AInteger; stdcall;
begin
  Result := AEvent_Invoke(FOnAfterRunEvent, 0);
end;

function DoBeforeRun(): AInteger; stdcall;
begin
  Result := AEvent_Invoke(FOnBeforeRunEvent, 0);
end;

// --- ASystem ---

function ASystem_OnAfterRun_Connect(Callback: ACallbackProc; Weight: AInt): AInt;
begin
  Result := AEvent_Connect(FOnAfterRunEvent, Callback, Weight);
end;

function ASystem_OnAfterRun_Disconnect(Callback: ACallbackProc): AInt;
begin
  Result := AEvent_Disconnect(FOnAfterRunEvent, Callback);
end;

function ASystem_OnBeforeRun_Connect(Callback: ACallbackProc; Weight: AInt = High(AInt)): AInt;
begin
  Result := AEvent_Connect(FOnBeforeRunEvent, Callback, Weight);
end;

function ASystem_OnBeforeRun_Disconnect(Callback: ACallbackProc): AInt;
begin
  Result := AEvent_Disconnect(FOnBeforeRunEvent, Callback);
end;

// --- ASystemEvents ---

function ASystemEvents_Init(): AError;
begin
  if (AEvents_Init() < 0) then
  begin
    Result := -3;
    Exit;
  end;

  FOnAfterRunEvent := AEvent_NewP(0, 'AfterRun');
  FOnBeforeRunEvent := AEvent_NewP(0, 'BeforeRun');
  {$ifdef UseRuntime}
  ARuntime_SetOnAfterRun(DoAfterRun);
  ARuntime_SetOnBeforeRun(DoBeforeRun);
  {$endif}

  Result := 0;
end;

end.
 