﻿{**
@Abstract Базовый модуль основных типов и их преобразования. Базовые функции for Delphi 5,7,2005,2006
@Author Prof1983 <prof1983@ya.ru>
@Created 06.06.2004
@LastMod 20.12.2012
}
unit ABaseUtils2;

interface

uses
  ABase, ABase2, ATypes;

// ---
type // from unBase-20061023.pas
  THandle32 = Integer;
// ---

type // Простые типы -----------------------------------------------------------
  //** Массив Char08
  TArrayChar08 = array of AChar;
  //** Массив строк string
  TArrayStr = array of string;
  //** Вид конвентарции: 0-Дата+Время, 1-Дата, 2-Время
  TConvertDT = type AUInt32;
  //** Простой тип для процедуры
  TProc = procedure;
  //** Информация. Певый символ: #0-очистить все, #1-вывести строку. #2-вывести подстроку. #3-прогресс(второй символ [0..255]-прогресс), #4#n#p-прогресс n=[1..] p-текущий прогресс[0..255], #4#0-очистить все прогрессы
  TProcInfo = procedure(Str: string);

type // ------------------------------------------------------------------------
  TWndRes         = Integer;
  TWndType        = Integer;
  TDateTimeFormat = string;
  TStrPosChar     = Integer;
  {0 - Нет символа
   1 - .
   2 - !
   3 - ?
   4 - ...
   5 - ,
   6 - ;
   7 - (
   8 - )
   9 - {
   10 - Закрывающаяся фигурная кавычка
   11 - [
   12 - ]
  }

const // Глобальные константы --------------------------------------------------
  HighInt008 = 127;
  HighInt016 = 32767;
  HighInt032 = 2147483647;
  HighInt064 = 9223372036854775807;
  HighUInt008 = 255;
  HighUInt016 = 65535;
  HighUInt032 = 4294967295;
  HighUInt064 = $FFFFFFFFFFFFFFFF;
  //HighUInt128 = $FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
  LowInt008 = -128;
  LowInt016 = -32768;
  //LowInt032 = -2147483648;
  //LowInt064 = -9223372036854775808
  timeHour: TDateTime = 1 / 24; //Величина 1 часа в типе TDateTime064
  timeMin: TDateTime = 1 / (24 * 60);
  timeSec: TDateTime = 1 / (24 * 60 * 60);

type // ------------------------------------------------------------------------
  TVariantType = type UInt32;
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
  //** Для передичи параметров меджду процедурами. Формат: <name1>=<value1>&<name2>=<value2>
  TUrlParams = type String;
  TUrlParams2 = array of TUrlParam;

// functions -------------------------------------------------------------------

function ArrayByteCopy(const Source: TArrayByte; Offset, Count: UInt32): TArrayByte;
function ArrayByteInsert(var A: TArrayByte; const Source: TArrayByte; Offset: UInt32): UInt32;

function cArrayByteToFloat64(const A: TArrayByte): Float64;
function cArrayByteToString(const A: TArrayByte): string;
function cArrayByteToUInt32(const A: TArrayByte): UInt32;
function cArrayByteToUInt64(const A: TArrayByte): UInt64;

function cChar08ToHex(Value: Char): string;
function cCharToByte(Value: Char): Byte;
function cCharToUInt08(C: Char): AUInt08;
function cFloat32ToInt32(Value: Float32): Int32;
function cFloat64ToArrayByte(Value: Float64): TArrayByte;
function cFloat64ToDateTime64(Value: Float64): TDateTime;
function cFloat64ToUInt32(F: Float64): UInt32;
function cHexToUInt08(H: Char): AUInt08;
function cStringToArrayString(Value: string): TArrayString;
// Преобразует строку к виду ... F0 A1 B2 ...
// Delimer - Разделитель
function cStrToHex(Value: string; Delimiter: string = ''): string;
function cStrToHtmlStr(Str: string): string;
function cStrToInt32(Str: string): Int32; deprecated; // Use ABaseUtils3.pas
function cStrToUInt32(Str: string): UInt32;
function cStrToUInt64(Str: string): UInt64;
function cUInt08ToHex(I: AUInt08): string;
function cUInt64ToInt32(Value: UInt64): Int32;
function cUInt64ToUInt08(Value: UInt64): AUInt08;
function cUInt64ToInt16(Value: UInt64): UInt16;
function cUInt64ToUInt32(Value: UInt64): UInt32;
function cUInt32ToArrayByte(Value: UInt32): TArrayByte;
function cUInt64ToArrayByte(Value: UInt64): TArrayByte;

function IsCharEng(C: Char): Boolean;
function IsCharRus(C: Char): Boolean;
function IsCharRusEng(C: Char): Boolean;
function mathMinInt32(V1, V2: Int32): Int32;
function mathMinUInt32(V1: UInt32; V2: UInt32): UInt32;
// Сравнивает 2 строки
// Result - Позиция, в которой строки имеют различия или 0, если они одинаковые
function strEqual(Str1, Str2: string): UInt32;
function strEqual2(S1, S2: string; A1: Float64 = 0; A2: Float64 = 0; A3: Float64 = 0): Float64;
// Выделяет слово Num по счету c разделителями Delims
function StrExtractWord(Num: Integer; Str: WideString; Delims: TArrayChar): WideString;
function StrHtmlFromStr(Value: string): string;
function StrHtmlToStr(Value: WideString): WideString;
//** Вставляет подстроку SubSt в строку St, начиная с символа с номеров Index
procedure strInsert(var S: String; SubSt: String; Index: UInt32);
//** Возвращает длину строки
function strLength(const S: String): UInt32;
//** Возвращает в строке St первое вхождение подстроки SubSt и возвращает номер позиции с которой она начинается. Если подстрока не найдена, возвращает ноль.
function strPos(St: String; SubSt: String): UInt32;
// Ищет в строке первое вхождение . ! ? ...
// S  - {in}{Строка}
// Ch - {out}{Код окончания предложения}
// Result - Позиция в строке или 0, если не найдено
function strPos3(S: String; var Ch: TStrPosChar): UInt32;
// Ищет индекс символа C в строке St с конца строки. Возвращает 0, если символ не найден.
// St - Строка
// C - Символ
function StrPosEnd(const St: WideString; C: WideChar): Integer;
//** Преобразует символы, записанные в виде URLencoded
function urlDecode(Value: string): string;
function urlParamDecode(const InParams: TUrlParams; var Params: TURLParams2): AError;
//** Возвращает значение атрибута заданного в качестве параметра функции из строки данных
function urlParamByName(InParams: TUrlParams; Name: string): string;
function urlParamByName_UInt064(InParams: TUrlParams; Name: String): UInt64;

function MinInt32(Value1, Value2: Int32): Int32;

function _StrToBool(const S: String; var Value: Boolean): Boolean;
function _StrToFloat32(const S: String; var Value: Float32): UInt32;
function _StrToFloat64(const S: String; var Value: Float64): UInt32;
function _StrToInt08(const S: String; var Value: AInt08): UInt32;
function _StrToInt16(const S: String; var Value: Int16): UInt32;
function _StrToInt32(const S: String; var Value: Int32): UInt32;
function _StrToInt64(const S: String; var Value: Int64): UInt32;
function _StrToUInt08(const S: String; var Value: AUInt08): UInt32;
function _StrToUInt16(const S: String; var Value: UInt16): UInt32;
function _StrToUInt32(const S: String; var Value: UInt32): UInt32;
function _StrToUInt64(const S: String; var Value: UInt64): UInt32;

{**
  Удаление префиксных, постфиксных, повторяющихся пробелов и префиксных и поствиксных #13#10
}
function _StrDeleteSpace(var S: APascalString; Options: TDeleteSpaceOptionSet): AError;

function cBoolToStr(Value: Boolean): String;
function cUInt08ToChar(I: AUInt08): Char;
procedure strAdd(var Str: String; S2: String);
function strCopy(SIn: String; Index, Count: Int32): String;
function strDelete(var St: String; Index, Count: UInt32): AError;

{**
  Удаление префиксных, постфиксных, повторяющихся пробелов и префиксных и поствиксных #13#10
}
function StrDeleteSpace(const SIn: WideString; Options: TDeleteSpaceOptionsSet = [dsFirst, dsLast, dsRep]): APascalString;

function Tag(Name, Value: String): String;

implementation

// API -------------------------------------------------------------------------
// -----------------------------------------------------------------------------
function __CloseHandle(hObject: THandle32): Boolean; stdcall; external 'kernel32.dll' name 'CloseHandle';
function __GetLastError: UInt32; stdcall; external 'kernel32.dll' name 'GetLastError';

// Functions -------------------------------------------------------------------

function ArrayByteCopy(const Source: TArrayByte; Offset, Count: UInt32): TArrayByte;
var
  I: Int32;
  L: Int32;
begin
  L := MinInt32(Length(Source) - Offset, Count);
  SetLength(Result, L);
  for I := 0 to L - 1 do
    Result[I] := Source[I + Offset];
end;

function ArrayByteInsert(var A: TArrayByte; const Source: TArrayByte; Offset: UInt32): UInt32;
var
  I: Int32;
  L: Int32;
begin
  Result := 0;
  L := MinInt32(Length(A) - Offset, Length(Source));
  if L <= 0 then Exit;
  Result := L;
  for I := 0 to L do
    A[I+Offset] := Source[I];
end;

function cArrayByteToFloat64(const A: TArrayByte): Float64;
begin
  Result := 0;
end;

function cArrayByteToString(const A: TArrayByte): String;
var
  I: Int32;
begin
  SetLength(Result, Length(A));
  for I := 0 to High(A) do
    Result[I + 1] := cUInt08ToChar(A[I]);
end;

function cArrayByteToUInt32(const A: TArrayByte): UInt32;
begin
  Result := 0;
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

function cFloat32ToInt32(Value: Float32): Int32;
begin
  Result := Round(Value);
end;

function cFloat64ToArrayByte(Value: Float64): TArrayByte;
begin
  SetLength(Result, 8);
end;

function cFloat64ToDateTime64(Value: Float64): TDateTime;
begin
  Result := Value;
end;

function cFloat64ToUInt32(F: Float64): UInt32;
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
// Разделение строка на части. Разделитель #9
var
  I: Int32;
  Index: Int32;
  IStart: Int32;
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
  I: UInt32;
begin
  Result := '';
  for I := 1 to strLength(Str) do case Str[I] of
    '<': Result := Result + '&lt;';
    '>': Result := Result + '&gt;';
  else
    Result := Result + Str[I];
  end;
end;

function cStrToInt32(Str: String): Int32;
var
  Code: Int32;
begin
  Result := 0;
  try
    Val(Str, Result, Code);
  except
  else
  end;
end;

function cStrToUInt32(Str: String): UInt32;
var
  Code: Int32;
begin
  Result := 0;
  try
    Val(Str, Result, Code);
  except
  else
  end;
end;

function cStrToUInt64(Str: String): UInt64;
var
  Code: Int32;
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

function cUInt64ToInt32(Value: UInt64): Int32;
begin
  if Value > High(Int32) then
    Result := High(Int32)
  else if Value <= Low(Int32) then
    Result := Low(Int32)
  else
    Result := Value;
end;

function cUInt64ToUInt08(Value: UInt64): AUInt08;
begin
  if (Value > High(AUInt08)) then
    Result := High(AUInt08)
  else if Value <= 0 then
    Result := 0
  else
    Result := Value;
end;

function cUInt64ToInt16(Value: UInt64): UInt16;
begin
  if Value > High(UInt16) then
    Result := High(UInt16)
  else if Value <= 0 then
    Result := 0
  else
    Result := Value;
end;

function cUInt64ToUInt32(Value: UInt64): UInt32;
begin
  if Value > High(UInt32) then
    Result := High(UInt32)
  else if Value <= 0 then
    Result := 0
  else
    Result := Value;
end;

function cUInt32ToArrayByte(Value: UInt32): TArrayByte;
begin
  SetLength(Result, 0);
end;

function cUInt64ToArrayByte(Value: UInt64): TArrayByte;
begin
  SetLength(Result, 8);
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

function mathAbs(F: Float64): Float64; overload;
begin
  Result := Abs(F);
end;

function mathAbs(I: UInt32): UInt32; overload;
begin
  Result := Abs(I);
end;

function mathMax(V1, V2: UInt32): UInt32;
begin
  if V1 < V2 then Result := V2 else Result := V1;
end;

function mathMinInt32(V1, V2: Int32): Int32;
begin
  if V1 > V2 then Result := V2 else Result := V1;
end;

function mathMinUInt32(V1, V2: UInt32): UInt32;
//Возвращает меньшее из двех заданых чисел
//V1 - Первое значение
//V2 - Второе значение
begin
  if V1 > V2 then Result := V2 else Result := V1;
end;

function strEqual(Str1, Str2: String): UInt32;
var
  I: UInt32;
  L1, L2: UInt32;
begin
  L1 := Length(Str1); L2 := Length(Str2);
  if (L1 <> L2) then begin Result := mathMinUInt32(L1, L2) + 1; Exit; end;
  if (L1 > 0) then for I := 0 to L1 do begin
    if (Str1[I] <> Str2[I]) then begin Result := I + 1; Exit; end;
  end;
  Result := 0;
end;

function strEqual2(S1, S2: String; A1: Float64 = 0; A2: Float64 = 0; A3: Float64 = 0): Float64;
{A1-коэффициент, учитывающий разницу длин строк (0..1)
 A2-коэффициент, учитывающий сдвиг сравниваемых строк (0..1)
 A3-коэффициент, учитывающий несоответствие букв (0..1)
 Результат (0..1) 0 - не похоже, 1 - похоже
}
var
  K1: Float64; // Коэффициент разници длин строк
  K2: Float64; // Коэффициент сдвига строк
  K3: Float64; // Коэффициент несоответствия букв
  K: Float64;
  L1: UInt32;
  L2: UInt32;
  Lmin: UInt32;
  dL: UInt32;
  S: String;
  L: UInt32;
  I, I2: UInt32;
begin
  Result := 0;
  // Длины строк
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
  INum: Int32;        // Текущее слово по порядку
  Pos: Int32;         // Позиция начала строки для выделения слова
  MinDelimPos: Int32;

  function GetMinDelimPos(Str: WideString; Start: UInt32; Delims: TArrayChar): Int32;
  var
    I: Int32;
    I2: Int32;
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
// Переводит строку со спец символими в строку Html формата со спецсимволами
var
  I: Int32;
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
// Переводит строку Html формата с тегами в простую строку с символами
// Обратная процедура StrHtmlFromStr
var
  Igt: Int32;
  Ilt: Int32;
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

procedure strInsert(var S: String; SubSt: String; Index: UInt32);
begin
  Insert(SubSt, S, Index);
end;

function strLength(const S: String): UInt32;
begin
  // Вычисляет реальную длину (без учета конца строки #0)
  Result := Length(S);
end;

function strPos(St, SubSt: String): UInt32;
begin
  Result := Pos(SubSt, St);
end;

function strPos3(S: String; var Ch: TStrPosChar): UInt32;
var
  I: UInt32;
  L: UInt32;
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
// Ищет индекс символа C в строке St с конца строки. Возвращает 0, если символ не найден.
var
  I: Integer;
begin
  Result := 0;
  for I := Length(St) downto 1 do if St[I] = C then begin Result := I; Exit; end;
end;

function urlDecode(Value: string): string;
// Преобразует символы, записанные в виде URLencoded
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
  I: Int32;
  K: Int32;
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
// Фнкция возвращает значение атрибута заданного в качестве параметра функции из строки данных
var
  SS: String;
  ST: String;
  K: Int32;
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
function _strLen(const Str: PChar): UInt32; assembler;
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

{IFDEF VER170}
function cFloat64ToDateTime64(Value: Float64): TDateTime64;
begin
  Result := Value;
end;
{ENDIF}

function cUInt32ToInt32(Value: UInt32): Int32;
begin
  Result := Int32(Value);
end;

function MinInt32(Value1, Value2: Int32): Int32;
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

function _StrToFloat32(const S: String; var Value: Float32): UInt32;
begin
  Val(S, Value, Result);
end;

function _StrToFloat64(const S: String; var Value: Float64): UInt32;
begin
  Val(S, Value, Result);
end;

function _StrToInt08(const S: String; var Value: AInt08): UInt32;
begin
  Val(S, Value, Result);
end;

function _StrToInt16(const S: String; var Value: Int16): UInt32;
begin
  Val(S, Value, Result);
end;

function _StrToInt32(const S: String; var Value: Int32): UInt32;
begin
  Val(S, Value, Result);
end;

function _StrToInt64(const S: String; var Value: Int64): UInt32;
begin
  Val(S, Value, Result);
end;

function _StrToUInt08(const S: String; var Value: AUInt08): UInt32;
begin
  Val(S, Value, Result);
end;

function _StrToUInt16(const S: String; var Value: UInt16): UInt32;
begin
  Val(S, Value, Result);
end;

function _StrToUInt32(const S: String; var Value: UInt32): UInt32;
begin
  Val(S, Value, Result);
end;

function _StrToUInt64(const S: String; var Value: UInt64): UInt32;
begin
  Val(S, Value, Result);
end;

function _StrDeleteSpace(var S: APascalString; Options: TDeleteSpaceOptionSet): AError;
// Удаление префиксных, постфиксных, повторяющихся пробелов и префиксных и поствиксных #13#10
var
  B: Boolean;
  I: UInt32;
begin
  repeat
  B := False;

  Result := 0; if (strLength(S) = 0) then Exit;
  // Удаление префиксных пробелов
  if (dsFirst in Options) then while (S[1] = ' ') do begin
    strDelete(S, 1, 1);
    if strLength(S) = 0 then Exit;
    B := True;
  end;
  // Удаление постфиксных пробелов
  if (dsLast in Options) then while (S[strLength(S)] = ' ') do begin
    strDelete(S, strLength(S), 1);
    if strLength(S) = 0 then Exit;
    B := True
  end;
  // Удаление повторяющихся промежуточных пробелов
  if (dsRep in Options) then repeat
    I := strPos(S, '  ');
    if I = 0 then Break;
    Delete(S, I, 1);
  until False;

  // Удаление префиксных #13#10
  if (Length(S) >= 2) and (S[1]=#13) and (S[2]=#10) then begin
    Delete(S, 1, 2);
    B := True;
  end;
  // Удаление постфиксных #13#10
  if (Length(S) >= 2) and (S[Length(S)-1]=#13) and (S[Length(S)]=#10) then begin
    Delete(S, Length(S)-1, 2);
    B := True;
  end;

  // Повтор удаления
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

function strCopy(SIn: String; Index, Count: Int32): String;
begin
  if Count <= 0 then Result := '' else Result := Copy(SIn, Index, Count);
end;

function strDelete(var St: String; Index, Count: UInt32): AError;
begin
  Delete(St, Index, Count);
  Result := 0;
end;

function StrDeleteSpace(const SIn: WideString; Options: TDeleteSpaceOptionsSet): APascalString;
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
