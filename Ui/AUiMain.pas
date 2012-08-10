{**
@Abstract AUi common functions
@Author Prof1983 <prof1983@ya.ru>
@Created 26.10.2011
@LastMod 10.08.2012
}
unit AUiMain;

interface

uses
  Forms, Windows,
  ASystem, AUtils;

procedure UI_ShowHelp();

procedure UI_ShowHelp2(const FileName: string);

implementation

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
 