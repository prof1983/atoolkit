{**
@Abstract AUi common functions
@Author Prof1983 <prof1983@ya.ru>
@Created 26.10.2011
@LastMod 19.07.2012
}
unit AUIMain;

interface

uses
  Forms, SysUtils, Windows,
  ABase, AEvents, ASystem,
  AUiData;

//** Присоединяет к событию OnDone.
function UI_OnDone_Connect(Proc: ACallbackProc): AInteger;

//** Отсоединяет от события OnDone.
function UI_OnDone_Disconnect(Proc: ACallbackProc): AInteger;

procedure UI_ShowHelp();

procedure UI_ShowHelp2(const FileName: string);

implementation

function UI_OnDone_Connect(Proc: ACallbackProc): AInteger;
begin
  Result := AEvents.Event_Connect(FOnDone, Proc);
end;

function UI_OnDone_Disconnect(Proc: ACallbackProc): AInteger;
begin
  Result := AEvents.Event_Disconnect(FOnDone, Proc);
end;

procedure UI_ShowHelp();
begin
  UI_ShowHelp2(ASystem.Info_GetDirectoryPathP + ChangeFileExt(ASystem.Info_GetProgramNameP, '.hlp'));
end;

procedure UI_ShowHelp2(const FileName: string);
begin
{$IFNDEF UNIX}
  Application.HelpFile := FileName;
  Application.HelpCommand(HELP_FINDER, 1);
{$ENDIF}
end;

end.
 