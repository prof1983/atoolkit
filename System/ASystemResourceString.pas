{**
@Abstract ASystem resource
@Author Prof1983 <prof1983@ya.ru>
@Created 29.05.2011
@LastMod 24.07.2012
}
unit ASystemResourceString;

{$I A.inc}

interface

uses
  ABase;

function Runtime_GetResourceString(const Section, Name, Default: APascalString): APascalString; stdcall;

implementation

{$IFDEF DELPHI_XE_UP}
  {$I ASystemResourceString.ru.utf8.inc}
{$ELSE}
const
  cAbout = 'About...';
  cSettings = 'Options...';
  cModules = 'Modules';
{$ENDIF}

function Runtime_GetResourceString(const Section, Name, Default: APascalString): APascalString; stdcall;
begin
  Result := Default;
  if (Section = 'About') then
  begin
    if (Name = 'MenuText') then
      Result := cAbout;
  end
  else if (Section = 'Tools') then
  begin
    if (Name = 'Options') then
      Result := cSettings;
  end
  else if (Section = '') then
  begin
    if (Name = 'Modules') then
      Result := cModules;
  end;
end;

end.
 