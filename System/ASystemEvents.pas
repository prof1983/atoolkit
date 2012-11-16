{**
@Abstract ASystem event function
@Author Prof1983 <prof1983@ya.ru>
@Created 16.11.2012
@LastMod 16.11.2012
}
unit ASystemEvents;

{$IFNDEF NoRuntime}
  {$DEFINE USE_RUNTIME}
{$ENDIF}

interface

uses
  ABase, AEvents,
  {$IFDEF USE_RUNTIME}ARuntime,{$ENDIF}
  ASystemData;

function ASystem_OnAfterRun_Connect(Callback: ACallbackProc; Weight: AInt = High(AInt)): AInt; stdcall;

function ASystem_OnAfterRun_Disconnect(Callback: ACallbackProc): AInt; stdcall;

function ASystem_OnBeforeRun_Connect(Callback: ACallbackProc; Weight: AInt = High(AInt)): AInt; stdcall;

function ASystem_OnBeforeRun_Disconnect(Callback: ACallbackProc): AInt; stdcall;

// --- Private ---

function ASystemEvents_Init(): AError;

implementation

// --- Events ---

function DoAfterRun(): AInteger; stdcall;
begin
  Result := AEvents.Event_Invoke(FOnAfterRunEvent, 0);
end;

procedure DoAfterRun02(); stdcall;
begin
  AEvents.Event_Invoke(FOnAfterRunEvent, 0);
end;

function DoBeforeRun(): AInteger; stdcall;
begin
  Result := AEvents.Event_Invoke(FOnBeforeRunEvent, 0);
end;

procedure DoBeforeRun02(); stdcall;
begin
  AEvents.Event_Invoke(FOnBeforeRunEvent, 0);
end;

// --- ASystem ---

function ASystem_OnAfterRun_Connect(Callback: ACallbackProc; Weight: AInt): AInt;
begin
  Result := AEvents.Event_Connect(FOnAfterRunEvent, Callback, Weight);
end;

function ASystem_OnAfterRun_Disconnect(Callback: ACallbackProc): AInt;
begin
  Result := AEvents.Event_Disconnect(FOnAfterRunEvent, Callback);
end;

function ASystem_OnBeforeRun_Connect(Callback: ACallbackProc; Weight: AInt = High(AInt)): AInt;
begin
  Result := AEvents.Event_Connect(FOnBeforeRunEvent, Callback, Weight);
end;

function ASystem_OnBeforeRun_Disconnect(Callback: ACallbackProc): AInt;
begin
  Result := AEvents.Event_Disconnect(FOnBeforeRunEvent, Callback);
end;

// --- ASystemEvents ---

function ASystemEvents_Init(): AError;
begin
  if (AEvents.Init() < 0) then
  begin
    Result := -3;
    Exit;
  end;

  FOnAfterRunEvent := AEvents.Event_NewW(0, 'AfterRun');
  FOnBeforeRunEvent := AEvents.Event_NewW(0, 'BeforeRun');
  {$IFDEF USE_RUNTIME}
  {$IFDEF A01}
    ARuntime.OnAfterRun_Set(DoAfterRun02);
    ARuntime.OnBeforeRun_Set(DoBeforeRun02);
  {$ELSE}
    {$IFDEF A02}
    ARuntime.OnAfterRun_Set(DoAfterRun02);
    ARuntime.OnBeforeRun_Set(DoBeforeRun02);
    {$ELSE}
    ARuntime.SetOnAfterRun(DoAfterRun);
    ARuntime.SetOnBeforeRun(DoBeforeRun);
    {$ENDIF A02}
  {$ENDIF A01}
  {$ENDIF USE_RUNTIME}

  Result := 0;
end;

end.
 