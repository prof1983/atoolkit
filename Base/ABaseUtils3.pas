{**
@Abstract(Базовый модуль основных типов и их преобразования. Базовые функции for Delphi 5,7,9)
@Author(Prof1983 prof1983@ya.ru)
@Created(06.06.2004)
@LastMod(21.06.2012)
@Version(0.5)
}
unit ABaseUtils3;

interface

uses
  SysUtils, Dialogs, ExtCtrls, Forms, Windows, StrUtils, Math,
  ABase2, ATypes;

type // Простые типы -----------------------------------------------------------
  TArrayChar08 = array of Char08;
  TArrayStr = array of string;
  TConvertDT = type UInt032; // Вид конвентарции: 0-Дата+Время, 1-Дата, 2-Время
  TProc = procedure;
  // Информация. Певый символ: #0-очистить все, #1-вывести строку. #2-вывести подстроку. #3-прогресс(второй символ [0..255]-прогресс), #4#n#p-прогресс n=[1..] p-текущий прогресс[0..255], #4#0-очистить все прогрессы
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
  timeHour: TDateTime64 = 1 / 24; //Величина 1 часа в типе TDateTime064
  timeMin: TDateTime64 = 1 / (24 * 60);
  timeSec: TDateTime64 = 1 / (24 * 60 * 60);

// -----------------------------------------------------------------------------
type // Опции удаления пробелов в функции strDeleteStace -----------------------
  TDeleteSpaceOptions = (
    dsFirst,  // Первые
    dsLast,   // Последние
    dsRep     // Повторяющиеся
    );
  TSetDeleteSpaceOptions = set of TDeleteSpaceOptions;

type // ------------------------------------------------------------------------
  TVariantType = type UInt032;
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

type //Для передичи параметров меджду процедурами. Формат: <name1>=<value1>&<name2>=<value2>
  TUrlParams = type String;
  TUrlParams2 = array of TUrlParam;

