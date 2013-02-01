{**
@Abstract ASystem resource
@Author Prof1983 <prof1983@ya.ru>
@Created 29.05.2011
@LastMod 30.01.2013
}
unit ASystemResourceString;

{$I A.inc}

{define AStdCall}

interface

uses
  ABase,
  AStringMain;

function ASystem_GetResourceString(const Section, Name, Default: AString_Type;
    out Value: AString_Type): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function ASystem_GetResourceStringP(const Section, Name, Default: APascalString): APascalString;

implementation

{$IFDEF DELPHI_XE_UP}
  {$I ASystemResourceString.ru.utf8.inc}
{$ELSE}
const
  cAbout = 'About...';
  cSettings = 'Options...';
  cModules = 'Modules';
{$ENDIF}

// --- ASystem ---

function ASystem_GetResourceString(const Section, Name, Default: AString_Type;
    out Value: AString_Type): AInteger;
var
  Res: APascalString;
begin
  try
    Res := ASystem_GetResourceStringP(
            AString_ToPascalString(Section),
            AString_ToPascalString(Name),
            AString_ToPascalString(Default));
    Result := AString_AssignP(Value, Res);
  except
    Result := 0;
  end;
end;

function ASystem_GetResourceStringP(const Section, Name, Default: APascalString): APascalString;
begin
  try
    Result := Default;
    if (Section = 'About') then
    begin
      if (Name = 'MenuText') then
        Result := cAbout;
    end
    else if (Section = 'Tools') then
    begin
      if (Name = 'Options') then
        Result := cSettings;
    end
    else if (Section = '') then
    begin
      if (Name = 'Modules') then
        Result := cModules;
    end;
  except
    Result := '';
  end;
end;

end.
 