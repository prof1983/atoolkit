{**
@Abstract ASettings main functions
@Author Prof1983 <prof1983@ya.ru>
@Created 13.08.2012
@LastMod 24.12.2012
}
unit ASettingsMain;

{$ifndef NoXmlNode}
  {$define UseXmlNode}
{$endif}

interface

uses
  ABase,
  {$ifdef UseXmlNode}AConfigUtils,{$endif}
  AStrings,
  AAbstractSettings;

// --- ASettings ---

function ASettings_Close(Config: AConfig): AError; stdcall;

function ASettings_ReadBoolDef(Config: AConfig; const Section, Name: AString_Type; DefValue: ABoolean): ABoolean; stdcall;

function ASettings_ReadBoolDefP(Config: AConfig; const Section, Name: APascalString; DefValue: ABoolean): ABoolean;

function ASettings_ReadIntegerDefP(Config: AConfig; const Section, Name: APascalString; DefValue: AInteger): AInteger;

function ASettings_ReadStringDefP(Config: AConfig; const Section, Name, DefValue: APascalString): APascalString;

function ASettings_WriteBoolP(Config: AConfig; const Section, Name: APascalString; Value: ABoolean): AError;

function ASettings_WriteIntegerP(Config: AConfig; const Section, Name: APascalString; Value: AInteger): AError;

function ASettings_WriteStringP(Config: AConfig; const Section, Name, Value: APascalString): AError;

implementation

// --- ASettings ---

function ASettings_Close(Config: AConfig): AError;
begin
  if (Config = 0) then
  begin
    Result := -2;
    Exit;
  end;
  if not(TObject(Config) is TAbstractSettings) then
  begin
    Result := -3;
    Exit;
  end;
  try
    TAbstractSettings(Config).Close();
    Result := 0;
  except
    Result := -1;
  end;
end;

function ASettings_ReadBoolDef(Config: AConfig; const Section, Name: AString_Type; DefValue: ABoolean): ABoolean;
begin
  try
    Result := ASettings_ReadBoolDefP(Config,
        AStrings.String_ToWideString(Section),
        AStrings.String_ToWideString(Name),
        DefValue);
  except
    Result := DefValue;
  end
end;

function ASettings_ReadBoolDefP(Config: AConfig; const Section, Name: APascalString; DefValue: ABoolean): ABoolean;
begin
  if (Config = 0) then
  begin
    Result := DefValue;
    Exit;
  end;
  if (TObject(Config) is TAbstractSettings) then
  try
    Result := TAbstractSettings(Config).ReadBool(Section, Name, DefValue)
  except
    Result := DefValue;
  end
  else
  begin
    {$ifdef UseXmlNode}
    if (AConfig_ReadBool(Config, Name, Result) >= 0) then
      Exit;
    {$endif}
    Result := DefValue;
  end;
end;

function ASettings_ReadIntegerDefP(Config: AConfig; const Section, Name: APascalString; DefValue: AInteger): AInteger;
begin
  if (Config = 0) then
  begin
    Result := DefValue;
    Exit;
  end;

  if (TObject(Config) is TAbstractSettings) then
  try
    Result := TAbstractSettings(Config).ReadInteger(Section, Name, DefValue);
  except
    Result := DefValue;
  end
  else
  begin
    {$ifdef UseXmlNode}
    if (AConfig_ReadInt(Config, Name, Result) >= 0) then
      Exit;
    {$endif}
    Result := DefValue;
  end;
end;

function ASettings_ReadStringDefP(Config: AConfig; const Section, Name, DefValue: APascalString): APascalString;
begin
  if (Config = 0) then
  begin
    Result := DefValue;
    Exit;
  end;
  if (TObject(Config) is TAbstractSettings) then
  try
    TAbstractSettings(Config).ReadString(Section, Name, DefValue, Result);
  except
    Result := DefValue;
  end
  else
  begin
    {$ifdef UseXmlNode}
    if (AConfig_ReadString(Config, Name, Result) >= 0) then
      Exit;
    {$endif}
    Result := DefValue;
  end;
end;

function ASettings_WriteBoolP(Config: AConfig; const Section, Name: APascalString; Value: ABoolean): AError;
begin
  if (Config = 0) then
  begin
    Result := -1;
    Exit;
  end;

  if (TObject(Config) is TAbstractSettings) then
  try
    if TAbstractSettings(Config).WriteBool(Section, Name, Value) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end
  else
  begin
    {$ifdef UseXmlNode}
    Result := AConfig_WriteBool(Config, Name, Value);
    {$else}
    Result := -3;
    {$endif}
  end;
end;

function ASettings_WriteIntegerP(Config: AConfig; const Section, Name: APascalString; Value: AInteger): AError;
begin
  if (Config = 0) then
  begin
    Result := -1;
    Exit;
  end;

  if (TObject(Config) is TAbstractSettings) then
  try
    if TAbstractSettings(Config).WriteInteger(Section, Name, Value) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end
  else
  begin
    {$ifdef UseXmlNode}
    Result := AConfig_WriteInt(Config, Name, Value);
    {$else}
    Result := -3;
    {$endif}
  end;
end;

function ASettings_WriteStringP(Config: AConfig; const Section, Name, Value: APascalString): AError;
begin
  if (Config = 0) then
  begin
    Result := -2;
    Exit;
  end;

  if (TObject(Config) is TAbstractSettings) then
  try
    if TAbstractSettings(Config).WriteString(Section, Name, Value) then
      Result := 0
    else
      Result := -2;
  except
    Result := -1;
  end
  else
  begin
    {$ifdef UseXmlNode}
    Result := AConfig_WriteString(Config, Name, Value);
    {$else}
    Result := -3;
    {$endif}
  end;
end;

end.
 