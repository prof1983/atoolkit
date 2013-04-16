{**
@Abstract ASettingsIni
@Author Prof1983 <prof1983@ya.ru>
@Created 12.11.2012
@LastMod 16.04.2013
}
unit ASettingsIni;

interface

uses
  ABase,
  AIniSettings,
  AStringMain;

// --- ASettings ---

function ASettings_IniConfig_NewP(const FileName: APascalString): AConfig; stdcall; deprecated {$ifdef ADeprText}'Use ASettings_NewIniSettingsP()'{$endif};

function ASettings_NewIniSettings(const FileName: AString_Type): AConfig; stdcall;

function ASettings_NewIniSettingsA(FileName: AStr): AConfig; stdcall;

function ASettings_NewIniSettingsP(const FileName: APascalString): ASettings;

// --- Settings ---

function Settings_IniConfig_New(const FileName: APascalString): AConfig; stdcall; deprecated; // Use ASettings_IniConfig_NewP()

implementation

// --- ASettings ---

function ASettings_IniConfig_NewP(const FileName: APascalString): AConfig;
begin
  Result := ASettings_NewIniSettingsP(FileName);
end;

function ASettings_NewIniSettings(const FileName: AString_Type): AConfig;
begin
  try
    Result := ASettings_NewIniSettingsP(AString_ToP(FileName));
  except
    Result := 0;
  end;
end;

function ASettings_NewIniSettingsA(FileName: AStr): AConfig;
begin
  try
    Result := ASettings_NewIniSettingsP(AnsiString(FileName));
  except
    Result := 0;
  end;
end;

function ASettings_NewIniSettingsP(const FileName: APascalString): ASettings;
var
  S: TIniSettings;
begin
  try
    S := TIniSettings.Create();
    S.OpenIniFile(FileName);
    Result := Integer(S);
  except
    Result := 0;
  end;
end;

// --- Settings ---

function Settings_IniConfig_New(const FileName: APascalString): AConfig;
begin
  Result := ASettings_IniConfig_NewP(FileName);
end;

end.
