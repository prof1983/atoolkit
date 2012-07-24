{**
@Abstract ALibraries (.dll, .so)
@Author Prof1983 <prof1983@ya.ru>
@Created 02.10.2005
@LastMod 24.07.2012
}
unit ALibraries;

{$I Defines.inc}

interface

uses
  {$IFNDEF NoSysUtils}SysUtils,{$ENDIF}
  ABase;

function Library_Open(const FileName: APascalString; Flags: ALibraryFlags): ALibrary; stdcall;

function Library_Close(Lib: ALibrary): ABoolean; stdcall;

function Library_BuildPath(const Directory, LibraryName: APascalString): APascalString; stdcall;

function Library_GetName(Lib: ALibrary): APascalString; stdcall;

function Library_GetProcAddress(Lib: ALibrary; const Name: APascalString): Pointer; stdcall;

function Library_GetSymbol(Lib: ALibrary; const SymbolName: APascalString; var Symbol: Pointer): ABoolean; stdcall;

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

function FreeLibrary(hLibModule: HMODULE): BOOL; stdcall; external kernel32 name 'FreeLibrary';
function GetProcAddress(hModule: HMODULE; lpProcName: LPCSTR): FARPROC; stdcall; external kernel32 name 'GetProcAddress';
function LoadLibrary(lpLibFileName: PAnsiChar): HMODULE; stdcall; external kernel32 name 'LoadLibraryA';

{ Private functions }

function AddLibrary(const FileName: APascalString; Handle: HMODULE): Integer;
begin
  Result := Length(FLibraries);
  SetLength(FLibraries, Result + 1);
  FLibraries[Result].FileName := FileName;
  FLibraries[Result].Handle := Handle;
end;

procedure DelLibrary(Index: Integer);
begin
  if (Index < 0) then Exit;
  FLibraries[Index] := FLibraries[High(FLibraries)];
  SetLength(FLibraries, High(FLibraries));
end;

function FindLibraryByHandle(Handle: Integer): Integer;
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

function FindLibraryByFileName(const FileName: APascalString): Integer;
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

{ Public Functions }

function Library_BuildPath(const Directory, LibraryName: APascalString): APascalString; stdcall;
begin
  Result := LibraryName + '.dll';
  {$IFNDEF NoSysUtils}
  Result := ExpandFileName(Result);
  {$ENDIF}
end;

function Library_Close(Lib: ALibrary): ABoolean; stdcall;
var
  Index: Integer;
begin
  if (Lib = 0) then
  begin
    Result := True;
    Exit;
  end;
  try
    FreeLibrary(Lib{FHandle});
    Result := True;
  except
    Result := False;
  end;
  Index := FindLibraryByHandle(Lib);
  DelLibrary(Index);
end;

function Library_GetName(Lib: ALibrary): APascalString; stdcall;
{$IFNDEF NoSysUtils}
var
  Index: Integer;
{$ENDIF}
begin
  {$IFNDEF NoSysUtils}
  Index := FindLibraryByHandle(Lib);
  if (Index >= 0) then
  begin
    Result := ExtractFileName(FLibraries[Index].FileName);
    Result := ChangeFileExt(Result, '');
  end;
  {$ENDIF}
end;

function Library_GetProcAddress(Lib: ALibrary; const Name: APascalString): Pointer; stdcall;
var
  S: AnsiString;
  P: PAnsiChar;
begin
  S := AnsiString(Name);
  P := PAnsiChar(S);
  Result := GetProcAddress(Lib{FHandle}, P);
end;

function Library_GetSymbol(Lib: ALibrary; const SymbolName: APascalString; var Symbol: Pointer): ABoolean; stdcall;
begin
  Symbol := Library_GetProcAddress(Lib, SymbolName);
  Result := (Symbol <> nil);
end;

function Library_Open(const FileName: APascalString; Flags: ALibraryFlags): ALibrary; stdcall;
var
  //Error: LongWord;
  Index: Integer;
  Handle: Integer;
  S: AnsiString;
begin
  Index := FindLibraryByFileName(FileName);
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
  S := string(FileName);
  Handle := LoadLibrary(PAnsiChar(S));
  if (Handle <= 32) then
  begin
    //Error := GetLastError;
    Result := 0;
    Exit;
  end;
  AddLibrary(FileName, Handle);
  Result := Handle;
end;

end.
