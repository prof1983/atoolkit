{**
@Abstract AString utils
@Author Prof1983 <prof1983@ya.ru>
@Created 01.08.2012
@LastMod 20.02.2013
}
unit AStringUtils;

{define AStdCall}

interface

uses
  SysUtils,
  ABase,
  AStringMain;

// --- AString ---

function AString_ToLower(const S: AString_Type; out Res: AString_Type): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AString_ToLowerP(const S: APascalString): APascalString;

function AString_ToUpper(const S: AString_Type; out Res: AString_Type): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AString_ToUpperP(const S: APascalString): APascalString;

implementation

// --- AString ---

function AString_ToLower(const S: AString_Type; out Res: AString_Type): AInt;
begin
  try
    Result := AString_AssignP(Res, SysUtils.AnsiLowerCase(AString_ToPascalString(S)));
  except
    Result := 0;
  end;
end;

function AString_ToLowerP(const S: APascalString): APascalString;
begin
  try
    Result := SysUtils.AnsiLowerCase(S);
  except
    Result := '';
  end;
end;

function AString_ToUpper(const S: AString_Type; out Res: AString_Type): AInt;
begin
  try
    Result := AString_AssignP(Res, SysUtils.AnsiUpperCase(AString_ToPascalString(S)));
  except
    Result := 0;
  end;
end;

function AString_ToUpperP(const S: APascalString): APascalString;
begin
  try
    Result := SysUtils.AnsiUpperCase(S);
  except
    Result := '';
  end;
end;

end.
 