{**
@Abstract AStrings
@Author Prof1983 <prof1983@ya.ru>
@Created 24.05.2011
@LastMod 01.02.2013
}
unit AStrings;

TODO: Use AStringMain.pas

interface

uses
  SysUtils,
  ABase, AStringBaseUtils;

// --- AnsiString ---

function AnsiString_GetChar(const S: AnsiString; Index: AInt): AChar; stdcall;

// --- AStrings ---

function AStrings_Init(): AError; stdcall;

// ----

function Init(): AError; stdcall;
function Done(): AError; stdcall;

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

// --- AStrings ---

function AStrings_Init(): AError;
begin
  Result := 0;
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

function Str_Free({var} S: AString): AError; stdcall;
begin
  Result := AString_Clear(S^);
end;

end.
