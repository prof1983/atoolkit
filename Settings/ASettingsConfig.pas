{**
@Abstract ASettingsConfig
@Author Prof1983 <prof1983@ya.ru>
@Created 06.03.2008
@LastMod 16.04.2013
}
unit ASettingsConfig;

interface

uses
  ABase,
  ABaseTypes,
  ACollectionsBase,
  AStringMain,
  AAbstractSettings, ASettingsMain;

{deprecated}
procedure Settings_Close(Config: AConfig); stdcall; deprecated; // Use ASettings_Close()
function Settings_DeleteKey(Config: AConfig; const Section, Name: APascalString): ABoolean; stdcall;
function Settings_DeleteSection(Config: AConfig; const Section: APascalString): ABoolean; stdcall;
function Settings_ReadBool(Config: AConfig; const Section, Name: APascalString; DefValue: ABoolean): ABoolean; stdcall; deprecated; // Use ASettings_ReadBoolDefP()
function Settings_ReadInteger(Config: AConfig; const Section, Name: APascalString; DefValue: AInteger): AInteger; stdcall; deprecated; // Use ASettings_ReadIntegerDefP()
function Settings_ReadFloat(Config: AConfig; const Section, Name: APascalString; DefValue: AFloat): AFloat; stdcall;
function Settings_ReadSection(Config: AConfig; const Section: APascalString; Strings: AStringList): ABoolean; stdcall;
function Settings_ReadString(Config: AConfig; const Section, Name: APascalString; out Value: APascalString): AInteger; stdcall;
function Settings_ReadStringA(Config: AConfig; const Section, Name, DefValue: APascalString; out Value: APascalString): AInteger; stdcall;
function Settings_ReadStringDef(Config: AConfig; const Section, Name, DefValue: APascalString): APascalString; stdcall; deprecated; // Use ASettings_ReadStringDefP()
function Settings_ReadDateTime(Config: AConfig; const Section, Name: APascalString; DefValue: TDateTime): TDateTime; stdcall;
function Settings_WriteBool(Config: AConfig; const Section, Name: APascalString; Value: Boolean): ABoolean; stdcall;
function Settings_WriteInteger(Config: AConfig; const Section, Name: APascalString; Value: Integer): ABoolean; stdcall; // Use ASettings_WriteIntegerP()
function Settings_WriteFloat(Config: AConfig; const Section, Name: APascalString; Value: AFloat): ABoolean; stdcall;
function Settings_WriteString(Config: AConfig; const Section, Name, Value: APascalString): ABoolean; stdcall;
function Settings_WriteDateTime(Config: AConfig; const Section, Name: APascalString; Value: TDateTime): ABoolean; stdcall;

implementation

{ Settings }

procedure Settings_Close(Config: AConfig);
begin
  ASettings_Close(Config);
end;

function Settings_DeleteKey(Config: AConfig; const Section, Name: APascalString): ABoolean;
begin
  Result := TAbstractSettings(Config).DeleteKey(Section, Name);
end;

function Settings_DeleteSection(Config: AConfig; const Section: APascalString): ABoolean;
begin
  Result := TAbstractSettings(Config).DeleteSection(Section);
end;

function Settings_ReadBool(Config: AConfig; const Section, Name: APascalString; DefValue: ABoolean): ABoolean;
begin
  Result := ASettings_ReadBoolDefP(Config, Section, Name, DefValue)
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
  Result := ASettings_ReadFloatDefP(Config, Section, Name, DefValue);
end;

function Settings_ReadInteger(Config: AConfig; const Section, Name: APascalString; DefValue: AInteger): AInteger;
begin
  Result := ASettings_ReadIntegerDefP(Config, Section, Name, DefValue);
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

function Settings_ReadStringDef(Config: AConfig; const Section, Name, DefValue: APascalString): APascalString;
begin
  Result := ASettings_ReadStringDefP(Config, Section, Name, DefValue);
end;

function Settings_WriteBool(Config: AConfig; const Section, Name: APascalString; Value: ABoolean): ABoolean;
begin
  Result := (ASettings_WriteBoolP(Config, Section, Name, Value) = 0);
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
  Result := (ASettings_WriteFloatP(Config, Section, Name, Value) = 0);
end;

function Settings_WriteInteger(Config: AConfig; const Section, Name: APascalString; Value: AInteger): ABoolean;
begin
  Result := (ASettings_WriteIntegerP(Config, Section, Name, Value) = 0);
end;

function Settings_WriteString(Config: AConfig; const Section, Name, Value: APascalString): ABoolean;
begin
  Result := (ASettings_WriteStringP(Config, Section, Name, Value) = 0);
end;

end.
 