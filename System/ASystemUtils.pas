{**
@Author Prof1983 <prof1983@ya.ru>
@Created 29.05.2011
@LastMod 29.01.2013
}
unit ASystemUtils;

{$I Defines.inc}

{$IFDEF UNIX}
  {$DEFINE NoRuntimeSysUtils}
{$ENDIF}

{$IFNDEF NoRuntimeSysUtils}
  {$DEFINE USE_SYSUTILS}
  {$DEFINE UseSysUtils}
{$ENDIF NoRuntimeSysUtils}

interface

uses
  {$IFDEF UseSysUtils}SysUtils,{$ENDIF}
  ABase, ASystemData;

function IntToHex4(Value: Integer): string;
function IntToHex8(Value: Integer): string;
function AGuidToString(const ID: TGuid): string;
{$IFNDEF USE_SYSUTILS}
function IsEqualGUID(const guid1, guid2: TGUID): Boolean;
{$ENDIF}
function NormalizePath(const Path: AnsiString): AnsiString;

function NormalizePath2(const Path: APascalString): APascalString;

procedure ExtractFileNameAndPathW(const FExeFileName: APascalString; var FExeName, FExePath: APascalString);

implementation

{$IFDEF NoSysUtils}
  const
  {$IFDEF MSWINDOWS}
    PathDelim = '\';
  {$ELSE}
    {$IFDEF UNIX}
      PathDelim = '/';
    {$ELSE}
      {$MESSAGE 'No MSWindows and no Unux'}
    {$ENDIF}
  {$ENDIF}
{$ENDIF NoSysUtils}

{ Private }

{$IFDEF MSWINDOWS}
type
  DWORD = LongWord;

const
  Kernel32 = 'kernel32.dll';

function GetFullPathName(lpFileName: PAnsiChar; nBufferLength: DWORD;
  lpBuffer: PAnsiChar; var lpFilePart: PAnsiChar): DWORD; stdcall; external Kernel32 name 'GetFullPathNameA';

function ExpandFileName(const FileName: AnsiString): AnsiString;
const
  MAX_PATH = 260;
var
  FName: PAnsiChar;
  Buffer: array[0..MAX_PATH - 1] of AnsiChar;
begin
  SetString(Result, Buffer, GetFullPathName(PAnsiChar(FileName), SizeOf(Buffer), Buffer, FName));
end;
{$ENDIF MSWINDOWS}

{ Procedures }

function IntToHex4(Value: Integer): string;
const
  A: array[0..15] of Char = ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F');
var
  B: Byte;
begin
  SetLength(Result, 4);
  B := Byte((Value shr 12) and $0F); Result[1] := A[B];
  B := Byte((Value shr 08) and $0F); Result[2] := A[B];
  B := Byte((Value shr 04) and $0F); Result[3] := A[B];
  B := Byte(Value and $0F);          Result[4] := A[B];
end;

function IntToHex8(Value: Integer): string;
const
  A: array[0..15] of Char = ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F');
var
  B: Byte;
begin
  SetLength(Result, 8);
  B := Byte((Value shr 28) and $0F); Result[1] := A[B];
  B := Byte((Value shr 24) and $0F); Result[2] := A[B];
  B := Byte((Value shr 20) and $0F); Result[3] := A[B];
  B := Byte((Value shr 16) and $0F); Result[4] := A[B];
  B := Byte((Value shr 12) and $0F); Result[5] := A[B];
  B := Byte((Value shr 08) and $0F); Result[6] := A[B];
  B := Byte((Value shr 04) and $0F); Result[7] := A[B];
  B := Byte(Value and $0F);          Result[8] := A[B];
end;

function AGuidToString(const ID: TGuid): string;
{$IFNDEF FPC}
var
  W: Word;
  I: Integer;
{$ENDIF}
begin
  {$IFDEF FPC}
  Result := '';
  {$ELSE}
  Result := IntToHex8(ID.D1)+'-'+IntToHex4(ID.D2)+'-'+IntToHex4(ID.D3)+'-';
  W := (ID.D4[0] shl 8)+ID.D4[1];
  Result := Result + IntToHex4(W)+'-';
  W := (ID.D4[2] shl 8)+ID.D4[3];
  Result := Result + IntToHex4(W);
  I := (ID.D4[4] shl 24)+(ID.D4[5] shl 16)+(ID.D4[6] shl 8)+ID.D4[7];
  Result := Result + IntToHex8(I);
  {$ENDIF}
end;

procedure ExtractFileNameAndPathW(const FExeFileName: APascalString; var FExeName, FExePath: APascalString);
var
  I: Integer;
begin
  for I := Length(FExeFileName) downto 1 do
    if (FExeFileName[I] = PathDelim) then
    begin
      FExeName := Copy(FExeFileName, I+1, Length(FExeFileName));
      FExePath := Copy(FExeFileName, 1, I);
      Exit;
    end;
end;

{$IFNDEF USE_SYSUTILS}
  {$IFDEF MSWINDOWS}
  function IsEqualGUID(const guid1, guid2: TGUID): Boolean; external 'ole32.dll' name 'IsEqualGUID';
  {$ENDIF}
  {$IFDEF UNIX}
  function IsEqualGUID(const guid1, guid2: TGUID): Boolean;
  var
    a, b: PIntegerArray;
  begin
    a := PIntegerArray(@guid1);
    b := PIntegerArray(@guid2);
    Result := (a^[0] = b^[0]) and (a^[1] = b^[1]) and (a^[2] = b^[2]) and (a^[3] = b^[3]);
  end;
  {$ENDIF}
{$ENDIF}

function NormalizePath(const Path: AnsiString): AnsiString;
begin
  if (Length(Path) = 0) then
    Result := AnsiString(FExePath)
  else
  begin
    if (Path[1] = '.') then
    begin
      {$IFDEF MSWINDOWS}
      Result := AnsiString(ExpandFileName(AnsiString(FExePath+Path)));
      {$ELSE}
      Result := Copy(FExePath, 1, Length(FExePath)-1) + Copy(Result, 2, Length(Result)-1);
      {$ENDIF MSWINDOWS}
    end
    else
      Result := Path;
  end;
end;

function NormalizePath2(const Path: APascalString): APascalString;
begin
  if (Length(Path) = 0) then
    Result := FExePath
  else
  begin
    if (Path[1] = '.') then
    begin
      {$IFDEF MSWINDOWS}
      Result := ExpandFileName(AnsiString(FExePath+Path));
      {$ELSE}
      Result := Copy(FExePath, 1, Length(FExePath)-1) + Copy(Result, 2, Length(Result)-1);
      {$ENDIF MSWINDOWS}
    end
    else
      Result := Path;
  end;
  if (Length(Result) > 0) and (Result[Length(Result)] <> '/') and (Result[Length(Result)] <> '\') then
    Result := Result + '\';
end;

end.
 