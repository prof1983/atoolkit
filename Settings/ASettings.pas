{**
@Abstract The module for work with the settings
@Author Prof1983 <prof1983@ya.ru>
@Created 06.03.2008
@LastMod 05.02.2013
}
unit ASettings;

interface

uses
  ABase,
  ABaseTypes,
  ACollectionsBase,
  ASettingsIni,
  ASettingsMain,
  ASettingsReg,
  AStringBaseUtils,
  AStringMain;

// ----

function Fin(): AError; stdcall;

function Init(): AError; stdcall;

function Config_Close(Config: AConfig): AError; stdcall;

function Config_DeleteKey(Config: AConfig; const Section, Name: AString_Type): AError; stdcall;

function Config_DeleteKeyA(Config: AConfig; {const} Section, Name: PAnsiChar): AError; stdcall;

function Config_DeleteKeyP(Config: AConfig; const Section, Name: APascalString): AError; stdcall;

function Config_DeleteKeyS(Config: AConfig; {const} Section, Name: AString): AError; stdcall;

function Config_DeleteKeyW(Config: AConfig; {const} Section, Name: PWideChar): AError; stdcall;

function Config_DeleteSection(Config: AConfig; const Section: AString_Type): AError; stdcall;

function Config_DeleteSectionA(Config: AConfig; {const} Section: PAnsiChar): AError; stdcall;

function Config_DeleteSectionP(Config: AConfig; const Section: APascalString): AError; stdcall;

function Config_DeleteSectionS(Config: AConfig; {const} Section: AString): AError; stdcall;

function Config_DeleteSectionW(Config: AConfig; {const} Section: PWideChar): AError; stdcall;

function Config_ReadBoolDef(Config: AConfig; const Section, Name: AString_Type; DefValue: ABoolean): ABoolean; stdcall;

function Config_ReadBoolDefA(Config: AConfig; {const} Section, Name: PAnsiChar; DefValue: ABoolean): ABoolean; stdcall;

//** Считывает параметр из конфигурации.
function Config_ReadBoolDefP(Config: AConfig; const Section, Name: APascalString; DefValue: ABoolean): ABoolean; stdcall;

function Config_ReadBoolDefS(Config: AConfig; {const} Section, Name: AString; DefValue: ABoolean): ABoolean; stdcall;

function Config_ReadBoolDefW(Config: AConfig; {const} Section, Name: PWideChar; DefValue: ABoolean): ABoolean; stdcall;

function Config_ReadIntegerDef(Config: AConfig; const Section, Name: AString_Type; DefValue: AInteger): AInteger; stdcall;

function Config_ReadIntegerDefA(Config: AConfig; {const} Section, Name: PAnsiChar; DefValue: AInteger): AInteger; stdcall;

function Config_ReadIntegerDefP(Config: AConfig; const Section, Name: APascalString; DefValue: AInteger): AInteger; stdcall;

function Config_ReadIntegerDefS(Config: AConfig; {const} Section, Name: AString; DefValue: AInteger): AInteger; stdcall;

function Config_ReadIntegerDefW(Config: AConfig; {const} Section, Name: PWideChar; DefValue: AInteger): AInteger; stdcall;

function Config_ReadFloatDef(Config: AConfig; const Section, Name: AString_Type; DefValue: AFloat): AFloat; stdcall;

function Config_ReadFloatDefA(Config: AConfig; {const} Section, Name: PAnsiChar; DefValue: AFloat): AFloat; stdcall;

function Config_ReadFloatDefP(Config: AConfig; const Section, Name: APascalString; DefValue: AFloat): AFloat; stdcall;

function Config_ReadFloatDefS(Config: AConfig; {const} Section, Name: AString; DefValue: AFloat): AFloat; stdcall;

function Config_ReadFloatDefW(Config: AConfig; {const} Section, Name: PWideChar; DefValue: AFloat): AFloat; stdcall;

function Config_ReadSection(Config: AConfig; const Section: AString_Type; Strings: AStringList): AError; stdcall;

function Config_ReadSectionA(Config: AConfig; {const} Section: PAnsiChar; Strings: AStringList): AError; stdcall;

function Config_ReadSectionP(Config: AConfig; const Section: APascalString; Strings: AStringList): AError; stdcall;