// functions -------------------------------------------------------------------
// -----------------------------------------------------------------------------
function ArrayByteCopy(const Source: TArrayByte; Offset, Count: UInt32): TArrayByte;
function ArrayStringAdd(var Source: TArrayString; const S: string): UInt32;
function cArrayByteToFloat64(const A: TArrayByte): Float64;
function cArrayByteToString(const A: TArrayByte): string;
function cArrayByteToUInt32(const A: TArrayByte): UInt32;
function cArrayByteToUInt64(const A: TArrayByte): UInt64;
function cBtnToStr(BtnCode: TWndRes): string;
function cByteToStr(Value: Byte): string;
function cChar08ToChar16(C: Char08): Char16;
function cChar08ToUInt08(C: Char): UInt008;
function cCharToByte(Value: Char): Byte;
function cCharToUInt08(C: Char): UInt008;
function cDateTime64ToStr(T: TDateTime64): string;
function cDateTime64ToStr2(T: TDateTime64; Typ: TConvertDT): string;
// Конвертирует тип TDateTime064 в String
function cDateTime64ToStrF(Format: TDateTimeFormat; T: TDateTime64): string;
//function cDateTime64ToUInt64(DT: TDateTime64): UInt064;
function cDateTimeToStr(Value: TDateTime): string;
function cDateToStr(D: TDateTime64): string;
function cDoubleToDateTime(Value: Double): TDateTime;
function cFloat32ToInt32(Value: Float32): Int32;
function cFloat32ToStr(Value: Float32): string;
function cFloat64ToArrayByte(Value: Float64): TArrayByte;
function cFloat64ToDateTime64(Value: Float64): TDateTime64;
function cFloat64ToInt32(F: Float64): Int032;
function cFloat64ToStrP(Value: Float64): string;
function cFloat64ToUInt32(F: Float64): UInt032;
function cHexToChar(H1, H2: Char): Char;
function cHexToUInt08(H: Char): UInt008;
function cInt08ToStr(I: Int008): string;
function cInt16ToStr(I: Int016): string;
function cInt32ToStr(Value: Int032): string;
function cInt64ToStr(I: Int064): string;
function cInt64ToUInt64(Value: Int064): UInt064;
function cSingleToInt32(Value: Single): Int32;
function cSingleToStr(Value: Single): string;
function cSingleToUInt32(Value: Single): UInt32;
// Делает все заглавные буквы строчными
function cStrCaseLower(St: string): string;
// Делает все строчныме буквы заглавными
function cStrCaseUpper(St: string): string;
function cStringToArrayString(Value: string): TArrayString;
function cStrPosCharToStr(Ch: TStrPosChar): string;
function cStrToArrayByte(const S: string): TArrayByte;
function cStrToDate(S: string): TDateTime64;
function cStrToDateTime(S: string): TDateTime64;
function cStrToDouble(Value: string): Double;
function cStrToFloat32(S: string): Float32;
function cStrToFloat64(S: string): Float64;
{$IFNDEF VER170}
function cStrToFloatCurr(S: string; var Value: Float64): Boolean;
function cUInt64ToDateTime64(Value: UInt064): TDateTime64;
{$ENDIF}
function cStrToHtmlStr(Str: string): string;
function cStrToInt32(Str: string): Int032;
function cStrToSingle(Value: string): Single;
function cStrToTime(Str: string): TDateTime64;
function cStrToUInt08(Str: string): UInt008;
function cStrToUInt16(Str: string): UInt016;
function cStrToUInt32(Str: string): UInt032;
function cStrToUInt64(Str: string): UInt064;
function cUInt08ToHex(I: UInt008): string;
function cUInt32ToStr(I: UInt032): string;
function cUInt64ToInt32(Value: UInt064): Int032;
function cUInt64ToStr(I: UInt064): string;
function cUInt64ToUInt08(Value: UInt064): UInt008;
function cUInt64ToInt16(Value: UInt064): UInt016;
function cUInt64ToUInt32(Value: UInt064): UInt032;
function cUInt32ToArrayByte(Value: UInt32): TArrayByte;
function cUInt64ToArrayByte(Value: UInt64): TArrayByte;
function cUIntToStr(Value: UIntPtr): String;
function DateTimeNow: TDateTime;
//Возвращает текущую дату/время
function dtNow: TDateTime64;
function IsCharEng(C: Char): Boolean;
function IsCharRus(C: Char): Boolean;
function IsCharRusEng(C: Char): Boolean;
//function mathAddUInt064(var A1: UInt064; A2: UInt064): TError;
function mathMinInt32(V1, V2: Int32): Int32;
function mathMinUInt32(V1: UInt032; V2: UInt032): UInt032;
//function mathMulInt32x32To64(Multiplier: Int032; Multiplicand: Int032): Int064;
function mathPower(Base, Exponent: Float64): Float64;
function strCaseLower(const S: string): string;
function strCaseLowerEng(const S: string): string;
// Заменяет все строчные буквы на заглавные с учетом русских букв
procedure strCaseUpper(var S: string);
function strCopyFrom(SIn: string; IStart: UInt032): string;
function strCopyFromTo(SIn: string; IStart: UInt032; IEnd: UInt032): string;
// Разделяет строку на слова и выражения, удаляет префиксные и постфиксные пробелы. Разделителем является запятая.
// Words - Слова и выражения по порядку (out)
// Result - Номер символа, в котором произошла ошибка или 0, если успешно
function strDivisionComma(const S: string; var Words: TArrayString): UInt032;
// Сравнивает 2 строки
// Result - Позиция, в которой строки имеют различия или 0, если они одинаковые
function strEqual(Str1, Str2: string): UInt032;
function strEqual2(S1, S2: string; A1: Float64 = 0; A2: Float64 = 0; A3: Float64 = 0): Float64;
function strExecutePath(FullFileName: string): string;
function StrExtractWord(Num: UInt32; Str: string; Delims: TArrayChar): string;
function StrHtmlFromStr(Value: string): string;
// Удаляет открывающий и закрывающий теги заголовка <hx>
// SIn   - {in}{Исходная строка}
// SOut  - {out}{Результат}
// Level - {out}{Уровень заголовка}
function strHtmlTagErraceH(SIn: String; var SOut: String; var Level: UInt032): TError;
// Удаляет открывающий и закрывающий теги абзаца <p>
// SIn  - {in}{Исходная строка}
// SOut - {out}{Результат}
function strHtmlTagErraceP(const SIn: String; var SOut: String): TError;
function StrHtmlToStr(Value: WideString): WideString;
// Вставляет подстроку SubSt в строку St, начиная с символа с номеров Index
procedure strInsert(var S: String; SubSt: String; Index: UInt032);
// Возвращает длину строки
function strLength(const S: String): UInt032;
// Устанавливает новую длину строки
function strLengthSet(var S: String; NewLength: UInt032): TError;
// Возвращает в строке St первое вхождение подстроки SubSt и возвращает номер позиции с которой она начинается. Если подстрока не найдена, возвращает ноль.
function strPos(St: String; SubSt: String): UInt032;
// Ищет в строке первое вхождение . ! ? ...
// S  - {in}{Строка}
// Ch - {out}{Код окончания предложения}
// Result - Позиция в строке или 0, если не найдено
function strPos3(S: String; var Ch: TStrPosChar): UInt032;
// Ищет индекс символа C в строке St с конца строки. Возвращает 0, если символ не найден.
// St - Строка
// C - Символ
function StrPosEnd(const St: WideString; C: WideChar): Integer;
// Возвращает текущее время
function timeNow: TDateTime64;
// Преобразует символы, записанные в виде URLencoded
function urlDecode(Value: string): string;
function urlParamDecode(const InParams: TUrlParams; var Params: TURLParams2): TError;
function urlParamBack(const InParams: String): String;
// Возвращает значение атрибута заданного в качестве параметра функции из строки данных
function urlParamByName(InParams: TUrlParams; Name: string): string;
function urlParamByName_UInt064(InParams: TUrlParams; Name: String): UInt064;
function urlParamCount(InParams: String): UInt032;

