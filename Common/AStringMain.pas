{**
@Abstract AStrings
@Author Prof1983 <prof1983@ya.ru>
@Created 24.05.2011
@LastMod 29.01.2013
}
unit AStringMain;

interface

uses
  SysUtils,
  ABase, AStringBaseUtils;

// --- AString ---

function AString_Assign(var S: AString_Type; const Value: AString_Type): AError; stdcall;

function AString_AssignA(var S: AString_Type; Value: AStr): AError; stdcall;

function AString_AssignP(var S: AString_Type; const Value: APascalString): AError; stdcall;

function AString_AssignWS(var S: AString_Type; const Value: AWideString): AError; stdcall;

function AString_Clear(var S: AString_Type): AError; stdcall;

function AString_Copy(var S: AString_Type; const Value: AString_Type): ASize; stdcall;

function AString_CopyA(var S: AString_Type; const Value: AStr): ASize; stdcall;

function AString_CopyWS(var S: AString_Type; const Value: AWideString): ASize; stdcall;

function AString_GetChar(const S: AString_Type; Index: AInt): AChar; stdcall;

function AString_GetLength(const S: AString_Type): AInteger; stdcall;

function AString_ToPascalString(const S: AString_Type): APascalString; stdcall;

function AString_ToWideString(const S: AString_Type): WideString; stdcall;

// --- AnsiString ---

function AnsiString_GetChar(const S: AnsiString; Index: AInt): AChar; stdcall;

// ----

function Str_Assign({var} S: AString; {const} Value: AString): ASize; stdcall;
function Str_AssignA({var} S: AString; Value: PAnsiChar): ASize; stdcall;
function Str_AssignW({var} S: AString; {const} Value: PWideChar): ASize; stdcall;
function Str_AssignWS({var} S: AString; const Value: WideString): ASize; stdcall;
function Str_Copy({var} S: AString; {const} Value: AString): ASize; stdcall;
function Str_CopyA({var} S: AString; {const} Value: PAnsiChar): ASize; stdcall;
function Str_CopyW({var} S: AString; {const} Value: PWideChar): ASize; stdcall;
function Str_CopyWS({var} S: AString; const Value: WideString): ASize; stdcall;
function Str_Length({const} S: AString): AInteger; stdcall;
function Str_ToP({const} S: AString): APascalString; stdcall; deprecated; // Use String_ToPascalString()
function Str_ToUtf8String({const} S: AString): UTF8String; stdcall; deprecated; // Use String_ToUtf8String()
function Str_Free({var} S: AString): AError; stdcall;

implementation

// --- AnsiString ---

function AnsiString_GetChar(const S: AnsiString; Index: AInt): AChar; stdcall;
begin
  if (Index >= 1) and (Length(S) >= Index) then
    Result := S[Index]
  else
    Result := #0;
end;

// --- AString ---

function AString_Assign(var S: AString_Type; const Value: AString_Type): AError;
begin
  Result := AString_AssignA(S, Value.Str);
end;

function AString_AssignA(var S: AString_Type; Value: AStr): AError;
var
  Size: AInt;
begin
  try
    Size := AStr_GetLength(Value)+1;
    if (AInt(S.AllocSize) < Size) then
    begin
      if Assigned(S.Str) then
        FreeMem(S.Str);
      GetMem(S.Str, Size);
    end;
    StrLCopy(S.Str, Value, Size); //Move(Value, S.Str, Size);
    S.Len := Size-1;
    S.AllocSize := Size;
    S.Code := AStringCode_Ansi;
    Result := 0;
  except
    Result := -1;
  end;
end;

function AString_AssignP(var S: AString_Type; const Value: APascalString): AError;
begin
  Result := AString_AssignA(S, AStr(AnsiString(Value)));
end;

function AString_AssignWS(var S: AString_Type; const Value: AWideString): AError;
begin
  Result := AString_AssignA(S, AStr(AnsiString(Value)));
end;

function AString_Clear(var S: AString_Type): AError;
begin
  try
    S.Str := '';
    S.Len := 0;
  except
  end;
  Result := 0;
end;

function AString_Copy(var S: AString_Type; const Value: AString_Type): ASize;
begin
  // TODO: Make!
  try
    S.Str := Value.Str;
  except
  end;
  Result := 0;
end;

function AString_CopyA(var S: AString_Type; const Value: AStr): ASize;
begin
  try
    S.Str := Value;
  except
  end;
  Result := 0;
end;

function AString_CopyWS(var S: AString_Type; const Value: AWideString): ASize;
begin
  Result := AString_CopyA(S, AStr(AnsiString(Value)));
end;

function AString_GetChar(const S: AString_Type; Index: AInt): AChar;
begin
  if (Index >= 1) and (Length(S.Str) >= Index) then
    Result := S.Str[Index]
  else
    Result := #0;
end;

function AString_GetLength(const S: AString_Type): AInteger;
begin
  try
    Result := S.Len;
  except
    Result := 0;
  end;
end;

function AString_ToPascalString(const S: AString_Type): APascalString;
var
  A: AnsiString;
begin
  A := S.Str;
  Result := APascalString(A);
end;

function AString_ToUtf8String(const S: AString_Type): UTF8String;
begin
  Result := Utf8Encode(S.Str);
end;

function AString_ToWideString(const S: AString_Type): WideString;
begin
  Result := AString_ToPascalString(S);
end;

{ Str }

function Str_Assign({var} S: AString; {const} Value: AString): ASize;
begin
  Result := AString_Assign(S^, Value^);
end;

function Str_AssignA({var} S: AString; Value: PAnsiChar): ASize;
begin
  Result := AString_AssignA(S^, Value);
end;

function Str_AssignW({var} S: AString; {const} Value: PWideChar): ASize;
var
  Tmp: WideString;
begin
  Tmp := WideString(Value);
  Result := AString_AssignP(S^, Tmp);
end;

function Str_AssignWS({var} S: AString; const Value: WideString): ASize;
begin
  Result := AString_AssignP(S^, Value);
end;

function Str_Copy({var} S: AString; {const} Value: AString): ASize;
begin
  Result := AString_Copy(S^, Value^);
end;

function Str_CopyA({var} S: AString; {const} Value: PAnsiChar): ASize;
begin
  Result := AString_CopyA(S^, Value);
end;

function Str_CopyW({var} S: AString; {const} Value: PWideChar): ASize;
begin
  Result := AString_CopyWS(S^, AWideString(Value));
end;

function Str_CopyWS({var} S: AString; const Value: WideString): ASize;
begin
  Result := AString_CopyWS(S^, Value);
end;

function Str_Length({const} S: AString): AInteger;
begin
  Result := AString_GetLength(S^);
end;

function Str_ToP({const} S: AString): APascalString;
begin
  if not(Assigned(S)) then
  begin
    Result := '';
    Exit;
  end;
  Result := AString_ToPascalString(S^);
end;

function Str_ToUtf8String({const} S: AString): UTF8String;
begin
  Result := AString_ToUtf8String(S^);
end;

function Str_Free({var} S: AString): AError;
begin
  Result := AString_Clear(S^);
end;

end.
