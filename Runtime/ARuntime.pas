{**
@Abstract ARuntime
@Author Prof1983 <prof1983@ya.ru>
@Created 20.08.2007
@LastMod 30.01.2013
}
unit ARuntime;

interface

uses
  ABase, ABaseTypes, ARuntimeBase, ARuntimeData, ARuntimeMain;

// --- AModule ---

function AModule_Register(const Module: AModule_Type): AInteger; stdcall;

// ----

function Fin(): AError; stdcall;

function GetIsShutdown: ABoolean; stdcall;

function GetOnAfterRun: AProc; stdcall;

function GetOnBeforeRun: AProc; stdcall;

function Run(): AError; stdcall;

procedure SetOnAfterRun(Value: AProc); stdcall;

procedure SetOnBeforeRun(Value: AProc); stdcall;

procedure SetOnRun(Value: AProc); stdcall;

procedure SetOnShutdown(Value: AProc); stdcall;

function Shutdown(): AError; stdcall;

implementation

// --- AModule ---

function AModule_Register(const Module: AModule_Type): AInt;
begin
  Result := ARuntime_RegisterModule(Module);
end;

{ Public }

function Fin(): AError;
begin
  Result := ARuntime_Fin();
end;

function GetIsShutdown(): ABool;
begin
  Result := FIsShutdown;
end;

function GetOnAfterRun(): AProc;
begin
  Result := ARuntime_GetOnAfterRun();
end;

function GetOnBeforeRun(): AProc;
begin
  Result := FOnBeforeRun;
end;

function Run(): AError;
begin
  Result := ARuntime_Run();
end;

procedure SetOnAfterRun(Value: AProc);
begin
  FOnAfterRun := Value;
end;

procedure SetOnBeforeRun(Value: AProc);
begin
  FOnBeforeRun := Value;
end;

procedure SetOnRun(Value: AProc);
begin
  FOnRun := Value;
end;

procedure SetOnShutdown(Value: AProc);
begin
  ARuntime_SetOnShutdown(Value);
end;

function Shutdown(): AError;
begin
  Result := ARuntime_Shutdown();
end;

end.
