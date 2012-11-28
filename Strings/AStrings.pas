{**
@Abstract AStrings
@Author Prof1983 <prof1983@ya.ru>
@Created 24.05.2011
@LastMod 28.11.2012
}
unit AStrings;

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

// --- AStrings ---

function AStrings_Init(): AError; stdcall;

// ----

function Init(): AError; stdcall;
function Done(): AError; stdcall;

function String_Assign(var S: AString_Type; const Value: AString_Type): ASize; stdcall; deprecated; // Use AString_Assign()
function String_AssignA(var S: AString_Type; Value: PAnsiChar): ASize; stdcall; deprecated; // Use AString_AssignA()
function String_AssignP(var S: AString_Type; const Value: APascalString): ASize; stdcall;
function String_AssignWS(var S: AString_Type; const Value: AWideString): ASize; stdcall; deprecated; // Use AString_AssignWS()
function String_Copy(var S: AString_Type; const Value: AString_Type): ASize; stdcall; deprecated; // Use AString_Copy()
function String_CopyA(var S: AString_Type; const Value: AnsiString): ASize; stdcall; deprecated; // Use AString_CopyA()
function String_CopyW(var S: AString_Type; const Value: WideString): ASize; stdcall; deprecated; // Use AString_CopyWS()
function String_Length(const S: AString_Type): AInteger; stdcall; deprecated; // Use AString_GetLength()
//function String_NewC(Value: PChar): AString;
//function String_NewW(const Value: AWideString): AString;
function String_ToPascalString(const S: AString_Type): APascalString; stdcall; deprecated; // Use AString_ToPascalString()
function String_ToUtf8String(const S: AString_Type): UTF8String; stdcall;
function String_ToWideString(const S: AString_Type): WideString; stdcall;
function String_Free(var S: AString_Type): AInteger; stdcall; deprecated; // Use AString_Clear()

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

{ Public }

function Done(): AError; stdcall;
begin
  Result := 0;
end;

function Init(): AError; stdcall;
begin
  Result := AStrings_Init();
end;

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
    if (S.AllocSize < Size) then
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

function AString_GetChar(const S: AString_Type; Index: AInt): AChar; stdcall;
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

function AString_ToPascalString(const S: AString_Type): APascalString; stdcall;
var
  A: AnsiString;
begin
  A := S.Str;
  Result := A;
end;

function AString_ToWideString(const S: AString_Type): WideString;
begin
  Result := AString_ToPascalString(S);
end;

// --- AStrings ---

function AStrings_Init(): AError;
begin
  Result := 0;
end;

{ String }

function String_Assign(var S: AString_Type; const Value: AString_Type): ASize; stdcall;
begin
  Result := AString_Assign(S, Value);
end;

function String_AssignA(var S: AString_Type; Value: PAnsiChar): ASize; stdcall;
begin
  Result := AString_AssignA(S, Value);
end;

function String_AssignP(var S: AString_Type; const Value: APascalString): ASize;
begin
  Result := AString_AssignA(S, AStr(AnsiString(Value)));
end;

function String_AssignWS(var S: AString_Type; const Value: AWideString): ASize; stdcall;
begin
  Result := AString_AssignWS(S, Value);
end;

function String_Copy(var S: AString_Type; const Value: AString_Type): ASize; stdcall;
begin
  Result := AString_Copy(S, Value);
end;

function String_CopyA(var S: AString_Type; const Value: AnsiString): ASize; stdcall;
begin
  Result := AString_CopyA(S, AStr(Value));
end;

function String_CopyW(var S: AString_Type; const Value: WideString): ASize; stdcall;
begin
  Result := AString_CopyWS(S, Value);
end;

function String_Free(var S: AString_Type): AInteger; stdcall;
begin
  Result := AString_Clear(S);
end;

function String_Length(const S: AString_Type): AInteger; stdcall;
begin
  Result := AString_GetLength(S);
end;

(*
function String_NewC(Value: PChar): AString;
begin
  {$IFDEF A03}
  ...
  {$ELSE}
  Result := Value;
  {$ENDIF}
end;
*)

(*
function String_NewW(const Value: AWideString): AString;
begin
  {$IFDEF A03}
  ...
  {$ELSE}
  Result := Value;
  {$ENDIF}
end;
*)

function String_ToPascalString(const S: AString_Type): APascalString; stdcall;
begin
  Result := AString_ToPascalString(S);
end;

function String_ToUtf8String(const S: AString_Type): UTF8String; stdcall;
begin
  Result := Utf8Encode(S.Str); //Result := A_String_ToUtf8String(S);
end;

function String_ToWideString(const S: AString_Type): WideString; stdcall;
begin
  Result := AString_ToPascalString(S);
end;

{ Str }

function Str_Assign({var} S: AString; {const} Value: AString): ASize; stdcall;
begin
  Result := AString_Assign(S^, Value^);
end;

function Str_AssignA({var} S: AString; Value: PAnsiChar): ASize; stdcall;
begin
  Result := AString_AssignA(S^, Value);