function ArrayByteInsert(var A: TArrayByte; const Source: TArrayByte; Offset: UInt32): UInt32;
function cErrorToStr(Value: TError): String;
function MinInt32(Value1, Value2: Int32): Int32;

function _StrToBool(const S: String; var Value: Boolean): Boolean;
function _StrToDateTime(const S: String; var Value: TDateTime): Boolean;
function _StrToFloat32(const S: String; var Value: Float32): UInt32;
function _StrToFloat64(const S: String; var Value: Float64): UInt32;
function _StrToInt08(const S: String; var Value: Int08): UInt32;
function _StrToInt16(const S: String; var Value: Int16): UInt32;
function _StrToInt32(const S: String; var Value: Int32): UInt32;
function _StrToInt64(const S: String; var Value: Int64): UInt32;
function _StrToUInt08(const S: String; var Value: UInt08): UInt32;
function _StrToUInt16(const S: String; var Value: UInt16): UInt32;
function _StrToUInt32(const S: String; var Value: UInt32): UInt32;
function _StrToUInt64(const S: String; var Value: UInt64): UInt32;
function _strDeleteSpace(var S: String; Options: TSetDeleteSpaceOptions): TError;

function cBoolToStr(Value: Boolean): String;
function cFloat64ToStr(Value: Float64): String;
function cUInt08ToChar(I: UInt08): Char;
function cUInt08ToStr(I: UInt08): String;
function cUInt16ToStr(I: UInt16): String;
procedure strAdd(var Str: String; S2: String);
function strCopy(SIn: String; Index, Count: Int32): String;
function strDelete(var St: String; Index, Count: UInt32): TError;
function strDeleteSpace(SIn: String; Options: TSetDeleteSpaceOptions = [dsFirst, dsLast, dsRep]): String;
function Tag(Name, Value: String): String;
function TagUInt32(Name: String; Value: UInt32): String;
function TagUInt64(Name: String; Value: UInt64): String;

implementation

// Functions -------------------------------------------------------------------

function ArrayStringAdd(var Source: TArrayString; const S: String): UInt32;
begin
  Result := Length(Source);
  SetLength(Source, Result + 1);
  Source[Result] := S;
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

function cBtnToStr(BtnCode: TWndRes): String;
// Возвращает название кода кнопки
// BtnCode - Код кнопки
begin
  case BtnCode of
    1: Result := 'Ok';
    2: Result := 'Cancel';
    3: Result := 'Abort';
    4: Result := 'Retry';
    5: Result := 'Ignore';
    6: Result := 'Yes';
    7: Result := 'No';
    8: Result := 'Close';
    9: Result := 'Help';
    10: Result := 'Try again';
    11: Result := 'Continue';
    $F1: Result := 'Last';
    $F2: Result := 'Next';
  else
    Result := '?';
  end;
end;

function cByteToStr(Value: Byte): String;
begin
  Result := cUInt08ToStr(Value);
end;

function cChar08ToChar16(C: Char08): Char16;
begin
  Result := WideChar(C);
