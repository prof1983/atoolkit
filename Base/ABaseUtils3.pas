{**
@Abstract Базовый модуль основных типов и их преобразования. Базовые функции for Delphi 5,7,9
@Author Prof1983 <prof1983@ya.ru>
@Created 06.06.2004
@LastMod 20.12.2012
}
unit ABaseUtils3;

interface

uses
  SysUtils, Dialogs, ExtCtrls, Forms, Windows, StrUtils, Math,
  ABase, ABase2, ABaseUtils2, ATypes;

// functions -------------------------------------------------------------------

function cByteToStr(Value: Byte): string;
function cDateTime64ToStr(T: TDateTime64): string;
function cDateTime64ToStr2(T: TDateTime64; Typ: TConvertDT): string;
// Конвертирует тип TDateTime064 в String
function cDateTime64ToStrF(Format: TDateTimeFormat; T: TDateTime64): string;
function cDateTimeToStr(Value: TDateTime): string;
function cDateToStr(D: TDateTime64): string;
function cFloat32ToStr(Value: Float32): string;
function cFloat64ToStrP(Value: Float64): string;
function cInt08ToStr(I: Int008): string;
function cInt16ToStr(I: Int016): string;
function cInt32ToStr(Value: Int032): string;
function cInt64ToStr(I: Int064): string;
function cSingleToStr(Value: Single): string;
// Делает все заглавные буквы строчными
function cStrCaseLower(St: string): string;
// Делает все строчныме буквы заглавными
function cStrCaseUpper(St: string): string;
function cStrToDate(S: string): TDateTime64;
function cStrToDateTime(S: string): TDateTime64;
{$IFNDEF VER170}
function cStrToFloatCurr(S: string; var Value: Float64): Boolean;
{$ENDIF}
function cStrToTime(Str: string): TDateTime64;
function cUInt064ToStr(Value: Integer): string; deprecated; // Use cUInt64ToStr()
function cUInt32ToStr(I: AUInt32): string;
function cUInt64ToStr(I: UInt064): string;
function cUInt64ToUInt08(Value: UInt064): UInt008;
function cUInt64ToInt16(Value: UInt064): UInt016;
function cUInt64ToUInt32(Value: UInt064): UInt032;
function cUInt32ToArrayByte(Value: UInt32): TArrayByte;
function cUIntToStr(Value: UIntPtr): String;
function mathMinUInt32(V1: UInt032; V2: UInt032): UInt032;
function mathPower(Base, Exponent: Float64): Float64;
function strCaseLower(const S: string): string;
function strCaseLowerEng(const S: string): string;
// Заменяет все строчные буквы на заглавные с учетом русских букв
procedure strCaseUpper(var S: string);
// Разделяет строку на слова и выражения, удаляет префиксные и постфиксные пробелы. Разделителем является запятая.
// Words - Слова и выражения по порядку (out)
// Result - Номер символа, в котором произошла ошибка или 0, если успешно
function strDivisionComma(const S: string; var Words: TArrayString): UInt032;
// Возвращает текущее время
function timeNow: TDateTime64;

function _StrToDateTime(const S: String; var Value: TDateTime): Boolean;

function cFloat64ToStr(Value: Float64): String;
function cUInt08ToStr(I: AUInt08): String;
function cUInt16ToStr(I: UInt16): String;
function Tag(Name, Value: String): String;

implementation

// Functions -------------------------------------------------------------------

function cByteToStr(Value: Byte): String;
begin
  Result := cUInt08ToStr(Value);
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

function cInt08ToStr(I: Int008): String;
begin
  Result := cInt32ToStr(I);
end;

function cInt16ToStr(I: Int016): String;
begin
  Result := cInt32ToStr(I);
end;

function cInt32ToStr(Value: Int32): String;
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

function cInt64ToStr(I: Int64): String;
begin
  try
    Result := IntToStr(I);
  except
  else
  end;
end;

function cSingleToStr(Value: Single): String;
begin
  Result := cFloat64ToStr(Value);
end;

function cStrCaseLower(St: String): String;
begin
  Result := AnsiLowerCase(St);
end;

function cStrCaseUpper(St: String): String;
begin
  Result := AnsiUpperCase(St);
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

{$IFNDEF VER170}
function cStrToFloatCurr(S: String; var Value: Float64): Boolean;
begin
  Result := TextToFloat(PChar(S), Value, fvCurrency);
end;
{$ENDIF}

function cStrToTime(Str: String): TDateTime64;
begin
  Result := StrToTime(Str);
end;

function cUInt064ToStr(Value: Integer): string;
begin
  Result := IntToStr(Value);
end;

function cUInt32ToStr(I: AUInt32): String;
begin
  if I > HighInt032 then begin
    I := HighInt032;
  end;
  try
    Result := IntToStr(I);
  except
  end;
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

function cUIntToStr(Value: UIntPtr): String;
begin
  Result := cUInt64ToStr(UInt64(Value));
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

function strDivisionComma(const S: String; var Words: TArrayString): AUInt32;
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

function timeNow: TDateTime64;
begin
  Result := Time;
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

function cFloat32ToStr(Value: Float32): String;
begin
  Result := cFloat64ToStr(Value);
end;

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

function _StrToDateTime(const S: String; var Value: TDateTime): Boolean;
begin
  try
    Value := StrToDateTime(S);
    Result := True;
  except
    Result := False;
  end;
end;

function cUInt08ToStr(I: AUInt08): String;
begin
  Result := cUInt32ToStr(I);
end;

function cUInt16ToStr(I: UInt16): String;
begin
  Result := cUInt32ToStr(I);
end;

function Tag(Name, Value: String): String;
begin
  Result := '<'+Name+'>'+Value+'</'+Name+'>';
end;

end.
