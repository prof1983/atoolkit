{**
@Abstract ASettingsIni
@Author Prof1983 <prof1983@ya.ru>
@Created 12.11.2012
@LastMod 12.11.2012
}
unit ASettingsIni;

interface

uses
  ABase, AIniSettings;

function Settings_IniConfig_New(const FileName: APascalString): AConfig; stdcall;

implementation

function Settings_IniConfig_New(const FileName: APascalString): AConfig;
var
  S: TIniSettings;
begin
  S := TIniSettings.Create;
  S.OpenIniFile(FileName);
  Result := Integer(S);
end;

end.