end;

function cChar08ToUInt08(C: Char): UInt008;
begin
  Result := Ord(C);
end;

function cCharToByte(Value: Char): Byte;
begin
  Result := Ord(Value);
end;

function cCharToUInt08(C: Char): UInt008;
begin
  Result := Ord(C);
end;

function cDateTime64ToStr(T: TDateTime64): String;
begin
  try
    {Result := DateTimeToStr(T);}
    DateTimeToString(Result, 'dd.mm.yyyy hh:nn:ss', T);
  except
    //on EConvertError do ErrorUMyBaseConvert := ER_Convert + 2;
  else
  end;
end;

function cDateTime64ToStr2(T: TDateTime64; Typ: TConvertDT): String;
// Конвертирует тип TDateTime064 в String
// T   - Значение
// Typ - Вид вывода 0-Дата+Время, 1-Дата, 2-Время
begin
  try
  case Typ of
    1: Result := DateToStr(T);
    2: Result := TimeToStr(T);
    3: Result := cDateTime64ToStrF('s"."zzz', T); //FormatDateTime('hh:nn:ss', T);
  else
    Result := DateTimeToStr(T);
  end;
  except
  else
  end;
end;

function cDateTime64ToStrF(Format: TDateTimeFormat; T: TDateTime64): String;
begin
  Result := FormatDateTime(Format, T);
end;

function cDateTimeToStr(Value: TDateTime): String;
begin
  Result := cDateTime64ToStr(Value);
end;

function cDateToStr(D: TDateTime64): String;
begin
  Result := DateToStr(D);
end;

function cDoubleToDateTime(Value: Double): TDateTime;
begin
  Result := Value;
end;

function cFloat32ToInt32(Value: Float32): Int32;
begin
  Result := Round(Value);
end;

function cFloat64ToArrayByte(Value: Float64): TArrayByte;
begin
  SetLength(Result, 0);
end;

function cFloat64ToDateTime64(Value: Float64): TDateTime64;
begin
  Result := Value;
end;

function cFloat64ToInt32(F: Float64): Int032;
begin
  Result := Round(F);
end;

function cFloat64ToStrP(Value: Float64): String;
// Вводит тезультат с разделителем - точкой
var
  I: Int32;
begin
  Result := cFloat64ToStr(Value);
  for I := 1 to Length(Result) do
    if Result[I] = ',' then
      Result[I] := '.';
end;

function cFloat64ToUInt32(F: Float64): UInt032;
begin
  Result := Round(F);
end;

function cHexToChar(H1, H2: Char): Char;
const
  A: array[0..15] of Char = ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F');
begin
  Result := cUInt08ToChar(cHexToUInt08(H1) * 16 + cHexToUInt08(H2));
end;

function cHexToUInt08(H: Char): UInt008;
var
  B: UInt008;
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

function cInt08ToStr(I: Int008): String;
begin
  Result := cInt32ToStr(I);
end;

function cInt16ToStr(I: Int016): String;
begin
  Result := cInt32ToStr(I);
end;

{$IFNDEF VER170}
function cInt32ToPCharcInt32ToPChar(I: Int032): PChar;
var
  S: String;
begin
  S := cInt32ToStr(I);
  Result := PChar(S);
end;
{$ENDIF}

function cInt32ToStr(Value: Int032): String;
{$IFNDEF VER170}
begin
  try
    Result := IntToStr(Value);
  except
  else
  end;
end;
{$ELSE}
begin
  Result := Convert.ToString(Value);
end;
{$ENDIF}

function cInt64ToStr(I: Int064): String;
begin
  try
    Result := IntToStr(I);
  except
  else
  end;
end;

function cInt64ToUInt64(Value: Int064): UInt064;
begin
  Result := Value;
end;

{$IFNDEF VER170}
function cPCharToDateTime(S: PChar): TDateTime64;
begin
  Result := 0; if (S = nil) then Exit;
  Result := SysUtils.StrToDateTime(String(S));
end;

function cPCharToInt32cPCharToInt32(Str: PChar): Int032;
begin
  Result := cStrToInt32(String(Str));
end;

function cPCharToUInt32cPCharToUInt32(Str: PChar): UInt032;
var
  Code: Int032;
begin
  Result := 0;
  if (Str = nil) then begin Exit; end;
  try
    Val(String(Str), Result, Code);
  except
  else
  end;
