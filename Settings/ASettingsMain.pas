{**
@Abstract ASettings main functions
@Author Prof1983 <prof1983@ya.ru>
@Created 13.08.2012
@LastMod 16.04.2013
}
unit ASettingsMain;

{$ifndef NoXmlNode}
  {$define UseXmlNode}
{$endif}

interface

uses
  ABase,
  ABaseTypes,
  {$ifdef UseXmlNode}AConfigUtils,{$endif}
  AStringMain,
  AAbstractSettings;

// --- ASettings ---

function ASettings_Close(Config: AConfig): AError; stdcall;

function ASettings_DeleteKey(Settings: ASettings; const Section, Name: AString_Type): AError; stdcall;

{ Section, Name - const }
function ASettings_DeleteKeyA(Settings: ASettings; Section, Name: AStr): AError; stdcall;

function ASettings_DeleteSection(Settings: ASettings; const Section: AString_Type): AError; stdcall;

{ Section - const }
function ASettings_DeleteSectionA(Settings: ASettings; Section: AStr): AError; stdcall;

function ASettings_Fin(): AError; stdcall;

function ASettings_Init(): AError; stdcall;

function ASettings_ReadBoolDef(Config: AConfig; const Section, Name: AString_Type; DefValue: ABoolean): ABoolean; stdcall;

{ Section, Name - const }
function ASettings_ReadBoolDefA(Settings: ASettings; Section, Name: AStr; DefValue: ABool): ABool; stdcall;

function ASettings_ReadBoolDefP(Config: AConfig; const Section, Name: APascalString; DefValue: ABoolean): ABoolean;

function ASettings_ReadDateTimeDef(Settings: ASettings; const Section, Name: AString_Type;
    DefValue: TDateTime): TDateTime; stdcall;

{ Section, Name - const }
function ASettings_ReadDateTimeDefA(Settings: ASettings; Section, Name: AStr;
    DefValue: TDateTime): TDateTime; stdcall;

function ASettings_ReadFloatDef(Settings: ASettings; const Section, Name: AString_Type;
    DefValue: AFloat): AFloat; stdcall;

{ Section, Name - const }
function ASettings_ReadFloatDefA(Settings: ASettings; Section, Name: AStr;
    DefValue: AFloat): AFloat; stdcall;

function ASettings_ReadFloatDefP(Config: AConfig; const Section, Name: APascalString; DefValue: AFloat): AFloat;

function ASettings_ReadIntDef(Settings: ASettings; const Section, Name: AString_Type;
    DefValue: AInt): AInt; stdcall;

{ Section - const
  Name - const }
function ASettings_ReadIntDefA(Settings: ASettings; Section, Name: AStr; DefValue: AInt): AInt; stdcall;

function ASettings_ReadIntegerDefP(Config: AConfig; const Section, Name: APascalString; DefValue: AInteger): AInteger;

function ASettings_ReadSection(Settings: ASettings; const Section: AString_Type;
    Strings: AStringList): AError; stdcall;

{ Section - const }
function ASettings_ReadSectionA(Settings: ASettings; Section: AStr; Strings: AStringList): AError; stdcall;

function ASettings_ReadString(Settings: ASettings; const Section, Name: AString_Type;
    out Value: AString_Type): AInt; stdcall;

{ Section - const
  Name - const
  Value - out}
function ASettings_ReadStringA(Settings: ASettings; Section, Name: AStr;
    Value: AStr; MaxLen: AInt): AInt; stdcall;

function ASettings_ReadStringDef(Settings: ASettings; const Section, Name, DefValue: AString_Type;
    out Value: AString_Type): AInt; stdcall;

{ Section - const
  Name - const
  DefValue - const
  Value - out}
function ASettings_ReadStringDefA(Settings: ASettings; Section, Name, DefValue: AStr;
    Value: AStr; MaxLen: AInt): AInt; stdcall;

function ASettings_ReadStringDefP(Config: AConfig; const Section, Name, DefValue: APascalString): APascalString;

