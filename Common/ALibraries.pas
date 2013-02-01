{**
@Abstract ALibraries (.dll, .so)
@Author Prof1983 <prof1983@ya.ru>
@Created 02.10.2005
@LastMod 31.01.2013
}
unit ALibraries;

{$I Defines.inc}

{$IFNDEF NoSysUtils}{$DEFINE USE_SYSUTILS}{$ENDIF}

interface

uses
  {$IFDEF USE_SYSUTILS}SysUtils,{$ENDIF}
  ABase;

// --- ALibrary ---

function ALibrary_BuildPathP(const Directory, LibraryName: APascalString): APascalString; stdcall;

function ALibrary_Close(Lib: ALibrary): ABoolean; stdcall;

function ALibrary_GetNameP(Lib: ALibrary): APascalString; stdcall;

function ALibrary_GetProcAddressP(Lib: ALibrary; const Name: APascalString): Pointer; stdcall;

function ALibrary_GetSymbolP(Lib: ALibrary; const SymbolName: APascalString; var Symbol: Pointer): ABoolean; stdcall;

function ALibrary_OpenP(const FileName: APascalString; Flags: ALibraryFlags): ALibrary; stdcall;

implementation

type
  LPCSTR = PAnsiChar;
  BOOL = Boolean;
  FARPROC = Pointer;
  HMODULE = Integer;

// ----

type
  TALibraryRec = record
    FileName: APascalString;
    Handle: HMODULE;
  end;

var
  FLibraries: array of TALibraryRec;

{ API functions }

const
  kernel32  = 'kernel32.dll';

function _FreeLibrary(hLibModule: HMODULE): BOOL; stdcall; external kernel32 name 'FreeLibrary';
function _GetProcAddress(hModule: HMODULE; lpProcName: LPCSTR): FARPROC; stdcall; external kernel32 name 'GetProcAddress';
function _LoadLibrary(lpLibFileName: PAnsiChar): HMODULE; stdcall; external kernel32 name 'LoadLibraryA';

{ Private functions }

function _AddLibrary(const FileName: APascalString; Handle: HMODULE): Integer;
begin
  Result := Length(FLibraries);
  SetLength(FLibraries, Result + 1);
  FLibraries[Result].FileName := FileName;
  FLibraries[Result].Handle := Handle;
end;

procedure _DelLibrary(Index: Integer);
begin
  if (Index < 0) then Exit;
  FLibraries[Index] := FLibraries[High(FLibraries)];
  SetLength(FLibraries, High(FLibraries));
end;

function _FindLibraryByHandle(Handle: Integer): Integer;
var
  I: Integer;
begin
  for I := 0 to High(FLibraries) do
  begin
    if (FLibraries[I].Handle = HMODULE(Handle)) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

function _FindLibraryByFileName(const FileName: APascalString): Integer;
var
  I: Integer;
begin
  for I := 0 to High(FLibraries) do
  begin
    if (FLibraries[I].FileName = FileName) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

// --- ALibrary ---

function ALibrary_BuildPathP(const Directory, LibraryName: APascalString): APascalString;
begin
  try
    Result := LibraryName + '.dll';
    {$IFDEF USE_SYSUTILS}
    Result := ExpandFileName(Result);
    {$ENDIF}
  except
    Result := '';
  end;
end;

function ALibrary_Close(Lib: ALibrary): ABoolean;
var
  Index: Integer;
begin
  try
    if (Lib = 0) then
    begin
      Result := True;
      Exit;
    end;
    try
      _FreeLibrary(Lib{FHandle});
      Result := True;
    except
      Result := False;
    end;
    Index := _FindLibraryByHandle(Lib);
    _DelLibrary(Index);
  except
    Result := False;
  end;
end;

function ALibrary_GetNameP(Lib: ALibrary): APascalString;
{$IFDEF USE_SYSUTILS}
var
  Index: Integer;
{$ENDIF}
begin
  try
    {$IFDEF USE_SYSUTILS}
    Index := _FindLibraryByHandle(Lib);
    if (Index >= 0) then
    begin
      Result := ExtractFileName(FLibraries[Index].FileName);
      Result := ChangeFileExt(Result, '');
    end;
    {$ENDIF}
  except
    Result := '';
  end;
end;

function ALibrary_GetProcAddressP(Lib: ALibrary; const Name: APascalString): Pointer;
var
  S: AnsiString;
  P: PAnsiChar;
begin
  try
    S := AnsiString(Name);
    P := PAnsiChar(S);
    Result := _GetProcAddress(Lib{FHandle}, P);
  except
    Result := nil;
  end;
end;

function ALibrary_GetProcAddressWS(Lib: ALibrary; const Name: AWideString): Pointer;
begin
  try
    Result := ALibrary_GetProcAddressP(Lib, Name);
  except
    Result := nil;
  end;
end;

function ALibrary_GetSymbolP(Lib: ALibrary; const SymbolName: APascalString; var Symbol: Pointer): ABoolean;
begin
  try
    Symbol := ALibrary_GetProcAddressP(Lib, SymbolName);
    Result := (Symbol <> nil);
  except
    Result := False;
  end;
end;

function ALibrary_OpenP(const FileName: APascalString; Flags: ALibraryFlags): ALibrary;
var
  //Error: LongWord;
  Index: Integer;
  Handle: Integer;
  S: AnsiString;
begin
  try
    Index := _FindLibraryByFileName(FileName);
    if (Index >= 0) then
    begin
      Result := FLibraries[Index].Handle;
      Exit;
    end;

    if (FileName = '') then
    begin
      Result := 0;
      Exit;
    end;
    S := AnsiString(FileName);
    Handle := _LoadLibrary(PAnsiChar(S));
    if (Handle <= 32) then
    begin
      //Error := GetLastError;
      Result := 0;
      Exit;
    end;
    _AddLibrary(FileName, Handle);
    Result := Handle;
  except
    Result := 0;
  end;
end;

function ALibrary_OpenWS(const FileName: AWideString; Flags: ALibraryFlags): ALibrary;
begin
  Result := ALibrary_OpenP(FileName, Flags);
end;

end.
