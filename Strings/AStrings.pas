{**
@Abstract AStrings
@Author Prof1983 <prof1983@ya.ru>
@Created 24.05.2011
@LastMod 24.07.2012

0.0.5
[+] String_ToPascalString (01.08.2011)
[*] A_String_AssignC -> A_String_AssignA (01.09.2011)
[+] String_AssignWS (01.09.2011)
}
unit AStrings;

{
Null-terminated string functions 
Function       Description
StrAlloc       Allocates a character buffer of a given size on the heap.
StrBufSize     Returns the size of a character buffer allocated using StrAlloc or StrNew.
StrCat         Concatenates two strings.
StrComp        Compares two strings.
StrCopy        Copies a string.
StrDispose     Disposes a character buffer allocated using StrAlloc or StrNew.
StrECopy       Copies a string and returns a pointer to the end of the string.
StrEnd         Returns a pointer to the end of a string.
StrFmt         Formats one or more values into a string.
StrIComp       Compares two strings without case sensitivity.
StrLCat        Concatenates two strings with a given maximum length of the resulting string.
StrLComp       Compares two strings for a given maximum length.
StrLCopy       Copies a string up to a given maximum length.
StrLen         Returns the length of a string.
StrLFmt        Formats one or more values into a string with a given maximum length.
StrLIComp      Compares two strings for a given maximum length without case sensitivity.
StrLower       Converts a string to lowercase.
StrMove        Moves a block of characters from one string to another.
StrNew         Allocates a string on the heap.
StrPCopy       Copies a Pascal string to a null-terminated string.
StrPLCopy      Copies a Pascal string to a null-terminated string with a given maximum length.
StrPos         Returns a pointer to the first occurrence of a given substring within a string.
StrRScan       Returns a pointer to the last occurrence of a given character within a string.
StrScan        Returns a pointer to the first occurrence of a given character within a string.
StrUpper       Converts a string to uppercase.

Глава 14. Строковые и символьные функции
    isalnum
    isalpha
    isblank
    iscntrl
    isdigit
    isgraph
    islower
    isprint
    ispunct
    isspace
    isupper
    isxdigit
    memchr
    memcmp
    memcpy
    memmove
    memset
    strcat
    strchr
    strcmp
    strcoll
    strcpy - Функция strcpy() копирует содержимое строки str2 в строку str1. Параметр str2 должен указывать на строку с завершающим нулевым символом. Функция strcpy() возвращает значение указателя str1. 
    strcspn
    strerror
    strlen
    strncat
    strncmp
    strncpy
    strpbrk
    strrchr
    strspn
    strstr
    strtok
    strxfrm
    tolower
    toupper
}

interface

uses
  ABase;

{$IFDEF A01}
type
  AString = ^AString_Type;
{$ENDIF A01}

function Init(): AError; stdcall;
function Done(): AError; stdcall;

function AnsiString_GetChar(const S: AnsiString; Index: AInt): AChar; stdcall;

function AString_Assign(var S: AString_Type; const Value: AString_Type): ASize; stdcall;
function AString_AssignAnsi(var S: AString_Type; Value: PAnsiChar): ASize; stdcall;
function AString_GetChar(const S: AString_Type; Index: AInt): AChar; stdcall;
function AString_ToPascalString(const S: AString_Type): APascalString; stdcall;

function String_Assign(var S: AString_Type; const Value: AString_Type): ASize; stdcall; deprecated; // Use AString_Assign()
function String_AssignA(var S: AString_Type; Value: PAnsiChar): ASize; stdcall;
function String_AssignP(var S: AString_Type; const Value: APascalString): ASize; stdcall;
function String_AssignWS(var S: AString_Type; const Value: AWideString): ASize; stdcall;
function String_Copy(var S: AString_Type; const Value: AString_Type): ASize; stdcall;
function String_CopyA(var S: AString_Type; const Value: AnsiString): ASize; stdcall;
function String_CopyW(var S: AString_Type; const Value: WideString): ASize; stdcall;
function String_Length(const S: AString_Type): AInteger; stdcall;
//function String_NewC(Value: PChar): AString;
//function String_NewW(const Value: AWideString): AString;
function String_ToPascalString(const S: AString_Type): APascalString; stdcall;
function String_ToUtf8String(const S: AString_Type): UTF8String; stdcall;
function String_ToWideString(const S: AString_Type): WideString; stdcall;
function String_Free(var S: AString_Type): AInteger; stdcall;

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
function Str_Free({var} S: AString): AError; stdcall;

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

