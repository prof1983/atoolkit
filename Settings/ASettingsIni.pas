{**
@Abstract ASettingsIni
@Author Prof1983 <prof1983@ya.ru>
@Created 12.11.2012
@LastMod 02.04.2013
}
unit ASettingsIni;

{define AStdCall}
{$define ASettings_Old}

interface

uses
  ABase,
  ABaseTypes,
  {$ifdef ASettings_Old}
  AIniSettings,
  {$endif}
  AObjects,
  ASettingsAbstract,
  ASettingsTypes,
  AStringLists,
  AStringMain;

// --- AIniSettings ---

function AIniSettings_Close(Settings: ASettings): AError;

function AIniSettings_DeleteKey(Settings: ASettings; const Section, Name: AString_Type): AError;

function AIniSettings_DeleteKeyP(Settings: ASettings; const Section, Name: APascalString): AError;

function AIniSettings_DeleteSection(Settings: ASettings; const Section: AString_Type): AError;

function AIniSettings_DeleteSectionP(Settings: ASettings; const Section: APascalString): AError;

function AIniSettings_ReadBool(Settings: ASettings; const Section, Name: AString_Type;
    out Value: ABool): AError;

function AIniSettings_ReadDateTime(Settings: ASettings; const Section, Name: AString_Type;
    out Value: TDateTime): AError;

function AIniSettings_ReadFloat(Settings: ASettings; const Section, Name: AString_Type;
    out Value: AFloat): AError;

function AIniSettings_ReadInt(Settings: ASettings; const Section, Name: AString_Type;
    out Value: AInt): AError;

function AIniSettings_ReadSection(Settings: ASettings; const Section: AString_Type;
    Strings: AStringList): AError;

function AIniSettings_ReadSectionP(Settings: ASettings; const Section: APascalString;
    Strings: AStringList): AError;

function AIniSettings_ReadString(Settings: ASettings; const Section, Name: AString_Type;
    out Value: AString_Type): AError;

function AIniSettings_WriteBool(Settings: ASettings; const Section, Name: AString_Type;
    Value: ABool): AError;

function AIniSettings_WriteDateTime(Settings: ASettings; const Section, Name: AString_Type;
    Value: TDateTime): AError;

function AIniSettings_WriteFloat(Settings: ASettings; const Section, Name: AString_Type;
    Value: AFloat): AError;

function AIniSettings_WriteInt(Settings: ASettings; const Section, Name: AString_Type;
    Value: AInt): AError;

function AIniSettings_WriteString(Settings: ASettings; const Section, Name,
    Value: AString_Type): AError;

// --- ASettings ---

{$ifdef ASettings_Old}
function ASettings_NewIniConfig(const FileName: AString_Type): AConfig; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_NewIniConfigA(FileName: AStr): AConfig; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_NewIniConfigP(const FileName: APascalString): AConfig;
{$endif}

function ASettings_NewIniSettings(const FileName: AString_Type): AConfig; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_NewIniSettingsA(FileName: AStr): AConfig; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_NewIniSettingsP(const FileName: APascalString): ASettings;

implementation

uses
  Classes,
  IniFiles;

const
  AIniSettings_Class: ASettings_Interface = (
    Close: AIniSettings_Close;
    DeleteKey: AIniSettings_DeleteKey;
    DeleteSection: AIniSettings_DeleteSection;
    ReadBool: AIniSettings_ReadBool;
    ReadDateTime: AIniSettings_ReadDateTime;
    ReadFloat: AIniSettings_ReadFloat;
    ReadInt: AIniSettings_ReadInt;
    ReadSection: AIniSettings_ReadSection;
    ReadString: AIniSettings_ReadString;
    WriteBool: AIniSettings_WriteBool;
    WriteDateTime: AIniSettings_WriteDateTime;
    WriteFloat: AIniSettings_WriteFloat;
    WriteInt: AIniSettings_WriteInt;
    WriteString: AIniSettings_WriteString;
  );

type
  AIniSettings_Type = record
    Base: ASettings_Type;
    IniFile: TIniFile;
  end;
  PIniSettings = ^AIniSettings_Type;

// --- AIniSettings ---

function AIniSettings_Close(Settings: ASettings): AError;
begin
  if not(Assigned(PIniSettings(Settings)^.IniFile)) then
  begin
    Result := -2;
    Exit;
  end;
  try
    try
      PIniSettings(Settings)^.IniFile.Free();
      Result := 0;
    finally
      PIniSettings(Settings)^.IniFile := nil;
    end;
  except
    Result := -1;
  end;
end;

function AIniSettings_DeleteKey(Settings: ASettings; const Section, Name: AString_Type): AError;
begin
  Result := AIniSettings_DeleteKeyP(Settings, AString_ToPascalString(Section), AString_ToPascalString(Name));
end;

function AIniSettings_DeleteKeyP(Settings: ASettings; const Section, Name: APascalString): AError;
begin
  try
    if not(Assigned(PIniSettings(Settings)^.IniFile)) then
    begin
      Result := -2;
      Exit;
    end;
    PIniSettings(Settings)^.IniFile.DeleteKey(Section, Name);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AIniSettings_DeleteSection(Settings: ASettings; const Section: AString_Type): AError;
begin
  Result := AIniSettings_DeleteSectionP(Settings, AString_ToPascalString(Section));
end;