function Config_ReadSectionS(Config: AConfig; {const} Section: AString; Strings: AStringList): AError; stdcall;

function Config_ReadSectionW(Config: AConfig; {const} Section: PWideChar; Strings: AStringList): AError; stdcall;

function Config_ReadString(Config: AConfig; const Section, Name: AString_Type; out Value: AString_Type): AInteger; stdcall;

function Config_ReadStringA(Config: AConfig; {const} Section, Name: PAnsiChar; {out} Value: PAnsiChar; MaxLen: AInteger): AInteger; stdcall;

function Config_ReadStringP(Config: AConfig; const Section, Name: APascalString; out Value: APascalString): AInteger; stdcall;

function Config_ReadStringS(Config: AConfig; {const} Section, Name: AString; {out} Value: AString): AInteger; stdcall;

function Config_ReadStringW(Config: AConfig; {const} Section, Name: PWideChar; {out} Value: PWideChar; MaxLen: AInteger): AInteger; stdcall;

// Возвращает: если улачно - длину строки, если не удачно - код ошибки
function Config_ReadStringDef(Config: AConfig; const Section, Name, DefValue: AString_Type;
    out Value: AString_Type): AInteger; stdcall;

// Возвращает: если улачно - длину строки, если не удачно - код ошибки
function Config_ReadStringDefA(Config: AConfig; {const} Section, Name, DefValue: PAnsiChar;
    {out} Value: PAnsiChar; MaxLen: AInteger): AInteger; stdcall;

// Возвращает строку
function Config_ReadStringDefP(Config: AConfig; const Section, Name, DefValue: APascalString): APascalString; stdcall;

// Возвращает: если улачно - длину строки, если не удачно - код ошибки
function Config_ReadStringDefS(Config: AConfig; {const} Section, Name, DefValue: AString;
    {out} Value: AString): AInteger; stdcall;

// Возвращает: если улачно - длину строки, если не удачно - код ошибки
function Config_ReadStringDefW(Config: AConfig; {const} Section, Name, DefValue: PWideChar;
    {out} Value: PWideChar; MaxLen: AInteger): AInteger; stdcall;

function Config_ReadDateTimeDef(Config: AConfig; const Section, Name: AString_Type; DefValue: TDateTime): TDateTime; stdcall;

function Config_ReadDateTimeDefA(Config: AConfig; {const} Section, Name: PAnsiChar; DefValue: TDateTime): TDateTime; stdcall;

function Config_ReadDateTimeDefP(Config: AConfig; const Section, Name: APascalString; DefValue: TDateTime): TDateTime; stdcall;

function Config_ReadDateTimeDefS(Config: AConfig; {const} Section, Name: AString; DefValue: TDateTime): TDateTime; stdcall;

function Config_ReadDateTimeDefW(Config: AConfig; {const} Section, Name: PWideChar; DefValue: TDateTime): TDateTime; stdcall;

function Config_WriteBool(Config: AConfig; const Section, Name: AString_Type; Value: ABoolean): AError; stdcall;

function Config_WriteBoolA(Config: AConfig; {const} Section, Name: PAnsiChar; Value: ABoolean): AError; stdcall;

function Config_WriteBoolP(Config: AConfig; const Section, Name: APascalString; Value: ABoolean): AError; stdcall;

function Config_WriteBoolS(Config: AConfig; {const} Section, Name: AString; Value: ABoolean): AError; stdcall;

function Config_WriteBoolW(Config: AConfig; {const} Section, Name: PWideChar; Value: ABoolean): AError; stdcall;

function Config_WriteInteger(Config: AConfig; const Section, Name: AString_Type; Value: AInteger): AError; stdcall;

function Config_WriteIntegerA(Config: AConfig; {const} Section, Name: PAnsiChar; Value: AInteger): AError; stdcall;

function Config_WriteIntegerP(Config: AConfig; const Section, Name: APascalString; Value: AInteger): AError; stdcall;

function Config_WriteIntegerS(Config: AConfig; {const} Section, Name: AString; Value: AInteger): AError; stdcall;

function Config_WriteIntegerW(Config: AConfig; {const} Section, Name: PWideChar; Value: AInteger): AError; stdcall;

