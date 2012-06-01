{**
@Abstract()
@Author(Prof1983 prof1983@ya.ru)
@Created(26.10.2011)
@LastMod(26.10.2011)
@Version(0.5)
}
unit AUiMain;

interface

uses
  ABase, AEvents, AUiData;

function UI_OnDone_Connect(Proc: ACallbackProc): AInteger; stdcall;

implementation

function UI_OnDone_Connect(Proc: ACallbackProc): AInteger; stdcall;
begin
  Result := AEvents.Event_Connect(FOnDone, Proc);
end;

end.
 