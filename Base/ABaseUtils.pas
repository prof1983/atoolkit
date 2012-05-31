{**
@Abstract(Дополнительные фунции)
@Author(Prof1983 prof1983@ya.ru)
@Created(05.03.2008)
@LastMod(12.12.2011)
@Version(0.5)
}
unit ABaseUtils;

{$I A.inc}

interface

uses
  ABase;

function ByteToHex(I: Byte): string;
function ByteToStr(Value: Byte): string;
function CharToHex(Value: Char): string;
function HexToByte(H: Char): Byte;
function HexToChar(H1, H2: Char): Char;
function StrToHex(const Value: string; const Delimiter: string = ''): string;
function VersionToStr(Version: AVersion): string; {$IFDEF DELPHI_9_UP}inline;{$ENDIF}
function VersionToStr3(Version: AVersion): string; {$IFDEF DELPHI_9_UP}inline;{$ENDIF}
function WordToStr(Value: Word): string;

function GetNextParam(var S, Param: string; const ParamDelimer: Char = ';'): Boolean;
function EncodeParam(const Param: string; var ParamName, ParamValue: string; const Delimer: Char = '='): Boolean;

implementation

{ Private procs }

{$IFNDEF DELPHI_7}
{function ByteToChar(Value: Byte): Char; inline;
begin
  Result := Chr(Ord('0') + Value);
end;}
{$ENDIF}

{ Public procs }

function ByteToHex(I: Byte): string;
  function a(I: Byte): Char;
  begin
    case I of
      0..9: Result := Chr(Ord('0') + I);
      10..15: Result := Chr(Ord('A') + I - 10);
    else
      Result := '_';
    end;
  end;
begin
  Result := a(I shr 4) + a(I and $0F);
end;

// Prof1983: 06.04.2011 - исправил
function ByteToStr(Value: Byte): string;
var
  A: Byte;
  B: Byte;
  C: Byte;
begin
  if (Value = 0) then
  begin
    Result := '0';
    Exit;
  end;
  A := Value div 100;
  B := ((Value mod 100) div 10);
  C := Value mod 10;

  Result := '';
  if (A > 0) then
    Result := Result + Chr(Ord('0')+A) + Chr(Ord('0')+B) + Chr(Ord('0')+C)
  else if (B > 0) then
    Result := Result + Chr(Ord('0')+B) + Chr(Ord('0')+C)
  else
    Result := Result + Chr(Ord('0')+C);
end;

function CharToHex(Value: Char): string;
begin
  Result := ByteToHex(Ord(Value));
end;

function EncodeParam(const Param: string; var ParamName, ParamValue: string; const Delimer: Char): Boolean;
var
  I: Integer;
begin
  I := Pos(Delimer, Param);
  Result := (I >= 0);
  if Result then
  begin
    ParamName := Copy(Param, 1, I - 1);
    ParamValue := Copy(Param, I + 1, Length(Param));
  end
  else
  begin
    ParamName := Param;
    ParamValue := '';
  end;
end;

function GetNextParam(var S, Param: string; const ParamDelimer: Char): Boolean;
var
  I: Integer;
begin
  Result := (Length(S) > 0);
  if not(Result) then Exit;

  I := Pos(ParamDelimer, S);
  if (I > 0) then
  begin
    Param := Copy(S, 1, I - 1);
    Delete(S, 1, I);
  end
  else
  begin
    Param := S;
    S := '';
  end;
end;

function HexToByte(H: Char): Byte;
var
  B: Byte;
begin
  B := Ord(H);
  case H of
    '0'..'9': Result := B - 48;
    'A'..'F': Result := B - 55;
    'a'..'f': Result := B - 87;
  else
    Result := 0;
  end;
end;

function HexToChar(H1, H2: Char): Char;
const
  A: array[0..15] of Char = ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F');
begin
  Result := Chr(HexToByte(H1) * 16 + HexToByte(H2));
end;

function StrToHex(const Value: string; const Delimiter: string = ''): string;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(Value) do
    Result := Result + CharToHex(Value[I]) + Delimiter;
end;

function VersionToStr(Version: AVersion): string;
begin
  Result := ByteToStr((Version and $FF000000) shr 24) + '.' +
            ByteToStr((Version and $00FF0000) shr 16) + '.' +
            ByteToStr((Version and $0000FF00) shr 8) + '.' +
            ByteToStr(Version and $000000FF);
end;

function VersionToStr3(Version: AVersion): string;
begin
  Result := ByteToStr((Version and $FF000000) shr 24) + '.' +
            ByteToStr((Version and $00FF0000) shr 16) + '.' +
            ByteToStr((Version and $0000FF00) shr 8);
end;

function WordToStr(Value: Word): string;
var
  a, b, c, d, e: Byte;
begin
  if (Value = 0) then
  begin
    Result := '0';
    Exit;
  end;
  e := Value mod 10;
  d := Value div 10;
  c := d div 10;
  b := c div 10;
  a := b div 10;

  Result := '';
  if (a > 0) then
    Result := Result + Chr(Ord('0') + a);
  if (b > 0) then
    Result := Result + Chr(Ord('0') + b);
  if (c > 0) then
    Result := Result + Chr(Ord('0') + c);
  if (d > 0) then
    Result := Result + Chr(Ord('0') + c);
  if (e > 0) then
    Result := Result + Chr(Ord('0') + c);
end;

end.