end;
{$ENDIF}

function cSingleToInt32(Value: Single): Int32;
begin
  Result := Round(Value);
end;

function cSingleToStr(Value: Single): String;
begin
  Result := cFloat64ToStr(Value);
end;

function cSingleToUInt32(Value: Single): UInt32;
begin
  Result := Round(Value);
end;

function cStrCaseLower(St: String): String;
begin
  Result := AnsiLowerCase(St);
end;

function cStrCaseUpper(St: String): String;
begin
  Result := AnsiUpperCase(St);
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

function cStrPosCharToStr(Ch: TStrPosChar): String;
begin
  case Ch of
    1: Result := '.';
    2: Result := '!';
    3: Result := '?';
    4: Result := '...';
  else
    Result := '';
  end;
end;

function cStrToArrayByte(const S: String): TArrayByte;
var
  I: Int32;
begin
  SetLength(Result, Length(S));
  for I := 0 to High(Result) do
    Result[I] := cCharToUInt08(S[I + 1]);
end;

function cStrToDate(S: String): TDateTime64;
begin
  Result := SysUtils.StrToDate(S);
end;

function cStrToDateTime(S: String): TDateTime64;
begin
  if S = '' then
    Result := 0
  else
    Result := SysUtils.StrToDateTime(S);
end;

function cStrToDouble(Value: String): Double;
begin
  Result := cStrToFloat64(Value);
end;

function cStrToFloat32(S: String): Float32;
var
  Code: Cardinal;
begin
  Val(S, Result, Code);
  if Code <> 0 then Result := 0;
end;

function cStrToFloat64(S: String): Float64;
var
  Code: Cardinal;
begin
  Result := 0; if S = '' then Exit;
  Val(S, Result, Code);
  if Code <> 0 then Result := 0;
end;

{$IFNDEF VER170}
function cStrToFloatCurr(S: String; var Value: Float64): Boolean;
begin
  Result := TextToFloat(PChar(S), Value, fvCurrency);
end;
{$ENDIF}

function cStrToHtmlStr(Str: String): String;
var
  I: UInt032;
begin
  Result := '';
  for I := 1 to strLength(Str) do case Str[I] of
    '<': Result := Result + '&lt;';
    '>': Result := Result + '&gt;';
  else
    Result := Result + Str[I];
  end;
end;

function cStrToInt32(Str: String): Int032;
var
  Code: Int032;
begin
  Result := 0;
  try
    Val(Str, Result, Code);
  except
  else
  end;
end;

function cStrToSingle(Value: String): Single;
begin
  Result := cStrToFloat64(Value);
end;

function cStrToTime(Str: String): TDateTime64;
begin
  Result := StrToTime(Str);
end;

function cStrToUInt08(Str: String): UInt008;
var
  Code: Int032;
begin
  Val(Str, Result, Code);
end;

function cStrToUInt16(Str: String): UInt016;
var
  Code: Int032;
begin
  Val(Str, Result, Code);
end;

function cStrToUInt32(Str: String): UInt032;
var
  Code: Int032;
begin
  Result := 0;
  try
    Val(Str, Result, Code);
  except
  else
  end;
end;

function cStrToUInt64(Str: String): UInt064;
var
  Code: Int032;
begin
  Result := 0;
  try
    Val(Str, Result, Code);
  except
  else
  end;
end;

function cUInt08ToHex(I: UInt008): String;
  function a(I: UInt008): Char008;
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

function cUInt32ToStr(I: UInt032): String;
begin
  if I > HighInt032 then begin
    I := HighInt032;
  end;
  try
    Result := IntToStr(I);
  except
  end;
end;

{$IFNDEF VER170}
function cUInt64ToDateTime64(Value: UInt064): TDateTime64;
var
  P: Pointer;
begin
  P := @Value;
  Result := TDateTime64(P^);
end;
{$ENDIF}

function cUInt64ToInt32(Value: UInt064): Int032;
begin
  if Value > High(Int032) then
    Result := High(Int032)
  else if Value <= Low(Int032) then
    Result := Low(Int032)
  else
    Result := Value;
end;

function cUInt64ToStr(I: UInt064): String;
begin
  if I > HighInt064 then begin
    I := HighInt064;
  end;
  Result := cInt64ToStr(I);
end;

