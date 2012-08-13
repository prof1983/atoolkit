{**
@Abstract ASettings main functions
@Author Prof1983 <prof1983@ya.ru>
@Created 13.08.2012
@LastMod 13.08.2012
}
unit ASettingsMain;

interface

uses
  ABase;

// --- ASettings ---

function ASettings_ReadBoolDef(Config: AConfig; const Section, Name: AString_Type; DefValue: ABoolean): ABoolean; stdcall;

function ASettings_ReadBoolDefP(Config: AConfig; const Section, Name: APascalString; DefValue: ABoolean): ABoolean; stdcall;

implementation

// --- ASettings ---

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
  if (Config <> 0) then
    Result := TAbstractSettings(Config).ReadBool(Section, Name, DefValue)
  else
    Result := DefValue;
end;

end.
 