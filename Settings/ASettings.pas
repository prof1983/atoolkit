{**
@Abstract The module for work with the settings
@Author Prof1983 <prof1983@ya.ru>
@Created 06.03.2008
@LastMod 14.08.2012
}
unit ASettings;

interface

uses
  ABase, ACollectionsBase, ASettingsMain, AStrings;

// --- ASettings ---

function ASettings_WriteStringP(Config: AConfig; const Section, Name, Value: APascalString): AError; stdcall;

// ----

function Init(): AError; stdcall;
function Done(): AError; stdcall;

function Config_Close(Config: AConfig): AError; stdcall;
procedure Config_Close02(Config: AConfig); stdcall;

function Config_DeleteKey(Config: AConfig; const Section, Name: AString_Type): AError; stdcall;

function Config_DeleteKey02(Config: AConfig; const Section, Name: AWideString): ABoolean; stdcall;

function Config_DeleteKeyA(Config: AConfig; {const} Section, Name: PAnsiChar): AError; stdcall;

function Config_DeleteKeyP(Config: AConfig; const Section, Name: APascalString): AError; stdcall;

function Config_DeleteKeyS(Config: AConfig; {const} Section, Name: AString): AError; stdcall;

function Config_DeleteKeyW(Config: AConfig; {const} Section, Name: PWideChar): AError; stdcall;

function Config_DeleteKeyWS(Config: AConfig; const Section, Name: AWideString): AError; stdcall;

function Config_DeleteSection(Config: AConfig; const Section: AString_Type): AError; stdcall;

function Config_DeleteSection02(Config: AConfig; const Section: AWideString): ABoolean; stdcall;

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
function Config_ReadBoolDefWS(Config: AConfig; const Section, Name: AWideString; DefValue: ABoolean): ABoolean; stdcall;
function Config_ReadIntegerDef(Config: AConfig; const Section, Name: AString_Type; DefValue: AInteger): AInteger; stdcall;
function Config_ReadIntegerDefA(Config: AConfig; {const} Section, Name: PAnsiChar; DefValue: AInteger): AInteger; stdcall;
function Config_ReadIntegerDefP(Config: AConfig; const Section, Name: APascalString; DefValue: AInteger): AInteger; stdcall;
function Config_ReadIntegerDefS(Config: AConfig; {const} Section, Name: AString; DefValue: AInteger): AInteger; stdcall;
function Config_ReadIntegerDefW(Config: AConfig; {const} Section, Name: PWideChar; DefValue: AInteger): AInteger; stdcall;
function Config_ReadIntegerDefWS(Config: AConfig; const Section, Name: AWideString; DefValue: AInteger): AInteger; stdcall;
function Config_ReadFloatDef(Config: AConfig; const Section, Name: AString_Type; DefValue: AFloat): AFloat; stdcall;
function Config_ReadFloatDefA(Config: AConfig; {const} Section, Name: PAnsiChar; DefValue: AFloat): AFloat; stdcall;
function Config_ReadFloatDefP(Config: AConfig; const Section, Name: APascalString; DefValue: AFloat): AFloat; stdcall;
function Config_ReadFloatDefS(Config: AConfig; {const} Section, Name: AString; DefValue: AFloat): AFloat; stdcall;
function Config_ReadFloatDefW(Config: AConfig; {const} Section, Name: PWideChar; DefValue: AFloat): AFloat; stdcall;
function Config_ReadFloatDefWS(Config: AConfig; const Section, Name: AWideString; DefValue: AFloat): AFloat; stdcall;
function Config_ReadSection(Config: AConfig; const Section: AString_Type; Strings: AStringList): AError; stdcall;
function Config_ReadSectionA(Config: AConfig; {const} Section: PAnsiChar; Strings: AStringList): AError; stdcall;
function Config_ReadSectionP(Config: AConfig; const Section: APascalString; Strings: AStringList): AError; stdcall;
function Config_ReadSectionS(Config: AConfig; {const} Section: AString; Strings: AStringList): AError; stdcall;
function Config_ReadSectionW(Config: AConfig; {const} Section: PWideChar; Strings: AStringList): AError; stdcall;
function Config_ReadSectionWS(Config: AConfig; const Section: AWideString; Strings: AStringList): AError; stdcall;

function Config_ReadString(Config: AConfig; const Section, Name: AString_Type; out Value: AString_Type): AInteger; stdcall;
function Config_ReadStringA(Config: AConfig; {const} Section, Name: PAnsiChar; {out} Value: PAnsiChar; MaxLen: AInteger): AInteger; stdcall;
function Config_ReadStringP(Config: AConfig; const Section, Name: APascalString; out Value: APascalString): AInteger; stdcall;
function Config_ReadStringS(Config: AConfig; {const} Section, Name: AString; {out} Value: AString): AInteger; stdcall;
function Config_ReadStringW(Config: AConfig; {const} Section, Name: PWideChar; {out} Value: PWideChar; MaxLen: AInteger): AInteger; stdcall;
function Config_ReadStringWS(Config: AConfig; const Section, Name: AWideString; out Value: AWideString): AInteger; stdcall;

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
function Config_ReadStringDefWS(Config: AConfig; const Section, Name, DefValue: AWideString): AWideString; stdcall;

