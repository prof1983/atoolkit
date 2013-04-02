{**
@Abstract ASettingsReg
@Author Prof1983 <prof1983@ya.ru>
@Created 12.11.2012
@LastMod 02.04.2013
}
unit ASettingsReg;

{define AStdCall}
{define ASettings_Old}

interface

uses
  ABase,
  ABaseTypes,
  AObjects,
  {$ifdef ASettings_Old}
  ARegistrySettings,
  {$endif}
  ASettingsAbstract,
  ASettingsTypes,
  AStringLists,
  AStringMain;

// --- ASettings_RegConfig ---

{$ifdef ASettings_Old}
function ASettings_NewRegConfig(const Prefix: AString_Type; Key: AInt): AConfig; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_NewRegConfigA(Prefix: AStr; Key: AInt): AConfig; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_NewRegConfigP(const Prefix: APascalString; Key: AInt): AConfig;
{$endif}

function ASettings_NewRegSettings(const Prefix: AString_Type; Key: AInt): AConfig; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_NewRegSettingsA(Prefix: AStr; Key: AInt): AConfig; {$ifdef AStdCall}stdcall;{$endif}

function ASettings_NewRegSettingsP(const Prefix: APascalString; Key: AInt): AConfig;

// --- ARegSettings ---

function ARegSettings_Close(Settings: ASettings): AError;

function ARegSettings_DeleteKey(Settings: ASettings; const Section, Name: AString_Type): AError;

function ARegSettings_DeleteKeyP(Settings: ASettings; const Section, Name: APascalString): AError;

function ARegSettings_DeleteSection(Settings: ASettings; const Section: AString_Type): AError;

function ARegSettings_DeleteSectionP(Settings: ASettings; const Section: APascalString): AError;

function ARegSettings_NodeExistsP(Settings: ASettings; Name: APascalString): AError;

function ARegSettings_ReadBool(Settings: ASettings; const Section, Name: AString_Type;
    out Value: ABool): AError;

function ARegSettings_ReadBoolP(Settings: ASettings; const Section, Name: APascalString;
    out Value: ABool): AError;

function ARegSettings_ReadDateTime(Settings: ASettings; const Section, Name: AString_Type;
    out Value: TDateTime): AError;

function ARegSettings_ReadFloat(Settings: ASettings; const Section, Name: AString_Type;
    out Value: AFloat): AError;

function ARegSettings_ReadInt(Settings: ASettings; const Section, Name: AString_Type;
    out Value: AInt): AError;

function ARegSettings_ReadIntP(Settings: ASettings; const Section, Name: APascalString;
    out Value: AInt): AError;

function ARegSettings_ReadSection(Settings: ASettings; const Section: AString_Type;
    Strings: AStringList): AError;

function ARegSettings_ReadSectionP(Settings: ASettings; const Section: APascalString;
    Strings: AStringList): AError;

function ARegSettings_ReadString(Settings: ASettings; const Section, Name: AString_Type;
    out Value: AString_Type): AError;

function ARegSettings_ReadStringP(Settings: ASettings; const Section, Name: APascalString;
    out Value: APascalString): AError;

function ARegSettings_WriteBool(Settings: ASettings; const Section, Name: AString_Type;
    Value: ABool): AError;

function ARegSettings_WriteBoolP(Settings: ASettings; const Section, Name: APascalString;
    Value: ABool): AError;

function ARegSettings_WriteDateTime(Settings: ASettings; const Section, Name: AString_Type;
    Value: TDateTime): AError;

function ARegSettings_WriteFloat(Settings: ASettings; const Section, Name: AString_Type;
    Value: AFloat): AError;

function ARegSettings_WriteInt(Settings: ASettings; const Section, Name: AString_Type;
    Value: AInt): AError;

function ARegSettings_WriteIntP(Settings: ASettings; const Section, Name: APascalString;
    Value: AInt): AError;

function ARegSettings_WriteString(Settings: ASettings; const Section, Name,
    Value: AString_Type): AError;
    
function ARegSettings_WriteStringP(Settings: ASettings; const Section, Name,
    Value: APascalString): AError;

implementation

uses
  Classes,
  Registry,
  Windows;

