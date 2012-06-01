{**
@Abstract()
@Author(Prof1983 prof1983@ya.ru)
@Created(29.05.2011)
@LastMod(29.06.2011)
@Version(0.5)
}
unit ASystemResourceString;

interface

uses
  ABase;

function Runtime_GetResourceString(const Section, Name, Default: APascalString): APascalString; stdcall;

implementation

const
  {$IFDEF FPC}
  cAbout = 'About...';
  cSettings = 'Options...';
  cModules = 'Modules';
  {$ELSE}
  cAbout = 'О программе...';
  cSettings = 'Настройки...';
  cModules = 'Модули';
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
 