function Config_ReadDateTimeDef(Config: AConfig; const Section, Name: AString_Type; DefValue: TDateTime): TDateTime; stdcall;
function Config_ReadDateTimeDefA(Config: AConfig; {const} Section, Name: PAnsiChar; DefValue: TDateTime): TDateTime; stdcall;
function Config_ReadDateTimeDefP(Config: AConfig; const Section, Name: APascalString; DefValue: TDateTime): TDateTime; stdcall;
function Config_ReadDateTimeDefS(Config: AConfig; {const} Section, Name: AString; DefValue: TDateTime): TDateTime; stdcall;
function Config_ReadDateTimeDefW(Config: AConfig; {const} Section, Name: PWideChar; DefValue: TDateTime): TDateTime; stdcall;
function Config_ReadDateTimeDefWS(Config: AConfig; const Section, Name: AWideString; DefValue: TDateTime): TDateTime; stdcall;
function Config_WriteBool(Config: AConfig; const Section, Name: AString_Type; Value: ABoolean): AError; stdcall;
function Config_WriteBoolA(Config: AConfig; {const} Section, Name: PAnsiChar; Value: ABoolean): AError; stdcall;
function Config_WriteBoolP(Config: AConfig; const Section, Name: APascalString; Value: ABoolean): AError; stdcall;
function Config_WriteBoolS(Config: AConfig; {const} Section, Name: AString; Value: ABoolean): AError; stdcall;
function Config_WriteBoolW(Config: AConfig; {const} Section, Name: PWideChar; Value: ABoolean): AError; stdcall;
function Config_WriteBoolWS(Config: AConfig; const Section, Name: AWideString; Value: ABoolean): AError; stdcall;
function Config_WriteInteger(Config: AConfig; const Section, Name: AString_Type; Value: AInteger): AError; stdcall;
function Config_WriteIntegerA(Config: AConfig; {const} Section, Name: PAnsiChar; Value: AInteger): AError; stdcall;
function Config_WriteIntegerP(Config: AConfig; const Section, Name: APascalString; Value: AInteger): AError; stdcall;
function Config_WriteIntegerS(Config: AConfig; {const} Section, Name: AString; Value: AInteger): AError; stdcall;
function Config_WriteIntegerW(Config: AConfig; {const} Section, Name: PWideChar; Value: AInteger): AError; stdcall;
function Config_WriteIntegerWS(Config: AConfig; const Section, Name: AWideString; Value: AInteger): AError; stdcall;
function Config_WriteFloat(Config: AConfig; const Section, Name: AString_Type; Value: AFloat): AError; stdcall;
function Config_WriteFloatA(Config: AConfig; {const} Section, Name: PAnsiChar; Value: AFloat): AError; stdcall;
function Config_WriteFloatP(Config: AConfig; const Section, Name: APascalString; Value: AFloat): AError; stdcall;
function Config_WriteFloatS(Config: AConfig; {const} Section, Name: AString; Value: AFloat): AError; stdcall;
function Config_WriteFloatW(Config: AConfig; {const} Section, Name: PWideChar; Value: AFloat): AError; stdcall;
function Config_WriteFloatWS(Config: AConfig; const Section, Name: AWideString; Value: AFloat): AError; stdcall;
function Config_WriteString(Config: AConfig; const Section, Name, Value: AString_Type): AError; stdcall;
function Config_WriteStringA(Config: AConfig; {const} Section, Name, Value: PAnsiChar): AError; stdcall;
function Config_WriteStringP(Config: AConfig; const Section, Name, Value: APascalString): AError; stdcall;
function Config_WriteStringS(Config: AConfig; {const} Section, Name, Value: AString): AError; stdcall;
function Config_WriteStringW(Config: AConfig; {const} Section, Name, Value: PWideChar): AError; stdcall;
function Config_WriteStringWS(Config: AConfig; const Section, Name, Value: AWideString): AError; stdcall;
function Config_WriteDateTime(Config: AConfig; const Section, Name: AString_Type; Value: TDateTime): AError; stdcall;
function Config_WriteDateTimeA(Config: AConfig; {const} Section, Name: PAnsiChar; Value: TDateTime): AError; stdcall;
function Config_WriteDateTimeP(Config: AConfig; const Section, Name: APascalString; Value: TDateTime): AError; stdcall;
function Config_WriteDateTimeS(Config: AConfig; {const} Section, Name: AString; Value: TDateTime): AError; stdcall;
function Config_WriteDateTimeW(Config: AConfig; {const} Section, Name: PWideChar; Value: TDateTime): AError; stdcall;
function Config_WriteDateTimeWS(Config: AConfig; const Section, Name: AWideString; Value: TDateTime): AError; stdcall;

function IniConfig_New(const FileName: AString_Type): AConfig; stdcall;
function IniConfig_NewA({const} FileName: PAnsiChar): AConfig; stdcall;
function IniConfig_NewP(const FileName: APascalString): AConfig; stdcall;
function IniConfig_NewS({const} FileName: AString): AConfig; stdcall;
function IniConfig_NewW({const} FileName: PWideChar): AConfig; stdcall;
function IniConfig_NewWS(const FileName: AWideString): AConfig; stdcall;

function RegConfig_New(const Prefix: AString_Type): AConfig; stdcall;
function RegConfig_NewA({const} Prefix: PAnsiChar): AConfig; stdcall;
function RegConfig_NewP(const Prefix: APascalString): AConfig; stdcall;
function RegConfig_NewS({const} Prefix: AString): AConfig; stdcall;
function RegConfig_NewW({const} Prefix: PWideChar): AConfig; stdcall;
function RegConfig_NewWS(const Prefix: AWideString): AConfig; stdcall;

function RegConfig_New2(const Prefix: AString_Type; HKEY: Integer): AConfig; stdcall;
function RegConfig_New2P(const Prefix: APascalString; HKEY: Integer): AConfig; stdcall;
function RegConfig_New2WS(const Prefix: AWideString; HKEY: Integer): AConfig; stdcall;

function A_Settings_IniConfig_New(const FileName: AString_Type): AConfig; stdcall; deprecated;
function A_Settings_RegConfig_New(const Prefix: AString_Type): AConfig; stdcall; deprecated;
function A_Settings_RegConfig_NewA(const Prefix: AString_Type; HKEY: Integer): AConfig; stdcall; deprecated;

//procedure A_Settings_Config_Close(Config: AConfig); stdcall; deprecated;
function A_Settings_Config_DeleteKey(Config: AConfig; const Section, Name: AString_Type): ABoolean; stdcall; deprecated;
function A_Settings_Config_DeleteSection(Config: AConfig; const Section: AString_Type): ABoolean; stdcall; deprecated;
function A_Settings_Config_ReadBool(Config: AConfig; const Section, Name: AString_Type; DefValue: ABoolean): ABoolean; stdcall; deprecated; // Use ASettings_ReadBoolDef()
function A_Settings_Config_ReadInteger(Config: AConfig; const Section, Name: AString_Type; DefValue: AInteger): AInteger; stdcall; deprecated;
function A_Settings_Config_ReadFloat(Config: AConfig; const Section, Name: AString_Type; DefValue: AFloat): AFloat; stdcall; deprecated;
function A_Settings_Config_ReadSection(Config: AConfig; const Section: AString_Type; Strings: AStringList): ABoolean; stdcall; deprecated;
function A_Settings_Config_ReadString(Config: AConfig; const Section, Name, DefValue: AString_Type; out Value: AString_Type): AInteger; stdcall; deprecated;
function A_Settings_Config_ReadDateTime(Config: AConfig; const Section, Name: AString_Type; DefValue: TDateTime): TDateTime; stdcall; deprecated;
function A_Settings_Config_WriteBool(Config: AConfig; const Section, Name: AString_Type; Value: Boolean): ABoolean; stdcall; deprecated;
function A_Settings_Config_WriteInteger(Config: AConfig; const Section, Name: AString_Type; Value: Integer): ABoolean; stdcall; deprecated;
function A_Settings_Config_WriteFloat(Config: AConfig; const Section, Name: AString_Type; Value: AFloat): ABoolean; stdcall; deprecated;
function A_Settings_Config_WriteString(Config: AConfig; const Section, Name, Value: AString_Type): ABoolean; stdcall; deprecated;
function A_Settings_Config_WriteDateTime(Config: AConfig; const Section, Name: AString_Type; Value: TDateTime): ABoolean; stdcall; deprecated;

{ deprecated }

// Use Config_ReadBoolP()
function ReadBool(Config: AConfig; const Section, Name: APascalString; DefValue: ABoolean): ABoolean; stdcall; deprecated;
// Use Config_ReadFloatP()
//function ReadFloat(Config: AConfig; const Section, Name: APascalString; DefValue: AFloat): AFloat; stdcall; deprecated;
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

