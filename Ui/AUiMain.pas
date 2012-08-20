{**
@Abstract AUi common functions
@Author Prof1983 <prof1983@ya.ru>
@Created 26.10.2011
@LastMod 20.08.2012
}
unit AUiMain;

interface

uses
  Controls, Forms, Windows,
  ABase, ASystem, AUtils,
  AUiBase;

// --- AUi ---

function AUi_SetProgramState(State: AInteger): AError; stdcall;

// --- UI ---

procedure UI_ShowHelp();

procedure UI_ShowHelp2(const FileName: string);

implementation

// --- AUi ---

function AUi_SetProgramState(State: AInteger): AError;
begin
  try
    if (State = AUiProgramState_None) then
      Screen.Cursor := crNone
    else if (State = AUiProgramState_HourGlass) then
      Screen.Cursor := crHourGlass
    else
      Screen.Cursor := crDefault;
    Result := 0;
  except
    Result := -1;
  end;
end;

// --- UI ---

procedure UI_ShowHelp();
begin
  UI_ShowHelp2(ASystem.Info_GetDirectoryPathP + AUtils_ChangeFileExtP(ASystem.Info_GetProgramNameP, '.hlp'));
end;

procedure UI_ShowHelp2(const FileName: string);
begin
{$IFNDEF UNIX}
  Application.HelpFile := FileName;
  Application.HelpCommand(HELP_FINDER, 1);
{$ENDIF}
end;

end.
 