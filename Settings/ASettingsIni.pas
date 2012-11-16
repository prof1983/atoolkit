{**
@Abstract ASettingsIni
@Author Prof1983 <prof1983@ya.ru>
@Created 12.11.2012
@LastMod 16.11.2012
}
unit ASettingsIni;

interface

uses
  ABase, AIniSettings;

function ASettings_IniConfig_NewP(const FileName: APascalString): AConfig; stdcall;

function Settings_IniConfig_New(const FileName: APascalString): AConfig; stdcall; deprecated; // Use ASettings_IniConfig_NewP()

implementation

function ASettings_IniConfig_NewP(const FileName: APascalString): AConfig;
var
  S: TIniSettings;
begin
  S := TIniSettings.Create;
  S.OpenIniFile(FileName);
  Result := Integer(S);
end;

function Settings_IniConfig_New(const FileName: APascalString): AConfig;
begin
  Result := ASettings_IniConfig_NewP(FileName);
end;

end.