procedure Settings_Close02(Config: AConfig); stdcall;

//function Settings_DeleteKey(Config: AConfig; const Section, Name: APascalString): ABoolean; stdcall; deprecated;

function Settings_DeleteKey02(Config: AConfig; const Section, Name: APascalString): ABoolean; stdcall;

function Settings_DeleteSection02(Config: AConfig; const Section: APascalString): ABoolean; stdcall;

function Settings_ReadBool02(Config: AConfig; const Section, Name: APascalString; DefValue: ABoolean): ABoolean; stdcall;
function Settings_ReadInteger(Config: AConfig; const Section, Name: APascalString; DefValue: AInteger): AInteger; stdcall; deprecated;
function Settings_ReadInteger02(Config: AConfig; const Section, Name: APascalString; DefValue: AInteger): AInteger; stdcall;
function Settings_ReadFloat02(Config: AConfig; const Section, Name: APascalString; DefValue: AFloat): AFloat; stdcall;
function Settings_ReadSection02(Config: AConfig; const Section: APascalString; Strings: AStringList): ABoolean; stdcall;
function Settings_ReadString(Config: AConfig; const Section, Name, DefValue: APascalString): APascalString; stdcall;
{function Settings_ReadString(Config: AConfig; const Section, Name: APascalString; out Value: APascalString): AInteger; stdcall;
function Settings_ReadStringA(Config: AConfig; const Section, Name, DefValue: APascalString; out Value: APascalString): AInteger; stdcall;
function Settings_ReadStringDef(Config: AConfig; const Section, Name, DefValue: APascalString): APascalString; stdcall;
function Settings_ReadDateTime(Config: AConfig; const Section, Name: APascalString; DefValue: TDateTime): TDateTime; stdcall;}
function Settings_WriteBool02(Config: AConfig; const Section, Name: APascalString; Value: Boolean): ABoolean; stdcall;
function Settings_WriteInteger(Config: AConfig; const Section, Name: APascalString; Value: Integer): ABoolean; stdcall; deprecated;
function Settings_WriteInteger02(Config: AConfig; const Section, Name: APascalString; Value: Integer): ABoolean; stdcall;
function Settings_WriteFloat02(Config: AConfig; const Section, Name: APascalString; Value: AFloat): ABoolean; stdcall;
function Settings_WriteString(Config: AConfig; const Section, Name, Value: APascalString): ABoolean; stdcall; deprecated; // Use ASettigns_WriteStringP()
function Settings_WriteString02(Config: AConfig; const Section, Name, Value: APascalString): ABoolean; stdcall;
function Settings_WriteDateTime02(Config: AConfig; const Section, Name: APascalString; Value: TDateTime): ABoolean; stdcall;

implementation

uses
  ASettingsConfig;

// --- ASettings ---

function ASettings_WriteStringP(Config: AConfig; const Section, Name, Value: APascalString): AError;
begin
  Result := Config_WriteStringP(Config, Section, Name, Value);
end;

{ A_Settings }

{ Use Config_Close02().
procedure A_Settings_Config_Close(Config: AConfig); stdcall;
begin
  try
    Settings_Close(Config);
  except
  end;
end;}

function A_Settings_Config_DeleteKey(Config: AConfig; const Section, Name: AString_Type): ABoolean; stdcall;
begin
  try
    Result := Settings_DeleteKey(Config, AStrings.String_ToWideString(Section), AStrings.String_ToWideString(Name));
  except
    Result := False;
  end;
end;

function A_Settings_Config_DeleteSection(Config: AConfig; const Section: AString_Type): ABoolean; stdcall;
begin
  try
    Result := Settings_DeleteSection(Config, AStrings.String_ToWideString(Section));
  except
    Result := False;
  end;
end;

function A_Settings_Config_ReadBool(Config: AConfig; const Section, Name: AString_Type; DefValue: ABoolean): ABoolean; stdcall;
begin
  try
    Result := Settings_ReadBool(Config,
        AStrings.String_ToWideString(Section),
        AStrings.String_ToWideString(Name),
        DefValue);
  except
    Result := DefValue;
  end
end;

function A_Settings_Config_ReadDateTime(Config: AConfig; const Section, Name: AString_Type; DefValue: TDateTime): TDateTime; stdcall;
begin
  try
    Result := Settings_ReadDateTime(Config, AStrings.String_ToWideString(Section), AStrings.String_ToWideString(Name), DefValue);
  except
    Result := DefValue;
  end;
end;

function A_Settings_Config_ReadFloat(Config: AConfig; const Section, Name: AString_Type; DefValue: AFloat): AFloat; stdcall;
begin
  try
    Result := Settings_ReadFloat(Config, AStrings.String_ToWideString(Section), AStrings.String_ToWideString(Name), DefValue);
  except
    Result := DefValue;
  end;
end;

function A_Settings_Config_ReadInteger(Config: AConfig; const Section, Name: AString_Type; DefValue: AInteger): AInteger; stdcall;
begin
  try
    Result := Settings_ReadInteger(Config, AStrings.String_ToWideString(Section), AStrings.String_ToWideString(Name), DefValue);
  except
    Result := DefValue;
  end;
end;

function A_Settings_Config_ReadSection(Config: AConfig; const Section: AString_Type; Strings: AStringList): ABoolean; stdcall;
begin
  try
    Result := Settings_ReadSection(Config, AStrings.String_ToWideString(Section), Strings);
  except
    Result := False;
  end;
end;

function A_Settings_Config_ReadString(Config: AConfig; const Section, Name, DefValue: AString_Type; out Value: AString_Type): AInteger; stdcall;
var
  TmpValue: APascalString;
begin
  try
    Result := Settings_ReadStringA(Config,
        AStrings.String_ToWideString(Section),
        AStrings.String_ToWideString(Name),
        AStrings.String_ToWideString(DefValue),
        TmpValue);
    AStrings.String_AssignP(Value, TmpValue);
  except
    AStrings.String_Assign(Value, DefValue);
    Result := 0;
  end;
end;

function A_Settings_Config_WriteBool(Config: AConfig; const Section, Name: AString_Type; Value: ABoolean): ABoolean; stdcall;
begin
  try
    Result := Settings_WriteBool(Config, AStrings.String_ToWideString(Section), AStrings.String_ToWideString(Name), Value);
  except
    Result := False;
  end;
end;

function A_Settings_Config_WriteDateTime(Config: AConfig; const Section, Name: AString_Type; Value: TDateTime): ABoolean; stdcall;
begin
  try
    Result := Settings_WriteDateTime(Config,
        AStrings.String_ToWideString(Section),
        AStrings.String_ToWideString(Name),
        Value);
  except
    Result := False;
  end;
end;

function A_Settings_Config_WriteFloat(Config: AConfig; const Section, Name: AString_Type; Value: AFloat): ABoolean; stdcall;
begin
  try
    Result := Settings_WriteFloat(Config,
        AStrings.String_ToWideString(Section),
        AStrings.String_ToWideString(Name),
        Value);
  except
    Result := False;
  end;
