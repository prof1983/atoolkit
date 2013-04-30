{**
@Abstract AStrings
@Author Prof1983 <prof1983@ya.ru>
@Created 24.05.2011
}
unit AStrings;

{define A01}
{define A02}
{define A03}
{define A04}

{$ifdef A01}
  {$define AStringTypeW}
{$endif}

{$ifdef A02}
  {$define AStringTypeW}
{$endif}

{$ifdef A03}
  {$define AStringTypeW}
{$endif}

interface

uses
  SysUtils,
  ABase;

// --- AStr ---

function AStr_AssignP(S: AStr; const Source: APascalString; MaxLen: AInt): AError;

function AStr_GetLength(S: AStr): AInt;

function AStr_ToPascalString(S: AStr): APascalString;

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

function AString_ToP(const S: AString_Type): APascalString;

function AString_ToPascalString(const S: AString_Type): APascalString; stdcall;

function AString_ToWideString(const S: AString_Type): WideString; stdcall;

// --- AnsiString ---

function AnsiString_GetChar(const S: AnsiString; Index: AInt): AnsiChar; stdcall;

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
// Use String_ToPascalString()
function Str_ToP({const} S: AString): APascalString; stdcall;
// Use String_ToUtf8String()
function Str_ToUtf8String({const} S: AString): UTF8String; stdcall;
//function Str_ToWS({const} S: AString): WideString; stdcall;
{$ifndef AStringTypeW}
function Str_Free({var} S: AString): AError; stdcall;
{$endif}

(*
{$IFDEF A03}
function A_String_AssignW(var S: AString; const Value: WideString): ASize;
function A_String_Clear(var S: AString_Type): AInteger; stdcall;
function A_String_Copy(var S: AString_Type; const Value: AString_Type): ASize; stdcall;
function A_String_CopyA(var S: AString_Type; const Value: string{AnsiString}): ASize; stdcall;
function A_String_CopyUtf8(var S: AString_Type; const Value: UTF8String{UnicodeString}): ASize; stdcall;
//function A_String_CopyUtf32(var S: AString_Type; const Value: UCS4String{UnicodeString}): ASize; stdcall;
function A_String_CopyW(var S: AString_Type; const Value: WideString): ASize; stdcall;
function A_String_Free(var S: AString_Type): AInteger; stdcall;
function A_String_Length(const S: AString_Type): AInteger; stdcall;
function A_String_Realloc(var S: AString_Type; NewAllocSize: ASize): ASize; stdcall;
function A_String_ToUtf8String(const S: AString_Type): UTF8String; stdcall;
function A_String_ToWideString(const S: AString_Type): WideString; stdcall;
{$ENDIF A03}
*)

{ StrLCopy copies at most MaxLen characters from Source to Dest and returns Dest. }
function StrLCopy(Dest: PAnsiChar; const Source: PAnsiChar; MaxLen: Cardinal): PAnsiChar;

{ StrPLCopy copies at most MaxLen characters from the Pascal style string
  Source into Dest and returns Dest. }
function StrPLCopy(Dest: PAnsiChar; const Source: AnsiString; MaxLen: Cardinal): PAnsiChar;

function StrCopyLWP(Dest: PWideChar; const Source: WideString; MaxLen: AUInt): PWideChar;

implementation

{ Str }

function StrCopyLWP(Dest: PWideChar; const Source: WideString; MaxLen: AUInt): PWideChar;
begin
  if (Length(Source) > Integer(MaxLen)) then
    Move(Source, Dest^, (MaxLen+1)*2)
  else
    Move(Source, Dest^, (Length(Source)+1)*2);
  Result := Dest;
end;

// From DelphiXE2
function StrLCopy(Dest: PAnsiChar; const Source: PAnsiChar; MaxLen: Cardinal): PAnsiChar;
var
  Len: Cardinal;
begin
  Result := Dest;
  Len := StrLen(Source);
  if Len > MaxLen then
    Len := MaxLen;
  Move(Source^, Dest^, Len * SizeOf(AnsiChar));
  Dest[Len] := #0;
