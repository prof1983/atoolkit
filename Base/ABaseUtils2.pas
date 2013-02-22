{**
@Author Prof1983 <prof1983@ya.ru>
@Created 06.06.2004
@LastMod 22.02.2013
}
unit ABaseUtils2;

interface

uses
  ABase, ABase2, ATypes;

type // ------------------------------------------------------------------------
  TWndRes = AInt;
  TWndType = AInt;
  TDateTimeFormat = string;
  TStrPosChar = AInt;
  (*0 - no symbol
    1 - .
    2 - !
    3 - ?
    4 - ...
    5 - ,
    6 - ;
    7 - (
    8 - )
    9 - {
    10 - }
    11 - [
    12 - ]
  *)

type // ------------------------------------------------------------------------
  TVariantType = type AUInt32;
   {0-Uncnown,
    1-Boolean,
    2-UInt,
    3-Int,
    4-Float
    5-DateTime,
    6-String
   }

type // ------------------------------------------------------------------------
  TUrlParam = record
    Name: String;
    Value: String;
  end;

type
  //** Format: <name1>=<value1>&<name2>=<value2>
  TUrlParams = type String;
  TUrlParams2 = array of TUrlParam;

// functions -------------------------------------------------------------------

function cArrayByteToFloat64(const A: TArrayByte): Float64;
function cArrayByteToString(const A: TArrayByte): string;
function cArrayByteToUInt64(const A: TArrayByte): UInt64;