function StrLCopy(Dest: PAnsiChar; const Source: PAnsiChar; MaxLen: Cardinal): PAnsiChar; assembler;
// from SysUtils (Delphi7)
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
end;

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
  Result := 0;
end;

// --- AnsiString ---

function AnsiString_GetChar(const S: AnsiString; Index: AInt): AChar; stdcall;
{$IFDEF ABaseOld}
var
  WS: WideString;
{$ENDIF ABaseOld}
begin
  if (Index >= 1) and (Length(S) >= Index) then
  begin
    {$IFDEF ABaseOld}
    WS := S;
    Result := WS[Index];
    {$ELSE}
    Result := S[Index];
    {$ENDIF ABaseOld}
  end
  else
    Result := #0;
end;

// --- AString ---

function AString_Assign(var S: AString_Type; const Value: AString_Type): ASize; stdcall;
begin
  try
    S := Value;
  except
  end;
  Result := 0;
end;

function AString_AssignAnsi(var S: AString_Type; Value: PAnsiChar): ASize; stdcall;
begin
  Result := String_AssignA(S, Value);
end;

function AString_GetChar(const S: AString_Type; Index: AInt): AChar; stdcall;
begin
  if (Index >= 1) and (Length(S.Str) >= Index) then
    Result := S.Str[Index]
  else
    Result := #0;
end;

function AString_ToPascalString(const S: AString_Type): APascalString; stdcall;
begin
  Result := String_ToPascalString(S);
end;

{ String }

function String_Assign(var S: AString_Type; const Value: AString_Type): ASize; stdcall;
begin
  Result := AString_Assign(S, Value);
end;

function String_AssignA(var S: AString_Type; Value: PAnsiChar): ASize; stdcall;
begin
  try
    S.Str := Value;
  except
  end;
  Result := 0;
end;

function String_AssignP(var S: AString_Type; const Value: APascalString): ASize; stdcall;
begin
  try
    S.Str := Value;
  except
  end;
  Result := 0;
end;

function String_AssignWS(var S: AString_Type; const Value: AWideString): ASize; stdcall;
begin
  try
    S.Str := Value;
  except
  end;
  Result := 0;
end;

function String_Copy(var S: AString_Type; const Value: AString_Type): ASize; stdcall;
begin
  try
    S.Str := Value.Str;
  except
  end;
  Result := 0;
end;

function String_CopyA(var S: AString_Type; const Value: AnsiString): ASize; stdcall;
begin
  try
    S.Str := Value;
  except
  end;
  Result := 0;
end;

function String_CopyW(var S: AString_Type; const Value: WideString): ASize; stdcall;
begin
  try
    S.Str := Value;
  except
  end;
  Result := 0;
end;

function String_Free(var S: AString_Type): AInteger; stdcall;
begin
  try
    S.Str := '';
  except
  end;
  Result := 0;
end;

function String_Length(const S: AString_Type): AInteger; stdcall;
begin
  try
    Result := Length(S.Str);
  except
    Result := 0;
  end;
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
  Result := S.Str;
end;

function String_ToUtf8String(const S: AString_Type): UTF8String; stdcall;
begin
  Result := Utf8Encode(S.Str); //Result := A_String_ToUtf8String(S);
end;

function String_ToWideString(const S: AString_Type): WideString; stdcall;
begin
  Result := Str_ToP(Addr(S));
end;

{ Str }

function Str_Assign({var} S: AString; {const} Value: AString): ASize; stdcall;
begin
  Result := AString_Assign(S^, Value^);
end;

function Str_AssignA({var} S: AString; Value: PAnsiChar): ASize; stdcall;
begin
  Result := String_AssignA(S^, Value);
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
  Result := String_Copy(S^, Value^);
end;

function Str_CopyA({var} S: AString; {const} Value: PAnsiChar): ASize; stdcall;
begin
  Result := String_CopyA(S^, AnsiString(Value));
end;

function Str_CopyW({var} S: AString; {const} Value: PWideChar): ASize; stdcall;
begin
  Result := String_CopyW(S^, WideString(Value));
end;

function Str_CopyWS({var} S: AString; const Value: WideString): ASize; stdcall;
begin
  Result := String_CopyW(S^, Value);
end;

function Str_Length({const} S: AString): AInteger; stdcall;
begin
  Result := String_Length(S^);
end;

function Str_ToP({const} S: AString): APascalString; stdcall;
begin
  Result := S^.Str;
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
  Result := String_Free(S^);
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