end;
// from SysUtils (Delphi7)
{function StrLCopy(Dest: PAnsiChar; const Source: PAnsiChar; MaxLen: Cardinal): PAnsiChar; assembler;
asm
        PUSH    EDI
        PUSH    ESI
        PUSH    EBX
        MOV     ESI,EAX
        MOV     EDI,EDX
        MOV     EBX,ECX
        XOR     AL,AL
        TEST    ECX,ECX
        JZ      @@1
        REPNE   SCASB
        JNE     @@1
        INC     ECX
@@1:    SUB     EBX,ECX
        MOV     EDI,ESI
        MOV     ESI,EDX
        MOV     EDX,EDI
        MOV     ECX,EBX
        SHR     ECX,2
        REP     MOVSD
        MOV     ECX,EBX
        AND     ECX,3
        REP     MOVSB
        STOSB
        MOV     EAX,EDX
        POP     EBX
        POP     ESI
        POP     EDI
end;}

{ From DelphiXE2
  The initial developer of the original code is Fastcode.
  Portions created by the initial developer are Copyright (C) 2002-2007 the initial developer.
  Contributor(s): Pierre le Riche }
function StrLen(const Str: PAnsiChar): Cardinal;
asm //StackAlignSafe
        {Check the first byte}
        CMP BYTE PTR [EAX], 0
        JE @ZeroLength
        {Get the negative of the string start in edx}
        MOV EDX, EAX
        NEG EDX
        {Word align}
        ADD EAX, 1
        AND EAX, -2
@ScanLoop:
        MOV CX, [EAX]
        ADD EAX, 2
        TEST CL, CH
        JNZ @ScanLoop
        TEST CL, CL
        JZ @ReturnLess2
        TEST CH, CH
        JNZ @ScanLoop
        LEA EAX, [EAX + EDX - 1]
        RET
@ReturnLess2:
        LEA EAX, [EAX + EDX - 2]
        RET
@ZeroLength:
        XOR EAX, EAX
end;
// from SysUtils (Delphi7)
{function StrLen(const Str: PChar): Cardinal; assembler;
asm
        MOV     EDX,EDI
        MOV     EDI,EAX
        MOV     ECX,0FFFFFFFFH
        XOR     AL,AL
        REPNE   SCASB
        MOV     EAX,0FFFFFFFEH
        SUB     EAX,ECX
        MOV     EDI,EDX
end;}

function StrPLCopy(Dest: PAnsiChar; const Source: AnsiString; MaxLen: Cardinal): PAnsiChar;
begin
  Result := StrLCopy(Dest, PAnsiChar(Source), MaxLen);
end;

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

function AnsiString_GetChar(const S: AnsiString; Index: AInt): AnsiChar;
begin
  if (Index >= 1) and (Length(S) >= Index) then
    Result := S[Index]
  else
    Result := #0;
end;

// --- AStr ---

function AStr_AssignP(S: AStr; const Source: APascalString; MaxLen: AInt): AError;
begin
  try
    StrPLCopy(S, AnsiString(Source), MaxLen);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AStr_GetLength(S: AStr): AInt;
begin
  Result := StrLen(S);
end;

function AStr_ToPascalString(S: AStr): APascalString;
begin
  Result := AnsiString(S);
end;

// --- AString ---

function AString_Assign(var S: AString_Type; const Value: AString_Type): AError;
begin
  {$ifdef AStringTypeW}
  S := Value;
  Result := 0;
  {$else}
  Result := AString_AssignA(S, Value.Str);
  {$endif}
end;

function AString_AssignA(var S: AString_Type; Value: AStr): AError;
{$ifndef AStringTypeW}
var
  Size: AInt;
{$endif}
begin
  try
    {$ifdef AStringTypeW}
    S.Str := Value;
    {$else}
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
    {$endif}
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
    {$ifndef AStringTypeW}
    S.Len := 0;
    {$endif}
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
    {$ifdef AStringTypeW}
    Result := Length(S.Str);
    {$else}
    Result := S.Len;
    {$endif}
  except
    Result := 0;
  end;
end;

function AString_ToP(const S: AString_Type): APascalString;
begin
  Result := AString_ToPascalString(S);
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

{$ifndef AStringTypeW}
function Str_Free({var} S: AString): AError; stdcall;
begin
  Result := AString_Clear(S^);
end;
{$endif}

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