end;

function A_Settings_Config_WriteInteger(Config: AConfig; const Section, Name: AString_Type; Value: AInteger): ABoolean; stdcall;
begin
  try
    Result := Settings_WriteInteger(Config,
        AStrings.String_ToWideString(Section),
        AStrings.String_ToWideString(Name),
        Value);
  except
    Result := False;
  end;
end;

function A_Settings_Config_WriteString(Config: AConfig; const Section, Name, Value: AString_Type): ABoolean; stdcall;
begin
  try
    Result := Settings_WriteString(Config,
        AStrings.String_ToWideString(Section),
        AStrings.String_ToWideString(Name),
        AStrings.String_ToWideString(Value));
  except
    Result := False;
  end;
end;

function A_Settings_IniConfig_New(const FileName: AString_Type): AConfig; stdcall;
begin
  try
    Result := Settings_IniConfig_New(AStrings.String_ToWideString(FileName));
  except
    Result := 0;
  end;
end;

function A_Settings_RegConfig_New(const Prefix: AString_Type): AConfig; stdcall;
begin
  try
    Result := Settings_RegConfig_New(AStrings.String_ToWideString(Prefix));
  except
    Result := 0;
  end;
end;

function A_Settings_RegConfig_NewA(const Prefix: AString_Type; HKEY: Integer): AConfig; stdcall;
begin
  try
    Result := Settings_RegConfig_NewA(AStrings.String_ToWideString(Prefix), HKEY);
  except
    Result := 0;
  end;
end;

{ Config }

function Config_Close(Config: AConfig): AError;
begin
  Result := ASettings_Close();
end;

procedure Config_Close02(Config: AConfig);
begin
  ASettings_Close(Config);
end;

function Config_DeleteKey(Config: AConfig; const Section, Name: AString_Type): AError; stdcall;
begin
  try
    if ASettingsConfig.Settings_DeleteKey(Config, AStrings.String_ToWideString(Section), AStrings.String_ToWideString(Name)) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_DeleteKey02(Config: AConfig; const Section, Name: AWideString): ABoolean; stdcall;
begin
  try
    Result := Settings_DeleteKey(Config, Section, Name);
  except
    Result := False;
  end;
end;

function Config_DeleteKeyA(Config: AConfig; {const} Section, Name: PAnsiChar): AError; stdcall;
begin
  try
    if ASettingsConfig.Settings_DeleteKey(Config, AnsiString(Section), AnsiString(Name)) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_DeleteKeyP(Config: AConfig; const Section, Name: APascalString): AError; stdcall;
begin
  try
    if ASettingsConfig.Settings_DeleteKey(Config, Section, Name) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_DeleteKeyS(Config: AConfig; {const} Section, Name: AString): AError; stdcall;
begin
  Result := Config_DeleteKey(Config, Section^, Name^);
end;

function Config_DeleteKeyW(Config: AConfig; {const} Section, Name: PWideChar): AError; stdcall;
begin
  Result := Config_DeleteKeyP(Config, WideString(Section), WideString(Name));
end;

function Config_DeleteKeyWS(Config: AConfig; const Section, Name: AWideString): AError; stdcall;
begin
  try
    if ASettingsConfig.Settings_DeleteKey(Config, Section, Name) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_DeleteSection(Config: AConfig; const Section: AString_Type): AError; stdcall;
begin
  try
    if Settings_DeleteSection(Config, AStrings.String_ToWideString(Section)) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_DeleteSection02(Config: AConfig; const Section: AWideString): ABoolean; stdcall;
begin
  try
    Result := Settings_DeleteSection(Config, Section);
  except
    Result := False;
  end;
end;

function Config_DeleteSectionA(Config: AConfig; {const} Section: PAnsiChar): AError; stdcall;
begin
  try
    if Settings_DeleteSection(Config, AnsiString(Section)) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_DeleteSectionP(Config: AConfig; const Section: APascalString): AError; stdcall;
begin
  try
    if Settings_DeleteSection(Config, Section) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_DeleteSectionS(Config: AConfig; {const} Section: AString): AError; stdcall;
begin
  Result := Config_DeleteSection(Config, Section^);
end;

function Config_DeleteSectionW(Config: AConfig; {const} Section: PWideChar): AError; stdcall;
begin
  try
    if Settings_DeleteSection(Config, WideString(Section)) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_ReadBoolDef(Config: AConfig; const Section, Name: AString_Type; DefValue: ABoolean): ABoolean; stdcall;
begin
  Result := ASettings_ReadBoolDef(Config, Section, Name, DefValue);
end;

function Config_ReadBoolDefA(Config: AConfig; {const} Section, Name: PAnsiChar; DefValue: ABoolean): ABoolean; stdcall;
begin
  Result := ASettings_ReadBoolDefP(Config, AnsiString(Section), AnsiString(Name), DefValue);
end;

function Config_ReadBoolDefP(Config: AConfig; const Section, Name: APascalString; DefValue: ABoolean): ABoolean; stdcall;
begin
  Result := ASettings_ReadBoolDefP(Config, Section, Name, DefValue);
end;

function Config_ReadBoolDefS(Config: AConfig; {const} Section, Name: AString; DefValue: ABoolean): ABoolean; stdcall;
begin
  Result := ASettings_ReadBoolDef(Config, Section^, Name^, DefValue);
end;

function Config_ReadBoolDefW(Config: AConfig; {const} Section, Name: PWideChar; DefValue: ABoolean): ABoolean; stdcall;
begin
  Result := ASettings_ReadBoolDefP(Config, WideString(Section), WideString(Name), DefValue);
end;

function Config_ReadBoolDefWS(Config: AConfig; const Section, Name: AWideString; DefValue: ABoolean): ABoolean; stdcall;
begin
  Result := ASettings_ReadBoolDefP(Config, Section, Name, DefValue);
end;

function Config_ReadIntegerDef(Config: AConfig; const Section, Name: AString_Type; DefValue: AInteger): AInteger; stdcall;
begin
  try
    Result := ASettingsConfig.Settings_ReadInteger(Config,
        AStrings.String_ToWideString(Section),
        AStrings.String_ToWideString(Name),
        DefValue);
  except
    Result := DefValue;
  end;
end;

function Config_ReadIntegerDefA(Config: AConfig; {const} Section, Name: PAnsiChar; DefValue: AInteger): AInteger; stdcall;
begin
  try
    Result := ASettingsConfig.Settings_ReadInteger(Config, AnsiString(Section), AnsiString(Name), DefValue);
  except
    Result := DefValue;
  end;
end;

function Config_ReadIntegerDefP(Config: AConfig; const Section, Name: APascalString; DefValue: AInteger): AInteger;
begin
  Result := ASettings_ReadIntegerDefP(Config, Section, Name, DefValue);
end;

function Config_ReadIntegerDefS(Config: AConfig; {const} Section, Name: AString; DefValue: AInteger): AInteger; stdcall;
begin
  Result := Config_ReadIntegerDef(Config, Section^, Name^, DefValue);
end;

