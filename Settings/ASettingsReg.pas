{**
@Abstract ASettingsReg
@Author Prof1983 <prof1983@ya.ru>
@Created 12.11.2012
@LastMod 12.11.2012
}
unit ASettingsReg;

interface

uses
  {$IFDEF MSWINDOWS}Windows, ARegistrySettings,{$ENDIF}
  ABase;

{deprecated}
function Settings_RegConfig_New(const Prefix: APascalString): AConfig; stdcall;
function Settings_RegConfig_NewA(const Prefix: APascalString; HKEY: Integer): AConfig; stdcall;

implementation

function Settings_RegConfig_New(const Prefix: APascalString): AConfig;
begin
  {$IFDEF MSWINDOWS}
  Result := Settings_RegConfig_NewA(Prefix, Integer(HKEY_CURRENT_USER));
  {$ELSE}
  Result := 0;
  {$ENDIF}
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
