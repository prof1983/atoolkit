{**
@Abstract ASettingsReg
@Author Prof1983 <prof1983@ya.ru>
@Created 12.11.2012
@LastMod 16.11.2012
}
unit ASettingsReg;

interface

uses
  {$IFDEF MSWINDOWS}Windows, ARegistrySettings,{$ENDIF}
  ABase;

function ASettings_RegConfig_NewP(const Prefix: APascalString): AConfig; stdcall;

{deprecated}
function Settings_RegConfig_New(const Prefix: APascalString): AConfig; stdcall; deprecated; // Use ASettings_RegConfig_NewP()
function Settings_RegConfig_NewA(const Prefix: APascalString; HKEY: Integer): AConfig; stdcall;

implementation

function ASettings_RegConfig_NewP(const Prefix: APascalString): AConfig;
begin
  try
    {$IFDEF MSWINDOWS}
    Result := Settings_RegConfig_NewA(Prefix, Integer(HKEY_CURRENT_USER));
    {$ELSE}
    Result := 0;
    {$ENDIF}
  except
    Result := 0;
  end;
end;

function Settings_RegConfig_New(const Prefix: APascalString): AConfig;
begin
  Result := ASettings_RegConfig_NewP(Prefix);
end;

function Settings_RegConfig_NewA(const Prefix: APascalString; HKEY: Integer): AConfig;
{$IFDEF MSWINDOWS}
var
  S: TARegistrySettings;
{$ENDIF}
begin
  {$IFDEF MSWINDOWS}
  S := TARegistrySettings.Create;
  S.Registry.RootKey := HKEY;
  S.Prefix := Prefix;
  Result := AConfig(S);
  {$ELSE}
  Result := 0;
  {$ENDIF}
end;

end.