function AIniSettings_DeleteSectionP(Settings: ASettings; const Section: APascalString): AError;
begin
  try
    if not(Assigned(PIniSettings(Settings)^.IniFile)) then
    begin
      Result := -2;
      Exit;
    end;
    PIniSettings(Settings)^.IniFile.EraseSection(Section);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AIniSettings_ReadBool(Settings: ASettings; const Section, Name: AString_Type;
    out Value: ABool): AError;
begin
  Result := AAbstractSettings_ReadBool(Settings, Section, Name, Value);
end;

function AIniSettings_ReadDateTime(Settings: ASettings; const Section, Name: AString_Type;
    out Value: TDateTime): AError;
begin
  Result := AAbstractSettings_ReadDateTime(Settings, Section, Name, Value);
end;

function AIniSettings_ReadFloat(Settings: ASettings; const Section, Name: AString_Type;
    out Value: AFloat): AError;
begin
  Result := AAbstractSettings_ReadFloat(Settings, Section, Name, Value);
end;

function AIniSettings_ReadInt(Settings: ASettings; const Section, Name: AString_Type;
    out Value: AInt): AError;
begin
  Result := AAbstractSettings_ReadInt(Settings, Section, Name, Value);
end;

function AIniSettings_ReadSection(Settings: ASettings; const Section: AString_Type;
    Strings: AStringList): AError;
begin
  Result := AIniSettings_ReadSectionP(Settings, AString_ToP(Section), Strings);
end;

function AIniSettings_ReadSectionP(Settings: ASettings; const Section: APascalString;
    Strings: AStringList): AError;
var
  Values: AStringList;
  I: Integer;
  C: AInteger;
  IniFile: TIniFile;
begin
  IniFile := PIniSettings(Settings)^.IniFile;
  if not(Assigned(IniFile)) then
  begin
    Result := -1;
    Exit;
  end;
  AStringList_Clear(Strings);
  Values := AStringList_New();
  try
    IniFile.ReadSectionValues(Section, TStrings(Values));
    C := AStringList_GetCount(Values);
    for I := 0 to C - 1 do
      AStringList_AddP(Strings, AStringList_GetStringP(Values, I));
  finally
    AStringList_Free(Values);
  end;
  Result := 0;
end;

function AIniSettings_ReadString(Settings: ASettings; const Section, Name: AString_Type;
    out Value: AString_Type): AError;
var
  IniFile: TIniFile;
  V: APascalString;
begin
  IniFile := PIniSettings(Settings)^.IniFile;
  if Assigned(IniFile) then
  begin
    V := IniFile.ReadString(AString_ToP(Section), AString_ToP(Name), AString_ToP(Value));
    AString_AssignP(Value, V);
  end;
  Result := 0;
end;

function AIniSettings_WriteBool(Settings: ASettings; const Section, Name: AString_Type;
    Value: ABool): AError;
begin
  Result := AAbstractSettings_WriteBool(Settings, Section, Name, Value);
end;

function AIniSettings_WriteDateTime(Settings: ASettings; const Section, Name: AString_Type;
    Value: TDateTime): AError;
begin
  Result := AAbstractSettings_WriteDateTime(Settings, Section, Name, Value);
end;

function AIniSettings_WriteFloat(Settings: ASettings; const Section, Name: AString_Type;
    Value: AFloat): AError;
begin
  Result := AAbstractSettings_WriteFloat(Settings, Section, Name, Value);
end;

function AIniSettings_WriteInt(Settings: ASettings; const Section, Name: AString_Type;
    Value: AInt): AError;
begin
  Result := AAbstractSettings_WriteInt(Settings, Section, Name, Value);
end;

function AIniSettings_WriteString(Settings: ASettings; const Section, Name,
    Value: AString_Type): AError;
var
  IniFile: TIniFile;
begin
  IniFile := PIniSettings(Settings).IniFile;
  if not(Assigned(IniFile)) then
  begin
    Result := -1;
    Exit;
  end;
  IniFile.WriteString(AString_ToP(Section), AString_ToP(Name), AString_ToP(Value));
  Result := 0;
end;

// --- ASettings ---

{$ifdef ASettings_Old}
function ASettings_NewIniConfig(const FileName: AString_Type): AConfig;
begin
  Result := ASettings_NewIniConfigP(AString_ToPascalString(FileName));
end;
{$endif}

{$ifdef ASettings_Old}
function ASettings_NewIniConfigA(FileName: AStr): AConfig;
begin
  Result := ASettings_NewIniConfigP(FileName);
end;
{$endif}

{$ifdef ASettings_Old}
function ASettings_NewIniConfigP(const FileName: APascalString): AConfig;
var
  S: TIniSettings;
begin
  S := TIniSettings.Create;
  S.OpenIniFile(FileName);
  Result := Integer(S);
end;
{$endif}

function ASettings_NewIniSettings(const FileName: AString_Type): AConfig;
begin
  Result := ASettings_NewIniSettingsP(AString_ToPascalString(FileName));
end;

function ASettings_NewIniSettingsA(FileName: AStr): AConfig;
begin
  Result := ASettings_NewIniSettingsP(FileName);
end;

function ASettings_NewIniSettingsP(const FileName: APascalString): ASettings;
var
  S: PIniSettings;
begin
  S := PIniSettings(AObject_New(SizeOf(AIniSettings_Type)));
  if not(Assigned(S)) then
  begin
    Result := 0;
    Exit;
  end;
  try
    S^.IniFile := TIniFile.Create(FileName);
  except
    S^.IniFile := nil;
  end;
  Result := ASettings(S);
end;

end.