const
  ARegistrySettings_Class: ASettings_Interface = (
    Close: ARegSettings_Close;
    DeleteKey: ARegSettings_DeleteKey;
    DeleteSection: ARegSettings_DeleteSection;
    ReadBool: ARegSettings_ReadBool;
    ReadDateTime: ARegSettings_ReadDateTime;
    ReadFloat: ARegSettings_ReadFloat;
    ReadInt: ARegSettings_ReadInt;
    ReadSection: ARegSettings_ReadSection;
    ReadString: ARegSettings_ReadString;
    WriteBool: ARegSettings_WriteBool;
    WriteDateTime: ARegSettings_WriteDateTime;
    WriteFloat: ARegSettings_WriteFloat;
    WriteInt: ARegSettings_WriteInt;
    WriteString: ARegSettings_WriteString;
  );

type
  ARegSettings_Type = record
    Base: ASettings_Type;
    Prefix: APascalString;
    Registry: TRegistry;
  end;

type
  PRegSettings = ^ARegSettings_Type;

// --- ASettings ---

{$ifdef ASettings_Old}
function ASettings_NewRegConfig(const Prefix: AString_Type; Key: AInt): AConfig;
begin
  Result := ASettings_NewRegConfigP(AString_ToPascalString(Prefix), Key);
end;
{$endif}

{$ifdef ASettings_Old}
function ASettings_NewRegConfigA(Prefix: AStr; Key: AInt): AConfig;
begin
  Result := ASettings_NewRegConfigP(Prefix, Key);
end;
{$endif}

{$ifdef ASettings_Old}
function ASettings_NewRegConfigP(const Prefix: APascalString; Key: AInt): AConfig;
{$IFDEF MSWINDOWS}
var
  S: TARegistrySettings;
{$ENDIF}
begin
  try
    {$IFDEF MSWINDOWS}
    if (Key = 0) then
      Key := AInt(HKEY_CURRENT_USER);

    S := TARegistrySettings.Create();
    S.Registry.RootKey := Key;
    S.Prefix := Prefix;
    Result := AConfig(S);
    {$ELSE}
    Result := 0;
    {$ENDIF}
  except
    Result := 0;
  end;
end;
{$endif}

function ASettings_NewRegSettings(const Prefix: AString_Type; Key: AInt): AConfig;
begin
  Result := ASettings_NewRegSettingsP(AString_ToPascalString(Prefix), Key);
end;

function ASettings_NewRegSettingsA(Prefix: AStr; Key: AInt): AConfig;
begin
  Result := ASettings_NewRegSettingsP(Prefix, Key);
end;

function ASettings_NewRegSettingsP(const Prefix: APascalString; Key: AInt): AConfig;
var
  S: PRegSettings;
begin
  try
    if (Key = 0) then
      Key := AInt(HKEY_CURRENT_USER);

    S := PRegSettings(AObject_New(SizeOf(ARegSettings_Type)));
    S^.Base.Control := ARegistrySettings_Class;
    S^.Registry := TRegistry.Create;
    S^.Registry.RootKey := Key;
    S^.Prefix := Prefix;

    Result := AConfig(S);
  except
    Result := 0;
  end;
end;

// --- ARegSettings ---

function ARegSettings_Close(Settings: ASettings): AError;
begin
  try
    PRegSettings(Settings)^.Registry.Free();
    PRegSettings(Settings)^.Registry := nil;
    Result := 0;
  except
    Result := -1;
  end;
end;

function ARegSettings_DeleteKey(Settings: ASettings; const Section, Name: AString_Type): AError;
begin
  Result := ARegSettings_DeleteKeyP(Settings, AString_ToP(Section), AString_ToP(Name));
end;

function ARegSettings_DeleteKeyP(Settings: ASettings; const Section, Name: APascalString): AError;
begin
  if not(PRegSettings(Settings)^.Registry.OpenKey(PRegSettings(Settings)^.Prefix + Section, False)) then
  begin
    Result := -2;
    Exit;
  end;
  try
    PRegSettings(Settings)^.Registry.DeleteValue(Name);
    Result := 0;
  finally
    PRegSettings(Settings)^.Registry.CloseKey;
  end;