function cUInt64ToUInt08(Value: UInt064): UInt008;
begin
  if Value > High(UInt008) then
    Result := High(UInt008)
  else if Value <= 0 then
    Result := 0
  else
    Result := Value;
end;

function cUInt64ToInt16(Value: UInt064): UInt016;
begin
  if Value > High(UInt016) then
    Result := High(UInt016)
  else if Value <= 0 then
    Result := 0
  else
    Result := Value;
end;

function cUInt64ToUInt32(Value: UInt064): UInt032;
begin
  if Value > High(UInt032) then
    Result := High(UInt032)
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
  SetLength(Result, 0);
end;

function cUIntToStr(Value: UIntPtr): String;
begin
  Result := cUInt64ToStr(UInt64(Value));
end;

function DateTimeNow: TDateTime;
begin
  Result := dtNow;
end;

function dtNow: TDateTime64;
begin
  Result := Now;
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

function mathAbs(I: UInt032): UInt032; overload;
begin
  Result := Abs(I);
end;

function mathMax(V1, V2: UInt032): UInt032;
begin
  if V1 < V2 then Result := V2 else Result := V1;
end;

function mathMinInt32(V1, V2: Int32): Int32;
begin
  if V1 > V2 then Result := V2 else Result := V1;
end;

function mathMinUInt32(V1, V2: UInt032): UInt032;
//Возвращает меньшее из двех заданых чисел
//V1 - Первое значение
//V2 - Второе значение
begin
  if V1 > V2 then Result := V2 else Result := V1;
end;

function mathPower(Base, Exponent: Float64): Float64;
begin
  Result := Power(Base, Exponent);
end;

function strCaseLower(const S: String): String;
// Заменяет все заглавные буквы на строчные с учетом русских букв
begin
  Result := AnsiLowerCase(S);
end;

function strCaseLowerEng(const S: String): String;
// Заменяет все заглавные буквы на строчные (только латиница)
begin
  Result := AnsiLowerCase(S);
end;

procedure strCaseUpper(var S: String);
begin
  S := AnsiUpperCase(S);
end;

function strCopyFrom(SIn: String; IStart: UInt032): String;
var
  L: UInt032; // Длина строки
begin
  Result := '';
  L := strLength(SIn);
  if L < IStart then Exit;
  Result := strCopy(SIn, IStart, L-IStart+1);
end;

function strCopyFromTo(SIn: String; IStart, IEnd: UInt032): String;
// Копирует часть строки с начальной по конечный символы включая граничные символы
begin
  Result := ''; if IStart > IEnd then Exit;
  Result := Copy(SIn, IStart, IEnd-IStart+1);
end;

function strDivisionComma(const S: String; var Words: TArrayString): UInt032;
var
  Q: String;
  I: UInt032;
  I2: UInt032;
begin
  Result := 0; if strLength(S) = 0 then Exit;
  Q := S;
  SetLength(Words, 0);
  // Разделение на отдельные выражения
  while strLength(Q) > 0 do begin
    I := strPos(Q, ',');
    I2 := Length(Words); SetLength(Words, I2+1);
    if I > 0 then begin
      Words[I2] := strCopy(Q, 1, I-1);
      {}WriteLn(Words[I2]);
      {}WriteLn('<br>'+cUInt32ToStr(I2));
      strDelete(Q, 1, I);
    end else begin
      Words[I2] := Q;
      Q := '';
    end;
  end;
  if Length(Words) = 0 then Exit;
  // Удаление префиксных и постфиксных пробелов
  for I := 0 to High(Words) do Words[I] := strDeleteSpace(Words[I]);
end;

function strEqual(Str1, Str2: String): UInt032;
var
  I: UInt032;
  L1, L2: UInt032;
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
  L1: UInt032;
  L2: UInt032;
  Lmin: UInt032;
  dL: UInt032;
  S: String;
  L: UInt032;
  I, I2: UInt032;
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

function strExecutePath(FullFileName: String): String;
// Возвращает путь к файлу
var
  I: Int32;
  I2: Int32;