function Config_ReadIntegerDefW(Config: AConfig; {const} Section, Name: PWideChar; DefValue: AInteger): AInteger; stdcall;
begin
  try
    Result := ASettingsConfig.Settings_ReadInteger(Config, WideString(Section), WideString(Name), DefValue);
  except
    Result := DefValue;
  end;
end;

function Config_ReadIntegerDefWS(Config: AConfig; const Section, Name: AWideString; DefValue: AInteger): AInteger; stdcall;
begin
  try
    Result := ASettingsConfig.Settings_ReadInteger(Config, Section, Name, DefValue);
  except
    Result := DefValue;
  end;
end;

function Config_ReadFloatDef(Config: AConfig; const Section, Name: AString_Type; DefValue: AFloat): AFloat; stdcall;
begin
  try
    Result := Settings_ReadFloat(Config,
        AStrings.String_ToWideString(Section),
        AStrings.String_ToWideString(Name),
        DefValue);
  except
    Result := DefValue;
  end;
end;

function Config_ReadFloatDefA(Config: AConfig; {const} Section, Name: PAnsiChar; DefValue: AFloat): AFloat; stdcall;
begin
  try
    Result := Settings_ReadFloat(Config, AnsiString(Section), AnsiString(Name), DefValue);
  except
    Result := DefValue;
  end;
end;

function Config_ReadFloatDefP(Config: AConfig; const Section, Name: APascalString; DefValue: AFloat): AFloat; stdcall;
begin
  try
    Result := Settings_ReadFloat(Config, Section, Name, DefValue);
  except
    Result := DefValue;
  end;
end;

function Config_ReadFloatDefS(Config: AConfig; {const} Section, Name: AString; DefValue: AFloat): AFloat; stdcall;
begin
  Result := Config_ReadFloatDef(Config, Section^, Name^, DefValue);
end;

function Config_ReadFloatDefW(Config: AConfig; {const} Section, Name: PWideChar; DefValue: AFloat): AFloat; stdcall;
begin
  try
    Result := Settings_ReadFloat(Config, WideString(Section), WideString(Name), DefValue);
  except
    Result := DefValue;
  end;
end;

function Config_ReadFloatDefWS(Config: AConfig; const Section, Name: AWideString; DefValue: AFloat): AFloat; stdcall;
begin
  try
    Result := Settings_ReadFloat(Config, Section, Name, DefValue);
  except
    Result := DefValue;
  end;
end;

function Config_ReadSection(Config: AConfig; const Section: AString_Type; Strings: AStringList): AError; stdcall;
begin
  try
    if Settings_ReadSection(Config, AStrings.String_ToWideString(Section), Strings) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_ReadSectionA(Config: AConfig; {const} Section: PAnsiChar; Strings: AStringList): AError; stdcall;
begin
  try
    if Settings_ReadSection(Config, AnsiChar(Section), Strings) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_ReadSectionP(Config: AConfig; const Section: APascalString; Strings: AStringList): AError; stdcall;
begin
  try
    if Settings_ReadSection(Config, Section, Strings) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_ReadSectionS(Config: AConfig; {const} Section: AString; Strings: AStringList): AError; stdcall;
begin
  Result := Config_ReadSection(Config, Section^, Strings);
end;

function Config_ReadSectionW(Config: AConfig; {const} Section: PWideChar; Strings: AStringList): AError; stdcall;
begin
  try
    if Settings_ReadSection(Config, WideString(Section), Strings) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_ReadSectionWS(Config: AConfig; const Section: AWideString; Strings: AStringList): AError; stdcall;
begin
  try
    if Settings_ReadSection(Config, Section, Strings) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_ReadString(Config: AConfig; const Section, Name: AString_Type; out Value: AString_Type): AInteger; stdcall;
var
  S: APascalString;
begin
  try
    Result := ASettingsConfig.Settings_ReadString(Config,
        AStrings.String_ToWideString(Section),
        AStrings.String_ToWideString(Name),
        S);
    if (Result >= 0) then
      Result := AStrings.String_AssignP(Value, S);
  except
    Result := -1;
  end;
end;

function Config_ReadStringA(Config: AConfig; {const} Section, Name: PAnsiChar; {out} Value: PAnsiChar; MaxLen: AInteger): AInteger; stdcall;
var
  S: APascalString;
begin
  try
    Result := ASettingsConfig.Settings_ReadString(Config, AnsiString(Section), AnsiString(Name), S);
    if (Result > 0) then
      AStrings.StrPLCopy(Value, AnsiString(S), MaxLen);
  except
    Result := -1;
  end;
end;

function Config_ReadStringDef(Config: AConfig; const Section, Name, DefValue: AString_Type;
    out Value: AString_Type): AInteger; stdcall;
var
  S: APascalString;
begin
  try
    S := Settings_ReadStringDef(Config,
        AStrings.String_ToPascalString(Section),
        AStrings.String_ToPascalString(Name),
        AStrings.String_ToPascalString(DefValue));
    Result := AStrings.String_AssignP(Value, S);
  except
    Result := -1;
  end;
end;

function Config_ReadStringDefA(Config: AConfig; {const} Section, Name, DefValue: PAnsiChar;
    {out} Value: PAnsiChar; MaxLen: AInteger): AInteger; stdcall;
var
  S: AnsiString;
begin
  try
    S := Settings_ReadStringDef(Config, AnsiString(Section), AnsiString(Name), AnsiString(DefValue));
    AStrings.StrPLCopy(Value, AnsiString(S), MaxLen);
    Result := Length(S);
  except
    Result := -1;
  end;
end;

function Config_ReadStringDefP(Config: AConfig; const Section, Name, DefValue: APascalString): APascalString; stdcall;
begin
  try
    Result := Settings_ReadStringDef(Config, Section, Name, DefValue);
  except
    Result := '';
  end;
end;

function Config_ReadStringDefS(Config: AConfig; {const} Section, Name, DefValue: AString; {out} Value: AString): AInteger; stdcall;
begin
  if Assigned(Section) and Assigned(Name) and Assigned(DefValue) and Assigned(Value) then
    Result := Config_ReadStringDef(Config, Section^, Name^, DefValue^, Value^)
  else
    Result := -1;
end;

function Config_ReadStringDefW(Config: AConfig; {const} Section, Name, DefValue: PWideChar;
    {out} Value: PWideChar; MaxLen: AInteger): AInteger; stdcall;
var
  S: WideString;
begin
  try
    S := Settings_ReadStringDef(Config, WideString(Section), WideString(Name), WideString(DefValue));
    Result := Length(S);
    AStrings.StrCopyLWP(Value, S, MaxLen)
  except
    Result := -1;
  end;
end;

function Config_ReadStringDefWS(Config: AConfig; const Section, Name, DefValue: AWideString): AWideString; stdcall;
begin
  try
    Result := Settings_ReadStringDef(Config, Section, Name, DefValue);
  except
    Result := '';
  end;
end;

