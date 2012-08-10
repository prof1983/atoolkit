{**
@Abstract ASystem libraries functions
@Author Prof1983 <prof1983@ya.ru>
@Created 10.08.2012
@LastMod 10.08.2012
}
unit ASystemLibraries;

interface

uses
  ABase, ALibraries;

function Library_Close(Lib: ALibrary): ABoolean; stdcall;

function Library_BuildPath({const} Directory, LibraryName: AString; {out} Value: AString): AInteger; stdcall;

function Library_BuildPathP(const Directory, LibraryName: APascalString): APascalString; stdcall;

function Library_BuildPathS(const Directory, LibraryName: AString_Type; out Value: AString_Type): AInteger; stdcall;

function Library_GetName(Lib: ALibrary; {out} Value: AString): AInteger; stdcall;

function Library_GetNameP(Lib: ALibrary): APascalString; stdcall;

function Library_GetNameS(Lib: ALibrary; out Value: AString_Type): AInteger; stdcall;

function Library_GetProcAddress(Lib: ALibrary; const Name: AString_Type): Pointer; stdcall;

function Library_GetProcAddressP(Lib: ALibrary; const Name: APascalString): Pointer; stdcall;

function Library_GetProcAddressS(Lib: ALibrary; {const} Name: AString): Pointer; stdcall;

function Library_GetProcAddressWS(Lib: ALibrary; const Name: AWideString): Pointer; stdcall;

function Library_GetSymbol(Lib: ALibrary; {const} SymbolName: AString; {var} Symbol: PPointer): ABoolean; stdcall;

function Library_GetSymbolP(Lib: ALibrary; const SymbolName: APascalString; var Symbol: Pointer): ABoolean; stdcall;

function Library_GetSymbolS(Lib: ALibrary; const SymbolName: AString_Type; var Symbol: Pointer): ABoolean; stdcall;

function Library_Open(const FileName: AString_Type; Flags: ALibraryFlags): ALibrary; stdcall;

function Library_OpenP(const FileName: APascalString; Flags: ALibraryFlags): ALibrary; stdcall;

function Library_OpenS({const} FileName: AString; Flags: ALibraryFlags): ALibrary; stdcall;

function Library_OpenWS(const FileName: AWideString; Flags: ALibraryFlags): ALibrary; stdcall;

implementation

// --- Library ---

function Library_BuildPath(Directory, LibraryName: AString; Value: AString): AInteger; stdcall;
begin
  Result := Library_BuildPathS(Directory^, LibraryName^, Value^);
end;

function Library_BuildPathP(const Directory, LibraryName: APascalString): APascalString; stdcall;
begin
  try
    Result := ALibraries.Library_BuildPath(Directory, LibraryName);
  except
    Result := '';
  end;
end;

function Library_BuildPathS(const Directory, LibraryName: AString_Type; out Value: AString_Type): AInteger; stdcall;
begin
  try
    Result := AStrings.String_AssignP(Value, Library_BuildPathP(
        AStrings.String_ToWideString(Directory),
        AStrings.String_ToWideString(LibraryName)));
  except
    Result := 0;
  end;
end;

function Library_Close(Lib: ALibrary): ABoolean; stdcall;
begin
  try
    Result := ALibraries.Library_Close(Lib);
  except
    Result := False;
  end;
end;

function Library_GetName(Lib: ALibrary; Value: AString): AInteger; stdcall;
begin
  Result := Library_GetNameS(Lib, Value^);
end;

function Library_GetNameP(Lib: ALibrary): APascalString; stdcall;
begin
  try
    Result := ALibraries.Library_GetName(Lib);
  except
    Result := '';
  end;
end;

function Library_GetNameS(Lib: ALibrary; out Value: AString_Type): AInteger; stdcall;
var
  TmpValue: APascalString;
begin
  try
    TmpValue := Library_GetNameP(Lib);
    Result := AStrings.String_AssignP(Value, TmpValue);
  except
    Result := 0;
  end;
end;

function Library_GetProcAddress(Lib: ALibrary; const Name: AString_Type): Pointer; stdcall;
begin
  try
    Result := ALibraries.Library_GetProcAddress(Lib, AStrings.String_ToWideString(Name));
  except
    Result := nil;
  end;
end;

function Library_GetProcAddressP(Lib: ALibrary; const Name: APascalString): Pointer; stdcall;
begin
  try
    Result := ALibraries.Library_GetProcAddress(Lib, Name);
  except
    Result := nil;
  end;
end;

function Library_GetProcAddressS(Lib: ALibrary; Name: AString): Pointer; stdcall;
begin
  Result := Library_GetProcAddress(Lib, Name^);
end;

function Library_GetProcAddressWS(Lib: ALibrary; const Name: AWideString): Pointer; stdcall;
begin
  try
    Result := ALibraries.Library_GetProcAddress(Lib, Name);
  except
    Result := nil;
  end;
end;

function Library_GetSymbol(Lib: ALibrary; SymbolName: AString; Symbol: PPointer): ABoolean; stdcall;
begin
  Result := Library_GetSymbolS(Lib, SymbolName^, Symbol^);
end;

function Library_GetSymbolP(Lib: ALibrary; const SymbolName: APascalString; var Symbol: Pointer): ABoolean; stdcall;
begin
  try
    Result := ALibraries.Library_GetSymbol(Lib, SymbolName, Symbol);
  except
    Result := False;
  end;
end;

function Library_GetSymbolS(Lib: ALibrary; const SymbolName: AString_Type; var Symbol: Pointer): ABoolean; stdcall;
begin
  try
    Result := Library_GetSymbolP(Lib, AStrings.String_ToWideString(SymbolName), Symbol);
  except
    Result := False;
  end;
end;

function Library_Open(const FileName: AString_Type; Flags: ALibraryFlags): ALibrary; stdcall;
begin
  try
    Result := ALibraries.Library_Open(AStrings.String_ToWideString(FileName), Flags);
  except
    Result := 0;
  end;
end;

function Library_OpenP(const FileName: APascalString; Flags: ALibraryFlags): ALibrary; stdcall;
begin
  try
    Result := ALibraries.Library_Open(FileName, Flags);
  except
    Result := 0;
  end;
end;

function Library_OpenS(FileName: AString; Flags: ALibraryFlags): ALibrary; stdcall;
begin
  Result := Library_Open(FileName^, Flags);
end;

function Library_OpenWS(const FileName: AWideString; Flags: ALibraryFlags): ALibrary; stdcall;
begin
  try
    Result := ALibraries.Library_Open(FileName, Flags);
  except
    Result := 0;
  end;
end;

end.
