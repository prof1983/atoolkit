{**
@Author Prof1983 <prof1983@ya.ru>
@Created 28.11.2012
@LastMod 29.01.2013
}
unit AStringBaseUtils;

interface

uses
  ABase;

// --- AStr ---

function AStr_AssignA(S: AStr; Source: AStr; MaxLen: AInt): AError;

function AStr_AssignP(S: AStr; const Source: APascalString; MaxLen: AInt): AError;

function AStr_GetLength(S: AStr): AInt;

function AStr_ToPascalString(S: AStr): APascalString;

// ----

{** StrLCopy copies at most MaxLen characters from Source to Dest and returns Dest. }
function StrLCopy(Dest: PAnsiChar; const Source: PAnsiChar; MaxLen: Cardinal): PAnsiChar;

{** The initial developer of the original code is Fastcode.
    Portions created by the initial developer are Copyright (C) 2002-2007 the initial developer.
    Contributor(s): Pierre le Riche }
function StrLen(const Str: PAnsiChar): Cardinal;

{** StrPLCopy copies at most MaxLen characters from the Pascal style string
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

// From DelphiXE2
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

function StrPLCopy(Dest: PAnsiChar; const Source: AnsiString; MaxLen: Cardinal): PAnsiChar;
begin
  Result := StrLCopy(Dest, PAnsiChar(Source), MaxLen);
end;

// --- AStr ---

function AStr_AssignA(S: AStr; Source: AStr; MaxLen: AInt): AError;
begin
  try
    StrLCopy(S, Source, MaxLen);
    Result := 0;
  except
    Result := -1;
  end;
end;

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
  Result := APascalString(AnsiString(S));
end;

end.
