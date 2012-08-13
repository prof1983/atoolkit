{**
@Abstract ALibraries functions
@Author Prof1983 <prof1983@ya.ru>
@Created 13.08.2012
@LastMod 13.08.2012
}
unit ALibrariesS;

interface

uses
  AStrings;

// --- ALibrary ---

function ALibrary_BuildPath({const} Directory, LibraryName: AString; {out} Value: AString): AInteger; stdcall;

function ALibrary_BuildPathS(const Directory, LibraryName: AString_Type; out Value: AString_Type): AInteger; stdcall;

function ALibrary_GetName(Lib: ALibrary; {out} Value: AString): AInteger; stdcall;

function ALibrary_GetNameS(Lib: ALibrary; out Value: AString_Type): AInteger; stdcall;

function ALibrary_GetProcAddress(Lib: ALibrary; const Name: AString_Type): Pointer; stdcall;

function ALibrary_GetProcAddressS(Lib: ALibrary; {const} Name: AString): Pointer; stdcall;

function ALibrary_GetSymbol(Lib: ALibrary; {const} SymbolName: AString; {var} Symbol: PPointer): ABoolean; stdcall;

function ALibrary_GetSymbolS(Lib: ALibrary; const SymbolName: AString_Type; var Symbol: Pointer): ABoolean; stdcall;

function ALibrary_Open(const FileName: AString_Type; Flags: ALibraryFlags): ALibrary; stdcall;

function ALibrary_OpenS({const} FileName: AString; Flags: ALibraryFlags): ALibrary; stdcall;

implementation

// --- ALibrary ---

function ALibrary_BuildPath(Directory, LibraryName: AString; Value: AString): AInteger;
begin
  Result := ALibrary_BuildPathS(Directory^, LibraryName^, Value^);
end;

function ALibrary_BuildPathS(const Directory, LibraryName: AString_Type; out Value: AString_Type): AInteger;
begin
  try
    Result := AStrings.String_AssignP(Value, ALibrary_BuildPathP(
        AStrings.String_ToWideString(Directory),
        AStrings.String_ToWideString(LibraryName)));
  except
    Result := 0;
  end;
end;

function ALibrary_GetName(Lib: ALibrary; Value: AString): AInteger;
begin
  Result := ALibrary_GetNameS(Lib, Value^);
end;

function ALibrary_GetNameS(Lib: ALibrary; out Value: AString_Type): AInteger;
var
  TmpValue: APascalString;
begin
  try
    TmpValue := ALibrary_GetNameP(Lib);
    Result := AStrings.String_AssignP(Value, TmpValue);
  except
    Result := 0;
  end;
end;

function ALibrary_GetProcAddress(Lib: ALibrary; const Name: AString_Type): Pointer;
begin
  try
    Result := ALibrary_GetProcAddressP(Lib, AStrings.String_ToWideString(Name));
  except
    Result := nil;
  end;
end;

function ALibrary_GetProcAddressS(Lib: ALibrary; Name: AString): Pointer;
begin
  Result := ALibrary_GetProcAddress(Lib, Name^);
end;

function ALibrary_GetSymbol(Lib: ALibrary; SymbolName: AString; Symbol: PPointer): ABoolean;
begin
  Result := ALibrary_GetSymbolS(Lib, SymbolName^, Symbol^);
end;

function ALibrary_GetSymbolS(Lib: ALibrary; const SymbolName: AString_Type; var Symbol: Pointer): ABoolean;
begin
  try
    Result := ALibrary_GetSymbolP(Lib, AStrings.String_ToWideString(SymbolName), Symbol);
  except
    Result := False;
  end;
end;

function ALibrary_Open(const FileName: AString_Type; Flags: ALibraryFlags): ALibrary;
begin
  try
    Result := ALibrary_OpenP(AStrings.String_ToWideString(FileName), Flags);
  except
    Result := 0;
  end;
end;

function ALibrary_OpenS(FileName: AString; Flags: ALibraryFlags): ALibrary;
begin
  Result := ALibrary_Open(FileName^, Flags);
end;

end.
 