function Config_WriteFloat(Config: AConfig; const Section, Name: AString_Type; Value: AFloat): AError; stdcall;

function Config_WriteFloatA(Config: AConfig; {const} Section, Name: PAnsiChar; Value: AFloat): AError; stdcall;

function Config_WriteFloatP(Config: AConfig; const Section, Name: APascalString; Value: AFloat): AError; stdcall;

function Config_WriteFloatS(Config: AConfig; {const} Section, Name: AString; Value: AFloat): AError; stdcall;

function Config_WriteFloatW(Config: AConfig; {const} Section, Name: PWideChar; Value: AFloat): AError; stdcall;

function Config_WriteString(Config: AConfig; const Section, Name, Value: AString_Type): AError; stdcall;

function Config_WriteStringA(Config: AConfig; {const} Section, Name, Value: PAnsiChar): AError; stdcall;

function Config_WriteStringP(Config: AConfig; const Section, Name, Value: APascalString): AError; stdcall;

function Config_WriteStringS(Config: AConfig; {const} Section, Name, Value: AString): AError; stdcall;

function Config_WriteStringW(Config: AConfig; {const} Section, Name, Value: PWideChar): AError; stdcall;

function Config_WriteDateTime(Config: AConfig; const Section, Name: AString_Type; Value: TDateTime): AError; stdcall;

function Config_WriteDateTimeA(Config: AConfig; {const} Section, Name: PAnsiChar; Value: TDateTime): AError; stdcall;

function Config_WriteDateTimeP(Config: AConfig; const Section, Name: APascalString; Value: TDateTime): AError; stdcall;

function Config_WriteDateTimeS(Config: AConfig; {const} Section, Name: AString; Value: TDateTime): AError; stdcall;

function Config_WriteDateTimeW(Config: AConfig; {const} Section, Name: PWideChar; Value: TDateTime): AError; stdcall;

function IniConfig_New(const FileName: AString_Type): AConfig; stdcall;

function IniConfig_NewA({const} FileName: PAnsiChar): AConfig; stdcall;

function IniConfig_NewP(const FileName: APascalString): AConfig; stdcall;

function IniConfig_NewS({const} FileName: AString): AConfig; stdcall;

function IniConfig_NewW({const} FileName: PWideChar): AConfig; stdcall;

function RegConfig_New(const Prefix: AString_Type): AConfig; stdcall;

function RegConfig_NewA({const} Prefix: PAnsiChar): AConfig; stdcall;

function RegConfig_NewP(const Prefix: APascalString): AConfig; stdcall;

function RegConfig_NewS({const} Prefix: AString): AConfig; stdcall;

function RegConfig_NewW({const} Prefix: PWideChar): AConfig; stdcall;

function RegConfig_New2(const Prefix: AString_Type; Key: AInt): AConfig; stdcall;

function RegConfig_New2P(const Prefix: APascalString; Key: AInt): AConfig; stdcall;

{ deprecated }

// Use Config_ReadBoolP()
function ReadBool(Config: AConfig; const Section, Name: APascalString; DefValue: ABoolean): ABoolean; stdcall; deprecated;
// Use Config_ReadIntegerP()
function ReadInteger(Config: AConfig; const Section, Name: APascalString; DefValue: AInteger): AInteger; stdcall; deprecated;
// Use Config_ReadStringP()
function ReadString(Config: AConfig; const Section, Name, DefValue: APascalString): APascalString; stdcall; deprecated;
// Use Config_WriteBoolP()
function WriteBool(Config: AConfig; const Section, Name: APascalString; Value: ABoolean): AError; stdcall; deprecated;
// Use Config_WriteIntegerP()
function WriteInteger(Config: AConfig; const Section, Name: APascalString; Value: AInteger): AError; stdcall; deprecated;
// Use Config_WriteStringP();
function WriteString(Config: AConfig; const Section, Name, Value: APascalString): AError; stdcall; deprecated;

implementation

{ Config }

function Config_Close(Config: AConfig): AError;
begin
  Result := ASettings_Close(Config);
end;

function Config_DeleteKey(Config: AConfig; const Section, Name: AString_Type): AError;
begin
  try
    Result := ASettings_DeleteKeyP(Config, AString_ToPascalString(Section), AString_ToPascalString(Name));
  except
    Result := -1;
  end;
