{**
@Abstract ASettingsIni
@Author Prof1983 <prof1983@ya.ru>
@Created 12.11.2012
@LastMod 01.02.2013
}
unit ASettingsIni;

{define AStdCall}

interface

uses
  ABase, AIniSettings;

function ASettings_NewIniConfigP(const FileName: APascalString): AConfig; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_IniConfig_NewP(const FileName: APascalString): AConfig; stdcall; deprecated {$ifdef ADeprText}'Use ASettings_NewIniConfigP()'{$endif};

implementation

function ASettings_NewIniConfigP(const FileName: APascalString): AConfig;
var
  S: TIniSettings;
begin
  S := TIniSettings.Create;
  S.OpenIniFile(FileName);
  Result := Integer(S);
end;

function ASettings_IniConfig_NewP(const FileName: APascalString): AConfig;
begin
  Result := ASettings_NewIniConfigP(FileName);
end;

end.