function Config_ReadStringP(Config: AConfig; const Section, Name: APascalString; out Value: APascalString): AInteger; stdcall;
begin
  try
    Result := ASettingsConfig.Settings_ReadString(Config, Section, Name, Value);
  except
    Result := -1;
  end;
end;

function Config_ReadStringS(Config: AConfig; {const} Section, Name: AString; {out} Value: AString): AInteger; stdcall;
begin
  if Assigned(Section) and Assigned(Name) and Assigned(Value) then
    Result := Config_ReadString(Config, Section^, Name^, Value^)
  else
    Result := -1;
end;

function Config_ReadStringW(Config: AConfig; {const} Section, Name: PWideChar;
    {out} Value: PWideChar; MaxLen: AInteger): AInteger; stdcall;
var
  S: APascalString;
begin
  try
    Result := ASettingsConfig.Settings_ReadString(Config, WideString(Section), WideString(Name), S);
    if (Result > 0) then
      AStrings.StrCopyLWP(Value, S, MaxLen);
  except
    Result := -1;
  end;
end;

function Config_ReadStringWS(Config: AConfig; const Section, Name: AWideString; out Value: AWideString): AInteger; stdcall;
var
  S: APascalString;
begin
  try
    S := Value;
    Result := ASettingsConfig.Settings_ReadString(Config, Section, Name, S);
    Value := S;
  except
    Result := -1;
  end;
end;

function Config_ReadDateTimeDef(Config: AConfig; const Section, Name: AString_Type; DefValue: TDateTime): TDateTime; stdcall;
begin
  try
    Result := Settings_ReadDateTime(Config,
        AStrings.String_ToPascalString(Section),
        AStrings.String_ToPascalString(Name),
        DefValue);
  except
    Result := DefValue;
  end;
end;

function Config_ReadDateTimeDefA(Config: AConfig; {const} Section, Name: PAnsiChar; DefValue: TDateTime): TDateTime; stdcall;
begin
  try
    Result := Settings_ReadDateTime(Config, AnsiString(Section), AnsiString(Name), DefValue);
  except
    Result := DefValue;
  end;
end;

function Config_ReadDateTimeDefP(Config: AConfig; const Section, Name: APascalString; DefValue: TDateTime): TDateTime; stdcall;
begin
  try
    Result := Settings_ReadDateTime(Config, Section, Name, DefValue);
  except
    Result := DefValue;
  end;
end;

function Config_ReadDateTimeDefS(Config: AConfig; {const} Section, Name: AString; DefValue: TDateTime): TDateTime; stdcall;
begin
  if Assigned(Section) and Assigned(Name) then
    Result := Config_ReadDateTimeDef(Config, Section^, Name^, DefValue)
  else
    Result := DefValue;
end;

function Config_ReadDateTimeDefW(Config: AConfig; {const} Section, Name: PWideChar; DefValue: TDateTime): TDateTime; stdcall;
begin
  try
    Result := Settings_ReadDateTime(Config, WideString(Section), WideString(Name), DefValue);
  except
    Result := DefValue;
  end;
end;

function Config_ReadDateTimeDefWS(Config: AConfig; const Section, Name: AWideString; DefValue: TDateTime): TDateTime; stdcall;
begin
  try
    Result := Settings_ReadDateTime(Config, Section, Name, DefValue);
  except
    Result := DefValue;
  end;
end;

function Config_WriteBool(Config: AConfig; const Section, Name: AString_Type; Value: ABoolean): AError; stdcall;
begin
  try
    if Settings_WriteBool(Config,
        AStrings.String_ToPascalString(Section),
        AStrings.String_ToPascalString(Name),
        Value) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_WriteBoolA(Config: AConfig; {const} Section, Name: PAnsiChar; Value: ABoolean): AError; stdcall;
begin
  try
    if Settings_WriteBool(Config, AnsiString(Section), AnsiString(Name), Value) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_WriteBoolP(Config: AConfig; const Section, Name: APascalString; Value: ABoolean): AError; stdcall;
begin
  try
    if Settings_WriteBool(Config, Section, Name, Value) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_WriteBoolS(Config: AConfig; {const} Section, Name: AString; Value: ABoolean): AError; stdcall;
begin
  if Assigned(Section) and Assigned(Name) then
    Result := Config_WriteBool(Config, Section^, Name^, Value)
  else
    Result := -1;
end;

function Config_WriteBoolW(Config: AConfig; {const} Section, Name: PWideChar; Value: ABoolean): AError; stdcall;
begin
  try
    if Settings_WriteBool(Config, WideString(Section), WideString(Name), Value) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_WriteBoolWS(Config: AConfig; const Section, Name: AWideString; Value: ABoolean): AError; stdcall;
begin
  try
    if Settings_WriteBool(Config, Section, Name, Value) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_WriteInteger(Config: AConfig; const Section, Name: AString_Type; Value: AInteger): AError; stdcall;
begin
  try
    if ASettingsConfig.Settings_WriteInteger(Config, AStrings.String_ToPascalString(Section), AStrings.String_ToPascalString(Name), Value) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_WriteIntegerA(Config: AConfig; {const} Section, Name: PAnsiChar; Value: AInteger): AError; stdcall;
begin
  try
    if ASettingsConfig.Settings_WriteInteger(Config, AnsiString(Section), AnsiString(Name), Value) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_WriteIntegerP(Config: AConfig; const Section, Name: APascalString; Value: AInteger): AError; 
begin
  Result := ASettings_WriteIntegerP(Config, Section, Name, Value);
end;

function Config_WriteIntegerS(Config: AConfig; {const} Section, Name: AString; Value: AInteger): AError; stdcall;
begin
  if Assigned(Section) and Assigned(Name) then
    Result := Config_WriteInteger(Config, Section^, Name^, Value)
  else
    Result := -1;
end;

function Config_WriteIntegerW(Config: AConfig; {const} Section, Name: PWideChar; Value: AInteger): AError; stdcall;
begin
  try
    if ASettingsConfig.Settings_WriteInteger(Config, WideString(Section), WideString(Name), Value) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_WriteIntegerWS(Config: AConfig; const Section, Name: AWideString; Value: AInteger): AError; stdcall;
begin
  try
    if ASettingsConfig.Settings_WriteInteger(Config, Section, Name, Value) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_WriteFloat(Config: AConfig; const Section, Name: AString_Type; Value: AFloat): AError; stdcall;
begin
  try
    if Settings_WriteFloat(Config, AStrings.String_ToPascalString(Section), AStrings.String_ToPascalString(Name), Value) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_WriteFloatA(Config: AConfig; {const} Section, Name: PAnsiChar; Value: AFloat): AError; stdcall;
begin
  try
    if Settings_WriteFloat(Config, AnsiString(Section), AnsiString(Name), Value) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_WriteFloatP(Config: AConfig; const Section, Name: APascalString; Value: AFloat): AError; stdcall;
begin
  try
    if Settings_WriteFloat(Config, Section, Name, Value) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_WriteFloatS(Config: AConfig; {const} Section, Name: AString; Value: AFloat): AError; stdcall;
