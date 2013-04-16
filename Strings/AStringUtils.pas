{**
@Abstract AString utils
@Author Prof1983 <prof1983@ya.ru>
@Created 01.08.2012
@LastMod 25.12.2012
}
unit AStringUtils;

interface

uses
  SysUtils,
  ABase, AStrings;

// --- AString ---

function AString_ToLowerP(const S: APascalString): APascalString;

function AString_ToUpper(const S: AString_Type; out Res: AString_Type): AInteger; stdcall;

function AString_ToUpperP(const S: APascalString): APascalString; stdcall;

function AString_ToUpperWS(const S: AWideString): AWideString; stdcall;

implementation

function AString_ToLowerP(const S: APascalString): APascalString;
begin
  try
    Result := SysUtils.LowerCase(S);
  except
    Result := '';
  end;
end;

function AString_ToUpper(const S: AString_Type; out Res: AString_Type): AInteger;
begin
  try
    Result := AString_AssignWS(Res, SysUtils.AnsiUpperCase(AStrings.String_ToWideString(S)));
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

function AString_ToUpperWS(const S: AWideString): AWideString;
begin
  Result := AString_ToUpperP(S);
end;

end.
 