function ASettings_WriteBool(Settings: ASettings; const Section, Name: AString_Type;
    Value: ABool): AError; stdcall;

{ Section, Name - const }
function ASettings_WriteBoolA(Settings: ASettings; Section, Name: AStr; Value: ABool): AError; stdcall;

function ASettings_WriteBoolP(Config: AConfig; const Section, Name: APascalString; Value: ABoolean): AError;

function ASettings_WriteDateTime(Settings: ASettings; const Section, Name: AString_Type;
    Value: TDateTime): AError; stdcall;

{ Section, Name - const }
function ASettings_WriteDateTimeA(Settings: ASettings; Section, Name: AStr;
    Value: TDateTime): AError; stdcall;

function ASettings_WriteFloat(Settings: ASettings; const Section, Name: AString_Type;
    Value: AFloat): AError; stdcall;

{ Section, Name - const }
function ASettings_WriteFloatA(Settings: ASettings; Section, Name: AStr; Value: AFloat): AError; stdcall;

function ASettings_WriteFloatP(Config: AConfig; const Section, Name: APascalString; Value: AFloat): AError;

function ASettings_WriteInt(Settings: ASettings; const Section, Name: AString_Type;
    Value: AInt): AError; stdcall;

{ Section, Name - const }
function ASettings_WriteIntA(Settings: ASettings; Section, Name: AStr; Value: AInt): AError; stdcall;

function ASettings_WriteIntegerP(Config: AConfig; const Section, Name: APascalString; Value: AInteger): AError;

function ASettings_WriteString(Settings: ASettings; const Section, Name,
    Value: AString_Type): AError; stdcall;

{ Section, Name, Value - const }
function ASettings_WriteStringA(Settings: ASettings; Section, Name, Value: AStr): AError; stdcall;

function ASettings_WriteStringP(Config: AConfig; const Section, Name, Value: APascalString): AError;

implementation

uses
  ASettingsConfig;

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

function ASettings_DeleteKey(Settings: ASettings; const Section, Name: AString_Type): AError;
begin
  try
    if Settings_DeleteKey(Settings, AString_ToP(Section), AString_ToP(Name)) then
      Result := 0
    else
      Result := -2;
  except
    Result := -1;
  end;
end;

function ASettings_DeleteKeyA(Settings: ASettings; Section, Name: AStr): AError;
begin
  try
    if Settings_DeleteKey(Settings, AnsiString(Section), AnsiString(Name)) then
      Result := 0
    else
      Result := -2;
  except
    Result := -1;
  end;
end;

function ASettings_DeleteSection(Settings: ASettings; const Section: AString_Type): AError;
begin
  try
    if Settings_DeleteSection(Settings, AString_ToP(Section)) then
      Result := 0
    else
      Result := -2;
  except
    Result := -1;
  end;
end;

function ASettings_DeleteSectionA(Settings: ASettings; Section: AStr): AError;
begin
  try
    if Settings_DeleteSection(Settings, AnsiString(Section)) then
      Result := 0
    else
      Result := -2;
  except
    Result := -1;
  end;
end;

function ASettings_Fin(): AError;
begin
  Result := 0;
end;

function ASettings_Init(): AError;
begin
  Result := 0;
end;

function ASettings_ReadBoolDef(Config: AConfig; const Section, Name: AString_Type; DefValue: ABoolean): ABoolean;
begin
  try
    Result := ASettings_ReadBoolDefP(Config,
        AString_ToP(Section),
        AString_ToP(Name),
        DefValue);
  except
    Result := DefValue;
  end
end;