begin
  if Assigned(Section) and Assigned(Name) then
    Result := Config_WriteFloat(Config, Section^, Name^, Value)
  else
    Result := -1;
end;

function Config_WriteFloatW(Config: AConfig; {const} Section, Name: PWideChar; Value: AFloat): AError; stdcall;
begin
  try
    if Settings_WriteFloat(Config, WideString(Section), WideString(Name), Value) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_WriteFloatWS(Config: AConfig; const Section, Name: AWideString; Value: AFloat): AError; stdcall;
begin
  try
    if Settings_WriteFloat(Config, Section, Name, Value) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_WriteString(Config: AConfig; const Section, Name, Value: AString_Type): AError; stdcall;
begin
  try
    if ASettingsConfig.Settings_WriteString(Config,
        AStrings.String_ToPascalString(Section),
        AStrings.String_ToPascalString(Name),
        AStrings.String_ToPascalString(Value)) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_WriteStringA(Config: AConfig; {const} Section, Name, Value: PAnsiChar): AError; stdcall;
begin
  try
    if ASettingsConfig.Settings_WriteString(Config, AnsiString(Section), AnsiString(Name), AnsiString(Value)) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_WriteStringP(Config: AConfig; const Section, Name, Value: APascalString): AError; stdcall;
begin
  try
    if ASettingsConfig.Settings_WriteString(Config, Section, Name, Value) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_WriteStringS(Config: AConfig; {const} Section, Name, Value: AString): AError; stdcall;
begin
  if Assigned(Section) and Assigned(Name) and Assigned(Value) then
    Result := Config_WriteString(Config, Section^, Name^, Value^)
  else
    Result := -1;
end;

function Config_WriteStringW(Config: AConfig; {const} Section, Name, Value: PWideChar): AError; stdcall;
begin
  try
    if ASettingsConfig.Settings_WriteString(Config, WideString(Section), WideString(Name), WideString(Value)) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_WriteStringWS(Config: AConfig; const Section, Name, Value: AWideString): AError; stdcall;
begin
  try
    if ASettingsConfig.Settings_WriteString(Config, Section, Name, Value) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_WriteDateTime(Config: AConfig; const Section, Name: AString_Type; Value: TDateTime): AError; stdcall;
begin
  try
    if Settings_WriteDateTime(Config,
        AStrings.String_ToPascalString(Section),
        AStrings.String_ToPascalString(Name),
        Value) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_WriteDateTimeA(Config: AConfig; {const} Section, Name: PAnsiChar; Value: TDateTime): AError; stdcall;
begin
  try
    if Settings_WriteDateTime(Config, AnsiString(Section), AnsiString(Name), Value) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_WriteDateTimeP(Config: AConfig; const Section, Name: APascalString; Value: TDateTime): AError; stdcall;
begin
  try
    if Settings_WriteDateTime(Config, Section, Name, Value) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_WriteDateTimeS(Config: AConfig; {const} Section, Name: AString; Value: TDateTime): AError; stdcall;
begin
  if Assigned(Section) and Assigned(Name) then
    Result := Config_WriteDateTime(Config, Section^, Name^, Value)
  else
    Result := -1;
end;

function Config_WriteDateTimeW(Config: AConfig; {const} Section, Name: PWideChar; Value: TDateTime): AError; stdcall;
begin
  try
    if Settings_WriteDateTime(Config, WideString(Section), WideString(Name), Value) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Config_WriteDateTimeWS(Config: AConfig; const Section, Name: AWideString; Value: TDateTime): AError; stdcall;
begin
  try
    if Settings_WriteDateTime(Config, Section, Name, Value) then
      Result := 0
    else
      Result := -1;
  except
    Result := -1;
  end;
end;

function Done(): AError; stdcall;
begin
  Result := 0;
end;

function IniConfig_New(const FileName: AString_Type): AConfig; stdcall;
begin
  try
    Result := Settings_IniConfig_New(AStrings.String_ToPascalString(FileName));
  except
    Result := 0;
  end;
end;

function IniConfig_NewA({const} FileName: PAnsiChar): AConfig; stdcall;
begin
  try
    Result := Settings_IniConfig_New(AnsiString(FileName));
  except
    Result := 0;
  end;
end;

function IniConfig_NewP(const FileName: APascalString): AConfig; stdcall;
begin
  try
    Result := Settings_IniConfig_New(FileName);
  except
    Result := 0;
  end;
end;

function IniConfig_NewS({const} FileName: AString): AConfig; stdcall;
begin
  if Assigned(FileName) then
    Result := IniConfig_New(FileName^)
  else
    Result := 0;
end;

function IniConfig_NewW({const} FileName: PWideChar): AConfig; stdcall;
begin
  try
    Result := Settings_IniConfig_New(WideString(FileName));
  except
    Result := 0;
  end;
end;

function IniConfig_NewWS(const FileName: AWideString): AConfig; stdcall;
begin
  try
    Result := Settings_IniConfig_New(FileName);
  except
    Result := 0;
  end;
end;

function Init(): AError; stdcall;
begin
  Result := 0;
end;

function ReadBool(Config: AConfig; const Section, Name: APascalString; DefValue: ABoolean): ABoolean; stdcall;
begin
  Result := Settings_ReadBool(Config, Section, Name, DefValue);
end;

function ReadFloat(Config: AConfig; const Section, Name: APascalString; DefValue: AFloat): AFloat; stdcall;
begin
  Result := Settings_ReadFloat(Config, Section, Name, DefValue);
end;

function ReadInteger(Config: AConfig; const Section, Name: APascalString; DefValue: AInteger): AInteger; stdcall;
begin
  Result := Settings_ReadInteger(Config, Section, Name, DefValue);
end;

function ReadString(Config: AConfig; const Section, Name, DefValue: APascalString): APascalString; stdcall;
begin
  Result := Config_ReadStringDefP(Config, Section, Name, DefValue);
end;
{function ReadString(Config: AConfig; const Section, Name: APascalString; out Value: APascalString): AInteger; stdcall;
begin
  Result := Config_ReadStringP(Config, Section, Name, Value);
end;}

function RegConfig_New(const Prefix: AString_Type): AConfig; stdcall;
begin
  try
    Result := Settings_RegConfig_New(AStrings.String_ToPascalString(Prefix));
  except
    Result := 0;
  end;
end;

function RegConfig_New2(const Prefix: AString_Type; HKEY: Integer): AConfig; stdcall;
begin
  try
    Result := Settings_RegConfig_NewA(AStrings.String_ToWideString(Prefix), HKEY);
  except
    Result := 0;
  end;
end;

function RegConfig_New2P(const Prefix: APascalString; HKEY: Integer): AConfig; stdcall;
begin
  try
    Result := Settings_RegConfig_NewA(Prefix, HKEY);
  except
    Result := 0;
  end;
end;

function RegConfig_New2WS(const Prefix: AWideString; HKEY: Integer): AConfig; stdcall;
begin
  try
    Result := Settings_RegConfig_NewA(Prefix, HKEY);
  except
    Result := 0;
  end;
end;

