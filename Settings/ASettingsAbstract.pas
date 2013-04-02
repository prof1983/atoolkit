{**
@Author Prof1983 <prof1983@ya.ru>
@Created 01.04.2013
@LastMod 01.04.2013
}
unit ASettingsAbstract;

{$I A.inc}

interface

uses
  SysUtils,
  ABase,
  ABaseConsts,
  ABaseTypes,
  ASettingsTypes,
  AStringMain;

// --- AAbstractSettings ---

function AAbstractSettings_ReadBool(Settings: ASettings; const Section, Name: AString_Type;
    out Value: ABool): AError;

function AAbstractSettings_ReadDateTime(Settings: ASettings; const Section, Name: AString_Type;
    out Value: TDateTime): AError;

function AAbstractSettings_ReadFloat(Settings: ASettings; const Section, Name: AString_Type;
    out Value: AFloat): AError;

function AAbstractSettings_ReadInt(Settings: ASettings; const Section, Name: AString_Type;
    out Value: AInt): AError;

function AAbstractSettings_WriteBool(Settings: ASettings; const Section, Name: AString_Type;
    Value: ABool): AError;

function AAbstractSettings_WriteDateTime(Settings: ASettings; const Section, Name: AString_Type;
    Value: TDateTime): AError;

function AAbstractSettings_WriteFloat(Settings: ASettings; const Section, Name: AString_Type;
    Value: AFloat): AError;

function AAbstractSettings_WriteInt(Settings: ASettings; const Section, Name: AString_Type;
    Value: AInt): AError;

implementation

// --- AAbstractSettings ---

function AAbstractSettings_ReadBool(Settings: ASettings; const Section, Name: AString_Type;
    out Value: ABool): AError;
var
  V: AString_Type;
  S: APascalString;
begin
  AString_Clear(V);
  if (PSettings(Settings)^.Control.ReadString(Settings, Section, Name, V) < 0) then
  begin
    Result := -1;
    Exit;
  end;
  S := AString_ToP(V);
  if (S = STR_BOOL[True]) then
  begin
    Value := True;
    Result := 0;
  end
  else if (S = STR_BOOL[False]) then
  begin
    Value := False;
    Result := 0;
  end
  else
    Result := -1;
end;

function AAbstractSettings_ReadDateTime(Settings: ASettings; const Section, Name: AString_Type;
    out Value: TDateTime): AError;
var
  V: AString_Type;
  S: APascalString;
begin
  AString_Clear(V);
  if (PSettings(Settings)^.Control.ReadString(Settings, Section, Name, V) < 0) then
  begin
    Result := -1;
    Exit;
  end;
  S := AString_ToP(V);
  if (S <> '') then
  begin
    TryStrToDateTime(S, Value, PSettings(Settings)^.FormatSettings);
  end;
  Result := 0;
end;

function AAbstractSettings_ReadFloat(Settings: ASettings; const Section, Name: AString_Type;
    out Value: AFloat): AError;
var
  V: AString_Type;
  S: APascalString;
begin
  AString_Clear(V);
  if (PSettings(Settings)^.Control.ReadString(Settings, Section, Name, V) < 0) then
  begin
    Result := -1;
    Exit;
  end;
  S := AString_ToP(V);
  if (S <> '') then
    TryStrToFloat(S, Value);
  Result := 0;
end;

function AAbstractSettings_ReadInt(Settings: ASettings; const Section, Name: AString_Type;
    out Value: AInt): AError;
var
  V: AString_Type;
  S: APascalString;
begin
  AString_Clear(V);
  if (PSettings(Settings)^.Control.ReadString(Settings, Section, Name, V) < 0) then
  begin
    Result := -1;
    Exit;
  end;
  S := AString_ToP(V);
  if (S <> '') then
    TryStrToInt(S, Value);
  Result := 0;
end;

function AAbstractSettings_WriteBool(Settings: ASettings; const Section, Name: AString_Type;
    Value: ABool): AError;
var
  V: AString_Type;
begin
  AString_SetP(V, STR_BOOL[Value]);
  Result := PSettings(Settings)^.Control.WriteString(Settings, Section, Name, V)
end;

function AAbstractSettings_WriteDateTime(Settings: ASettings; const Section, Name: AString_Type;
    Value: TDateTime): AError;
var
  V: AString_Type;
begin
  AString_SetP(V, DateTimeToStr(Value, PSettings(Settings).FormatSettings));
  Result := PSettings(Settings)^.Control.WriteString(Settings, Section, Name, V);
end;

function AAbstractSettings_WriteFloat(Settings: ASettings; const Section, Name: AString_Type;
    Value: AFloat): AError;
var
  V: AString_Type;
begin
  AString_SetP(V, FloatToStr(Value, PSettings(Settings).FormatSettings));
  Result := PSettings(Settings)^.Control.WriteString(Settings, Section, Name, V);
end;

function AAbstractSettings_WriteInt(Settings: ASettings; const Section, Name: AString_Type;
    Value: AInt): AError;
var
  V: AString_Type;
begin
  AString_SetP(V, IntToStr(Value));
  Result := PSettings(Settings)^.Control.WriteString(Settings, Section, Name, V);
end;

end.