function ASettings_ReadBoolDefA(Settings: ASettings; Section, Name: AStr; DefValue: ABool): ABool;
begin
  try
    Result := ASettings_ReadBoolDefP(
        Settings,
        AnsiString(Section),
        AnsiString(Name),
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

function ASettings_ReadDateTimeDef(Settings: ASettings; const Section, Name: AString_Type;
    DefValue: TDateTime): TDateTime;
begin
  try
    Result := ASettings_ReadFloatDefP(Settings, AString_ToP(Section), AString_ToP(Name), DefValue);
  except
    Result := DefValue;
  end;
end;

function ASettings_ReadDateTimeDefA(Settings: ASettings; Section, Name: AStr;
    DefValue: TDateTime): TDateTime;
begin
  try
    Result := ASettings_ReadFloatDefP(Settings, AnsiString(Section), AnsiString(Name), DefValue);
  except
    Result := DefValue;
  end;
end;

function ASettings_ReadFloatDef(Settings: ASettings; const Section, Name: AString_Type;
    DefValue: AFloat): AFloat;
begin
  try
    Result := ASettings_ReadFloatDefP(Settings, AString_ToP(Section), AString_ToP(Name), DefValue);
  except
    Result := DefValue;
  end;
end;

function ASettings_ReadFloatDefA(Settings: ASettings; Section, Name: AStr;
    DefValue: AFloat): AFloat;
begin
  try
    Result := ASettings_ReadFloatDefP(Settings, AnsiString(Section), AnsiString(Name), DefValue);
  except
    Result := DefValue;
  end;
end;

function ASettings_ReadFloatDefP(Config: AConfig; const Section, Name: APascalString; DefValue: AFloat): AFloat;
begin
  if (Config = 0) then
  begin
    Result := DefValue;
    Exit;
  end;
  if not(TObject(Config) is TAbstractSettings) then
  begin
    Result := DefValue;
    Exit;
  end;
  try
    Result := TAbstractSettings(Config).ReadFloat(Section, Name, DefValue);
  except
    Result := DefValue;
  end;
end;

function ASettings_ReadIntDef(Settings: ASettings; const Section, Name: AString_Type;
    DefValue: AInt): AInt;
begin
  try
    Result := ASettings_ReadIntegerDefP(Settings, AString_ToP(Section), AString_ToP(Name), DefValue);
  except
    Result := DefValue;
  end;
end;

function ASettings_ReadIntDefA(Settings: ASettings; Section, Name: AStr; DefValue: AInt): AInt;
begin
  try
    Result := ASettings_ReadIntegerDefP(Settings, AnsiString(Section), AnsiString(Name), DefValue);
  except
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

function ASettings_ReadSection(Settings: ASettings; const Section: AString_Type;
    Strings: AStringList): AError;
begin
  try
    if Settings_ReadSection(Settings, AString_ToP(Section), Strings) then
      Result := 0
    else
      Result := -2;
  except
    Result := -1;
  end;
end;

function ASettings_ReadSectionA(Settings: ASettings; Section: AStr; Strings: AStringList): AError;
begin
  try
    if Settings_ReadSection(Settings, AnsiString(Section), Strings) then
      Result := 0
    else
      Result := -2;
  except
    Result := -1;
  end;
end;

function ASettings_ReadString(Settings: ASettings; const Section, Name: AString_Type;
    out Value: AString_Type): AInt;
var
  Er: AError;
  V: APascalString;
begin
  try
    V := AString_ToP(Value);
    Er := Settings_ReadString(Settings, AString_ToP(Section), AString_ToP(Name), V);
    AString_AssignP(Value, V);
    Result := Er;
  except
    Result := -1;
  end;
end;

function ASettings_ReadStringA(Settings: ASettings; Section, Name: AStr;
    Value: AStr; MaxLen: AInt): AInt;
var
  Er: AError;
  V: APascalString;
begin
  try
    V := AnsiString(Value);
    Er := Settings_ReadString(Settings, AnsiString(Section), AnsiString(Name), V);
    Value := AStr(AnsiString(V));
    Result := Er;
  except
    Result := -1;
  end;
end;

function ASettings_ReadStringDef(Settings: ASettings; const Section, Name, DefValue: AString_Type;
    out Value: AString_Type): AInt;
var
  V: APascalString;
begin
  try
    V := ASettings_ReadStringDefP(Settings, AString_ToP(Section), AString_ToP(Name), AString_ToP(DefValue));
    AString_AssignP(Value, V);
    Result := 0;
  except
    Result := -1;
  end;
end;

function ASettings_ReadStringDefA(Settings: ASettings; Section, Name, DefValue: AStr;
    Value: AStr; MaxLen: AInt): AInt;
var
  V: APascalString;
begin
  try
    V := ASettings_ReadStringDefP(Settings, AnsiString(Section), AnsiString(Name), AnsiString(DefValue));
    Value := AStr(AnsiString(V));
    Result := 0;
  except
    Result := -1;
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

function ASettings_WriteBool(Settings: ASettings; const Section, Name: AString_Type;
    Value: ABool): AError;
begin
  try
    Result := ASettings_WriteBoolP(Settings, AString_ToP(Section), AString_ToP(Name), Value);
  except
    Result := -1;
  end;
end;

function ASettings_WriteBoolA(Settings: ASettings; Section, Name: AStr; Value: ABool): AError;
begin
  try
    Result := ASettings_WriteBoolP(Settings, AnsiString(Section), AnsiString(Name), Value);
  except
    Result := -1;
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

function ASettings_WriteDateTime(Settings: ASettings; const Section, Name: AString_Type;
    Value: TDateTime): AError;
begin
  Result := ASettings_WriteFloat(Settings, Section, Name, Value);
end;

function ASettings_WriteDateTimeA(Settings: ASettings; Section, Name: AStr;
    Value: TDateTime): AError;
begin
  Result := ASettings_WriteFloatA(Settings, Section, Name, Value);
end;

function ASettings_WriteFloat(Settings: ASettings; const Section, Name: AString_Type;
    Value: AFloat): AError;
begin
  try
    Result := ASettings_WriteFloatP(Settings, AString_ToP(Section), AString_ToP(Name), Value);
  except
    Result := -1;
  end;
end;

function ASettings_WriteFloatA(Settings: ASettings; Section, Name: AStr; Value: AFloat): AError;
begin
  try
    Result := ASettings_WriteFloatP(Settings, AnsiString(Section), AnsiString(Name), Value);
  except
    Result := -1;
  end;
end;

function ASettings_WriteFloatP(Config: AConfig; const Section, Name: APascalString; Value: AFloat): AError;
begin
  if (Config = 0) then
  begin
    Result := -1;
    Exit;
  end;
  if (TObject(Config) is TAbstractSettings) then
  try
    if TAbstractSettings(Config).WriteFloat(Section, Name, Value) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end
  else
  begin
    {$ifdef UseXmlNode}
    Result := AConfig_WriteFloat(Config, Name, Value);
    {$else}
    Result := -3;
    {$endif}
  end;
end;

function ASettings_WriteInt(Settings: ASettings; const Section, Name: AString_Type;
    Value: AInt): AError;
begin
  try
    Result := ASettings_WriteIntegerP(Settings, AString_ToP(Section), AString_ToP(Name), Value);
  except
    Result := -1;
  end;
end;

function ASettings_WriteIntA(Settings: ASettings; Section, Name: AStr; Value: AInt): AError;
begin
  try
    Result := ASettings_WriteIntegerP(Settings, AnsiString(Section), AnsiString(Name), Value);
  except
    Result := -1;
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

function ASettings_WriteString(Settings: ASettings; const Section, Name,
    Value: AString_Type): AError;
begin
  try
    Result := ASettings_WriteStringP(Settings, AString_ToP(Section), AString_ToP(Name), AString_ToP(Value));
  except
    Result := -1;
  end;
end;

function ASettings_WriteStringA(Settings: ASettings; Section, Name, Value: AStr): AError;
begin
  try
    Result := ASettings_WriteStringP(Settings, AnsiString(Section), AnsiString(Name), AnsiString(Value));
  except
    Result := -1;
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
 