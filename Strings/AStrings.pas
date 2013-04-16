{**
@Abstract AStrings
@Author Prof1983 <prof1983@ya.ru>
@Created 24.05.2011
@LastMod 16.04.2013
}
unit AStrings;

interface

uses
  ABase,
  AStringMain,
  AStringsMain;

// ---- Public ---

function Init(): AError; stdcall;
function Done(): AError; stdcall;

// --- String ---

function String_Assign(var S: AString_Type; const Value: AString_Type): ASize; stdcall; deprecated; // Use AString_Assign()
function String_AssignA(var S: AString_Type; Value: PAnsiChar): ASize; stdcall; deprecated; // Use AString_AssignA()
function String_AssignP(var S: AString_Type; const Value: APascalString): ASize; stdcall;
function String_AssignWS(var S: AString_Type; const Value: AWideString): ASize; stdcall; deprecated; // Use AString_AssignWS()
function String_Copy(var S: AString_Type; const Value: AString_Type): ASize; stdcall; deprecated; // Use AString_Copy()
function String_CopyA(var S: AString_Type; const Value: AnsiString): ASize; stdcall; deprecated; // Use AString_CopyA()
function String_CopyW(var S: AString_Type; const Value: WideString): ASize; stdcall; deprecated; // Use AString_CopyWS()
function String_Length(const S: AString_Type): AInteger; stdcall; deprecated; // Use AString_GetLength()
function String_ToPascalString(const S: AString_Type): APascalString; stdcall; deprecated; // Use AString_ToPascalString()
function String_ToUtf8String(const S: AString_Type): UTF8String; stdcall;
function String_ToWideString(const S: AString_Type): WideString; stdcall;
function String_Free(var S: AString_Type): AInteger; stdcall; deprecated; // Use AString_Clear()

implementation

// --- Public ---

function Done(): AError; stdcall;
begin
  Result := AStrings_Fin();
end;

function Init(): AError; stdcall;
begin
  Result := AStrings_Init();
end;

// --- String ---

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

end.
