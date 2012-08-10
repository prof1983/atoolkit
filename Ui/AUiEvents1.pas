{**
@Abstract AUi events functions
@Author Prof1983 <prof1983@ya.ru>
@Created 10.08.2012
@LastMod 10.08.2012
}
unit AUiEvents1;

interface

uses
  ABase, AEvents;

{** Connect to OnDone event }
function Ui_OnDone_Connect(Proc: ACallbackProc): AInteger;

{** Disconnect from OnDone event }
function Ui_OnDone_Disconnect(Proc: ACallbackProc): AInteger;

implementation

function Ui_OnDone_Connect(Proc: ACallbackProc): AInteger;
begin
  Result := AEvents.Event_Connect(FOnDone, Proc);
end;

function Ui_OnDone_Disconnect(Proc: ACallbackProc): AInteger;
begin
  Result := AEvents.Event_Disconnect(FOnDone, Proc);
end;

end.