begin
  I2 := 0;
  Result := '';
  for I := Length(FullFileName) downto 1 do begin
    if (FullFileName[I] = '/') or (FullFileName[I] = '\') then begin
      I2 := I;
      Break;
    end;
  end;
  if I2 = 0 then Exit;
  Result := strCopy(FullFileName, 1, I2);
end;

function StrExtractWord(Num: UInt32; Str: String; Delims: TArrayChar): String;
// Выделяет слово Num по счету c разделителями Delims
var
  INum: Int32;        // Текущее слово по порядку
  Pos: Int32;         // Позиция начала строки для выделения слова
  MinDelimPos: Int32;

  function GetMinDelimPos(Str: String; Start: UInt32; Delims: TArrayChar): Int32;
  var
    I: Int32;
    I2: Int32;
  begin
    Result := 0;
    for I := 0 to High(Delims) do begin
      I2 := StrPos(Str, Delims[I]);
      if (Result > I2) and (I2 >= 0) then Result := I2;
    end;
  end;

begin
  Result := '';
  Pos := 1;
  if Num = 1 then begin
    MinDelimPos := GetMinDelimPos(Str, 1, Delims);
    if MinDelimPos <= 0 then begin
      Result := Str;
      Exit;
    end else begin
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

  if MinDelimPos <= 0 then begin
    Result := StrCopy(Str, Pos, StrLength(Str) - Pos);
  end else begin
    Result := StrCopy(Str, Pos + 1, MinDelimPos - Pos - 1);
  end;
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

function strHtmlTagErraceH(SIn: String; var SOut: String; var Level: UInt032): TError;
{var
  I, L: UInt032;
  P: PChar;
label L1;}
begin
  (*Result := eError; if (Level <> nil) then Level^ := 0;
  if (SOut <> nil) then SOut^ := '';
  L := _strLen(SIn);
  if (L < 10) then goto L1; {Минимум 10 символов <h1>A</h1>}
  P := memAlloc(L + 1);
  memCopy(SIn, P, L + 1);
  strPos(P, '<', @I); strDelete(@P, 1, I);
  {if (_strLen(P) < 2) then goto L1;}
  if (Char008(P^) <> 'h') and (Char008(P^) <> 'H') then goto L1;
  strDelete(@P, 1, 1);
  strPos(P, '>', @I);
  if (Level <> nil) then Level^ := StrToUInt032(_strCopy(P, 1, I - 1));
  strDelete(@P, 1, I);
  strPos(P, '<', @I);
  strDelete(@P, I, _strLen(P) + 1 - I);
  {Result := strDeleteSpace(SIn, SOut);}
L1:
  SOut^ := P;
  Result := 0;*)
  SOut := SIn;
  Result := 0;
end;

function strHtmlTagErraceP(const SIn: String; var SOut: String): TError;
{var
  I: UInt032;}
begin
  (*Result := eError; if (_strLen(SIn) < 1) then Exit; {Минимум 1 символов 'A'}
  strPos(SIn, '<', @I); strDelete(@SIn, 1, I);
  if (_strLen(SIn) < 2) then Exit;
  {strDelete(@SIn, 1, 1);}
  if (Char008(SIn^) <> 'p') and (Char008(SIn^) <> 'P') then Exit;
  strPos(SIn, '>', @I); strDelete(@SIn, 1, I);
  strPos(SIn, '<', @I); strDelete(@SIn, I, _strLen(SIn) + 1 - I);
  {Result := strDeleteSpace(SIn, SOut);}
  SOut^ := SIn;
  Result := 0;*)
  Result := 0;
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

procedure strInsert(var S: String; SubSt: String; Index: UInt032);
begin
  Insert(SubSt, S, Index);
end;

function strLength(const S: String): UInt032;
begin
  // Вычисляет реальную длину (без учета конца строки #0)
  Result := Length(S);
end;

function strLengthSet(var S: String; NewLength: UInt032): TError;
begin
  Result := 0;
  SetLength(S, NewLength);
end;

function strPos(St, SubSt: String): UInt032;
begin
  Result := Pos(SubSt, St);
end;

function strPos3(S: String; var Ch: TStrPosChar): UInt032;
var
  I: UInt032;
  L: UInt032;
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

function timeNow: TDateTime64;
begin
  Result := Time;
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

function urlParamDecode(const InParams: TUrlParams; var Params: TURLParams2): TError;
var
  SS: String;
  ST: String;
  I: Int032;
  K: Int032;
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

function urlParamBack(const InParams: String): String;
var
  I: UInt032;
begin
  Result := ''; if strLength(InParams) < 5 then Exit;
  I := strPos(InParams, 'Back=');
  if I = 0 then Exit;
  Result := strCopy(InParams, I + 5, strLength(InParams));
end;

function urlParamByName(InParams: TUrlParams; Name: string): string;
// Фнкция возвращает значение атрибута заданного в качестве параметра функции из строки данных
var
  SS: String;
  ST: String;
  K: Int032;
begin
  Result := '';
  SS := InParams;
  while Length(SS) <> 0 do
  begin
    K := strPos(SS, '&');
    if (K <> 0) then
    begin
      ST := strCopy(SS, 1, K-1);
      SS := strCopy(SS, K+1, 10000);
    end
    else
    begin
      ST :=SS;
      SS:='';
    end;
    K := Pos('=',ST);
    if (K <> 0) then
    begin
      if (Name = strCopy(ST, 1, K-1)) then
      begin
        Result := urlDecode(Copy(ST, K+1, 6000));
      end;
    end;
  end;
end;

function urlParamByName_UInt064(InParams: TUrlParams; Name: String): UInt064;
begin
  Result := cStrToUInt64(urlParamByName(InParams, Name));
end;

function urlParamCount(InParams: String): UInt032;
var
  Params: TURLParams2;
begin
  urlParamDecode(InParams, Params);
  Result := Length(Params);
end;

{$IFNDEF VER170}
function _strLen(const Str: PChar): UInt032; assembler;
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

function cErrorToStr(Value: TError): String;
begin
  if Value = 0 then
    Result := 'Ok'
  else
    Result := cUInt32ToStr(Value);
end;

function cFloat32ToStr(Value: Float32): String;
begin
  Result := cFloat64ToStr(Value);
end;

{$IFDEF VER170}
function cFloat64ToArrayByte(Value: Float64): TArrayByte;
begin
  SetLength(Result, 8);
end;

function cFloat64ToDateTime64(Value: Float64): TDateTime64;
begin
  Result := Value;
end;
{$ENDIF}

function cFloat64ToStr(Value: Float64): String;
// Выводит результат с разделителем по установкам Windos
begin
  try
    Result := FloatToStr(Value);
  except
    on EConvertError do begin end;
  else
  end;
end;

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

function _StrToDateTime(const S: String; var Value: TDateTime): Boolean;
begin
  try
    Value := StrToDateTime(S);
    Result := True;
  except
    Result := False;
  end;
end;

function _StrToFloat32(const S: String; var Value: Float32): UInt32;
begin
  Val(S, Value, Result);
end;

function _StrToFloat64(const S: String; var Value: Float64): UInt32;
begin
  Val(S, Value, Result);
end;

function _StrToInt08(const S: String; var Value: Int08): UInt32;
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

function _StrToUInt08(const S: String; var Value: UInt08): UInt32;
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

function _strDeleteSpace(var S: String; Options: TSetDeleteSpaceOptions): TError;
// Удаление префиксных, постфиксных, повторяющихся пробелов и префиксных и поствиксных #13#10
var
  B: Boolean;
  I: UInt32;
begin
  repeat
  B := False;

  Result := 0;
  if (strLength(S) = 0) then Exit;
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

function cUInt08ToChar(I: UInt08): Char;
begin
  Result := Chr(I);
end;

function cUInt08ToStr(I: UInt08): String;
begin
  Result := cUInt32ToStr(I);
end;

function cUInt16ToStr(I: UInt16): String;
begin
  Result := cUInt32ToStr(I);
end;

procedure strAdd(var Str: String; S2: String);
begin
  Str := Concat(Str, S2);
end;

function strCopy(SIn: String; Index, Count: Int32): String;
begin
  if Count <= 0 then Result := '' else Result := Copy(SIn, Index, Count);
end;

function strDelete(var St: String; Index, Count: UInt32): TError;
begin
  Delete(St, Index, Count);
  Result := 0;
end;

function strDeleteSpace(SIn: String; Options: TSetDeleteSpaceOptions): String;
begin
  Result := ''; if (strLength(SIn) = 0) then Exit;
  Result := SIn;
  _strDeleteSpace(Result, Options);
end;

function Tag(Name, Value: String): String;
begin
  Result := '<'+Name+'>'+Value+'</'+Name+'>';
end;

function TagUInt32(Name: String; Value: UInt32): String;
begin
  Result := Tag(Name, cUInt32ToStr(Value));
end;

function TagUInt64(Name: String; Value: UInt64): String;
begin
  Result := Tag(Name, cUInt64ToStr(Value));
end;

end.