end;

function Config_DeleteKeyA(Config: AConfig; {const} Section, Name: PAnsiChar): AError;
begin
  Result := ASettings_DeleteKeyP(Config, AnsiString(Section), AnsiString(Name));
end;

function Config_DeleteKeyP(Config: AConfig; const Section, Name: APascalString): AError;
begin
  Result := ASettings_DeleteKeyP(Config, Section, Name);
end;

function Config_DeleteKeyS(Config: AConfig; {const} Section, Name: AString): AError;
begin
  Result := ASettings_DeleteKeyP(
      Config,
      Str_ToP(Section),
      Str_ToP(Name));
end;

function Config_DeleteKeyW(Config: AConfig; Section, Name: PWideChar): AError;
begin
  Result := ASettings_DeleteKeyP(Config, WideString(Section), WideString(Name));
end;

function Config_DeleteSection(Config: AConfig; const Section: AString_Type): AError;
begin
  try
    Result := ASettings_DeleteSectionP(Config, AString_ToPascalString(Section));
  except
    Result := -1;
  end;
end;

function Config_DeleteSectionA(Config: AConfig; Section: PAnsiChar): AError;
begin
  try
    Result := ASettings_DeleteSectionP(Config, AnsiString(Section));
  except
    Result := -1;
  end;
end;

function Config_DeleteSectionP(Config: AConfig; const Section: APascalString): AError;
begin
  try
    Result := ASettings_DeleteSectionP(Config, Section);
  except
    Result := -1;
  end;
end;

function Config_DeleteSectionS(Config: AConfig; Section: AString): AError;
begin
  Result := Config_DeleteSection(Config, Section^);
end;

function Config_DeleteSectionW(Config: AConfig; Section: PWideChar): AError;
begin
  try
    ASettings_DeleteSectionP(Config, WideString(Section));
  except
    Result := -1;
  end;
end;

function Config_ReadBoolDef(Config: AConfig; const Section, Name: AString_Type; DefValue: ABool): ABool;
begin
  Result := ASettings_ReadBoolDef(Config, Section, Name, DefValue);
end;

function Config_ReadBoolDefA(Config: AConfig; Section, Name: PAnsiChar; DefValue: ABool): ABool;
begin
  Result := ASettings_ReadBoolDefP(Config, AnsiString(Section), AnsiString(Name), DefValue);
end;

function Config_ReadBoolDefP(Config: AConfig; const Section, Name: APascalString; DefValue: ABool): ABool;
begin
  Result := ASettings_ReadBoolDefP(Config, Section, Name, DefValue);
end;

function Config_ReadBoolDefS(Config: AConfig; Section, Name: AString; DefValue: ABool): ABool;
begin
  Result := ASettings_ReadBoolDef(Config, Section^, Name^, DefValue);
end;

function Config_ReadBoolDefW(Config: AConfig; Section, Name: PWideChar; DefValue: ABool): ABool;
begin
  Result := ASettings_ReadBoolDefP(Config, WideString(Section), WideString(Name), DefValue);
end;

function Config_ReadIntegerDef(Config: AConfig; const Section, Name: AString_Type; DefValue: AInt): AInt;
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

function Config_ReadIntegerDefA(Config: AConfig; Section, Name: PAnsiChar; DefValue: AInt): AInt;
begin
  try
    Result := ASettings_ReadIntDefP(Config, AnsiString(Section), AnsiString(Name), DefValue);
  except
    Result := DefValue;
  end;
end;

function Config_ReadIntegerDefP(Config: AConfig; const Section, Name: APascalString; DefValue: AInt): AInt;
begin
  Result := ASettings_ReadIntegerDefP(Config, Section, Name, DefValue);
end;

function Config_ReadIntegerDefS(Config: AConfig; Section, Name: AString; DefValue: AInt): AInt;
begin
  Result := Config_ReadIntegerDef(Config, Section^, Name^, DefValue);
end;

function Config_ReadIntegerDefW(Config: AConfig; Section, Name: PWideChar; DefValue: AInt): AInt;
begin
  try
    Result := ASettings_ReadIntDefP(Config, WideString(Section), WideString(Name), DefValue);
  except
    Result := DefValue;
  end;
end;

