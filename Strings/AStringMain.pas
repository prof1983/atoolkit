{**
@Abstract AStrings
@Author Prof1983 <prof1983@ya.ru>
@Created 24.05.2011
@LastMod 11.04.2013
}
unit AStringMain;

{define AStdCall}

interface

uses
  SysUtils,
  ABase, AStringBaseUtils;

// --- AString ---

function AString_Assign(var S: AString_Type; const Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AString_AssignA(var S: AString_Type; Value: AStr): AError; {$ifdef AStdCall}stdcall;{$endif}

function AString_AssignP(var S: AString_Type; const Value: APascalString): AError;

function AString_AssignWS(var S: AString_Type; const Value: AWideString): AError;

function AString_Clear(var S: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AString_Copy(var S: AString_Type; const Value: AString_Type): ASize; {$ifdef AStdCall}stdcall;{$endif}

function AString_CopyA(var S: AString_Type; const Value: AStr): ASize; {$ifdef AStdCall}stdcall;{$endif}

function AString_CopyWS(var S: AString_Type; const Value: AWideString): ASize;

function AString_GetChar(const S: AString_Type; Index: AInt): AChar; {$ifdef AStdCall}stdcall;{$endif}

function AString_GetLength(const S: AString_Type): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AString_Set(var S: AString_Type; const Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AString_SetA(var S: AString_Type; Value: AStr): AError; {$ifdef AStdCall}stdcall;{$endif}

function AString_SetP(var S: AString_Type; const Value: APascalString): AError;

function AString_ToP(const S: AString_Type): APascalString;

function AString_ToPascalString(const S: AString_Type): APascalString;

function AString_ToWideString(const S: AString_Type): WideString;

// --- AnsiString ---

function AnsiString_GetChar(const S: AnsiString; Index: AInt): AChar;

// ----

function Str_Assign({var} S: AString; {const} Value: AString): ASize; stdcall;
function Str_AssignA({var} S: AString; Value: PAnsiChar): ASize; stdcall;
function Str_AssignW({var} S: AString; {const} Value: PWideChar): ASize; stdcall;
function Str_AssignWS({var} S: AString; const Value: WideString): ASize; stdcall;
function Str_Copy({var} S: AString; {const} Value: AString): ASize; stdcall;
function Str_CopyA({var} S: AString; {const} Value: PAnsiChar): ASize; stdcall;
function Str_CopyW({var} S: AString; {const} Value: PWideChar): ASize; stdcall;
function Str_CopyWS({var} S: AString; const Value: WideString): ASize; stdcall;
function Str_Length({const} S: AString): AInt; stdcall;
function Str_ToP({const} S: AString): APascalString; stdcall;
function Str_ToUtf8String({const} S: AString): UTF8String; stdcall;
function Str_Free({var} S: AString): AError; stdcall;

implementation

type
  PStr = ^AString_Type;

// --- AnsiString ---

function AnsiString_GetChar(const S: AnsiString; Index: AInt): AChar;
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
    S.Str := nil;
    S.Len := 0;
    S.AllocSize := 0;
    S.Code := 1;
    Result := 0;
  except
    Result := -1;
  end;
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

function AString_GetLength(const S: AString_Type): AInt;
begin
  try
    Result := S.Len;
  except
    Result := 0;
  end;
end;

function AString_Set(var S: AString_Type; const Value: AString_Type): AError;
begin
  FillChar(S, SizeOf(AString_Type), 0);
  Result := AString_Assign(S, Value);
end;

function AString_SetA(var S: AString_Type; Value: AStr): AError;
begin
  FillChar(S, SizeOf(AString_Type), 0);
  Result := AString_AssignA(S, Value);
end;

function AString_SetP(var S: AString_Type; const Value: APascalString): AError;
begin
  FillChar(S, SizeOf(AString_Type), 0);
  Result := AString_AssignP(S, Value);
end;

function AString_ToP(const S: AString_Type): APascalString;
begin
  Result := AString_ToPascalString(S);
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

function Str_Assign(S: AString; Value: AString): ASize;
begin
  Result := AString_Assign(PStr(S)^, PStr(Value)^);
end;

function Str_AssignA(S: AString; Value: AStr): ASize;
begin
  Result := AString_AssignA(PStr(S)^, Value);
end;

function Str_AssignW(S: AString; Value: PWideChar): ASize;
var
  Tmp: WideString;
begin
  Tmp := WideString(Value);
  Result := AString_AssignP(PStr(S)^, Tmp);
end;

function Str_AssignWS(S: AString; const Value: WideString): ASize;
begin
  Result := AString_AssignP(PStr(S)^, Value);
end;

function Str_Copy(S: AString; Value: AString): ASize;
begin
  Result := AString_Copy(PStr(S)^, PStr(Value)^);
end;

function Str_CopyA(S: AString; Value: AStr): ASize;
begin
  Result := AString_CopyA(PStr(S)^, Value);
end;

function Str_CopyW(S: AString; Value: PWideChar): ASize;
begin
  Result := AString_CopyWS(PStr(S)^, AWideString(Value));
end;

function Str_CopyWS(S: AString; const Value: WideString): ASize;
begin
  Result := AString_CopyWS(PStr(S)^, Value);
end;

function Str_Free(S: AString): AError;
begin
  Result := AString_Clear(PStr(S)^);
end;

function Str_Length(S: AString): AInt;
begin
  Result := AString_GetLength(PStr(S)^);
end;

function Str_ToP(S: AString): APascalString;
begin
  if (S = 0) then
  begin
    Result := '';
    Exit;
  end;
  Result := AString_ToPascalString(PStr(S)^);
end;

function Str_ToUtf8String(S: AString): UTF8String;
begin
  Result := AString_ToUtf8String(PStr(S)^);
end;

end.