end;

function ARegSettings_DeleteSection(Settings: ASettings; const Section: AString_Type): AError;
begin
  Result := ARegSettings_DeleteSectionP(Settings, AString_ToP(Section));
end;

function ARegSettings_DeleteSectionP(Settings: ASettings; const Section: APascalString): AError;
begin
  PRegSettings(Settings)^.Registry.DeleteKey(PRegSettings(Settings)^.Prefix + Section);
  Result := 0;
end;

function ARegSettings_NodeExistsP(Settings: ASettings; Name: APascalString): AError;
begin
  if PRegSettings(Settings)^.Registry.KeyExists(PRegSettings(Settings)^.Prefix + Name) then
    Result := 0
  else
    Result := -1;
end;

function ARegSettings_ReadBool(Settings: ASettings; const Section, Name: AString_Type;
    out Value: ABool): AError;
begin
  Result := ARegSettings_ReadBoolP(Settings, AString_ToP(Section), AString_ToP(Name), Value);
end;

function ARegSettings_ReadBoolP(Settings: ASettings; const Section, Name: APascalString;
    out Value: ABool): AError;
begin
  try
    if not(PRegSettings(Settings)^.Registry.OpenKey(PRegSettings(Settings)^.Prefix + Section, False)) then
    begin
      Result := -2;
      Exit;
    end;
    if not(PRegSettings(Settings)^.Registry.ValueExists(Name)) then
    begin
      PRegSettings(Settings)^.Registry.CloseKey();
      Result := -3;
      Exit;
    end;
    Value := PRegSettings(Settings)^.Registry.ReadBool(Name);
    PRegSettings(Settings)^.Registry.CloseKey();
    Result := 0;
  except
    Result := -1;
  end;
end;

function ARegSettings_ReadDateTime(Settings: ASettings; const Section, Name: AString_Type;
    out Value: TDateTime): AError;
begin
  Result := AAbstractSettings_ReadDateTime(Settings, Section, Name, Value);
end;

function ARegSettings_ReadFloat(Settings: ASettings; const Section, Name: AString_Type;
    out Value: AFloat): AError;
begin
  Result := AAbstractSettings_ReadFloat(Settings, Section, Name, Value);
end;

function ARegSettings_ReadInt(Settings: ASettings; const Section, Name: AString_Type;
    out Value: AInt): AError;
begin
  Result := ARegSettings_ReadIntP(Settings, AString_ToP(Section), AString_ToP(Name), Value);
end;

function ARegSettings_ReadIntP(Settings: ASettings; const Section, Name: APascalString; out Value: AInt): AError;
begin
  try
    if not(PRegSettings(Settings)^.Registry.OpenKey(PRegSettings(Settings)^.Prefix + Section, False)) then
    begin
      Result := -2;
      Exit;
    end;
    if not(PRegSettings(Settings)^.Registry.ValueExists(Name)) then
    begin
      PRegSettings(Settings)^.Registry.CloseKey();
      Result := -3;
      Exit;
    end;
    Value := PRegSettings(Settings)^.Registry.ReadInteger(Name);
    PRegSettings(Settings)^.Registry.CloseKey();
    Result := 0;
  except
    Result := -1;
  end;
end;

function ARegSettings_ReadSection(Settings: ASettings; const Section: AString_Type;
    Strings: AStringList): AError;
begin
  Result := ARegSettings_ReadSectionP(Settings, AString_ToP(Section), Strings);
end;

function ARegSettings_ReadSectionP(Settings: ASettings; const Section: APascalString;
    Strings: AStringList): AError;
var
  S: TStringList;
  I: Integer;
begin
  try
    if not(PRegSettings(Settings)^.Registry.OpenKey(PRegSettings(Settings)^.Prefix + Section, False)) then
    begin
      Result := -2;
      Exit;
    end;
    S := TStringList.Create;
    PRegSettings(Settings)^.Registry.GetValueNames(S);
    AStringList_Clear(Strings);
    for I := 0 to S.Count - 1 do
      AStringList_AddP(
          Strings,
          S.Strings[I]+'=' + PRegSettings(Settings)^.Registry.ReadString(S.Strings[I]));
    S.Free();
    PRegSettings(Settings)^.Registry.CloseKey();
    Result := 0;
  except
    Result := -1;
  end;
