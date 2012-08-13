{**
@Abstract ASettingsConfig
@Author Prof1983 <prof1983@ya.ru>
@Created 06.03.2008
@LastMod 13.08.2012
}
unit ASettingsConfig;

interface

uses
  {$IFDEF MSWINDOWS}Windows, ARegistrySettings,{$ENDIF}
  ABase, ACollections, ACollectionsBase, AStrings,
  AAbstractSettings, AIniSettings;

{deprecated}
function Settings_IniConfig_New(const FileName: APascalString): AConfig; stdcall;
function Settings_RegConfig_New(const Prefix: APascalString): AConfig; stdcall;
function Settings_RegConfig_NewA(const Prefix: APascalString; HKEY: Integer): AConfig; stdcall;

{deprecated}
procedure Settings_Close(Config: AConfig); stdcall;
function Settings_DeleteKey(Config: AConfig; const Section, Name: APascalString): ABoolean; stdcall;
function Settings_DeleteSection(Config: AConfig; const Section: APascalString): ABoolean; stdcall;
function Settings_ReadBool(Config: AConfig; const Section, Name: APascalString; DefValue: ABoolean): ABoolean; stdcall; deprecated; // Use ASettings_ReadBoolDefP()
function Settings_ReadInteger(Config: AConfig; const Section, Name: APascalString; DefValue: AInteger): AInteger; stdcall;
function Settings_ReadFloat(Config: AConfig; const Section, Name: APascalString; DefValue: AFloat): AFloat; stdcall;
function Settings_ReadSection(Config: AConfig; const Section: APascalString; Strings: AStringList): ABoolean; stdcall;
function Settings_ReadString(Config: AConfig; const Section, Name: APascalString; out Value: APascalString): AInteger; stdcall;
function Settings_ReadStringA(Config: AConfig; const Section, Name, DefValue: APascalString; out Value: APascalString): AInteger; stdcall;
function Settings_ReadStringDef(Config: AConfig; const Section, Name, DefValue: APascalString): APascalString; stdcall;
function Settings_ReadDateTime(Config: AConfig; const Section, Name: APascalString; DefValue: TDateTime): TDateTime; stdcall;
function Settings_WriteBool(Config: AConfig; const Section, Name: APascalString; Value: Boolean): ABoolean; stdcall;
function Settings_WriteInteger(Config: AConfig; const Section, Name: APascalString; Value: Integer): ABoolean; stdcall;
function Settings_WriteFloat(Config: AConfig; const Section, Name: APascalString; Value: AFloat): ABoolean; stdcall;
function Settings_WriteString(Config: AConfig; const Section, Name, Value: APascalString): ABoolean; stdcall;
function Settings_WriteDateTime(Config: AConfig; const Section, Name: APascalString; Value: TDateTime): ABoolean; stdcall;

implementation

{ Settings }

procedure Settings_Close(Config: AConfig);
begin
  TAbstractSettings(Config).Close;
end;

function Settings_DeleteKey(Config: AConfig; const Section, Name: APascalString): ABoolean;
begin
  Result := TAbstractSettings(Config).DeleteKey(Section, Name);
end;

function Settings_DeleteSection(Config: AConfig; const Section: APascalString): ABoolean;
begin
  Result := TAbstractSettings(Config).DeleteSection(Section);
end;

function Settings_IniConfig_New(const FileName: APascalString): AConfig;
var
  S: TIniSettings;
begin
  S := TIniSettings.Create;
  S.OpenIniFile(FileName);
  Result := Integer(S);
end;

function Settings_ReadBool(Config: AConfig; const Section, Name: APascalString; DefValue: ABoolean): ABoolean;
begin
  if (Config <> 0) then
    Result := TAbstractSettings(Config).ReadBool(Section, Name, DefValue)
  else
    Result := DefValue;
end;

function Settings_ReadDateTime(Config: AConfig; const Section, Name: APascalString; DefValue: TDateTime): TDateTime;
begin
  if (Config <> 0) then
    Result := TAbstractSettings(Config).ReadDateTime(Section, Name, DefValue)
  else
    Result := DefValue;
end;

function Settings_ReadFloat(Config: AConfig; const Section, Name: APascalString; DefValue: AFloat): AFloat;
begin
  if (Config <> 0) then
    Result := TAbstractSettings(Config).ReadFloat(Section, Name, DefValue)
  else
    Result := DefValue;
end;

function Settings_ReadInteger(Config: AConfig; const Section, Name: APascalString; DefValue: AInteger): AInteger;
begin
  if (Config <> 0) then
    Result := TAbstractSettings(Config).ReadInteger(Section, Name, DefValue)
  else
    Result := DefValue;
end;

function Settings_ReadSection(Config: AConfig; const Section: APascalString; Strings: AStringList): ABoolean;
begin
  try
    Result := TAbstractSettings(Config).ReadSection(Section, Strings);
  except
    Result := False;
  end;
end;

function Settings_ReadString(Config: AConfig; const Section, Name: APascalString;
    out Value: APascalString): AInteger;
begin
  if (Config = 0) then
    Result := -1
  else
    Result := TAbstractSettings(Config).ReadString(Section, Name, '', Value);
end;

function Settings_ReadStringA(Config: AConfig; const Section, Name, DefValue: APascalString; out Value: APascalString): AInteger;
begin
  Result := TAbstractSettings(Config).ReadString(Section, Name, DefValue, Value);
end;

function Settings_ReadStringDef(Config: AConfig; const Section, Name, DefValue: APascalString): APascalString; stdcall;
begin
  if (Config = 0) then
    Result := ''
  else
    TAbstractSettings(Config).ReadString(Section, Name, DefValue, Result);
end;

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

function Settings_WriteBool(Config: AConfig; const Section, Name: APascalString; Value: ABoolean): ABoolean;
begin
  if (Config <> 0) then
    Result := TAbstractSettings(Config).WriteBool(Section, Name, Value)
  else
    Result := False;
end;

function Settings_WriteDateTime(Config: AConfig; const Section, Name: APascalString; Value: TDateTime): ABoolean;
begin
  if (Config <> 0) then
    Result := TAbstractSettings(Config).WriteDateTime(Section, Name, Value)
  else
    Result := False;
end;

function Settings_WriteFloat(Config: AConfig; const Section, Name: APascalString; Value: AFloat): ABoolean;
begin
  if (Config <> 0) then
    Result := TAbstractSettings(Config).WriteFloat(Section, Name, Value)
  else
    Result := False;
end;

function Settings_WriteInteger(Config: AConfig; const Section, Name: APascalString; Value: AInteger): ABoolean;
begin
  if (Config <> 0) then
    Result := TAbstractSettings(Config).WriteInteger(Section, Name, Value)
  else
    Result := False;
end;

function Settings_WriteString(Config: AConfig; const Section, Name, Value: APascalString): ABoolean;
begin
  if (Config <> 0) then
    Result := TAbstractSettings(Config).WriteString(Section, Name, Value)
  else
    Result := False;
end;

end.
 