function Config_ReadFloatDef(Config: AConfig; const Section, Name: AString_Type; DefValue: AFloat): AFloat;
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

function Config_ReadFloatDefA(Config: AConfig; Section, Name: PAnsiChar; DefValue: AFloat): AFloat;
begin
  try
    Result := ASettings_ReadFloatDefP(Config, AnsiString(Section), AnsiString(Name), DefValue);
  except
    Result := DefValue;
  end;
end;

function Config_ReadFloatDefP(Config: AConfig; const Section, Name: APascalString; DefValue: AFloat): AFloat;
begin
  Result := ASettings_ReadFloatDefP(Config, Section, Name, DefValue);
end;

function Config_ReadFloatDefS(Config: AConfig; Section, Name: AString; DefValue: AFloat): AFloat;
begin
  Result := Config_ReadFloatDef(Config, Section^, Name^, DefValue);
end;

function Config_ReadFloatDefW(Config: AConfig; Section, Name: PWideChar; DefValue: AFloat): AFloat;
begin
  try
    Result := ASettings_ReadFloatDefP(Config, WideString(Section), WideString(Name), DefValue);
  except
    Result := DefValue;
  end;
end;

function Config_ReadSection(Config: AConfig; const Section: AString_Type; Strings: AStringList): AError;
begin
  try
    Result := ASettings_ReadSectionP(Config, AString_ToPascalString(Section), Strings);
  except
    Result := -1;
  end;
end;

function Config_ReadSectionA(Config: AConfig; Section: PAnsiChar; Strings: AStringList): AError;
begin
  try
    Result := ASettings_ReadSectionP(Config, AnsiChar(Section), Strings);
  except
    Result := -1;
  end;
end;

function Config_ReadSectionP(Config: AConfig; const Section: APascalString; Strings: AStringList): AError;
begin
  try
    Result := ASettings_ReadSectionP(Config, Section, Strings);
  except
    Result := -1;
  end;
end;

function Config_ReadSectionS(Config: AConfig; Section: AString; Strings: AStringList): AError;
begin
  Result := Config_ReadSection(Config, Section^, Strings);
end;

function Config_ReadSectionW(Config: AConfig; Section: PWideChar; Strings: AStringList): AError;
begin
  try
    Result := ASettings_ReadSectionP(Config, WideString(Section), Strings);
  except
    Result := -1;
  end;
end;

function Config_ReadString(Config: AConfig; const Section, Name: AString_Type; out Value: AString_Type): AInt;
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

function Config_ReadStringA(Config: AConfig; Section, Name: PAnsiChar; Value: PAnsiChar; MaxLen: AInt): AInt;
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

