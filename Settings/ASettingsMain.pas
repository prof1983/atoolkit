{**
@Abstract ASettings main functions
@Author Prof1983 <prof1983@ya.ru>
@Created 13.08.2012
@LastMod 01.02.2013
}
unit ASettingsMain;

{define AStdCall}

{$ifndef NoXmlNode}
  {$define UseXmlNode}
{$endif}

interface

uses
  ABase,
  ABaseTypes,
  {$ifdef UseXmlNode}AConfigUtils,{$endif}
  AStringBaseUtils,
  AStringMain,
  AAbstractSettings;

// --- ASettings ---

function ASettings_Close(Config: AConfig): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_DeleteKey(Config: AConfig; const Section, Name: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

{ Section, Name - const }
function ASettings_DeleteKeyA(Config: AConfig; Section, Name: AStr): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_DeleteKeyP(Config: AConfig; const Section, Name: APascalString): AError;

function ASettings_DeleteSection(Config: AConfig; const Section: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

{ Section - const }
function ASettings_DeleteSectionA(Config: AConfig; Section: AStr): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_DeleteSectionP(Config: AConfig; const Section: APascalString): AError;

function ASettings_Fin(): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_Init(): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_ReadBoolDef(Config: AConfig; const Section, Name: AString_Type; DefValue: ABool): ABool; {$ifdef AStdCall}stdcall;{$endif}

{ Section, Name - const }
function ASettings_ReadBoolDefA(Config: AConfig; Section, Name: AStr; DefValue: ABool): ABool; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_ReadBoolDefP(Config: AConfig; const Section, Name: APascalString; DefValue: ABool): ABool;

function ASettings_ReadDateTimeDef(Config: AConfig; const Section, Name: AString_Type;
    DefValue: TDateTime): TDateTime; {$ifdef AStdCall}stdcall;{$endif}

{ Section, Name - const }
function ASettings_ReadDateTimeDefA(Config: AConfig; Section, Name: AStr;
    DefValue: TDateTime): TDateTime; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_ReadDateTimeDefP(Config: AConfig; const Section, Name: APascalString;
    DefValue: TDateTime): TDateTime;

function ASettings_ReadFloatDef(Config: AConfig; const Section, Name: AString_Type; DefValue: AFloat): AFloat; {$ifdef AStdCall}stdcall;{$endif}

{ Section, Name - const }
function ASettings_ReadFloatDefA(Config: AConfig; Section, Name: AStr; DefValue: AFloat): AFloat; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_ReadFloatDefP(Config: AConfig; const Section, Name: APascalString; DefValue: AFloat): AFloat;

function ASettings_ReadIntDef(Config: AConfig; const Section, Name: AString_Type; DefValue: AInt): AInt; {$ifdef AStdCall}stdcall;{$endif}

{ Section - const
  Name - const }
function ASettings_ReadIntDefA(Config: AConfig; Section, Name: AStr; DefValue: AInt): AInt; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_ReadIntDefP(Config: AConfig; const Section, Name: APascalString; DefValue: AInt): AInt;

function ASettings_ReadIntegerDefP(Config: AConfig; const Section, Name: APascalString; DefValue: AInt): AInt;

function ASettings_ReadSection(Config: AConfig; const Section: AString_Type; Strings: AStringList): AError; {$ifdef AStdCall}stdcall;{$endif}

{ Section - const }
function ASettings_ReadSectionA(Config: AConfig; Section: AStr; Strings: AStringList): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_ReadSectionP(Config: AConfig; const Section: APascalString;
    Strings: AStringList): AError;

function ASettings_ReadString(Config: AConfig; const Section, Name: AString_Type;
    out Value: AString_Type): AInt; {$ifdef AStdCall}stdcall;{$endif}

{ Section - const
  Name - const
  Value - out}
function ASettings_ReadStringA(Config: AConfig; Section, Name: AStr;
    Value: AStr; MaxLen: AInt): AInt; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_ReadStringDef(Config: AConfig; const Section, Name, DefValue: AString_Type;
    out Value: AString_Type): AInt; {$ifdef AStdCall}stdcall;{$endif}

{ Section - const
  Name - const
  DefValue - const
  Value - out}
function ASettings_ReadStringDefA(Config: AConfig; Section, Name, DefValue: AStr;
    Value: AStr; MaxLen: AInt): AInt; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_ReadStringDefP(Config: AConfig; const Section, Name,
    DefValue: APascalString): APascalString;

function ASettings_ReadStringP(Config: AConfig; const Section, Name: APascalString;
    out Value: APascalString): AInt;

function ASettings_WriteBool(Config: AConfig; const Section, Name: AString_Type;
    Value: ABool): AError; {$ifdef AStdCall}stdcall;{$endif}

{ Section, Name - const }
function ASettings_WriteBoolA(Config: AConfig; Section, Name: AStr; Value: ABool): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_WriteBoolP(Config: AConfig; const Section, Name: APascalString; Value: ABoolean): AError;

function ASettings_WriteDateTime(Config: AConfig; const Section, Name: AString_Type; Value: TDateTime): AError; {$ifdef AStdCall}stdcall;{$endif}

{ Section, Name - const }
function ASettings_WriteDateTimeA(Config: AConfig; Section, Name: AStr; Value: TDateTime): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_WriteDateTimeP(Config: AConfig; const Section, Name: APascalString; Value: TDateTime): AError;

function ASettings_WriteFloat(Config: AConfig; const Section, Name: AString_Type; Value: AFloat): AError; {$ifdef AStdCall}stdcall;{$endif}

{ Section, Name - const }
function ASettings_WriteFloatA(Config: AConfig; Section, Name: AStr; Value: AFloat): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_WriteFloatP(Config: AConfig; const Section, Name: APascalString; Value: AFloat): AError;

function ASettings_WriteInt(Config: AConfig; const Section, Name: AString_Type; Value: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

{ Section, Name - const }
function ASettings_WriteIntA(Config: AConfig; Section, Name: AStr; Value: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_WriteIntP(Config: AConfig; const Section, Name: APascalString; Value: AInt): AError;

function ASettings_WriteIntegerP(Config: AConfig; const Section, Name: APascalString; Value: AInt): AError;

function ASettings_WriteString(Config: AConfig; const Section, Name, Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

{ Section, Name, Value - const }
function ASettings_WriteStringA(Config: AConfig; Section, Name, Value: AStr): AError; {$ifdef AStdCall}stdcall;{$endif}

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

function ASettings_DeleteKey(Config: AConfig; const Section, Name: AString_Type): AError;
begin
  Result := ASettings_DeleteKeyP(Config, AString_ToPascalString(Section), AString_ToPascalString(Name));
end;

function ASettings_DeleteKeyA(Config: AConfig; Section, Name: AStr): AError;
begin
  Result := ASettings_DeleteKeyP(Config, AnsiString(Section), AnsiString(Name));
end;

function ASettings_DeleteKeyP(Config: AConfig; const Section, Name: APascalString): AError;
begin
  try
    if TAbstractSettings(Config).DeleteKey(Section, Name) then
      Result := 0
    else
      Result := -2;
  except
    Result := -1;
  end;
end;

function ASettings_DeleteSection(Config: AConfig; const Section: AString_Type): AError;
begin
  Result := ASettings_DeleteSectionP(Config, AString_ToPascalString(Section));
end;

function ASettings_DeleteSectionA(Config: AConfig; Section: AStr): AError;
begin
  Result := ASettings_DeleteSectionP(Config, AnsiString(Section));
end;

function ASettings_DeleteSectionP(Config: AConfig; const Section: APascalString): AError;
begin
  try
    if TAbstractSettings(Config).DeleteSection(Section) then
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

function ASettings_ReadBoolDef(Config: AConfig; const Section, Name: AString_Type; DefValue: ABool): ABool;
begin
  try
    Result := ASettings_ReadBoolDefP(Config,
        AString_ToPascalString(Section),
        AString_ToPascalString(Name),
        DefValue);
  except
    Result := DefValue;
  end
end;

function ASettings_ReadBoolDefA(Config: AConfig; Section, Name: AStr; DefValue: ABool): ABool;
begin
  Result := ASettings_ReadBoolDefP(Config, AnsiString(Section), AnsiString(Name), DefValue);
end;

function ASettings_ReadBoolDefP(Config: AConfig; const Section, Name: APascalString; DefValue: ABool): ABool;
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

function ASettings_ReadDateTimeDef(Config: AConfig; const Section, Name: AString_Type;
    DefValue: TDateTime): TDateTime;
begin
  try
    Result := ASettings_ReadDateTimeDefP(
        Config,
        AString_ToPascalString(Section),
        AString_ToPascalString(Name),
        DefValue);
  except
    Result := DefValue;
  end;
end;

function ASettings_ReadDateTimeDefA(Config: AConfig; Section, Name: AStr;
    DefValue: TDateTime): TDateTime;
begin
  try
    Result := ASettings_ReadDateTimeDefP(Config, AnsiString(Section), AnsiString(Name), DefValue);
  except
    Result := DefValue;
  end;
end;

function ASettings_ReadDateTimeDefP(Config: AConfig; const Section, Name: APascalString;
    DefValue: TDateTime): TDateTime;
begin
  if (Config = 0) then
  begin
    Result := DefValue;
    Exit;
  end;
  try
    Result := TAbstractSettings(Config).ReadDateTime(Section, Name, DefValue);
  except
    Result := DefValue;
  end;
end;

function ASettings_ReadFloatDef(Config: AConfig; const Section, Name: AString_Type; DefValue: AFloat): AFloat;
begin
  try
    Result := ASettings_ReadFloatDefP(
        Config,
        AString_ToPascalString(Section),
        AString_ToPascalString(Name),
        DefValue);
  except
    Result := DefValue;
  end;
end;

function ASettings_ReadFloatDefA(Config: AConfig; Section, Name: AStr; DefValue: AFloat): AFloat;
begin
  try
    Result := ASettings_ReadFloatDefP(Config, AnsiString(Section), AnsiString(Name), DefValue);
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

function ASettings_ReadIntDef(Config: AConfig; const Section, Name: AString_Type; DefValue: AInt): AInt;
begin
  try
    Result := ASettings_ReadIntDefP(
        Config,
        AString_ToPascalString(Section),
        AString_ToPascalString(Name),
        DefValue);
  except
    Result := DefValue;
  end;
end;

function ASettings_ReadIntDefA(Config: AConfig; Section, Name: AStr; DefValue: AInt): AInt;
begin
  try
    Result := ASettings_ReadIntDefP(Config, AnsiString(Section), AnsiString(Name), DefValue);
  except
    Result := DefValue;
  end;
end;

function ASettings_ReadIntDefP(Config: AConfig; const Section, Name: APascalString; DefValue: AInt): AInt;
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

function ASettings_ReadIntegerDefP(Config: AConfig; const Section, Name: APascalString; DefValue: AInt): AInt;
begin
  Result := ASettings_ReadIntDefP(Config, Section, Name, DefValue);
end;

function ASettings_ReadSection(Config: AConfig; const Section: AString_Type; Strings: AStringList): AError;
begin
  Result := ASettings_ReadSectionP(Config, AString_ToPascalString(Section), Strings);
end;

function ASettings_ReadSectionA(Config: AConfig; Section: AStr; Strings: AStringList): AError;
begin
  Result := ASettings_ReadSectionP(Config, AnsiChar(Section), Strings);
end;

function ASettings_ReadSectionP(Config: AConfig; const Section: APascalString; Strings: AStringList): AError;
begin
  try
    if TAbstractSettings(Config).ReadSection(Section, Strings) then
      Result := 0
    else
      Result := -2;
  except
    Result := -1;
  end;
end;

function ASettings_ReadString(Config: AConfig; const Section, Name: AString_Type; out Value: AString_Type): AInt;
var
  S: APascalString;
begin
  try
    Result := ASettings_ReadStringP(
        Config,
        AString_ToPascalString(Section),
        AString_ToPascalString(Name),
        S);
    if (Result >= 0) then
      Result := AString_AssignP(Value, S);
  except
    Result := -1;
  end;
end;

function ASettings_ReadStringA(Config: AConfig; Section, Name, Value: AStr; MaxLen: AInt): AInt;
var
  S: APascalString;
begin
  try
    Result := ASettings_ReadStringP(Config, AnsiString(Section), AnsiString(Name), S);
    if (Result > 0) then
      AStringBaseUtils.StrPLCopy(Value, AnsiString(S), MaxLen);
  except
    Result := -1;
  end;
end;

function ASettings_ReadStringDef(Config: AConfig; const Section, Name, DefValue: AString_Type;
    out Value: AString_Type): AInt;
var
  S: APascalString;
begin
  try
    S := ASettings_ReadStringDefP(Config,
        AString_ToPascalString(Section),
        AString_ToPascalString(Name),
        AString_ToPascalString(DefValue));
    Result := AString_AssignP(Value, S);
  except
    Result := -1;
  end;
end;

function ASettings_ReadStringDefA(Config: AConfig; Section, Name, DefValue: AStr;
    Value: AStr; MaxLen: AInt): AInt;
var
  S: AnsiString;
begin
  try
    S := ASettings_ReadStringDefP(Config, AnsiString(Section), AnsiString(Name), AnsiString(DefValue));
    AStringBaseUtils.StrPLCopy(Value, AnsiString(S), MaxLen);
    Result := Length(S);
  except
    Result := -1;
  end;
end;

function ASettings_ReadStringDefP(Config: AConfig; const Section, Name,
    DefValue: APascalString): APascalString;
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

function ASettings_ReadStringP(Config: AConfig; const Section, Name: APascalString;
    out Value: APascalString): AInt;
begin
  if (Config = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    Result := TAbstractSettings(Config).ReadString(Section, Name, '', Value);
  except
    Result := -1;
  end;
end;

function ASettings_WriteBool(Config: AConfig; const Section, Name: AString_Type; Value: ABool): AError;
begin
  try
    Result := ASettings_WriteBoolP(
        Config,
        AString_ToPascalString(Section),
        AString_ToPascalString(Name),
        Value);
  except
    Result := -1;
  end;
end;

function ASettings_WriteBoolA(Config: AConfig; {const} Section, Name: AStr; Value: ABool): AError;
begin
  Result := ASettings_WriteBoolP(Config, AnsiString(Section), AnsiString(Name), Value);
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

function ASettings_WriteDateTime(Config: AConfig; const Section, Name: AString_Type; Value: TDateTime): AError;
begin
  Result := ASettings_WriteDateTimeP(
      Config,
      AString_ToPascalString(Section),
      AString_ToPascalString(Name),
      Value);
end;

function ASettings_WriteDateTimeA(Config: AConfig; Section, Name: AStr; Value: TDateTime): AError;
begin
  Result := ASettings_WriteDateTimeP(Config, AnsiString(Section), AnsiString(Name), Value);
end;

function ASettings_WriteDateTimeP(Config: AConfig; const Section, Name: APascalString; Value: TDateTime): AError;
begin
  if (Config = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    if TAbstractSettings(Config).WriteDateTime(Section, Name, Value) then
      Result := 0
    else
      Result := -3;
  except
    Result := -1;
  end;
end;

function ASettings_WriteFloat(Config: AConfig; const Section, Name: AString_Type; Value: AFloat): AError;
begin
  Result := ASettings_WriteFloatP(Config, AString_ToPascalString(Section), AString_ToPascalString(Name), Value);
end;

function ASettings_WriteFloatA(Config: AConfig; {const} Section, Name: AStr; Value: AFloat): AError;
begin
  Result := ASettings_WriteFloatP(Config, AnsiString(Section), AnsiString(Name), Value);
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

function ASettings_WriteInt(Config: AConfig; const Section, Name: AString_Type; Value: AInt): AError;
begin
  Result := ASettings_WriteIntP(Config, AString_ToPascalString(Section), AString_ToPascalString(Name), Value);
end;

function ASettings_WriteIntA(Config: AConfig; Section, Name: AStr; Value: AInt): AError;
begin
  Result := ASettings_WriteIntP(Config, AnsiString(Section), AnsiString(Name), Value);
end;

function ASettings_WriteIntP(Config: AConfig; const Section, Name: APascalString; Value: AInt): AError;
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

function ASettings_WriteIntegerP(Config: AConfig; const Section, Name: APascalString; Value: AInt): AError;
begin
  Result := ASettings_WriteIntP(Config, Section, Name, Value);
end;

function ASettings_WriteString(Config: AConfig; const Section, Name, Value: AString_Type): AError;
begin
  Result := ASettings_WriteStringP(
      Config,
      AString_ToPascalString(Section),
      AString_ToPascalString(Name),
      AString_ToPascalString(Value));
end;

function ASettings_WriteStringA(Config: AConfig; Section, Name, Value: AStr): AError;
begin
  Result := ASettings_WriteStringP(Config, AnsiString(Section), AnsiString(Name), AnsiString(Value));
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
 