function RegConfig_NewA({const} Prefix: PAnsiChar): AConfig; stdcall;
begin
  try
    Result := Settings_RegConfig_New(AnsiString(Prefix));
  except
    Result := 0;
  end;
end;

function RegConfig_NewP(const Prefix: APascalString): AConfig; stdcall;
begin
  try
    Result := Settings_RegConfig_New(Prefix);
  except
    Result := 0;
  end;
end;

function RegConfig_NewS({const} Prefix: AString): AConfig; stdcall;
begin
  if Assigned(Prefix) then
    Result := RegConfig_New(Prefix^)
  else
    Result := 0;
end;

function RegConfig_NewW({const} Prefix: PWideChar): AConfig; stdcall;
begin
  try
    Result := Settings_RegConfig_New(WideString(Prefix));
  except
    Result := 0;
  end;
end;

function RegConfig_NewWS(const Prefix: AWideString): AConfig; stdcall;
begin
  try
    Result := Settings_RegConfig_New(Prefix);
  except
    Result := 0;
  end;
end;

{ Settings }

procedure Settings_Close02(Config: AConfig); stdcall;
begin
  Config_Close(Config);
end;

{
function Settings_DeleteKey(Config: AConfig; const Section, Name: APascalString): ABoolean; stdcall;
begin
  if (Config_DeleteKeyP(Config, Section, Name) >= 0) then
    Result := True
  else
    Result := False;
end;
}

function Settings_DeleteKey02(Config: AConfig; const Section, Name: APascalString): ABoolean; stdcall;
begin
  if (Config_DeleteKeyP(Config, Section, Name) >= 0) then
    Result := True
  else
    Result := False;
end;

function Settings_DeleteSection02(Config: AConfig; const Section: APascalString): ABoolean; stdcall;
begin
  if (Config_DeleteSectionP(Config, Section) >= 0) then
    Result := True
  else
    Result := False;
end;

function Settings_IniConfig_New02(const FileName: APascalString): AConfig; stdcall;
begin
  Result := IniConfig_NewP(FileName)
end;

function Settings_ReadBool02(Config: AConfig; const Section, Name: APascalString; DefValue: ABoolean): ABoolean; stdcall;
begin
  Result := Config_ReadBoolDefP(Config, Section, Name, DefValue);
end;

function Settings_ReadInteger(Config: AConfig; const Section, Name: APascalString; DefValue: AInteger): AInteger; stdcall;
begin
  Result := Config_ReadIntegerDefP(Config, Section, Name, DefValue);
end;

function Settings_ReadInteger02(Config: AConfig; const Section, Name: APascalString; DefValue: AInteger): AInteger; stdcall;
begin
  Result := Config_ReadIntegerDefP(Config, Section, Name, DefValue);
end;

function Settings_ReadFloat02(Config: AConfig; const Section, Name: APascalString; DefValue: AFloat): AFloat; stdcall;
begin
  Result := Config_ReadFloatDefP(Config, Section, Name, DefValue);
end;

function Settings_ReadSection02(Config: AConfig; const Section: APascalString; Strings: AStringList): ABoolean; stdcall;
begin
  if (Config_ReadSectionP(Config, Section, Strings) >= 0) then
    Result := True
  else
    Result := False;
end;

function Settings_ReadString(Config: AConfig; const Section, Name, DefValue: APascalString): APascalString; stdcall;
begin
  try
    Result := ASettingsConfig.Settings_ReadStringDef(Config, Section, Name, DefValue);
  except
    Result := '';
  end;
end;

{function Settings_ReadString(Config: AConfig; const Section, Name: APascalString; out Value: APascalString): AInteger; stdcall;
begin
  ...
end;

function Settings_ReadStringA(Config: AConfig; const Section, Name, DefValue: APascalString; out Value: APascalString): AInteger; stdcall;
begin
  ...
end;}

{function Settings_ReadStringDef(Config: AConfig; const Section, Name, DefValue: APascalString): APascalString; stdcall;
begin
  Result := Config_ReadStringDefP(Config, Section, Name, DefValue);
end;}

{
function Settings_ReadDateTime(Config: AConfig; const Section, Name: APascalString; DefValue: TDateTime): TDateTime; stdcall;
begin
  ...
end;

function Settings_RegConfig_New(const Prefix: APascalString): AConfig; stdcall;
begin
  ...
end;

function Settings_RegConfig_NewA(const Prefix: APascalString; HKEY: Integer): AConfig; stdcall;
begin
  ...
end;
}

function Settings_WriteBool02(Config: AConfig; const Section, Name: APascalString; Value: Boolean): ABoolean; stdcall;
begin
  if (Config_WriteBoolP(Config, Section, Name, Value) >= 0) then
    Result := True
  else
    Result := False;
end;

function Settings_WriteInteger(Config: AConfig; const Section, Name: APascalString; Value: Integer): ABoolean; stdcall;
begin
  if (Config_WriteIntegerP(Config, Section, Name, Value) >= 0) then
    Result := True
  else
    Result := False;
end;

function Settings_WriteInteger02(Config: AConfig; const Section, Name: APascalString; Value: Integer): ABoolean; stdcall;
begin
  if (Config_WriteIntegerP(Config, Section, Name, Value) >= 0) then
    Result := True
  else
    Result := False;
end;

function Settings_WriteFloat02(Config: AConfig; const Section, Name: APascalString; Value: AFloat): ABoolean; stdcall;
begin
  if (Config_WriteFloatP(Config, Section, Name, Value) >= 0) then
    Result := True
  else
    Result := False;
end;

function Settings_WriteString(Config: AConfig; const Section, Name, Value: APascalString): ABoolean; stdcall;
begin
  if (Config_WriteStringP(Config, Section, Name, Value) >= 0) then
    Result := True
  else
    Result := False;
end;

function Settings_WriteString02(Config: AConfig; const Section, Name, Value: APascalString): ABoolean; stdcall;
begin
  if (Config_WriteStringP(Config, Section, Name, Value) >= 0) then
    Result := True
  else
    Result := False;
end;

function Settings_WriteDateTime02(Config: AConfig; const Section, Name: APascalString; Value: TDateTime): ABoolean; stdcall;
begin
  if (Config_WriteDateTimeP(Config, Section, Name, Value) >= 0) then
    Result := True
  else
    Result := False;
end;

{ Write }

function WriteBool(Config: AConfig; const Section, Name: APascalString; Value: ABoolean): AError; stdcall;
begin
  if Settings_WriteBool(Config, Section, Name, Value) then
    Result := 0
  else
    Result := -1;
end;

function WriteInteger(Config: AConfig; const Section, Name: APascalString; Value: AInteger): AError; stdcall;
begin
  if Settings_WriteInteger(Config, Section, Name, Value) then
    Result := 0
  else
    Result := -1;
end;

function WriteString(Config: AConfig; const Section, Name, Value: APascalString): AError; stdcall;
begin
  if Settings_WriteString(Config, Section, Name, Value) then
    Result := 0
  else
    Result := -1;
end;

end.
