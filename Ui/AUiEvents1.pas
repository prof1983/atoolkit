{**
@Abstract AUi events functions
@Author Prof1983 <prof1983@ya.ru>
@Created 10.08.2012
@LastMod 23.11.2012
}
unit AUiEvents1;

{$define AStdCall}

interface

uses
  ABase, AEvents,
  AUiData;

// --- AUi ---

{** Connect to OnDone event }
function AUi_OnDone_Connect(Proc: ACallbackProc): AInt; {$ifdef AStdCall}stdcall;{$endif}

{** Disconnect from OnDone event }
function AUi_OnDone_Disconnect(Proc: ACallbackProc): AInt; {$ifdef AStdCall}stdcall;{$endif}

// --- UI ---

{** Connect to OnDone event }
function Ui_OnDone_Connect(Proc: ACallbackProc): AInteger;

{** Disconnect from OnDone event }
function Ui_OnDone_Disconnect(Proc: ACallbackProc): AInteger;

implementation

// --- AUi ---

function AUi_OnDone_Connect(Proc: ACallbackProc): AInt;
begin
  try
    Result := AEvents.Event_Connect(FOnDone, Proc);
  except
    Result := 0;
  end;
end;

function AUi_OnDone_Disconnect(Proc: ACallbackProc): AInt;
begin
  try
    Result := AEvents.Event_Disconnect(FOnDone, Proc);
  except
    Result := 0;
  end;
end;

// --- Ui ---

function Ui_OnDone_Connect(Proc: ACallbackProc): AInteger;
begin
  Result := AUi_OnDone_Connect(Proc);
end;

function Ui_OnDone_Disconnect(Proc: ACallbackProc): AInteger;
begin
  Result := AUi_OnDone_Disconnect(Proc);
end;

end.