end;

function Str_AssignW({var} S: AString; {const} Value: PWideChar): ASize; stdcall;
var
  Tmp: WideString;
begin
  Tmp := WideString(Value);
  Result := String_AssignP(S^, Tmp);
end;

function Str_AssignWS({var} S: AString; const Value: WideString): ASize; stdcall;
begin
  Result := String_AssignP(S^, Value);
end;

function Str_Copy({var} S: AString; {const} Value: AString): ASize; stdcall;
begin
  Result := AString_Copy(S^, Value^);
end;

function Str_CopyA({var} S: AString; {const} Value: PAnsiChar): ASize; stdcall;
begin
  Result := AString_CopyA(S^, Value);
end;

function Str_CopyW({var} S: AString; {const} Value: PWideChar): ASize; stdcall;
begin
  Result := AString_CopyWS(S^, AWideString(Value));
end;

function Str_CopyWS({var} S: AString; const Value: WideString): ASize; stdcall;
begin
  Result := AString_CopyWS(S^, Value);
end;

function Str_Length({const} S: AString): AInteger; stdcall;
begin
  Result := AString_GetLength(S^);
end;

function Str_ToP({const} S: AString): APascalString; stdcall;
begin
  if not(Assigned(S)) then
  begin
    Result := '';
    Exit;
  end;
  Result := AString_ToPascalString(S^);
end;

function Str_ToUtf8String({const} S: AString): UTF8String; stdcall;
begin
  Result := String_ToUtf8String(S^);
end;

(*function Str_ToWS({const} S: AString): WideString; stdcall;
begin
  Result := String_ToWideString(S^);
end;*)

function Str_Free({var} S: AString): AError; stdcall;
begin
  Result := AString_Clear(S^);
end;

{ A_String }

(*
{$IFDEF A03}
function A_String_AssignW(var S: AString; const Value: WideString): ASize;
begin
  A_String_Clear(S);
  Result := A_String_CopyW(S, Value);
end;

function A_String_Clear(var S: AString): AInteger; stdcall;
begin
  FillChar(S, SizeOf(S), 0);
end;

function A_String_Copy(var S: AString_Type; const Value: AString_Type): ASize; stdcall;
begin
  A_String_Realloc(S, Value.Len);
  Move(Value.Str^, S.Str^, Value.AllocSize);
  S.Len := Value.Len;
  S.Code := Value.Code;
  Result := S.AllocSize;
end;

function A_String_CopyA(var S: AString_Type; const Value: string{AnsiString}): ASize; stdcall;
begin
  Result := A_String_CopyUtf8(S, AnsiToUtf8(Value));
  //Result := String_CopyW(S, WideString(Value));
end;

function A_String_CopyUtf8(var S: AString_Type; const Value: UTF8String{UnicodeString}): ASize; stdcall;
var
  W: WideString;
begin
  W := Utf8Decode(Value);
  A_String_Realloc(S, Length(Value)+1);
  Move(Value, S.Str^, Length(Value));
  S.Str[Length(Value)] := #0;
  S.Len := Length(W);
  S.Code := 1;
  Result := S.AllocSize;
end;

function A_String_CopyW(var S: AString_Type; const Value: WideString): ASize; stdcall;
{var
  I: Integer;}
begin
  Result := A_String_CopyUtf8(S, UTF8Encode(Value));
  {
  if (String_Realloc(S, Length(Value)) <> Length(Value)) then
  begin
    Result := 0;
    Exit;
  end;
  for I := 0 to Length(Value) do
  begin
    WideChar(Pointer(Integer(S.Str)+I*2)^) := WideChar(Value[I]);
  end;
  S.Str[Length(Value)+1] := #0;
  Result := S.Len;
  }
end;

function A_String_Free(var S: AString): AInteger; stdcall;
begin
  if Assigned(S.Str) then
    FreeMem(S.Str, S.AllocSize);
  A_String_Clear(S);
end;

function A_String_Length(const S: AString_Type): AInteger; stdcall;
begin
  Result := S.Len;
end;

function A_String_Realloc(var S: AString_Type; NewAllocSize: ASize): ASize; stdcall;
begin
  if not(Assigned(S.Str)) then
    GetMem(S.Str, NewAllocSize)
  else
  begin
    FreeMem(S.Str, S.AllocSize);
    GetMem(S.Str, NewAllocSize);
  end;
  S.Len := 0;
  S.AllocSize := NewAllocSize;
  Result := S.AllocSize;
end;

function A_String_ToUtf8String(const S: AString_Type): UTF8String; stdcall;
begin
  SetLength(Result, S.AllocSize);
  Move(S.Str^, Result, S.AllocSize);
end;

function A_String_ToWideString(const S: AString_Type): WideString; stdcall;
var
  U: UTF8String;
begin
  U := A_String_ToUTF8String(S);
  Result := Utf8Decode(U);
end;
{$ENDIF A03}
*)

end.
