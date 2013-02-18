{**
@Abstract ASettingsIni
@Author Prof1983 <prof1983@ya.ru>
@Created 12.11.2012
@LastMod 18.02.2013
}
unit ASettingsIni;

{define AStdCall}

interface

uses
  ABase,
  AIniSettings,
  AStringMain;

// --- ASettings ---

function ASettings_NewIniConfig(const FileName: AString_Type): AConfig; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_NewIniConfigA(FileName: AStr): AConfig; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_NewIniConfigP(const FileName: APascalString): AConfig;

function ASettings_IniConfig_NewP(const FileName: APascalString): AConfig; stdcall; deprecated {$ifdef ADeprText}'Use ASettings_NewIniConfigP()'{$endif};

implementation

// --- ASettings ---

function ASettings_NewIniConfig(const FileName: AString_Type): AConfig;
begin
  Result := ASettings_NewIniConfigP(AString_ToPascalString(FileName));
end;

function ASettings_NewIniConfigA(FileName: AStr): AConfig;
begin
  Result := ASettings_NewIniConfigP(FileName);
end;

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
