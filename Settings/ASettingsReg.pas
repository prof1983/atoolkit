{**
@Abstract ASettingsReg
@Author Prof1983 <prof1983@ya.ru>
@Created 12.11.2012
@LastMod 16.04.2013
}
unit ASettingsReg;

interface

uses
  {$IFDEF MSWINDOWS}Windows, ARegistrySettings,{$ENDIF}
  ABase,
  AStringMain;

// --- ASettings ---

function ASettings_NewRegSettings(const Prefix: AString_Type; Key: AInt): AConfig; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_NewRegSettingsA(Prefix: AStr; Key: AInt): AConfig; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_NewRegSettingsP(const Prefix: APascalString; Key: AInt): AConfig;

function ASettings_RegConfig_NewP(const Prefix: APascalString): AConfig; stdcall; deprecated {$ifdef ADeptText}'Use ASettings_NewRegSettingsP()'{$endif};

// --- Settings ---

function Settings_RegConfig_New(const Prefix: APascalString): AConfig; stdcall; deprecated {$ifdef ADeprText}'Use ASettings_NewRegSettingsP()'{$endif};

function Settings_RegConfig_NewA(const Prefix: APascalString; HKEY: Integer): AConfig; stdcall; deprecated {$ifdef ADeprText}'Use ASettings_NewRegSettingsP()'{$endif};

implementation

// --- ASettings ---

function ASettings_NewRegSettings(const Prefix: AString_Type; Key: AInt): AConfig;
begin
  Result := ASettings_NewRegSettingsP(AString_ToP(Prefix), Key);
end;

function ASettings_NewRegSettingsA(Prefix: AStr; Key: AInt): AConfig;
begin
  Result := ASettings_NewRegSettingsP(AnsiString(Prefix), Key);
end;

function ASettings_NewRegSettingsP(const Prefix: APascalString; Key: AInt): AConfig;
{$ifdef MSWINDOWS}
var
  S: TARegistrySettings;
{$endif}
begin
  try
    {$ifdef MSWINDOWS}
    if (Key = 0) then
      Key := AInt(HKEY_CURRENT_USER);
    S := TARegistrySettings.Create;
    S.Registry.RootKey := Key;
    S.Prefix := Prefix;
    Result := ASettings(S);
    {$else}
    Result := 0;
    {$endif}
  except
    Result := 0;
  end;
end;

function ASettings_RegConfig_NewP(const Prefix: APascalString): AConfig;
begin
  Result := ASettings_NewRegSettingsP(Prefix, 0);
end;

// --- Settings ---

function Settings_RegConfig_New(const Prefix: APascalString): AConfig;
begin
  Result := ASettings_NewRegSettingsP(Prefix, 0);
end;

function Settings_RegConfig_NewA(const Prefix: APascalString; HKEY: Integer): AConfig;
begin
  Result := ASettings_NewRegSettingsP(Prefix, HKEY);
end;

end.