function cChar08ToHex(Value: Char): string;
function cCharToByte(Value: Char): Byte;
function cCharToUInt08(C: Char): AUInt08;
function cFloat32ToInt32(Value: AFloat32): AInt32;
function cFloat64ToArrayByte(Value: Float64): TArrayByte;
function cFloat64ToUInt32(F: Float64): AUInt32;
function cHexToUInt08(H: Char): AUInt08;
{** Delimer #9 }
function cStringToArrayString(Value: string): TArrayString;
function cStrToHex(Value: string; Delimiter: string = ''): string;
function cStrToHtmlStr(Str: string): string;
function cStrToInt32(Str: string): AInt32; deprecated; // Use ABaseUtils3.pas
function cStrToUInt32(Str: string): AUInt32;
function cStrToUInt64(Str: string): AUInt64;
function cUInt08ToHex(I: AUInt08): string;
function cUInt64ToInt32(Value: AUInt64): AInt32;
function cUInt64ToUInt08(Value: AUInt64): AUInt08;
function cUInt64ToInt16(Value: AUInt64): AUInt16;
function cUInt64ToUInt32(Value: AUInt64): AUInt32;
function cUInt32ToArrayByte(Value: AUInt32): TArrayByte;

function IsCharEng(C: Char): Boolean;
function IsCharRus(C: Char): Boolean;
function IsCharRusEng(C: Char): Boolean;
function mathMinInt32(V1, V2: AInt32): AInt32;
function mathMinUInt32(V1, V2: AUInt32): AUInt32;
function strEqual(Str1, Str2: string): AUInt32;
function strEqual2(S1, S2: string; A1: Float64 = 0; A2: Float64 = 0; A3: Float64 = 0): Float64;
function StrExtractWord(Num: Integer; Str: WideString; Delims: TArrayChar): WideString;
function StrHtmlFromStr(Value: string): string;
function StrHtmlToStr(Value: WideString): WideString;
procedure strInsert(var S: String; SubSt: String; Index: AUInt32);
function strLength(const S: String): AUInt32;
function strPos(St: String; SubSt: String): AUInt32;
// Search first symbol . ! ? ...
function strPos3(S: String; var Ch: TStrPosChar): AUInt32;
function StrPosEnd(const St: WideString; C: WideChar): Integer;
function urlDecode(Value: string): string;
function urlParamDecode(const InParams: TUrlParams; var Params: TURLParams2): AError;
function urlParamByName(InParams: TUrlParams; Name: string): string;
function urlParamByName_UInt064(InParams: TUrlParams; Name: String): UInt64;

function MinInt32(Value1, Value2: AInt32): AInt32;

function _StrToBool(const S: String; var Value: ABool): ABool;
function _StrToFloat32(const S: String; var Value: AFloat32): AUInt32;
function _StrToFloat64(const S: String; var Value: AFloat64): AUInt32;
function _StrToInt08(const S: String; var Value: AInt08): AUInt32;
function _StrToInt16(const S: String; var Value: AInt16): AUInt32;
function _StrToInt32(const S: String; var Value: AInt32): AUInt32;
function _StrToInt64(const S: String; var Value: AInt64): AUInt32;
function _StrToUInt08(const S: String; var Value: AUInt08): AUInt32;
function _StrToUInt16(const S: String; var Value: AUInt16): AUInt32;
function _StrToUInt32(const S: String; var Value: AUInt32): AUInt32;
function _StrToUInt64(const S: String; var Value: AUInt64): AUInt32;

{** Delete prefix and postfix space (probel) and delete prefix and postfix #13#10 }
function _StrDeleteSpace(var S: String; Options: TDeleteSpaceOptionSet): AError;

function cBoolToStr(Value: Boolean): String;
function cUInt08ToChar(I: AUInt08): Char;
procedure strAdd(var Str: String; S2: String);
function strCopy(SIn: String; Index, Count: AInt32): String;
function strDelete(var St: String; Index, Count: AUInt32): AError;

{** Delete prefix and postfix space (probel) and delete prefix and postfix #13#10 }
function StrDeleteSpace(const SIn: WideString; Options: TDeleteSpaceOptionsSet = [dsFirst, dsLast, dsRep]): String;

function Tag(Name, Value: String): String;

implementation

// API -------------------------------------------------------------------------
// -----------------------------------------------------------------------------
function __CloseHandle(hObject: THandle32): Boolean; stdcall; external 'kernel32.dll' name 'CloseHandle';
function __GetLastError(): Integer; stdcall; external 'kernel32.dll' name 'GetLastError';

// Functions -------------------------------------------------------------------

function cArrayByteToFloat64(const A: TArrayByte): Float64;
begin
  Result := 0;
end;

function cArrayByteToString(const A: TArrayByte): String;
var
  I: AInt32;
begin
  SetLength(Result, Length(A));
  for I := 0 to High(A) do
    Result[I + 1] := cUInt08ToChar(A[I]);
end;

function cArrayByteToUInt64(const A: TArrayByte): UInt64;
begin
  Result := 0;
end;

function cBoolToStr(Value: Boolean): String;
begin
  if Value then Result := 'True' else Result := 'False';
end;

function cChar08ToHex(Value: Char): string;
begin
  Result := cUInt08ToHex(Ord(Value));
end;

function cCharToByte(Value: Char): Byte;
begin
  Result := Ord(Value);
end;

function cCharToUInt08(C: Char): AUInt08;
begin
  Result := Ord(C);
end;

function cFloat32ToInt32(Value: AFloat32): AInt32;
begin
  Result := Round(Value);
end;

function cFloat64ToArrayByte(Value: Float64): TArrayByte;
begin
  SetLength(Result, 8);
end;

function cFloat64ToUInt32(F: AFloat64): AUInt32;
begin
  Result := Round(F);
end;

function cHexToUInt08(H: Char): AUInt08;
var
  B: AUInt08;
begin
  B := cCharToUInt08(H);
  case H of
    '0'..'9': Result := B - 48;
    'A'..'F': Result := B - 55;
    'a'..'f': Result := B - 87;
  else
    Result := 0;
  end;
end;

function cStringToArrayString(Value: String): TArrayString;
var
  I: AInt32;
  Index: AInt32;
  IStart: AInt32;
begin
  SetLength(Result, 0);
  Value := StrDeleteSpace(Value);
  if Length(Value) = 0 then Exit;
  I := 1;
  IStart := 1;
  while I <= Length(Value) do begin
    if Value[I] = #9 then begin
      Index := Length(Result);
      SetLength(Result, Index + 1);
      Result[Index] := StrCopy(Value, IStart, I - IStart);
      IStart := I + 1;
    end;
    if I = Length(Value) then begin
      Index := Length(Result);
      SetLength(Result, Index + 1);
      Result[Index] := StrCopy(Value, IStart, I - IStart + 1);
    end;
    Inc(I);
  end;
end;

function cStrToHex(Value: string; Delimiter: string = ''): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(Value) do
    Result := Result + cChar08ToHex(Value[i]) + Delimiter;
end;

function cStrToHtmlStr(Str: String): String;
var
  I: AUInt32;
begin
  Result := '';
  for I := 1 to strLength(Str) do case Str[I] of
    '<': Result := Result + '&lt;';
    '>': Result := Result + '&gt;';
  else
    Result := Result + Str[I];
  end;
end;

function cStrToInt32(Str: String): AInt32;
var
  Code: AInt32;
begin
  Result := 0;
  try
    Val(Str, Result, Code);
  except
  else
  end;
end;

function cStrToUInt32(Str: String): AUInt32;
var
  Code: AInt32;
begin
  Result := 0;
  try
    Val(Str, Result, Code);
  except
  else
  end;
end;

function cStrToUInt64(Str: String): AUInt64;
var
  Code: AInt32;
begin
  Result := 0;
  try
    Val(Str, Result, Code);
  except
  else
  end;
end;

function cUInt08ToHex(I: AUInt08): String;

  function a(I: AUInt08): Char08;
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

function cUInt64ToInt32(Value: AUInt64): AInt32;
begin
  if (Value > High(AInt32)) then
    Result := High(AInt32)
  else if (Value <= Low(AInt32)) then
    Result := Low(AInt32)
  else
    Result := Value;
end;

function cUInt64ToUInt08(Value: AUInt64): AUInt08;
begin
  if (Value > High(AUInt08)) then
    Result := High(AUInt08)
  else if Value <= 0 then
    Result := 0
  else
    Result := Value;
end;

function cUInt64ToInt16(Value: AUInt64): AUInt16;
begin
  if (Value > High(AUInt16)) then
    Result := High(AUInt16)
  else if (Value <= 0) then
    Result := 0
  else
    Result := Value;
end;

function cUInt64ToUInt32(Value: AUInt64): AUInt32;
begin
  if (Value > High(AUInt32)) then
    Result := High(AUInt32)
  else if (Value <= 0) then
    Result := 0
  else
    Result := Value;
end;

function cUInt32ToArrayByte(Value: AUInt32): TArrayByte;
begin
  SetLength(Result, 0);
end;

function IsCharEng(C: Char): Boolean;
begin
  if (('A' <= C) and (C <= 'Z')) or
     (('a' <= C) and (C <= 'z')) then
    Result := True
  else
    Result := False;
end;

function IsCharRus(C: Char): Boolean;
begin
  if (('А' <= C) and (C <= 'Я')) or
     (('а' <= C) and (C <= 'я')) then
    Result := True
  else
    Result := False;
end;

function IsCharRusEng(C: Char): Boolean;
begin
  Result := IsCharEng(C) or IsCharRus(C);
end;

function mathAbs(F: AFloat64): AFloat64; overload;
begin
  Result := Abs(F);
end;

function mathAbs(I: AUInt32): AUInt32; overload;
begin
  Result := Abs(I);
end;

function mathMax(V1, V2: AUInt32): AUInt32;
begin
  if V1 < V2 then Result := V2 else Result := V1;
end;

function mathMinInt32(V1, V2: AInt32): AInt32;
begin
  if V1 > V2 then Result := V2 else Result := V1;
end;

function mathMinUInt32(V1, V2: AUInt32): AUInt32;
begin
  if V1 > V2 then Result := V2 else Result := V1;
end;

function strEqual(Str1, Str2: String): AUInt32;
var
  I: AUInt32;
  L1: AUInt32;
  L2: AUInt32;
begin
  L1 := Length(Str1); L2 := Length(Str2);
  if (L1 <> L2) then begin Result := mathMinUInt32(L1, L2) + 1; Exit; end;
  if (L1 > 0) then for I := 0 to L1 do begin
    if (Str1[I] <> Str2[I]) then begin Result := I + 1; Exit; end;
  end;
  Result := 0;
end;

function strEqual2(S1, S2: String; A1: Float64 = 0; A2: Float64 = 0; A3: Float64 = 0): Float64;
var
  K1: Float64;
  K2: Float64;
  K3: Float64;
  K: Float64;
  L1: AUInt32;
  L2: AUInt32;
  Lmin: AUInt32;
  dL: AUInt32;
  S: String;
  L: AUInt32;
  I: AUInt32;
  I2: AUInt32;
begin
  Result := 0;
  L1 := strLength(S1);
  L2 := strLength(S2);
  if L1 < L2 then begin S := S1; S1 := S2; S2 := S; L := L1; L1 := L2; L2 := L; end;
  if (L1 = 0) or (L2 = 0) then Exit;
  dL := mathAbs(L1 - L2);
  Lmin := mathMinUInt32(L1,L2);
  K1 := mathMinUInt32(L1,L2) / mathMax(L1,L2);
  {}
  K3 := 0;
  for I := 0 to dL do begin
    K2 := (dL-I+1) / (dL+1);
    K := 0;
    for I2 := 1 to Lmin do if S1[I2+I] = S2[I2] then K := K + 1;
    K := K2 * (K / mathMinUInt32(L1, L2));
    if K > K3 then K3 := K;
  end;
  Result := K1 * K3
end;

function StrExtractWord(Num: Integer; Str: WideString; Delims: TArrayChar): WideString;
var
  INum: AInt32;
  Pos: AInt32;
  MinDelimPos: AInt32;

  function GetMinDelimPos(Str: WideString; Start: AUInt32; Delims: TArrayChar): AInt32;
  var
    I: AInt32;
    I2: AInt32;
  begin
    Result := 0;
    for I := 0 to High(Delims) do
    begin
      I2 := StrPos(Str, Delims[I]);
      if (Result > I2) and (I2 >= 0) then Result := I2;
    end;
  end;

begin
  Result := '';
  MinDelimPos := 1;
  if Num = 1 then
  begin
    MinDelimPos := GetMinDelimPos(Str, 1, Delims);
    if MinDelimPos <= 0 then
    begin
      Result := Str;
      Exit;
    end
    else
    begin
      Result := StrCopy(Str, 1, MinDelimPos - 1);
      Exit;
    end;
  end;
  INum := 1;
  repeat
    Pos := MinDelimPos;
    MinDelimPos := GetMinDelimPos(Str, Pos, Delims);
    Inc(INum);
  until (INum = Num) or (MinDelimPos <= 0);

  if MinDelimPos <= 0 then
    Result := StrCopy(Str, Pos, StrLength(Str) - Pos)
  else
    Result := StrCopy(Str, Pos + 1, MinDelimPos - Pos - 1);
end;

function StrHtmlFromStr(Value: String): String;
var
  I: AInt32;
begin
  Result := '';
  for I := 1 to Length(Value) do case Value[I] of
    '<': Result := Result + '&lt;';
    '>': Result := Result + '&gt;';
  else
    Result := Result + Value[I];
  end;
end;

function StrHtmlToStr(Value: WideString): WideString;
var
  Igt: AInt32;
  Ilt: AInt32;
begin
  Result := '';
  repeat
    Igt := Pos(WideString('&gt;'), Value);
    Ilt := Pos(WideString('&lt;'), Value);
    if (Igt > 0) and (Ilt > 0) and (Igt < Ilt) then begin
      Result := Result + Copy(Value, 1, Igt - 1) + '>';
      Delete(Value, 1, Igt + 3);
    end else if (Igt > 0) and (Ilt > 0) and (Ilt < Igt) then begin
      Result := Result + Copy(Value, 1, Ilt - 1) + '<';
      Delete(Value, 1, Ilt + 3);
    end else if (Igt > 0) then begin
      Result := Result + Copy(Value, 1, Igt - 1) + '>';
      Delete(Value, 1, Igt + 3);
    end else if (Ilt > 0) then begin
      Result := Result + Copy(Value, 1, Ilt - 1) + '<';
      Delete(Value, 1, Ilt + 3);
    end else Result := Result + Value;
  until (Igt = 0) and (Ilt = 0);
end;

procedure strInsert(var S: String; SubSt: String; Index: AUInt32);
begin
  Insert(SubSt, S, Index);
end;

function strLength(const S: String): AUInt32;
begin
  Result := Length(S);
end;

function strPos(St, SubSt: String): AUInt32;
begin
  Result := Pos(SubSt, St);
end;

function strPos3(S: String; var Ch: TStrPosChar): AUInt32;
var
  I: AUInt32;
  L: AUInt32;
begin
  Result := 0; Ch := 0;
  L := strLength(S);
  if L = 0 then Exit;
  for I := 1 to L do case S[I] of
    '.': begin
      if (L >= I+2) and (S[I+1] = '.') and (S[I+2] = '.') then begin
        Ch := 4; Result := I; Exit;
      end;
      Ch := 1; Result := I; Exit;
    end;
    '!': begin
      Ch := 2; Result := I; Exit;
    end;
    '?': begin
      Ch := 3; Result := I; Exit;
    end;
  end;
end;

function StrPosEnd(const St: WideString; C: WideChar): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := Length(St) downto 1 do if St[I] = C then begin Result := I; Exit; end;
end;

function urlDecode(Value: string): string;
var
  i, L: integer;
begin
  Result:='';
  L:=0;
  for i := 1 to Length(Value) do
  begin
    if(Value[i] <> '%') and (Value[i] <> '+') and (L<1) then
    begin
      Result := Result + Value[i];
    end
    else
    begin
      if(Value[i] = '+') then
        Result := Result + ' '
      else if(Value[i] = '%') then
      begin
        L := 2;
        if(i < Length(Value) - 1) then
        begin
          Result := Result + Chr(cHexToUInt08(Value[i+1]) * 16 +
					cHexToUInt08(Value[i+2]));
        end;
      end
      else
        Dec(L);
    end;
  end;
end;

function urlParamDecode(const InParams: TUrlParams; var Params: TURLParams2): AError;
var
  SS: String;
  ST: String;
  I: AInt32;
  K: AInt32;
begin
  Result := 0;
  SetLength(Params, 0);
  SS := InParams;
  while Length(SS) <> 0 do begin
    K := strPos(SS, '&');
    if (K <> 0) then begin
      ST := strCopy(SS, 1, K-1);
      SS := strCopy(SS, K+1, 10000);
    end else begin
      ST :=SS;
      SS:='';
    end;
    K := Pos('=',ST);
    if (K <> 0) then begin
      I := Length(Params); SetLength(Params, I+1);
      Params[I].Name := strCopy(ST, 1, K-1);
      Params[I].Value := urlDecode(Copy(ST, K+1, 6000));
    end;
  end;
end;

function urlParamByName(InParams: TUrlParams; Name: string): string;
var
  SS: String;
  ST: String;
  K: AInt32;
begin
  Result := '';
  SS := InParams;
  while Length(SS) <> 0 do begin
    K := strPos(SS, '&');
    if (K <> 0) then begin
      ST := strCopy(SS, 1, K-1);
      SS := strCopy(SS, K+1, 10000);
    end else begin
      ST :=SS;
      SS:='';
    end;
    K := Pos('=',ST);
    if (K <> 0) then begin
      if (Name = strCopy(ST, 1, K-1)) then begin
        Result := urlDecode(Copy(ST, K+1, 6000));
      end;
    end;
  end;
end;

function urlParamByName_UInt064(InParams: TUrlParams; Name: String): UInt64;
begin
  Result := cStrToUInt64(urlParamByName(InParams, Name));
end;

{$IFNDEF VER170}
function _strLen(const Str: PChar): AUInt32; assembler;
asm
  MOV     EDX,EDI
  MOV     EDI,EAX
  MOV     ECX,0FFFFFFFFH
  XOR     AL,AL
  REPNE   SCASB
  MOV     EAX,0FFFFFFFEH
  SUB     EAX,ECX
  MOV     EDI,EDX
end;
{$ENDIF}

function cUInt32ToInt32(Value: AUInt32): AInt32;
begin
  Result := AInt32(Value);
end;

function MinInt32(Value1, Value2: AInt32): AInt32;
begin
  if Value1 > Value2 then
    Result := Value2
  else
    Result := Value1;
end;

function _StrToBool(const S: String; var Value: Boolean): Boolean;
begin
  Result := True;
  if S = 'True' then Value := True else
  if S = 'False' then Value := False else
    Result := False;
end;

function _StrToFloat32(const S: String; var Value: AFloat32): AUInt32;
begin
  Val(S, Value, Result);
end;

function _StrToFloat64(const S: String; var Value: AFloat64): AUInt32;
begin
  Val(S, Value, Result);
end;

function _StrToInt08(const S: String; var Value: AInt08): AUInt32;
begin
  Val(S, Value, Result);
end;

function _StrToInt16(const S: String; var Value: AInt16): AUInt32;
begin
  Val(S, Value, Result);
end;

function _StrToInt32(const S: String; var Value: AInt32): AUInt32;
begin
  Val(S, Value, Result);
end;

function _StrToInt64(const S: String; var Value: AInt64): AUInt32;
begin
  Val(S, Value, Result);
end;

function _StrToUInt08(const S: String; var Value: AUInt08): AUInt32;
begin
  Val(S, Value, Result);
end;

function _StrToUInt16(const S: String; var Value: AUInt16): AUInt32;
begin
  Val(S, Value, Result);
end;

function _StrToUInt32(const S: String; var Value: AUInt32): AUInt32;
begin
  Val(S, Value, Result);
end;

function _StrToUInt64(const S: String; var Value: AUInt64): AUInt32;
begin
  Val(S, Value, Result);
end;

function _StrDeleteSpace(var S: String; Options: TDeleteSpaceOptionSet): AError;
var
  B: Boolean;
  I: AUInt32;
begin
  repeat
    B := False;

    Result := 0; if (strLength(S) = 0) then Exit;
    // Delete prefix space
    if (dsFirst in Options) then while (S[1] = ' ') do begin
      strDelete(S, 1, 1);
      if strLength(S) = 0 then Exit;
      B := True;
    end;
    // Delete postfix space
    if (dsLast in Options) then while (S[strLength(S)] = ' ') do begin
      strDelete(S, strLength(S), 1);
      if strLength(S) = 0 then Exit;
      B := True
    end;
    // Delete repeat space
    if (dsRep in Options) then repeat
      I := strPos(S, '  ');
      if I = 0 then Break;
      Delete(S, I, 1);
    until False;

    // Delete prefix #13#10
    if (Length(S) >= 2) and (S[1]=#13) and (S[2]=#10) then begin
      Delete(S, 1, 2);
      B := True;
    end;
    // Delete postfix #13#10
    if (Length(S) >= 2) and (S[Length(S)-1]=#13) and (S[Length(S)]=#10) then begin
      Delete(S, Length(S)-1, 2);
      B := True;
    end;
  until (B = False);
end;

function cUInt08ToChar(I: AUInt08): Char;
begin
  Result := Chr(I);
end;

procedure strAdd(var Str: String; S2: String);
begin
  Str := Concat(Str, S2);
end;

function strCopy(SIn: String; Index, Count: AInt32): String;
begin
  if Count <= 0 then Result := '' else Result := Copy(SIn, Index, Count);
end;

function strDelete(var St: String; Index, Count: AUInt32): AError;
begin
  Delete(St, Index, Count);
  Result := 0;
end;

function StrDeleteSpace(const SIn: WideString; Options: TDeleteSpaceOptionsSet): String;
begin
  Result := ''; if (strLength(SIn) = 0) then Exit;
  Result := SIn;
  _strDeleteSpace(Result, Options);
end;

function Tag(Name, Value: String): String;
begin
  Result := '<'+Name+'>'+Value+'</'+Name+'>';
end;

end.
