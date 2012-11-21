{**
@Abstract ASettings main functions
@Author Prof1983 <prof1983@ya.ru>
@Created 13.08.2012
@LastMod 21.11.2012
}
unit ASettingsMain;

interface

uses
  ABase, AStrings,
  AAbstractSettings;

// --- ASettings ---

function ASettings_Close(Config: AConfig): AError; stdcall;

function ASettings_ReadBoolDef(Config: AConfig; const Section, Name: AString_Type; DefValue: ABoolean): ABoolean; stdcall;

function ASettings_ReadBoolDefP(Config: AConfig; const Section, Name: APascalString; DefValue: ABoolean): ABoolean; stdcall;

function ASettings_ReadIntegerDefP(Config: AConfig; const Section, Name: APascalString; DefValue: AInteger): AInteger; stdcall;

function ASettings_ReadStringDefP(Config: AConfig; const Section, Name, DefValue: APascalString): APascalString; stdcall;

function ASettings_WriteIntegerP(Config: AConfig; const Section, Name: APascalString; Value: AInteger): AError; stdcall;

function ASettings_WriteStringP(Config: AConfig; const Section, Name, Value: APascalString): AError; stdcall;

implementation

uses
  ASettings;

// --- ASettings ---

function ASettings_Close(Config: AConfig): AError;
begin
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
  try
    Result := TAbstractSettings(Config).ReadBool(Section, Name, DefValue)
  except
    Result := DefValue;
  end;
end;

function ASettings_ReadIntegerDefP(Config: AConfig; const Section, Name: APascalString; DefValue: AInteger): AInteger;
begin
  if (Config <> 0) then
  begin
    Result := DefValue;
    Exit;
  end;

  try
    Result := TAbstractSettings(Config).ReadInteger(Section, Name, DefValue);
  except
    Result := DefValue;
  end;
end;

function ASettings_ReadStringDefP(Config: AConfig; const Section, Name, DefValue: APascalString): APascalString;
begin
  if (Config = 0) then
    Result := ''
  else
    TAbstractSettings(Config).ReadString(Section, Name, DefValue, Result);
end;

function ASettings_WriteIntegerP(Config: AConfig; const Section, Name: APascalString; Value: AInteger): AError;
begin
  if (Config = 0) then
  begin
    Result := -1;
    Exit;
  end;

  try
    if TAbstractSettings(Config).WriteInteger(Section, Name, Value) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function ASettings_WriteStringP(Config: AConfig; const Section, Name, Value: APascalString): AError;
begin
  Result := Config_WriteStringP(Config, Section, Name, Value);
end;

end.
 