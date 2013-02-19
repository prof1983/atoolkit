{**
@Abstract AUi events functions
@Author Prof1983 <prof1983@ya.ru>
@Created 10.08.2012
@LastMod 19.02.2013
}
unit AUiEvents;

{define AStdCall}

interface

uses
  ABase,
  AEventsMain,
  AUiData;

// --- AUi ---

{** Connect to OnDone event }
function AUi_OnDone_Connect(Proc: ACallbackProc): AInt; {$ifdef AStdCall}stdcall;{$endif}

{** Disconnect from OnDone event }
function AUi_OnDone_Disconnect(Proc: ACallbackProc): AInt; {$ifdef AStdCall}stdcall;{$endif}

implementation

// --- AUi ---

function AUi_OnDone_Connect(Proc: ACallbackProc): AInt;
begin
  try
    Result := AEvent_Connect(FOnDone, Proc);
  except
    Result := 0;
  end;
end;

function AUi_OnDone_Disconnect(Proc: ACallbackProc): AInt;
begin
  try
    Result := AEvent_Disconnect(FOnDone, Proc);
  except
    Result := 0;
  end;
end;

end.