function Config_ReadStringDef(Config: AConfig; const Section, Name, DefValue: AString_Type;
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

function Config_ReadStringDefA(Config: AConfig; Section, Name, DefValue: PAnsiChar;
    Value: PAnsiChar; MaxLen: AInt): AInt;
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

function Config_ReadStringDefP(Config: AConfig; const Section, Name, DefValue: APascalString): APascalString;
begin
  try
    Result := ASettings_ReadStringDefP(Config, Section, Name, DefValue);
  except
    Result := '';
  end;
end;

function Config_ReadStringDefS(Config: AConfig; Section, Name, DefValue: AString; Value: AString): AInt;
begin
  if Assigned(Section) and Assigned(Name) and Assigned(DefValue) and Assigned(Value) then
    Result := Config_ReadStringDef(Config, Section^, Name^, DefValue^, Value^)
  else
    Result := -1;
end;

function Config_ReadStringDefW(Config: AConfig; Section, Name, DefValue: PWideChar;
    Value: PWideChar; MaxLen: AInt): AInt;
var
  S: WideString;
begin
  try
    S := ASettings_ReadStringDefP(Config, WideString(Section), WideString(Name), WideString(DefValue));
    Result := Length(S);
    AStringBaseUtils.StrCopyLWP(Value, S, MaxLen)
  except
    Result := -1;
  end;
end;

function Config_ReadStringP(Config: AConfig; const Section, Name: APascalString; out Value: APascalString): AInt;
begin
  try
    Result := ASettings_ReadStringP(Config, Section, Name, Value);
  except
    Result := -1;
  end;
end;

function Config_ReadStringS(Config: AConfig; Section, Name: AString; Value: AString): AInt;
begin
  if Assigned(Section) and Assigned(Name) and Assigned(Value) then
    Result := Config_ReadString(Config, Section^, Name^, Value^)
  else
    Result := -1;
end;

function Config_ReadStringW(Config: AConfig; Section, Name: PWideChar;
    Value: PWideChar; MaxLen: AInt): AInt;
var
  S: APascalString;
begin
  try
    Result := ASettings_ReadStringP(Config, WideString(Section), WideString(Name), S);
    if (Result > 0) then
      AStringBaseUtils.StrCopyLWP(Value, S, MaxLen);
  except
    Result := -1;
  end;
end;

function Config_ReadDateTimeDef(Config: AConfig; const Section, Name: AString_Type; DefValue: TDateTime): TDateTime;
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

function Config_ReadDateTimeDefA(Config: AConfig; Section, Name: PAnsiChar; DefValue: TDateTime): TDateTime;
begin
  try
    Result := ASettings_ReadDateTimeDefP(Config, AnsiString(Section), AnsiString(Name), DefValue);
  except
    Result := DefValue;
  end;
end;

function Config_ReadDateTimeDefP(Config: AConfig; const Section, Name: APascalString; DefValue: TDateTime): TDateTime;
begin
  try
    Result := ASettings_ReadDateTimeDefP(Config, Section, Name, DefValue);
  except
    Result := DefValue;
  end;
end;

function Config_ReadDateTimeDefS(Config: AConfig; Section, Name: AString; DefValue: TDateTime): TDateTime;
begin
  if Assigned(Section) and Assigned(Name) then
    Result := Config_ReadDateTimeDef(Config, Section^, Name^, DefValue)
  else
    Result := DefValue;
end;

function Config_ReadDateTimeDefW(Config: AConfig; Section, Name: PWideChar; DefValue: TDateTime): TDateTime;
begin
  try
    Result := ASettings_ReadDateTimeDefP(Config, WideString(Section), WideString(Name), DefValue);
  except
    Result := DefValue;
  end;
end;

function Config_WriteBool(Config: AConfig; const Section, Name: AString_Type; Value: ABool): AError;
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

function Config_WriteBoolA(Config: AConfig; Section, Name: PAnsiChar; Value: ABool): AError;
begin
  try
    Result := ASettings_WriteBoolP(Config, AnsiString(Section), AnsiString(Name), Value);
  except
    Result := -1;
  end;
end;

function Config_WriteBoolP(Config: AConfig; const Section, Name: APascalString; Value: ABool): AError;
begin
  try
    Result := ASettings_WriteBoolP(Config, Section, Name, Value);
  except
    Result := -1;
  end;
end;

function Config_WriteBoolS(Config: AConfig; Section, Name: AString; Value: ABool): AError;
begin
  if Assigned(Section) and Assigned(Name) then
    Result := Config_WriteBool(Config, Section^, Name^, Value)
  else
    Result := -1;
end;

function Config_WriteBoolW(Config: AConfig; Section, Name: PWideChar; Value: ABool): AError;
begin
  try
    Result := ASettings_WriteBoolP(Config, WideString(Section), WideString(Name), Value);
  except
    Result := -1;
  end;
end;

function Config_WriteInteger(Config: AConfig; const Section, Name: AString_Type; Value: AInt): AError;
begin
  try
    Result := ASettings_WriteIntP(Config, AString_ToPascalString(Section), AString_ToPascalString(Name), Value);
  except
    Result := -1;
  end;
end;

function Config_WriteIntegerA(Config: AConfig; Section, Name: PAnsiChar; Value: AInt): AError;
begin
  try
    Result := ASettings_WriteIntP(Config, AnsiString(Section), AnsiString(Name), Value);
  except
    Result := -1;
  end;
end;

function Config_WriteIntegerP(Config: AConfig; const Section, Name: APascalString; Value: AInteger): AError; 
begin
  Result := ASettings_WriteIntegerP(Config, Section, Name, Value);
end;

function Config_WriteIntegerS(Config: AConfig; Section, Name: AString; Value: AInt): AError;
begin
  if Assigned(Section) and Assigned(Name) then
    Result := Config_WriteInteger(Config, Section^, Name^, Value)
  else
    Result := -1;
end;

function Config_WriteIntegerW(Config: AConfig; Section, Name: PWideChar; Value: AInt): AError;
begin
  try
    Result := ASettings_WriteIntP(Config, WideString(Section), WideString(Name), Value);
  except
    Result := -1;
  end;
end;

function Config_WriteFloat(Config: AConfig; const Section, Name: AString_Type; Value: AFloat): AError;
begin
  try
    Result := ASettings_WriteFloatP(Config, AString_ToPascalString(Section), AString_ToPascalString(Name), Value);
  except
    Result := -1;
  end;
end;

function Config_WriteFloatA(Config: AConfig; Section, Name: PAnsiChar; Value: AFloat): AError;
begin
  try
    Result := ASettings_WriteFloatP(Config, AnsiString(Section), AnsiString(Name), Value);
  except
    Result := -1;
  end;
end;

function Config_WriteFloatP(Config: AConfig; const Section, Name: APascalString; Value: AFloat): AError;
begin
  Result := ASettings_WriteFloatP(Config, Section, Name, Value);
end;

function Config_WriteFloatS(Config: AConfig; Section, Name: AString; Value: AFloat): AError;
begin
  if Assigned(Section) and Assigned(Name) then
    Result := Config_WriteFloat(Config, Section^, Name^, Value)
  else
    Result := -1;
end;

function Config_WriteFloatW(Config: AConfig; Section, Name: PWideChar; Value: AFloat): AError;
begin
  try
    Result := ASettings_WriteFloatP(Config, WideString(Section), WideString(Name), Value);
  except
    Result := -1;
  end;
end;

function Config_WriteString(Config: AConfig; const Section, Name, Value: AString_Type): AError;
begin
  try
    Result := ASettings_WriteStringP(
        Config,
        AString_ToPascalString(Section),
        AString_ToPascalString(Name),
        AString_ToPascalString(Value));
  except
    Result := -1;
  end;
end;

function Config_WriteStringA(Config: AConfig; Section, Name, Value: PAnsiChar): AError;
begin
  try
    Result := ASettings_WriteStringP(Config, AnsiString(Section), AnsiString(Name), AnsiString(Value));
  except
    Result := -1;
  end;
end;

function Config_WriteStringP(Config: AConfig; const Section, Name, Value: APascalString): AError;
begin
  try
    Result := ASettings_WriteStringP(Config, Section, Name, Value);
  except
    Result := -1;
  end;
end;

function Config_WriteStringS(Config: AConfig; Section, Name, Value: AString): AError;
begin
  if Assigned(Section) and Assigned(Name) and Assigned(Value) then
    Result := Config_WriteString(Config, Section^, Name^, Value^)
  else
    Result := -1;
end;

function Config_WriteStringW(Config: AConfig; Section, Name, Value: PWideChar): AError;
begin
  try
    Result := ASettings_WriteStringP(Config, WideString(Section), WideString(Name), WideString(Value));
  except
    Result := -1;
  end;
end;

function Config_WriteDateTime(Config: AConfig; const Section, Name: AString_Type; Value: TDateTime): AError;
begin
  try
    Result := ASettings_WriteDateTimeP(
        Config,
        AString_ToPascalString(Section),
        AString_ToPascalString(Name),
        Value);
  except
    Result := -1;
  end;
end;

function Config_WriteDateTimeA(Config: AConfig; Section, Name: PAnsiChar; Value: TDateTime): AError;
begin
  try
    Result := ASettings_WriteDateTimeP(Config, AnsiString(Section), AnsiString(Name), Value);
  except
    Result := -1;
  end;
end;

function Config_WriteDateTimeP(Config: AConfig; const Section, Name: APascalString; Value: TDateTime): AError;
begin
  try
    Result := ASettings_WriteDateTimeP(Config, Section, Name, Value);
  except
    Result := -1;
  end;
end;

function Config_WriteDateTimeS(Config: AConfig; Section, Name: AString; Value: TDateTime): AError;
begin
  if Assigned(Section) and Assigned(Name) then
    Result := Config_WriteDateTime(Config, Section^, Name^, Value)
  else
    Result := -1;
end;

function Config_WriteDateTimeW(Config: AConfig; Section, Name: PWideChar; Value: TDateTime): AError;
begin
  try
    Result := ASettings_WriteDateTimeP(Config, WideString(Section), WideString(Name), Value);
  except
    Result := -1;
  end;
end;

function Fin(): AError;
begin
  Result := 0;
end;

function IniConfig_New(const FileName: AString_Type): AConfig;
begin
  try
    Result := ASettings_IniConfig_NewP(AString_ToPascalString(FileName));
  except
    Result := 0;
  end;
end;

function IniConfig_NewA(FileName: PAnsiChar): AConfig;
begin
  try
    Result := ASettings_IniConfig_NewP(AnsiString(FileName));
  except
    Result := 0;
  end;
end;

function IniConfig_NewP(const FileName: APascalString): AConfig;
begin
  try
    Result := ASettings_IniConfig_NewP(FileName);
  except
    Result := 0;
  end;
end;

function IniConfig_NewS(FileName: AString): AConfig;
begin
  if Assigned(FileName) then
    Result := IniConfig_New(FileName^)
  else
    Result := 0;
end;

function IniConfig_NewW(FileName: PWideChar): AConfig;
begin
  try
    Result := ASettings_IniConfig_NewP(WideString(FileName));
  except
    Result := 0;
  end;
end;

function Init(): AError;
begin
  Result := ASettings_Init();
end;

function ReadBool(Config: AConfig; const Section, Name: APascalString; DefValue: ABool): ABool;
begin
  Result := ASettings_ReadBoolDefP(Config, Section, Name, DefValue);
end;

function ReadFloat(Config: AConfig; const Section, Name: APascalString; DefValue: AFloat): AFloat;
begin
  Result := ASettings_ReadFloatDefP(Config, Section, Name, DefValue);
end;

function ReadInteger(Config: AConfig; const Section, Name: APascalString; DefValue: AInt): AInt;
begin
  Result := ASettings_ReadIntDefP(Config, Section, Name, DefValue);
end;

function ReadString(Config: AConfig; const Section, Name, DefValue: APascalString): APascalString;
begin
  Result := ASettings_ReadStringDefP(Config, Section, Name, DefValue);
end;

function RegConfig_New(const Prefix: AString_Type): AConfig;
begin
  try
    Result := ASettings_NewRegConfigP(AString_ToPascalString(Prefix), 0);
  except
    Result := 0;
  end;
end;

function RegConfig_New2(const Prefix: AString_Type; Key: AInt): AConfig;
begin
  try
    Result := ASettings_NewRegConfigP(AString_ToPascalString(Prefix), Key);
  except
    Result := 0;
  end;
end;

function RegConfig_New2P(const Prefix: APascalString; Key: AInt): AConfig;
begin
  try
    Result := ASettings_NewRegConfigP(Prefix, Key);
  except
    Result := 0;
  end;
end;

function RegConfig_NewA(Prefix: PAnsiChar): AConfig;
begin
  try
    Result := ASettings_NewRegConfigP(AnsiString(Prefix), 0);
  except
    Result := 0;
  end;
end;

function RegConfig_NewP(const Prefix: APascalString): AConfig;
begin
  try
    Result := ASettings_NewRegConfigP(Prefix, 0);
  except
    Result := 0;
  end;
end;

function RegConfig_NewS(Prefix: AString): AConfig;
begin
  if Assigned(Prefix) then
    Result := ASettings_NewRegConfigP(Str_ToP(Prefix), 0)
  else
    Result := 0;
end;

function RegConfig_NewW(Prefix: PWideChar): AConfig;
begin
  try
    Result := ASettings_NewRegConfigP(WideString(Prefix), 0);
  except
    Result := 0;
  end;
end;

{ Write }

function WriteBool(Config: AConfig; const Section, Name: APascalString; Value: ABool): AError;
begin
  Result := ASettings_WriteBoolP(Config, Section, Name, Value);
end;

function WriteInteger(Config: AConfig; const Section, Name: APascalString; Value: AInt): AError;
begin
  Result := ASettings_WriteIntP(Config, Section, Name, Value);
end;

function WriteString(Config: AConfig; const Section, Name, Value: APascalString): AError;
begin
  Result := ASettings_WriteStringP(Config, Section, Name, Value);
end;

end.
