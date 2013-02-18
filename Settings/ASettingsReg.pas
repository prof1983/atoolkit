{**
@Abstract ASettingsReg
@Author Prof1983 <prof1983@ya.ru>
@Created 12.11.2012
@LastMod 18.02.2013
}
unit ASettingsReg;

{define AStdCall}

interface

uses
  {$IFDEF MSWINDOWS}Windows, ARegistrySettings,{$ENDIF}
  ABase,
  AStringMain;

// --- ASettings_RegConfig ---

function ASettings_NewRegConfig(const Prefix: AString_Type; Key: AInt): AConfig; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_NewRegConfigA(Prefix: AStr; Key: AInt): AConfig; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_NewRegConfigP(const Prefix: APascalString; Key: AInt): AConfig;

function ASettings_RegConfig_NewP(const Prefix: APascalString): AConfig; deprecated {$ifdef ADeprText}'Use ASettings_NewRegConfigP()'{$endif};

implementation

// --- ASettings_RegConfig ---

function ASettings_NewRegConfig(const Prefix: AString_Type; Key: AInt): AConfig;
begin
  Result := ASettings_NewRegConfigP(AString_ToPascalString(Prefix), Key);
end;

function ASettings_NewRegConfigA(Prefix: AStr; Key: AInt): AConfig;
begin
  Result := ASettings_NewRegConfigP(Prefix, Key);
end;

function ASettings_NewRegConfigP(const Prefix: APascalString; Key: AInt): AConfig;
{$IFDEF MSWINDOWS}
var
  S: TARegistrySettings;
{$ENDIF}
begin
  try
    {$IFDEF MSWINDOWS}
    if (Key = 0) then
      Key := AInt(HKEY_CURRENT_USER);

    S := TARegistrySettings.Create();
    S.Registry.RootKey := Key;
    S.Prefix := Prefix;
    Result := AConfig(S);
    {$ELSE}
    Result := 0;
    {$ENDIF}
  except
    Result := 0;
  end;
end;

function ASettings_RegConfig_NewP(const Prefix: APascalString): AConfig;
begin
  Result := ASettings_NewRegConfigP(Prefix, 0);
end;

end.