end;

function ARegSettings_ReadString(Settings: ASettings; const Section, Name: AString_Type;
    out Value: AString_Type): AError;
var
  V: APascalString;
begin
  V := AString_ToP(Value);
  Result := ARegSettings_ReadStringP(Settings, AString_ToP(Section), AString_ToP(Name), V);
  AString_AssignP(Value, V);
end;

function ARegSettings_ReadStringP(Settings: ASettings; const Section, Name: APascalString;
    out Value: APascalString): AError;
begin
  try
    if not(PRegSettings(Settings)^.Registry.OpenKey(PRegSettings(Settings)^.Prefix + Section, False)) then
    begin
      Result := -2;
      Exit;
    end;
    if not(PRegSettings(Settings)^.Registry.ValueExists(Name)) then
    begin
      PRegSettings(Settings)^.Registry.CloseKey();
      Result := -3;
      Exit;
    end;
    Value := PRegSettings(Settings)^.Registry.ReadString(Name);
    PRegSettings(Settings)^.Registry.CloseKey();
    Result := 0;
  except
    Result := -1;
  end;
end;

function ARegSettings_WriteBool(Settings: ASettings; const Section, Name: AString_Type;
    Value: ABool): AError;
begin
  Result := ARegSettings_WriteBoolP(Settings, AString_ToP(Section), AString_ToP(Name), Value);
end;

function ARegSettings_WriteBoolP(Settings: ASettings; const Section, Name: APascalString;
    Value: ABool): AError;
begin
  try
    if not(PRegSettings(Settings)^.Registry.OpenKey(PRegSettings(Settings)^.Prefix + Section, True)) then
    begin
      Result := -2;
      Exit;
    end;
    PRegSettings(Settings)^.Registry.WriteBool(Name, Value);
    PRegSettings(Settings)^.Registry.CloseKey();
    Result := 0;
  except
    Result := -1;
  end;
end;

function ARegSettings_WriteDateTime(Settings: ASettings; const Section, Name: AString_Type;
    Value: TDateTime): AError;
begin
  Result := AAbstractSettings_WriteDateTime(Settings, Section, Name, Value);
end;

function ARegSettings_WriteFloat(Settings: ASettings; const Section, Name: AString_Type;
    Value: AFloat): AError;
begin
  Result := AAbstractSettings_WriteFloat(Settings, Section, Name, Value);
end;

function ARegSettings_WriteInt(Settings: ASettings; const Section, Name: AString_Type;
    Value: AInt): AError;
begin
  Result := ARegSettings_WriteIntP(Settings, AString_ToP(Section), AString_ToP(Name), Value);
end;

function ARegSettings_WriteIntP(Settings: ASettings; const Section, Name: APascalString;
    Value: AInt): AError;
begin
  try
    if not(PRegSettings(Settings)^.Registry.OpenKey(PRegSettings(Settings)^.Prefix + Section, True)) then
    begin
      Result := -2;
      Exit;
    end;
    PRegSettings(Settings)^.Registry.WriteInteger(Name, Value);
    PRegSettings(Settings)^.Registry.CloseKey();
    Result := 0;
  except
    Result := -1;
  end;
end;

function ARegSettings_WriteString(Settings: ASettings; const Section, Name,
    Value: AString_Type): AError;
begin
  Result := ARegSettings_WriteStringP(Settings, AString_ToP(Section), AString_ToP(Name), AString_ToP(Value));
end;

function ARegSettings_WriteStringP(Settings: ASettings; const Section, Name,
    Value: APascalString): AError;
begin
  try
    if not(PRegSettings(Settings)^.Registry.OpenKey(PRegSettings(Settings)^.Prefix + Section, True)) then
    begin
      Result := -2;
      Exit;
    end;
    PRegSettings(Settings)^.Registry.WriteString(Name, Value);
    PRegSettings(Settings)^.Registry.CloseKey();
    Result := 0;
  except
    Result := -1;
  end;
end;

end.
