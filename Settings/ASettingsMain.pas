{**
@Abstract ASettings main functions
@Author Prof1983 <prof1983@ya.ru>
@Created 13.08.2012
@LastMod 02.04.2013
}
unit ASettingsMain;

{$I A.inc}

{define AStdCall}
{define ASettings_Old}

{$ifndef NoXmlNode}
  {$define UseXmlNode}
{$endif}

interface

uses
  SysUtils,
  {$ifdef ASettings_Old}
  AAbstractSettings,
  {$endif}
  ABase,
  ABaseTypes,
  {$ifdef UseXmlNode}AConfigUtils,{$endif}
  AObjects,
  ASettingsTypes,
  AStringBaseUtils,
  AStringMain;

// --- ASettings ---

function ASettings_Close(Settings: ASettings): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_DeleteKey(Settings: ASettings; const Section, Name: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

{ Section, Name - const }
function ASettings_DeleteKeyA(Settings: ASettings; Section, Name: AStr): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_DeleteKeyP(Settings: ASettings; const Section, Name: APascalString): AError;

function ASettings_DeleteSection(Settings: ASettings; const Section: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

{ Section - const }
function ASettings_DeleteSectionA(Settings: ASettings; Section: AStr): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_DeleteSectionP(Settings: ASettings; const Section: APascalString): AError;

function ASettings_Fin(): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_Init(): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_New(Control: ASettings_Interface): ASettings; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_ReadBoolDef(Settings: ASettings; const Section, Name: AString_Type;
    DefValue: ABool): ABool; {$ifdef AStdCall}stdcall;{$endif}

{ Section, Name - const }
function ASettings_ReadBoolDefA(Settings: ASettings; Section, Name: AStr; DefValue: ABool): ABool; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_ReadBoolDefP(Settings: ASettings; const Section, Name: APascalString;
    DefValue: ABool): ABool;

function ASettings_ReadDateTimeDef(Settings: ASettings; const Section, Name: AString_Type;
    DefValue: TDateTime): TDateTime; {$ifdef AStdCall}stdcall;{$endif}

{ Section, Name - const }
function ASettings_ReadDateTimeDefA(Settings: ASettings; Section, Name: AStr;
    DefValue: TDateTime): TDateTime; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_ReadDateTimeDefP(Settings: ASettings; const Section, Name: APascalString;
    DefValue: TDateTime): TDateTime;

function ASettings_ReadFloatDef(Settings: ASettings; const Section, Name: AString_Type;
    DefValue: AFloat): AFloat; {$ifdef AStdCall}stdcall;{$endif}

{ Section, Name - const }
function ASettings_ReadFloatDefA(Settings: ASettings; Section, Name: AStr;
    DefValue: AFloat): AFloat; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_ReadFloatDefP(Settings: ASettings; const Section, Name: APascalString;
    DefValue: AFloat): AFloat;

function ASettings_ReadIntDef(Settings: ASettings; const Section, Name: AString_Type;
    DefValue: AInt): AInt; {$ifdef AStdCall}stdcall;{$endif}

{ Section - const
  Name - const }
function ASettings_ReadIntDefA(Settings: ASettings; Section, Name: AStr; DefValue: AInt): AInt; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_ReadIntDefP(Settings: ASettings; const Section, Name: APascalString;
    DefValue: AInt): AInt;

function ASettings_ReadIntegerDefP(Settings: ASettings; const Section, Name: APascalString;
    DefValue: AInt): AInt;

function ASettings_ReadSection(Settings: ASettings; const Section: AString_Type;
    Strings: AStringList): AError; {$ifdef AStdCall}stdcall;{$endif}

{ Section - const }
function ASettings_ReadSectionA(Settings: ASettings; Section: AStr; Strings: AStringList): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_ReadSectionP(Settings: ASettings; const Section: APascalString;
    Strings: AStringList): AError;

function ASettings_ReadString(Settings: ASettings; const Section, Name: AString_Type;
    out Value: AString_Type): AInt; {$ifdef AStdCall}stdcall;{$endif}

{ Section - const
  Name - const
  Value - out}
function ASettings_ReadStringA(Settings: ASettings; Section, Name: AStr;
    Value: AStr; MaxLen: AInt): AInt; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_ReadStringDef(Settings: ASettings; const Section, Name, DefValue: AString_Type;
    out Value: AString_Type): AInt; {$ifdef AStdCall}stdcall;{$endif}

{ Section - const
  Name - const
  DefValue - const
  Value - out}
function ASettings_ReadStringDefA(Settings: ASettings; Section, Name, DefValue: AStr;
    Value: AStr; MaxLen: AInt): AInt; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_ReadStringDefP(Settings: ASettings; const Section, Name,
    DefValue: APascalString): APascalString;

function ASettings_ReadStringP(Settings: ASettings; const Section, Name: APascalString;
    out Value: APascalString): AInt;

function ASettings_WriteBool(Settings: ASettings; const Section, Name: AString_Type;
    Value: ABool): AError; {$ifdef AStdCall}stdcall;{$endif}

{ Section, Name - const }
function ASettings_WriteBoolA(Settings: ASettings; Section, Name: AStr; Value: ABool): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_WriteBoolP(Settings: ASettings; const Section, Name: APascalString;
    Value: ABoolean): AError;

function ASettings_WriteDateTime(Settings: ASettings; const Section, Name: AString_Type;
    Value: TDateTime): AError; {$ifdef AStdCall}stdcall;{$endif}

{ Section, Name - const }
function ASettings_WriteDateTimeA(Settings: ASettings; Section, Name: AStr;
    Value: TDateTime): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_WriteDateTimeP(Settings: ASettings; const Section, Name: APascalString;
    Value: TDateTime): AError;

function ASettings_WriteFloat(Settings: ASettings; const Section, Name: AString_Type;
    Value: AFloat): AError; {$ifdef AStdCall}stdcall;{$endif}

{ Section, Name - const }
function ASettings_WriteFloatA(Settings: ASettings; Section, Name: AStr; Value: AFloat): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_WriteFloatP(Settings: ASettings; const Section, Name: APascalString;
    Value: AFloat): AError;

function ASettings_WriteInt(Settings: ASettings; const Section, Name: AString_Type;
    Value: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

{ Section, Name - const }
function ASettings_WriteIntA(Settings: ASettings; Section, Name: AStr; Value: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_WriteIntP(Settings: ASettings; const Section, Name: APascalString;
    Value: AInt): AError;

function ASettings_WriteIntegerP(Settings: ASettings; const Section, Name: APascalString;
    Value: AInt): AError;

function ASettings_WriteString(Settings: ASettings; const Section, Name,
    Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

{ Section, Name, Value - const }
function ASettings_WriteStringA(Settings: ASettings; Section, Name, Value: AStr): AError; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_WriteStringP(Settings: ASettings; const Section, Name,
    Value: APascalString): AError;

implementation

var
  _Settings: array of ASettings_Type;

// --- ASettings ---

function ASettings_Close(Settings: ASettings): AError;
begin
  if (Settings = 0) then
  begin
    Result := -2;
    Exit;
  end;
  if AObject_Assigned(Settings) then
  begin
    Result := PSettings(Settings)^.Control.Close(Settings);
    Exit;
  end;
  {$ifdef ASettings_Old}
  if not(TObject(Settings) is TAbstractSettings) then
  begin
    Result := -3;
    Exit;
  end;
  try
    TAbstractSettings(Settings).Close();
    Result := 0;
  except
    Result := -1;
  end;
  {$else}
  Result := -1;
  {$endif}
end;

function ASettings_DeleteKey(Settings: ASettings; const Section, Name: AString_Type): AError;
begin
  if AObject_Assigned(Settings) then
  begin
    Result := PSettings(Settings)^.Control.DeleteKey(Settings, Section, Name);
    Exit;
  end;
  Result := ASettings_DeleteKeyP(Settings, AString_ToPascalString(Section), AString_ToPascalString(Name));
end;

function ASettings_DeleteKeyA(Settings: ASettings; Section, Name: AStr): AError;
begin
  Result := ASettings_DeleteKeyP(Settings, AnsiString(Section), AnsiString(Name));
end;

function ASettings_DeleteKeyP(Settings: ASettings; const Section, Name: APascalString): AError;
var
  SectionStr: AString_Type;
  NameStr: AString_Type;
begin
  try
    if AObject_Assigned(Settings) then
    begin
      AString_SetP(SectionStr, Section);
      AString_SetP(NameStr, Name);
      Result := PSettings(Settings)^.Control.DeleteKey(Settings, SectionStr, NameStr);
      Exit;
    end;
    {$ifdef ASettings_Old}
    if TAbstractSettings(Settings).DeleteKey(Section, Name) then
      Result := 0
    else
      Result := -2;
    {$else}
    Result := -1;
    {$endif}
  except
    Result := -1;
  end;
end;

function ASettings_DeleteSection(Settings: ASettings; const Section: AString_Type): AError;
begin
  if AObject_Assigned(Settings) then
  begin
    Result := PSettings(Settings)^.Control.DeleteSection(Settings, Section);
    Exit;
  end;
  {$ifdef ASettings_Old}
  Result := ASettings_DeleteSectionP(Settings, AString_ToPascalString(Section));
  {$else}
  Result := -1;
  {$endif}
end;

function ASettings_DeleteSectionA(Settings: ASettings; Section: AStr): AError;
begin
  Result := ASettings_DeleteSectionP(Settings, AnsiString(Section));
end;

function ASettings_DeleteSectionP(Settings: ASettings; const Section: APascalString): AError;
var
  SectionStr: AString_Type;
begin
  try
    if AObject_Assigned(Settings) then
    begin
      AString_SetP(SectionStr, Section);
      Result := PSettings(Settings)^.Control.DeleteSection(Settings, SectionStr);
      Exit;
    end;
    {$ifdef ASettings_Old}
    if TAbstractSettings(Settings).DeleteSection(Section) then
      Result := 0
    else
      Result := -2;
    {$else}
    Result := -1;
    {$endif}
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

function ASettings_New(Control: ASettings_Interface): ASettings;
var
  I: AInt;
begin
  I := Length(_Settings);
  SetLength(_Settings, I + 1);
  _Settings[I].Base.ObjConst := AObjConst;
  _Settings[I].Base.Reserved1 := 0;
  _Settings[I].Base.Reserved2 := 0;
  _Settings[I].Base.Reserved3 := 0;
  _Settings[I].Control := Control;

  {$ifdef FPC}
  GetFormatSettings();
  _Settings[I].FormatSettings := DefaultFormatSettings;
  {$else}
  {$ifdef DELPHI_XE_UP}
  _Settings[I].FormatSettings := TFormatSettings.Create(0);
  {$else}
  GetLocaleFormatSettings(0, _Settings[I].FormatSettings);
  {$endif}
  {$endif}
  _Settings[I].FormatSettings.DecimalSeparator := '.';
  _Settings[I].FormatSettings.DateSeparator := '.';
  _Settings[I].FormatSettings.TimeSeparator := ':';
  _Settings[I].FormatSettings.ShortDateFormat := 'dd.MM.yyyy';
  _Settings[I].FormatSettings.ShortTimeFormat := 'h:mm:ss';
  _Settings[I].FormatSettings.LongTimeFormat := 'h:mm:ss.nnnn';

  Result := ASettings(Addr(_Settings[I]));
end;

function ASettings_ReadBoolDef(Settings: ASettings; const Section, Name: AString_Type; DefValue: ABool): ABool;
begin
  try
    if AObject_Assigned(Settings) then
    begin
      Result := DefValue;
      PSettings(Settings)^.Control.ReadBool(Settings, Section, Name, Result);
      Exit;
    end;
    {$ifdef ASettings_Old}
    Result := ASettings_ReadBoolDefP(Settings,
        AString_ToPascalString(Section),
        AString_ToPascalString(Name),
        DefValue);
    {$else}
    Result := DefValue;
    {$endif}
  except
    Result := DefValue;
  end
end;

function ASettings_ReadBoolDefA(Settings: ASettings; Section, Name: AStr; DefValue: ABool): ABool;
begin
  Result := ASettings_ReadBoolDefP(Settings, AnsiString(Section), AnsiString(Name), DefValue);
end;

function ASettings_ReadBoolDefP(Settings: ASettings; const Section, Name: APascalString; DefValue: ABool): ABool;
var
  SectionStr: AString_Type;
  NameStr: AString_Type;
begin
  if (Settings = 0) then
  begin
    Result := DefValue;
    Exit;
  end;
  if AObject_Assigned(Settings) then
  begin
    AString_SetP(SectionStr, Section);
    AString_SetP(NameStr, Name);
    Result := DefValue;
    PSettings(Settings)^.Control.ReadBool(Settings, SectionStr, NameStr, Result);
    Exit;
  end;
  {$ifdef ASettings_Old}
  if (TObject(Settings) is TAbstractSettings) then
  try
    Result := TAbstractSettings(Settings).ReadBool(Section, Name, DefValue)
  except
    Result := DefValue;
  end
  else
  begin
    {$ifdef UseXmlNode}
    if (AConfig_ReadBool(Settings, Name, Result) >= 0) then
      Exit;
    {$endif}
    Result := DefValue;
  end;
  {$else}
  Result := DefValue;
  {$endif}
end;

function ASettings_ReadDateTimeDef(Settings: ASettings; const Section, Name: AString_Type;
    DefValue: TDateTime): TDateTime;
begin
  try
    if AObject_Assigned(Settings) then
    begin
      Result := DefValue;
      PSettings(Settings)^.Control.ReadDateTime(Settings, Section, Name, Result);
      Exit;
    end;
    {$ifdef ASettings_Old}
    Result := ASettings_ReadDateTimeDefP(
        Settings,
        AString_ToPascalString(Section),
        AString_ToPascalString(Name),
        DefValue);
    {$else}
    Result := DefValue;
    {$endif}
  except
    Result := DefValue;
  end;
end;

function ASettings_ReadDateTimeDefA(Settings: ASettings; Section, Name: AStr;
    DefValue: TDateTime): TDateTime;
begin
  try
    Result := ASettings_ReadDateTimeDefP(Settings, AnsiString(Section), AnsiString(Name), DefValue);
  except
    Result := DefValue;
  end;
end;

function ASettings_ReadDateTimeDefP(Settings: ASettings; const Section, Name: APascalString;
    DefValue: TDateTime): TDateTime;
var
  SectionStr: AString_Type;
  NameStr: AString_Type;
begin
  if (Settings = 0) then
  begin
    Result := DefValue;
    Exit;
  end;
  try
    if AObject_Assigned(Settings) then
    begin
      AString_SetP(SectionStr, Section);
      AString_SetP(NameStr, Name);
      Result := DefValue;
      PSettings(Settings)^.Control.ReadDateTime(Settings, SectionStr, NameStr, Result);
      Exit;
    end;
    {$ifdef ASettings_Old}
    Result := TAbstractSettings(Settings).ReadDateTime(Section, Name, DefValue);
    {$else}
    Result := DefValue;
    {$endif}
  except
    Result := DefValue;
  end;
end;

function ASettings_ReadFloatDef(Settings: ASettings; const Section, Name: AString_Type; DefValue: AFloat): AFloat;
begin
  try
    if AObject_Assigned(Settings) then
    begin
      Result := DefValue;
      PSettings(Settings)^.Control.ReadFloat(Settings, Section, Name, Result);
      Exit;
    end;
    {$ifdef ASettings_Old}
    Result := ASettings_ReadFloatDefP(
        Settings,
        AString_ToPascalString(Section),
        AString_ToPascalString(Name),
        DefValue);
    {$else}
    Result := DefValue;
    {$endif}
  except
    Result := DefValue;
  end;
end;

function ASettings_ReadFloatDefA(Settings: ASettings; Section, Name: AStr; DefValue: AFloat): AFloat;
begin
  try
    Result := ASettings_ReadFloatDefP(Settings, AnsiString(Section), AnsiString(Name), DefValue);
  except
    Result := DefValue;
  end;
end;

function ASettings_ReadFloatDefP(Settings: ASettings; const Section, Name: APascalString; DefValue: AFloat): AFloat;
var
  SectionStr: AString_Type;
  NameStr: AString_Type;
begin
  if (Settings = 0) then
  begin
    Result := DefValue;
    Exit;
  end;
  try
    if AObject_Assigned(Settings) then
    begin
      AString_SetP(SectionStr, Section);
      AString_SetP(NameStr, Name);
      Result := DefValue;
      PSettings(Settings)^.Control.ReadFloat(Settings, SectionStr, NameStr, Result);
      Exit;
    end;
    {$ifdef ASettings_Old}
    if not(TObject(Settings) is TAbstractSettings) then
    begin
      Result := DefValue;
      Exit;
    end;
    try
      Result := TAbstractSettings(Settings).ReadFloat(Section, Name, DefValue);
    except
      Result := DefValue;
    end;
    {$else}
    Result := DefValue;
    {$endif}
  except
    Result := DefValue;
  end;
end;

function ASettings_ReadIntDef(Settings: ASettings; const Section, Name: AString_Type; DefValue: AInt): AInt;
begin
  try
    if AObject_Assigned(Settings) then
    begin
      Result := DefValue;
      PSettings(Settings)^.Control.ReadInt(Settings, Section, Name, Result);
      Exit;
    end;
    {$ifdef ASettings_Old}
    Result := ASettings_ReadIntDefP(
        Settings,
        AString_ToPascalString(Section),
        AString_ToPascalString(Name),
        DefValue);
    {$else}
    Result := DefValue;
    {$endif}
  except
    Result := DefValue;
  end;
end;

function ASettings_ReadIntDefA(Settings: ASettings; Section, Name: AStr; DefValue: AInt): AInt;
begin
  try
    Result := ASettings_ReadIntDefP(Settings, AnsiString(Section), AnsiString(Name), DefValue);
  except
    Result := DefValue;
  end;
end;

function ASettings_ReadIntDefP(Settings: ASettings; const Section, Name: APascalString; DefValue: AInt): AInt;
var
  SectionStr: AString_Type;
  NameStr: AString_Type;
begin
  if (Settings = 0) then
  begin
    Result := DefValue;
    Exit;
  end;
  try
    if AObject_Assigned(Settings) then
    begin
      AString_SetP(SectionStr, Section);
      AString_SetP(NameStr, Name);
      Result := DefValue;
      PSettings(Settings)^.Control.ReadInt(Settings, SectionStr, NameStr, Result);
      Exit;
    end;
    {$ifdef ASettings_Old}
    if (TObject(Settings) is TAbstractSettings) then
    try
      Result := TAbstractSettings(Settings).ReadInteger(Section, Name, DefValue);
    except
      Result := DefValue;
    end
    else
    begin
      {$ifdef UseXmlNode}
      if (AConfig_ReadInt(Settings, Name, Result) >= 0) then
        Exit;
      {$endif}
      Result := DefValue;
    end;
    {$else}
    Result := DefValue;
    {$endif}
  except
    Result := DefValue;
  end;
end;

function ASettings_ReadIntegerDefP(Settings: ASettings; const Section, Name: APascalString; DefValue: AInt): AInt;
begin
  Result := ASettings_ReadIntDefP(Settings, Section, Name, DefValue);
end;

function ASettings_ReadSection(Settings: ASettings; const Section: AString_Type; Strings: AStringList): AError;
begin
  if AObject_Assigned(Settings) then
  begin
    Result := PSettings(Settings)^.Control.ReadSection(Settings, Section, Strings);
    Exit;
  end;
  Result := ASettings_ReadSectionP(Settings, AString_ToPascalString(Section), Strings);
end;

function ASettings_ReadSectionA(Settings: ASettings; Section: AStr; Strings: AStringList): AError;
begin
  Result := ASettings_ReadSectionP(Settings, AnsiChar(Section), Strings);
end;

function ASettings_ReadSectionP(Settings: ASettings; const Section: APascalString; Strings: AStringList): AError;
var
  SectionStr: AString_Type;
begin
  try
    if AObject_Assigned(Settings) then
    begin
      AString_SetP(SectionStr, Section);
      Result := PSettings(Settings)^.Control.ReadSection(Settings, SectionStr, Strings);
      Exit;
    end;
    {$ifdef ASettings_Old}
    if TAbstractSettings(Settings).ReadSection(Section, Strings) then
      Result := 0
    else
      Result := -2;
    {$else}
    Result := -1;
    {$endif}
  except
    Result := -1;
  end;
end;

function ASettings_ReadString(Settings: ASettings; const Section, Name: AString_Type; out Value: AString_Type): AInt;
var
  S: APascalString;
begin
  try
    if AObject_Assigned(Settings) then
    begin
      Result := PSettings(Settings)^.Control.ReadString(Settings, Section, Name, Value);
      Exit;
    end;
    Result := ASettings_ReadStringP(
        Settings,
        AString_ToPascalString(Section),
        AString_ToPascalString(Name),
        S);
    if (Result >= 0) then
      Result := AString_AssignP(Value, S);
  except
    Result := -1;
  end;
end;

function ASettings_ReadStringA(Settings: ASettings; Section, Name, Value: AStr; MaxLen: AInt): AInt;
var
  S: APascalString;
begin
  try
    Result := ASettings_ReadStringP(Settings, AnsiString(Section), AnsiString(Name), S);
    if (Result > 0) then
      AStringBaseUtils.StrPLCopy(Value, AnsiString(S), MaxLen);
  except
    Result := -1;
  end;
end;

function ASettings_ReadStringDef(Settings: ASettings; const Section, Name, DefValue: AString_Type;
    out Value: AString_Type): AInt;
var
  S: APascalString;
begin
  try
    if AObject_Assigned(Settings) then
    begin
      AString_Assign(Value, DefValue);
      Result := PSettings(Settings)^.Control.ReadString(Settings, Section, Name, Value);
      Exit;
    end;
    S := ASettings_ReadStringDefP(
        Settings,
        AString_ToPascalString(Section),
        AString_ToPascalString(Name),
        AString_ToPascalString(DefValue));
    Result := AString_AssignP(Value, S);
  except
    Result := -1;
  end;
end;

function ASettings_ReadStringDefA(Settings: ASettings; Section, Name, DefValue: AStr;
    Value: AStr; MaxLen: AInt): AInt;
var
  S: AnsiString;
begin
  try
    S := ASettings_ReadStringDefP(Settings, AnsiString(Section), AnsiString(Name), AnsiString(DefValue));
    AStringBaseUtils.StrPLCopy(Value, AnsiString(S), MaxLen);
    Result := Length(S);
  except
    Result := -1;
  end;
end;

function ASettings_ReadStringDefP(Settings: ASettings; const Section, Name,
    DefValue: APascalString): APascalString;
var
  SectionStr: AString_Type;
  NameStr: AString_Type;
  Value: AString_Type;
begin
  if (Settings = 0) then
  begin
    Result := DefValue;
    Exit;
  end;
  try
    if AObject_Assigned(Settings) then
    begin
      AString_SetP(SectionStr, Section);
      AString_SetP(NameStr, Name);
      AString_SetP(Value, DefValue);
      PSettings(Settings)^.Control.ReadString(Settings, SectionStr, NameStr, Value);
      Result := AString_ToPascalString(Value);
      Exit;
    end;
    {$ifdef ASettings_Old}
    if (TObject(Settings) is TAbstractSettings) then
    try
      TAbstractSettings(Settings).ReadString(Section, Name, DefValue, Result);
    except
      Result := DefValue;
    end
    else
    begin
      {$ifdef UseXmlNode}
      if (AConfig_ReadString(Settings, Name, Result) >= 0) then
        Exit;
      {$endif}
      Result := DefValue;
    end;
    {$else}
    Result := DefValue;
    {$endif}
  except
    Result := DefValue;
  end;
end;

function ASettings_ReadStringP(Settings: ASettings; const Section, Name: APascalString;
    out Value: APascalString): AInt;
var
  SectionStr: AString_Type;
  NameStr: AString_Type;
  V: AString_Type;
begin
  if (Settings = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    if AObject_Assigned(Settings) then
    begin
      AString_SetP(SectionStr, Section);
      AString_SetP(NameStr, Name);
      AString_SetP(V, Value);
      if (PSettings(Settings)^.Control.ReadString(Settings, SectionStr, NameStr, V) >= 0) then
        Value := AString_ToP(V);
      Result := 0;
      Exit;
    end;
    {$ifdef ASettings_Old}
    Result := TAbstractSettings(Settings).ReadString(Section, Name, '', Value);
    {$else}
    Result := -1;
    {$endif}
  except
    Result := -1;
  end;
end;

function ASettings_WriteBool(Settings: ASettings; const Section, Name: AString_Type; Value: ABool): AError;
begin
  try
    if AObject_Assigned(Settings) then
    begin
      Result := PSettings(Settings)^.Control.WriteBool(Settings, Section, Name, Value);
      Exit;
    end;
    Result := ASettings_WriteBoolP(
        Settings,
        AString_ToPascalString(Section),
        AString_ToPascalString(Name),
        Value);
  except
    Result := -1;
  end;
end;

function ASettings_WriteBoolA(Settings: ASettings; {const} Section, Name: AStr; Value: ABool): AError;
begin
  Result := ASettings_WriteBoolP(Settings, AnsiString(Section), AnsiString(Name), Value);
end;

function ASettings_WriteBoolP(Settings: ASettings; const Section, Name: APascalString; Value: ABoolean): AError;
var
  SectionStr: AString_Type;
  NameStr: AString_Type;
begin
  if (Settings = 0) then
  begin
    Result := -1;
    Exit;
  end;
  try
    if AObject_Assigned(Settings) then
    begin
      AString_SetP(SectionStr, Section);
      AString_SetP(NameStr, Name);
      Result := PSettings(Settings).Control.WriteBool(Settings, SectionStr, NameStr, Value);
      Exit;
    end;
    {$ifdef ASettings_Old}
    if (TObject(Settings) is TAbstractSettings) then
    try
      if TAbstractSettings(Settings).WriteBool(Section, Name, Value) then
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
    {$else}
    Result := -1;
    {$endif}
  except
    Result := -1;
  end;
end;

function ASettings_WriteDateTime(Settings: ASettings; const Section, Name: AString_Type; Value: TDateTime): AError;
begin
  if AObject_Assigned(Settings) then
  begin
    Result := PSettings(Settings)^.Control.WriteDateTime(Settings, Section, Name, Value);
    Exit;
  end;
  Result := ASettings_WriteDateTimeP(
      Settings,
      AString_ToPascalString(Section),
      AString_ToPascalString(Name),
      Value);
end;

function ASettings_WriteDateTimeA(Settings: ASettings; Section, Name: AStr; Value: TDateTime): AError;
begin
  Result := ASettings_WriteDateTimeP(Settings, AnsiString(Section), AnsiString(Name), Value);
end;

function ASettings_WriteDateTimeP(Settings: ASettings; const Section, Name: APascalString; Value: TDateTime): AError;
var
  SectionStr: AString_Type;
  NameStr: AString_Type;
begin
  if (Settings = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    if AObject_Assigned(Settings) then
    begin
      AString_SetP(SectionStr, Section);
      AString_SetP(NameStr, Name);
      Result := PSettings(Settings)^.Control.WriteDateTime(Settings, SectionStr, NameStr, Value);
      Exit;
    end;
    {$ifdef ASettings_Old}
    if TAbstractSettings(Settings).WriteDateTime(Section, Name, Value) then
      Result := 0
    else
      Result := -3;
    {$else}
    Result := -1;
    {$endif}
  except
    Result := -1;
  end;
end;

function ASettings_WriteFloat(Settings: ASettings; const Section, Name: AString_Type;
    Value: AFloat): AError;
begin
  if AObject_Assigned(Settings) then
  begin
    Result := PSettings(Settings)^.Control.WriteFloat(Settings, Section, Name, Value);
    Exit;
  end;
  Result := ASettings_WriteFloatP(Settings, AString_ToPascalString(Section), AString_ToPascalString(Name), Value);
end;

function ASettings_WriteFloatA(Settings: ASettings; {const} Section, Name: AStr; Value: AFloat): AError;
begin
  Result := ASettings_WriteFloatP(Settings, AnsiString(Section), AnsiString(Name), Value);
end;

function ASettings_WriteFloatP(Settings: ASettings; const Section, Name: APascalString;
    Value: AFloat): AError;
var
  SectionStr: AString_Type;
  NameStr: AString_Type;
begin
  if (Settings = 0) then
  begin
    Result := -1;
    Exit;
  end;
  try
    if AObject_Assigned(Settings) then
    begin
      AString_SetP(SectionStr, Section);
      AString_SetP(NameStr, Name);
      Result := PSettings(Settings)^.Control.WriteFloat(Settings, SectionStr, NameStr, Value);
      Exit;
    end;
    {$ifdef ASettings_Old}
    if (TObject(Settings) is TAbstractSettings) then
    try
      if TAbstractSettings(Settings).WriteFloat(Section, Name, Value) then
        Result := 0
      else
        Result := -1;
    except
      Result := -1;
    end
    else
    begin
      {$ifdef UseXmlNode}
      Result := AConfig_WriteFloat(Settings, Name, Value);
      {$else}
      Result := -3;
      {$endif}
    end;
    {$else}
    Result := -1;
    {$endif}
  except
    Result := -1;
  end;
end;

function ASettings_WriteInt(Settings: ASettings; const Section, Name: AString_Type;
    Value: AInt): AError;
begin
  if AObject_Assigned(Settings) then
  begin
    Result := PSettings(Settings)^.Control.WriteInt(Settings, Section, Name, Value);
    Exit;
  end;
  Result := ASettings_WriteIntP(Settings, AString_ToPascalString(Section), AString_ToPascalString(Name), Value);
end;

function ASettings_WriteIntA(Settings: ASettings; Section, Name: AStr; Value: AInt): AError;
begin
  Result := ASettings_WriteIntP(Settings, AnsiString(Section), AnsiString(Name), Value);
end;

function ASettings_WriteIntP(Settings: ASettings; const Section, Name: APascalString;
    Value: AInt): AError;
var
  SectionStr: AString_Type;
  NameStr: AString_Type;
begin
  if (Settings = 0) then
  begin
    Result := -1;
    Exit;
  end;
  try
    if AObject_Assigned(Settings) then
    begin
      AString_SetP(SectionStr, Section);
      AString_SetP(NameStr, Name);
      Result := PSettings(Settings)^.Control.WriteInt(Settings, SectionStr, NameStr, Value);
      Exit;
    end;
    {$ifdef ASettings_Old}
    if (TObject(Settings) is TAbstractSettings) then
    try
      if TAbstractSettings(Settings).WriteInteger(Section, Name, Value) then
        Result := 0
      else
        Result := -1;
    except
      Result := -1;
    end
    else
    begin
      {$ifdef UseXmlNode}
      Result := AConfig_WriteInt(Settings, Name, Value);
      {$else}
      Result := -3;
      {$endif}
    end;
    {$else}
    Result := -1;
    {$endif}
  except
    Result := -1;
  end;
end;

function ASettings_WriteIntegerP(Settings: ASettings; const Section, Name: APascalString; Value: AInt): AError;
begin
  Result := ASettings_WriteIntP(Settings, Section, Name, Value);
end;

function ASettings_WriteString(Settings: ASettings; const Section, Name, Value: AString_Type): AError;
begin
  if AObject_Assigned(Settings) then
  begin
    Result := PSettings(Settings)^.Control.WriteString(Settings, Section, Name, Value);
    Exit;
  end;
  Result := ASettings_WriteStringP(
      Settings,
      AString_ToPascalString(Section),
      AString_ToPascalString(Name),
      AString_ToPascalString(Value));
end;

function ASettings_WriteStringA(Settings: ASettings; Section, Name, Value: AStr): AError;
begin
  Result := ASettings_WriteStringP(Settings, AnsiString(Section), AnsiString(Name), AnsiString(Value));
end;

function ASettings_WriteStringP(Settings: ASettings; const Section, Name, Value: APascalString): AError;
var
  SectionStr: AString_Type;
  NameStr: AString_Type;
  ValueStr: AString_Type;
begin
  if (Settings = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    if AObject_Assigned(Settings) then
    begin
      AString_SetP(SectionStr, Section);
      AString_SetP(NameStr, Name);
      AString_SetP(ValueStr, Value);
      Result := PSettings(Settings)^.Control.WriteString(Settings, SectionStr, NameStr, ValueStr);
      Exit;
    end;
    {$ifdef ASettings_Old}
    if (TObject(Settings) is TAbstractSettings) then
    try
      if TAbstractSettings(Settings).WriteString(Section, Name, Value) then
        Result := 0
      else
        Result := -2;
    except
      Result := -1;
    end
    else
    begin
      {$ifdef UseXmlNode}
      Result := AConfig_WriteString(Settings, Name, Value);
      {$else}
      Result := -3;
      {$endif}
    end;
    {$else}
    Result := -1;
    {$endif}
  except
    Result := -1;
  end;
end;

end.
