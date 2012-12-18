{**
@Abstract Util functions
@Author Prof1983 <prof1983@ya.ru>
@Created 30.09.2009
@LastMod 18.12.2012
}
unit AUtils;

{$IFDEF AOLD}
  {$DEFINE AUTILSOLD}
{$ENDIF AOLD}

interface

uses
  SysUtils, {$IFNDEF FPC}Windows,{$ENDIF}
  ABase, ABaseUtils, AStringUtils, AStrings, ASystem;

// ----

function Init(): AError; stdcall; deprecated; // Use AUtils_Init()
function Done(): AError; stdcall; deprecated; // Use AUtils_Fin()

function Utils_Init(): AError; deprecated; // Use AUtils_Init()
function Utils_Done(): AError; deprecated; // Use AUtils_Fin()

function ChangeFileExtP(const FileName, Extension: APascalString): APascalString; stdcall;

function ChangeFileExtWS(const FileName, Extension: AWideString): AWideString; stdcall;

function DateToStrP(Value: TDateTime): APascalString; stdcall;

function DateToStrWS(Value: TDateTime): AWideString; stdcall;

function DeleteFileP(const FileName: APascalString): AError; stdcall;

function DeleteFileWS(const FileName: AWideString): AError; stdcall;

function DirectoryExistsP(const Directory: APascalString): ABoolean; stdcall;

function ExpandFileNameP(const FileName: APascalString): APascalString; stdcall;

function ExpandFileNameWS(const FileName: AWideString): AWideString; stdcall;

{$IFDEF AUTILSOLD}
// Use ExtractFileExt()
function ExtractFileExt(const FileName: AWideString): AWideString; stdcall; deprecated;
{$ELSE}
function ExtractFileExt(const FileName: AString_Type; out Res: AString_Type): AInteger; stdcall;
{$ENDIF AUTILSOLD}

// Извлекает расширение файла из полного названия.
function ExtractFileExtP(const FileName: APascalString): APascalString; stdcall;

// Извлекает расширение файла из полного названия.
function ExtractFileExtWS(const FileName: AWideString): AWideString; stdcall;

{$IFDEF AUTILSOLD}
{$ELSE}
function ExtractFilePath(const FileName: AString_Type; out Res: AString_Type): AInteger; stdcall;
{$ENDIF AUTILSOLD}

// Извлекает путь к файлу.
function ExtractFilePathP(const FileName: APascalString): APascalString; stdcall;

// Извлекает путь к файлу.
function ExtractFilePathWS(const FileName: AWideString): AWideString; stdcall;

{$IFDEF AUTILSOLD}
function FileExists(const FileName: AWideString): ABoolean; stdcall; deprecated; // Use FileExistsWS()
{$ELSE}
function FileExists(const FileName: AString_Type): ABoolean; stdcall;
{$ENDIF AUTILSOLD}

// Возвращает True, если указанный файл существует.
function FileExistsP(const FileName: APascalString): ABoolean; stdcall;

// Возвращает True, если указанный файл существует.
function FileExistsWS(const FileName: AWideString): ABoolean; stdcall;

// Преобразует число в строку.
{$IFDEF AUTILSOLD}
function FloatToStr(Value: AFloat): APascalString; stdcall; deprecated; // Use FloatToStrWS()
{$ELSE}
function FloatToStr(Value: AFloat; out Res: AString_Type): AInteger; stdcall;
{$ENDIF AUTILSOLD}

function FloatToStr2WS(Value: AFloat; DigitsAfterComma: Integer; ReplaceComma, Delimer: ABoolean): AWideString; stdcall;

// Преобразует число в строку c двумя знаками после запятой.
{$IFDEF AUTILSOLD}
function FloatToStrA(Value: AFloat; DigitsAfterComma: Integer = 2): AWideString; stdcall; deprecated; // Use FloatToStrAP()
{$ELSE}
function FloatToStrA(Value: AFloat; DigitsAfterComma: AInteger; out Res: AString_Type): AInteger; stdcall;
{$ENDIF AUTILSOLD}

// Преобразует число в строку c двумя знаками после запятой.
function FloatToStrAP(Value: AFloat; DigitsAfterComma: Integer = 2): APascalString; stdcall;

// Преобразует число в строку c двумя знаками после запятой.
function FloatToStrAWS(Value: AFloat; DigitsAfterComma: Integer = 2): AWideString; stdcall;

// Преобразует число в строку для записи в БД (SQL). Для SQL необходим разделитель - точка.
{$IFDEF AUTILSOLD}
function FloatToStrB(Value: AFloat; DigitsAfterComma: Integer = 2): APascalString; stdcall; deprecated; // Use FloatToStrBP()
{$ELSE}
function FloatToStrB(Value: AFloat; Digits: AInteger; out Res: AString_Type): AInteger; stdcall;
{$ENDIF AUTILSOLD}

// Преобразует число в строку для записи в БД (SQL). Для SQL необходим разделитель - точка.
function FloatToStrBP(Value: AFloat; DigitsAfterComma: Integer = 2): APascalString; stdcall;

// Преобразует число в строку для записи в БД (SQL). Для SQL необходим разделитель - точка.
function FloatToStrBWS(Value: AFloat; DigitsAfterComma: Integer = 2): AWideString; stdcall;

{$IFDEF AUTILSOLD}
function FloatToStrC(Value: AFloat; DigitsAfterComma: Integer = 2): APascalString; stdcall; deprecated; // Use FloatToStrCP()
{$ELSE}
function FloatToStrC(Value: AFloat; Digits: AInteger; out Res: AString_Type): AInteger; stdcall;
{$ENDIF AUTILSOLD}

function FloatToStrCP(Value: AFloat; DigitsAfterComma: Integer = 2): APascalString; stdcall;

function FloatToStrCWS(Value: AFloat; DigitsAfterComma: Integer = 2): AWideString; stdcall;

function FloatToStrD(Value: AFloat; out Res: AString_Type): AInteger; stdcall;

function FloatToStrDP(Value: AFloat): APascalString; stdcall;

function FloatToStrDWS(Value: AFloat): AWideString; stdcall;

// Преобразует число в строку.
function FloatToStrP(Value: AFloat): APascalString; stdcall;

// Преобразует число в строку.
function FloatToStrWS(Value: AFloat): AWideString; stdcall;

function FormatFloat1(Value: AFloat; Count, Digits: AInteger; out Res: AString_Type): AInteger; stdcall;

function FormatFloatP(Value: AFloat; DigitsBeforeComma, DigitsAfterComma: AInteger): APascalString; stdcall;

function FormatFloatWS(Value: AFloat; DigitsBeforeComma, DigitsAfterComma: AInteger): AWideString; stdcall;

// Преобразует число в строку формата "%Nd".
{$IFDEF AUTILSOLD}
function FormatInt(Value, Count: AInteger): AWideString; stdcall; deprecated; // Use FormatIntWS()
{$ELSE}
function FormatInt(Value, Count: AInteger; out Res: AString_Type): AInteger; stdcall;
{$ENDIF AUTILSOLD}

// Преобразует число в строку формата "%Nd".
function FormatIntP(Value, Count: AInteger): APascalString; stdcall;

// Преобразует число в строку формата "%Nd".
function FormatIntWS(Value, Count: AInteger): AWideString; stdcall;

// Возвращяет строку обрезанную до определенной длины (Len > 0) или строку указанной длины (L < 0).
function FormatStr(const Value: AString_Type; Len: AInteger; out Res: AString_Type): AInteger; stdcall;

// Возвращяет строку обрезанную до определенной длины (Len > 0) или строку указанной длины (L < 0).
function FormatStrAnsi(const Value: AnsiString; Len: AInteger): AnsiString; stdcall;

// Возвращяет строку обрезанную до определенной длины (Len > 0) или строку указанной длины (L < 0).
function FormatStrP(const Value: APascalString; Len: AInteger): APascalString; stdcall;

// Возвращяет строку обрезанную до определенной длины (Len > 0) или строку указанной длины (L < 0).
function FormatStrWS(const Value: AWideString; Len: AInteger): AWideString; stdcall;

function GetNowDateTime(): TDateTime; stdcall;

// Применяет Format() к строке с одним строковым параметром. Например: "Ошибка в %s".
function FormatStrStr(const FormatStr, S: APascalString): APascalString; stdcall;

// Применяет Format() к строке с одним строковым параметром. Например: "Ошибка в %s".
function FormatStrStrWS(const FormatStr, S: AWideString): AWideString; stdcall;

{$IFDEF AUTILSOLD}
function IntToStr(Value: AInteger): AWideString; stdcall; deprecated; // Use IntToStrWS()
{$ELSE}
function IntToStr(Value: AInteger; out Res: AString_Type): AInteger; stdcall;
{$ENDIF AUTILSOLD}

// Преобразует число в строку.
function IntToStrP(Value: AInteger): APascalString; stdcall;

// Преобразует число в строку.
function IntToStrWS(Value: AInteger): AWideString; stdcall;

function NormalizeFloat(Value: AFloat): AFloat; stdcall;

// Заменяет не отображаемые символы строки на #
{$IFDEF AUTILSOLD}
function NormalizeStr(const Value: AWideString): AWideString; stdcall; deprecated; // Use NormalizeStrWS()
{$ELSE}
function NormalizeStr(const Value: AString_Type; out Res: AString_Type): AInteger; stdcall;
{$ENDIF AUTILSOLD}

// Заменяет не отображаемые символы строки на #
function NormalizeStrP(const Value: APascalString): APascalString; stdcall;

// Заменяет не отображаемые символы строки на #
function NormalizeStrWS(const Value: AWideString): AWideString; stdcall;

{ Заменяет не отображаемые символы строки на пробелы,
  перенос строки (#13#10) заменяет на один пробел. }
function NormalizeStrSpace(const Value: AString_Type; out Res: AString_Type): AInteger; stdcall;

{ Заменяет не отображаемые символы строки на пробелы,
  перенос строки (#13#10) заменяет на один пробел. }
function NormalizeStrSpaceP(const Value: APascalString): APascalString; stdcall;

{ Заменяет не отображаемые символы строки на пробелы,
  перенос строки (#13#10) заменяет на один пробел. }
function NormalizeStrSpaceWS(const Value: AWideString): AWideString; stdcall;

function Power(Base, Exponent: AFloat): AFloat; stdcall;

{ Заменяет все точки на запятые или все запятые на точки в зависимости от региональных настроек.
  Если параметр DecimalSeparator указан, то региональные настройки игнорируются. }
{$IFDEF AUTILSOLD}
// Use ReplaceCommaWS()
function ReplaceComma(const S: AWideString; DecimalSeparator: AChar = #0;
    ClearSpace: ABoolean = True): AWideString; stdcall; deprecated;
{$ELSE}
function ReplaceComma(const S: AString_Type; DecimalSeparator: AChar {= #0};
    ClearSpace: ABoolean {= True}; out Res: AString_Type): AInteger; stdcall;
{$ENDIF AUTILSOLD}

{ Заменяет все точки на запятые или все запятые на точки в зависимости от региональных настроек.
  Если параметр DecimalSeparator указан, то региональные настройки игнорируются. }
function ReplaceCommaP(const S: APascalString; DecimalSeparator: AChar = #0;
    ClearSpace: ABoolean = True): APascalString; stdcall;

{ Заменяет все точки на запятые или все запятые на точки в зависимости от региональных настроек.
  Если параметр DecimalSeparator указан, то региональные настройки игнорируются. }
function ReplaceCommaWS(const S: AWideString; DecimalSeparator: AChar = #0;
    ClearSpace: ABoolean = True): AWideString; stdcall;

{ Округляет значение до указанного кол-ва значащих цифр и обрезает до указанного кол-ва знаков после запятой.
  Digits1 - кол-во значащих цифр (Meaning numbers)
  DigitsAfterComma - максимально необходимое кол-во знаков после запятой (Numbers after a comma) }
function Round2(Value: Real; Digits1, DigitsAfterComma: Integer): Real; stdcall;

{$IFDEF AUTILSOLD}
function StrToDate(const Value: AWideString): TDateTime; stdcall; deprecated; // Use StrToDateWS()
{$ELSE}
function StrToDate(const Value: AString_Type): TDateTime; stdcall;
{$ENDIF AUTILSOLD}

//** Преобразует дату/время из строки.
function StrToDateA(Value: PAnsiChar): TDateTime; stdcall;

//** Преобразует дату/время из строки.
function StrToDateWS(const Value: AWideString): TDateTime; stdcall;

{$IFDEF AUTILSOLD}
{$ELSE}
function StrToFloat(const Value: AString_Type): AFloat; stdcall;
{$ENDIF AUTILSOLD}

{ Преобразует строку в Float. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы.
  Use StrToFloatWS() or StrToFloatDefP(S,0) }
{$IFDEF AUTILSOLD}
function StrToFloat1(const S: APascalString; DefValue: AFloat = 0): AFloat; stdcall; deprecated;
{$ELSE}
function StrToFloat1(const S: AString_Type; DefValue: AFloat = 0): AFloat; stdcall; deprecated;
{$ENDIF AUTILSOLD}

{ Преобразует строку в Float. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
function StrToFloatDef(const S: AString_Type; DefValue: AFloat): AFloat; stdcall;

{ Преобразует строку в Float. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
function StrToFloatDefP(const S: APascalString; DefValue: AFloat): AFloat; stdcall;

{ Преобразует строку в Float. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
function StrToFloatDefWS(const S: AWideString; DefValue: AFloat): AFloat; stdcall;

{ Преобразует строку в Float. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
function StrToFloatP(const S: APascalString): AFloat; stdcall;

{ Преобразует строку в Float. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
function StrToFloatWS(const S: AWideString): AFloat; stdcall;

{$IFDEF AUTILSOLD}
function StrToInt(const S: AWideString): AInteger; stdcall; deprecated; // Use StrToIntWS()
{$ELSE}
function StrToInt(const Value: AString_Type): AInteger; stdcall;
{$ENDIF}

function StrToInt1(const S: APascalString; DefValue: AInteger = 0): AInteger; stdcall; deprecated; // Use StrToIntDefP(S,0)

function StrToIntDefP(const S: APascalString; DefValue: AInteger): AInteger; stdcall;

function StrToIntDefWS(const S: AWideString; DefValue: AInteger): AInteger; stdcall;

// Преобразует строку в число.
function StrToIntP(const S: APascalString): AInteger; stdcall;

// Преобразует строку в число.
function StrToIntWS(const S: AWideString): AInteger; stdcall;

// Переводит все символы строки в нижний регистр.
function String_ToLowerP(const S: APascalString): APascalString; stdcall;

// Переводит все символы строки в нижний регистр.
function String_ToLowerWS(const S: AWideString): AWideString; stdcall;

// Переводит все символы строки в верхний регистр.
function String_ToUpper(const S: AString_Type; out Res: AString_Type): AInteger; stdcall; deprecated; // Use AString_ToUpper()

// Переводит все символы строки в верхний регистр.
function String_ToUpperP(const S: APascalString): APascalString; stdcall; deprecated; // Use AString_ToUpperP()

// Переводит все символы строки в верхний регистр.
function String_ToUpperWS(const S: AWideString): AWideString; stdcall; deprecated; // Use AString_ToUpperWS()

{$IFDEF AUTILSOLD}
function TryStrToDate(const S: AWideString; var Value: TDateTime): ABoolean; stdcall; deprecated; // Use TryStrToDateWS()
{$ELSE}
function TryStrToDate(const S: AString_Type; var Value: TDateTime): ABoolean; stdcall;
{$ENDIF AUTILSOLD}

function TryStrToDateP(const S: APascalString; var Value: TDateTime): ABoolean; stdcall;

function TryStrToDateWS(const S: AWideString; var Value: TDateTime): ABoolean; stdcall;

{ Преобразует строку в Float. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
{$IFDEF AUTILSOLD}
function TryStrToFloat(const S: AWideString; var Value: AFloat): ABoolean; stdcall; deprecated; // Use TryStrToFloatWS()
{$ELSE}
function TryStrToFloat(const S: AString_Type; var Value: AFloat): ABoolean; stdcall;
{$ENDIF AUTILSOLD}

{ Преобразует строку в Float32. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
{$IFDEF AUTILSOLD}
function TryStrToFloat32(const S: APascalString; var Value: AFloat32): ABoolean; stdcall; deprecated; // Use TryStrToFloat32()
{$ELSE}
function TryStrToFloat32(const S: AString_Type; var Value: AFloat32): ABoolean; stdcall;
{$ENDIF AUTILSOLD}

{ Преобразует строку в Float32. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
function TryStrToFloat32P(const S: APascalString; var Value: AFloat32): ABoolean; stdcall;

{ Преобразует строку в Float32. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
function TryStrToFloat32WS(const S: AWideString; var Value: AFloat32): ABoolean; stdcall;

{ Преобразует строку в Float64. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
{$IFDEF AUTILSOLD}
function TryStrToFloat64(const S: APascalString; var Value: AFloat64): ABoolean; stdcall; deprecated; // Use TryStrToFloat64WS()
{$ELSE}
function TryStrToFloat64(const S: AString_Type; var Value: AFloat64): ABoolean; stdcall;
{$ENDIF AUTILSOLD}

{ Преобразует строку в Float64. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
function TryStrToFloat64P(const S: APascalString; var Value: AFloat64): ABoolean; stdcall;

{ Преобразует строку в Float64. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
function TryStrToFloat64WS(const S: AWideString; var Value: AFloat64): ABoolean; stdcall;

{ Преобразует строку в Float. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
function TryStrToFloatP(const S: APascalString; var Value: AFloat): ABoolean; stdcall;

{ Преобразует строку в Float. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
function TryStrToFloatWS(const S: AWideString; var Value: AFloat): ABoolean; stdcall;

{$IFDEF AUTILSOLD}
function TryStrToInt(const S: AWideString; var Value: AInteger): ABoolean; stdcall; deprecated; // Use TryStrToIntWS()
{$ELSE}
function TryStrToInt(const S: AString_Type; var Value: AInteger): ABoolean; stdcall;
{$ENDIF AUTILSOLD}

function TryStrToIntWS(const S: AWideString; var Value: AInteger): ABoolean; stdcall;

function UpperStringP(const S: APascalString): APascalString; stdcall; deprecated; // Use String_ToUpperP()

{ Trims leading and trailing spaces and control characters from a string.
  Удаляет первые и последние пробелы }
{$IFDEF AUTILSOLD}
function Trim(const S: AWideString): AWideString; stdcall; deprecated; // Use TrimWS()
{$ELSE}
function Trim(const S: AString_Type; out Res: AString_Type): AInteger; stdcall;
{$ENDIF AUTILSOLD}

{ Trims leading and trailing spaces and control characters from a string.
  Удаляет первые и последние пробелы. }
function TrimP(const S: APascalString): APascalString; stdcall;

{ Trims leading and trailing spaces and control characters from a string.
  Удаляет первые и последние пробелы. }
function TrimWS(const S: AWideString): AWideString; stdcall;

//** Ожидает указанное кол-во миллисекунд.
function Sleep(Milliseconds: AUInt): AError; stdcall;

//** Ожидает указанное кол-во миллисекунд.
procedure Sleep02(Milliseconds: AUInt); stdcall;

//** Возвращает текущую дату и время.
function Time_Now(): TDateTime; stdcall; // Use GetNowDateTime()

{ Utils }

// TODO: Убрать stdcall
// TODO: Перенести в AUtilsMain

{** Преобразует число в строку }
function Utils_FloatToStr(Value: AFloat): APascalString; stdcall; deprecated; // Use FloatToStrWS()

{** Преобразует число в строку c двумя знаками после запятой }
function Utils_FloatToStrA(Value: AFloat; DigitsAfterComma: Integer = 2): APascalString; stdcall; deprecated; // Use FloatToStrAWS()

// Преобразует число в строку для записи в БД (SQL). Для SQL необходим разделитель - точка.
function Utils_FloatToStrB(Value: AFloat; DigitsAfterComma: Integer = 2): APascalString; stdcall; deprecated; { Use FloatToStrBP() }

function Utils_FloatToStrC(Value: AFloat; DigitsAfterComma: Integer = 2): APascalString; stdcall; deprecated; { Use FloatToStrCP() }

function Utils_FloatToStrD(Value: AFloat): APascalString; stdcall; deprecated; { Use FloatToStrDP() }

function Utils_NormalizeFloat(Value: AFloat): AFloat; stdcall;

// Заменяет не отображаемые символы строки на #
function Utils_NormalizeStr(const Value: APascalString): APascalString; stdcall;

// Заменяет не отображаемые символы строки на пробелы, перенос строки #13#10 заменяет на один пробел
function Utils_NormalizeStrSpace(const Value: APascalString): APascalString; stdcall; deprecated; // Use NormalizeStrSpaceP()

{ Заменяет все точки на запятые или все запятые на точки в зависимости от региональных настроек.
  Если параметр DecimalSeparator указан, то региональные настройки игнорируются. }
function Utils_ReplaceComma(const S: APascalString; DecimalSeparator: AChar = #0;
    ClearSpace: ABoolean = True): APascalString; stdcall; deprecated; // Use ReplaceComma()

procedure Utils_Sleep(Milliseconds: AUInt); stdcall;

function Utils_Time_Now: TDateTime; stdcall; // Use GetNowDateTime()

{$IFDEF AUTILSOLD}
function Utils_Trim(const S: APascalString): APascalString; deprecated; // Use TrimWS()
{$ENDIF AUTILSOLD}

function Utils_StrToFloat(const Value: APascalString): AFloat; stdcall;
function Utils_StrToFloat1(const S: APascalString; DefValue: AFloat = 0): AFloat; stdcall; deprecated;
function Utils_StrToInt(const Value: APascalString): AInteger; stdcall;
function Utils_StrToInt1(const S: APascalString; DefValue: AInteger = 0): AInteger; stdcall; deprecated; // Use AUtils.StrToInt1

{ Возведение числа Base в степень Exponent.
  Analog: SysUtils.Power(Base, Exponent) }
function Utils_Power(Base, Exponent: AFloat): AFloat; stdcall;

function Utils_TryStrToDate(const S: APascalString; var Value: TDateTime): ABoolean; stdcall; deprecated; // Use TryStrToDateWS()

{ Преобразует строку в Float. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
function Utils_TryStrToFloat(const S: APascalString; var Value: AFloat): ABoolean; stdcall; deprecated; // Use TryStrToFloat()

{ Преобразует строку в Float32. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
function Utils_TryStrToFloat32(const S: APascalString; var Value: AFloat32): ABoolean; stdcall; deprecated; // Use TryStrToFloat32()

{ Преобразует строку в Float64. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
function Utils_TryStrToFloat64(const S: APascalString; var Value: AFloat64): ABoolean; stdcall; deprecated; // Use TryStrToFloat64()

function Utils_TryStrToInt(const S: APascalString; var Value: AInteger): ABoolean; stdcall; deprecated; // Use TryStrToInt()

function Utils_UpperString(const S: APascalString): APascalString; stdcall; deprecated; // Use AString_ToUpperP()

function Utils_FormatFloat(Value: AFloat; Count, Digits: AInteger): APascalString; stdcall; deprecated; // Use FormatFloatWS()

// Преобразует число в строку формата "%Nd".
function Utils_FormatInt(Value, Count: AInteger): APascalString; stdcall;
function Utils_FormatStr(const Value: APascalString; Len: AInteger): APascalString; stdcall;
function Utils_FormatStrAnsi(const Value: AnsiString; Len: AInteger): AnsiString; stdcall;
function Utils_StrToDate(const Value: APascalString): TDateTime; stdcall;

function Utils_String_ToLower(const S: APascalString): APascalString;
function Utils_String_ToUpper(const S: APascalString): APascalString; deprecated; // Use AString_ToUpperP()

{ Private }

type // Тип версии системы
  TWinVersion = (wvUnknown, wv95, wv98, wvME, wvNT3, wvNT4, wvW2K, wvXP, wv2003);

{$IFNDEF FPC}
// Версия операционной системы под которой запущена прога
//   Result:    версия операционной системы
function WinVersion: TWinVersion;
{$ENDIF}

implementation

uses
  AUtilsMain;

{ Private }

{$IFNDEF FPC}
function WinVersion: TWinVersion;
var
  OSVersionInfo: TOSVersionInfo;
begin
  Result := wvUnknown;
  OSVersionInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  if GetVersionEx(OSVersionInfo) then
  begin
    case OSVersionInfo.DwMajorVersion of
      3: Result := wvNT3;
      4: case OSVersionInfo.DwMinorVersion of
           0: if (OSVersionInfo.dwPlatformId = VER_PLATFORM_WIN32_NT) then
                Result := wvNT4
              else
                Result := wv95;
           10: Result := wv98;
           90: Result := wvME;
         end;
      5: case OSVersionInfo.DwMinorVersion of
           0: Result := wvW2K;
           1: Result := wvXP;
           2: Result := wv2003;
         end;
    end;
  end;
end;
{$ENDIF}

{ Utils }

function ChangeFileExtP(const FileName, Extension: APascalString): APascalString; stdcall;
begin
  Result := AUtils_ChangeFileExtP(FileName, Extension);
end;

function ChangeFileExtWS(const FileName, Extension: AWideString): AWideString; stdcall;
begin
  Result := AUtils_ChangeFileExtWS(FileName, Extension);
end;

function DateToStrP(Value: TDateTime): APascalString; stdcall;
begin
  Result := AUtils_DateToStrP(Value);
end;

function DateToStrWS(Value: TDateTime): AWideString; stdcall;
begin
  Result := AUtils_DateToStrWS(Value);
end;

function DeleteFileP(const FileName: APascalString): AError; stdcall;
begin
  Result := AUtils_DeleteFileP(FileName);
end;

function DeleteFileWS(const FileName: AWideString): AError; stdcall;
begin
  Result := AUtils_DeleteFileWS(FileName);
end;

function DirectoryExistsP(const Directory: APascalString): ABoolean; stdcall;
begin
  Result := AUtils_DirectoryExistsP(Directory);
end;

function Done(): AError; stdcall;
begin
  Result := AUtils_Fin();
end;

function ExpandFileNameP(const FileName: APascalString): APascalString; stdcall;
begin
  Result := AUtils_ExpandFileNameP(FileName);
end;

function ExpandFileNameWS(const FileName: AWideString): AWideString; stdcall;
begin
  Result := AUtils_ExpandFileNameWS(FileName);
end;

{$IFDEF AUTILSOLD}
function ExtractFileExt(const FileName: AWideString): AWideString; stdcall;
begin
  Result := AUtils_ExtractFileExtWS(FileName);
end;
{$ELSE}
function ExtractFileExt(const FileName: AString_Type; out Res: AString_Type): AInteger; stdcall;
begin
  Result := AUtils_ExtractFileExt(FileName, Res);
end;
{$ENDIF AUTILSOLD}

function ExtractFileExtP(const FileName: APascalString): APascalString; stdcall;
begin
  Result := AUtils_ExtractFileExtP(FileName);
end;

function ExtractFileExtWS(const FileName: AWideString): AWideString; stdcall;
begin
  Result := AUtils_ExtractFileExtWS(FileName);
end;

{$IFDEF AUTILSOLD}
{$ELSE}
function ExtractFilePath(const FileName: AString_Type; out Res: AString_Type): AInteger; stdcall;
begin
  Result := AUtils_ExtractFilePath(FileName, Res);
end;
{$ENDIF AUTILSOLD}

function ExtractFilePathP(const FileName: APascalString): APascalString; stdcall;
begin
  Result := AUtils_ExtractFilePathP(FileName);
end;

function ExtractFilePathWS(const FileName: AWideString): AWideString; stdcall;
begin
  Result := AUtils_ExtractFilePathWS(FileName);
end;

{$IFDEF AUTILSOLD}
function FileExists(const FileName: AWideString): ABoolean; stdcall;
begin
  Result := AUtils_FileExistsWS(FileName);
end;
{$ELSE}
function FileExists(const FileName: AString_Type): ABoolean; stdcall;
begin
  Result := AUtils_FileExists(FileName);
end;
{$ENDIF AUTILSOLD}

function FileExistsP(const FileName: APascalString): ABoolean; stdcall;
begin
  Result := AUtils_FileExistsP(FileName);
end;

function FileExistsWS(const FileName: AWideString): ABoolean; stdcall;
begin
  Result := AUtils_FileExistsWS(FileName);
end;

{$IFDEF AUTILSOLD}
function FloatToStr(Value: AFloat): APascalString; stdcall;
begin
  Result := SysUtils.FloatToStr(Value);
end;
{$ELSE}
function FloatToStr(Value: AFloat; out Res: AString_Type): AInteger; stdcall;
begin
  Result := AUtils_FloatToStr(Value, Res);
end;
{$ENDIF AUTILSOLD}

function FloatToStr2WS(Value: AFloat; DigitsAfterComma: Integer; ReplaceComma, Delimer: ABoolean): AWideString; stdcall;
begin
  Result := AUtils_FloatToStr2WS(Value, DigitsAfterComma, ReplaceComma, Delimer);
end;

{$IFDEF AUTILSOLD}
function FloatToStrA(Value: AFloat; DigitsAfterComma: Integer = 2): AWideString; stdcall;
begin
  try
    Result := Utils_FloatToStrA(Value, DigitsAfterComma);
  except
    Result := '';
  end;
end;
{$ELSE}
function FloatToStrA(Value: AFloat; DigitsAfterComma: AInteger; out Res: AString_Type): AInteger; stdcall;
begin
  try
    Result := AStrings.String_AssignWS(Res, AUtilsMain.Utils_FloatToStrA(Value, DigitsAfterComma));
  except
    Result := 0;
  end;
end;
{$ENDIF AUTILSOLD}

function FloatToStrAP(Value: AFloat; DigitsAfterComma: Integer = 2): APascalString; stdcall;
begin
  try
    Result := AUtilsMain.Utils_FloatToStrA(Value, DigitsAfterComma);
  except
    Result := '';
  end;
end;

function FloatToStrAWS(Value: AFloat; DigitsAfterComma: Integer = 2): AWideString; stdcall;
begin
  try
    Result := AUtilsMain.Utils_FloatToStrA(Value, DigitsAfterComma);
  except
    Result := '';
  end;
end;

{$IFDEF AUTILSOLD}
function FloatToStrB(Value: AFloat; DigitsAfterComma: Integer = 2): APascalString; stdcall;
begin
  try
    Result := AUtilsMain.Utils_FloatToStrB(Value, DigitsAfterComma);
  except
    Result := '';
  end;
end;
{$ELSE}
function FloatToStrB(Value: AFloat; Digits: AInteger; out Res: AString_Type): AInteger; stdcall;
begin
  try
    Result := AStrings.String_AssignWS(Res, AUtils.FloatToStrBP(Value, Digits));
  except
    Result := 0;
  end;
end;
{$ENDIF AUTILSOLD}

function FloatToStrBP(Value: AFloat; DigitsAfterComma: Integer = 2): APascalString; stdcall;
begin
  try
    Result := AUtilsMain.Utils_FloatToStrB(Value, DigitsAfterComma);
  except
    Result := '';
  end;
end;

function FloatToStrBWS(Value: AFloat; DigitsAfterComma: Integer = 2): AWideString; stdcall;
begin
  try
    Result := AUtilsMain.Utils_FloatToStrB(Value, DigitsAfterComma);
  except
    Result := '';
  end;
end;

{$IFDEF AUTILSOLD}
function FloatToStrC(Value: AFloat; DigitsAfterComma: Integer = 2): APascalString; stdcall;
begin
  try
    Result := AUtilsMain.Utils_FloatToStrC(Value, DigitsAfterComma);
  except
    Result := '';
  end;
end;
{$ELSE}
function FloatToStrC(Value: AFloat; Digits: AInteger; out Res: AString_Type): AInteger; stdcall;
begin
  try
    Result := AStrings.String_AssignWS(Res, AUtilsMain.Utils_FloatToStrC(Value, Digits));
  except
    Result := 0;
  end;
end;
{$ENDIF AUTILSOLD}

function FloatToStrCP(Value: AFloat; DigitsAfterComma: Integer = 2): APascalString; stdcall;
begin
  try
    Result := AUtilsMain.Utils_FloatToStrC(Value, DigitsAfterComma);
  except
    Result := '';
  end;
end;

function FloatToStrCWS(Value: AFloat; DigitsAfterComma: Integer = 2): AWideString; stdcall;
begin
  try
    Result := AUtilsMain.Utils_FloatToStrC(Value, DigitsAfterComma);
  except
    Result := '';
  end;
end;

function FloatToStrD(Value: AFloat; out Res: AString_Type): AInteger; stdcall;
begin
  try
    Result := AStrings.String_AssignWS(Res, AUtilsMain.Utils_FloatToStrD(Value));
  except
    Result := 0;
  end;
end;

function FloatToStrDP(Value: AFloat): APascalString; stdcall;
begin
  try
    Result := AUtilsMain.Utils_FloatToStrD(Value);
  except
    Result := '';
  end;
end;

function FloatToStrDWS(Value: AFloat): AWideString; stdcall;
begin
  try
    Result := AUtilsMain.Utils_FloatToStrD(Value);
  except
    Result := '';
  end;
end;

function FloatToStrP(Value: AFloat): APascalString; stdcall;
begin
  Result := AUtils_FloatToStrP(Value);
end;

function FloatToStrWS(Value: AFloat): AWideString; stdcall;
begin
  Result := AUtils_FloatToStrWS(Value);
end;

function FormatFloat1(Value: AFloat; Count, Digits: AInteger; out Res: AString_Type): AInteger; stdcall;
begin
  Result := AUtils_FormatFloat(Value, Count, Digits, Res);
end;

function FormatFloatP(Value: AFloat; DigitsBeforeComma, DigitsAfterComma: AInteger): APascalString; stdcall;
begin
  Result := AUtils_FormatFloatP(Value, DigitsBeforeComma, DigitsAfterComma);
end;

function FormatFloatWS(Value: AFloat; DigitsBeforeComma, DigitsAfterComma: AInteger): AWideString; stdcall;
begin
  Result := AUtils_FormatFloatWS(Value, DigitsBeforeComma, DigitsAfterComma);
end;

{$IFDEF AUTILSOLD}
function FormatInt(Value, Count: AInteger): AWideString; stdcall;
begin
  Result := AUtils_FormatIntWS(Value, Count);
end;
{$ELSE}
function FormatInt(Value, Count: AInteger; out Res: AString_Type): AInteger; stdcall;
begin
  Result := AUtils_FormatInt(Value, Count, Res);
end;
{$ENDIF AUTILSOLD}

function FormatIntP(Value, Count: AInteger): APascalString; stdcall;
begin
  Result := AUtils_FormatIntP(Value, Count);
end;

function FormatIntWS(Value, Count: AInteger): AWideString; stdcall;
begin
  Result := AUtils_FormatIntWS(Value, Count);
end;

function FormatStr(const Value: AString_Type; Len: AInteger; out Res: AString_Type): AInteger; stdcall;
begin
  Result := AUtils_FormatStr(Value, Len, Res);
end;

function FormatStrAnsi(const Value: AnsiString; Len: AInteger): AnsiString; stdcall;
begin
  Result := AUtils_FormatStrAnsi(Value, Len);
end;

function FormatStrP(const Value: APascalString; Len: AInteger): APascalString; stdcall;
begin
  Result := AUtils_FormatStrP(Value, Len);
end;

function FormatStrStr(const FormatStr, S: APascalString): APascalString; stdcall;
begin
  Result := AUtils_FormatStrStrP(FormatStr, S);
end;

function FormatStrStrWS(const FormatStr, S: AWideString): AWideString; stdcall;
begin
  Result := AUtils_FormatStrStrWS(FormatStr, S);
end;

function FormatStrWS(const Value: AWideString; Len: AInteger): AWideString; stdcall;
begin
  Result := AUtils_FormatStrWS(Value, Len);
end;

function GetNowDateTime(): TDateTime;
begin
  Result := AUtils_GetNowDateTime();
end;

function Init(): AError; stdcall;
begin
  Result := AUtils_Init();
end;

{$IFDEF AUTILSOLD}
function IntToStr(Value: AInteger): AWideString; stdcall;
begin
  Result := AUtils_IntToStrWS(Value);
end;
{$ELSE}
function IntToStr(Value: AInteger; out Res: AString_Type): AInteger; stdcall;
begin
  Result := AUtils_IntToStr(Value, Res);
end;
{$ENDIF AUTILSOLD}

function IntToStrP(Value: AInteger): APascalString; stdcall;
begin
  Result := AUtils_IntToStrP(Value);
end;

function IntToStrWS(Value: AInteger): AWideString; stdcall;
begin
  Result := AUtils_IntToStrWS(Value);
end;

function NormalizeFloat(Value: AFloat): AFloat; stdcall;
begin
  Result := AUtils_NormalizeFloat(Value);
end;

{$IFDEF AUTILSOLD}
function NormalizeStr(const Value: AWideString): AWideString; stdcall;
begin
  try
    Result := Utils_NormalizeStr(Value);
  except
    Result := '';
  end;
end;
{$ELSE}
function NormalizeStr(const Value: AString_Type; out Res: AString_Type): AInteger; stdcall;
begin
  Result := AUtils_NormalizeStr(Value, Res);
end;
{$ENDIF AUTILSOLD}

function NormalizeStrP(const Value: APascalString): APascalString; stdcall;
begin
  Result := AUtils_NormalizeStrP(Value);
end;

function NormalizeStrSpace(const Value: AString_Type; out Res: AString_Type): AInteger; stdcall;
begin
  Result := AUtils_NormalizeStrSpace(Value, Res);
end;

function NormalizeStrSpaceP(const Value: APascalString): APascalString; stdcall;
begin
  Result := AUtils_NormalizeStrSpaceP(Value);
end;

function NormalizeStrSpaceWS(const Value: AWideString): AWideString; stdcall;
begin
  Result := AUtils_NormalizeStrSpaceWS(Value);
end;

function NormalizeStrWS(const Value: AWideString): AWideString; stdcall;
begin
  Result := AUtils_NormalizeStrWS(Value);
end;

function Power(Base, Exponent: AFloat): AFloat; stdcall;
begin
  Result := AUtils_Power(Base, Exponent);
end;

{$IFDEF AUTILSOLD}
function ReplaceComma(const S: AWideString; DecimalSeparator: AChar = #0;
    ClearSpace: ABoolean = True): AWideString; stdcall;
begin
  Result := AUtils_ReplaceCommaWS(S, DecimalSeparator, ClearSpace);
end;
{$ELSE}
function ReplaceComma(const S: AString_Type; DecimalSeparator: AChar;
    ClearSpace: ABoolean; out Res: AString_Type): AInteger; stdcall;
begin
  Result := AUtils_ReplaceComma(S, DecimalSeparator, ClearSpace, Res);
end;
{$ENDIF AUTILSOLD}

function ReplaceCommaP(const S: APascalString; DecimalSeparator: AChar = #0;
    ClearSpace: ABoolean = True): APascalString; stdcall;
begin
  Result := AUtils_ReplaceCommaP(S, DecimalSeparator, ClearSpace);
end;

function ReplaceCommaWS(const S: AWideString; DecimalSeparator: AChar = #0;
    ClearSpace: ABoolean = True): AWideString; stdcall;
begin
  Result := AUtils_ReplaceCommaWS(S, DecimalSeparator, ClearSpace);
end;

function Round2(Value: Real; Digits1, DigitsAfterComma: Integer): Real; stdcall;
begin
  Result := AUtils_Round2(Value, Digits1, DigitsAfterComma);
end;

function Sleep(Milliseconds: AUInt): AError; stdcall;
begin
  Result := AUtils_Sleep(Milliseconds);
end;

procedure Sleep02(Milliseconds: AUInt); stdcall;
begin
  AUtils_Sleep(Milliseconds);
end;

function String_ToLowerP(const S: APascalString): APascalString; stdcall;
begin
  try
    Result := Utils_String_ToLower(S);
  except
    Result := '';
  end;
end;

function String_ToLowerWS(const S: AWideString): AWideString; stdcall;
begin
  try
    Result := Utils_String_ToLower(S);
  except
    Result := '';
  end;
end;

function String_ToUpper(const S: AString_Type; out Res: AString_Type): AInteger; stdcall;
begin
  Result := AString_ToUpper(S, Res);
end;

function String_ToUpperP(const S: APascalString): APascalString; stdcall;
begin
  Result := AString_ToUpperP(S);
end;

function String_ToUpperWS(const S: AWideString): AWideString; stdcall;
begin
  Result := AString_ToUpperWS(S);
end;

{$IFDEF AUTILSOLD}
function StrToDate(const Value: AWideString): TDateTime; stdcall;
begin
  try
    Result := Utils_StrToDate(Value);
  except
    Result := 0;
  end;
end;
{$ELSE}
function StrToDate(const Value: AString_Type): TDateTime; stdcall;
begin
  try
    Result := Utils_StrToDate(AStrings.String_ToWideString(Value));
  except
    Result := 0;
  end;
end;
{$ENDIF AUTILSOLD}

function StrToDateA(Value: PAnsiChar): TDateTime; stdcall;
begin
  try
    Result := Utils_StrToDate(Value);
  except
    Result := 0;
  end;
end;

function StrToDateWS(const Value: AWideString): TDateTime; stdcall;
begin
  try
    Result := Utils_StrToDate(Value);
  except
    Result := 0;
  end;
end;

{$IFDEF AUTILSOLD}
{$ELSE}
function StrToFloat(const Value: AString_Type): AFloat; stdcall;
begin
  try
    Result := Utils_StrToFloat(AStrings.String_ToWideString(Value));
  except
    Result := 0;
  end;
end;
{$ENDIF AUTILSOLD}

{$IFDEF AUTILSOLD}
function StrToFloat1(const S: APascalString; DefValue: AFloat = 0): AFloat; stdcall;
begin
  Result := StrToFloatDefP(S, DefValue);
end;
{$ELSE}
function StrToFloat1(const S: AString_Type; DefValue: AFloat): AFloat; stdcall;
begin
  Result := StrToFloatDef(S, DefValue);
end;
{$ENDIF AUTILSOLD}

function StrToFloatDef(const S: AString_Type; DefValue: AFloat): AFloat; stdcall;
begin
  try
    Result := StrToFloatDefP(AStrings.String_ToWideString(S), DefValue);
  except
    Result := 0;
  end;
end;

function StrToFloatDefP(const S: APascalString; DefValue: AFloat): AFloat; stdcall;
var
  Value: AFloat64;
begin
  if TryStrToFloat64P(S, Value) then
    Result := Value
  else
    Result := DefValue;
end;

function StrToFloatDefWS(const S: AWideString; DefValue: AFloat): AFloat; stdcall;
var
  Value: AFloat64;
begin
  if TryStrToFloat64P(S, Value) then
    Result := Value
  else
    Result := DefValue;
end;

function StrToFloatP(const S: APascalString): AFloat; stdcall;
begin
  Result := StrToFloatDefP(S, 0);
end;

function StrToFloatWS(const S: AWideString): AFloat; stdcall;
begin
  Result := StrToFloatDefP(S, 0);
end;

{$IFDEF AUTILSOLD}
function StrToInt(const S: AWideString): AInteger; stdcall;
begin
  Result := StrToIntDefP(S, 0);
end;
{$ELSE}
function StrToInt(const Value: AString_Type): AInteger; stdcall;
begin
  try
    Result := Utils_StrToInt(AStrings.String_ToWideString(Value));
  except
    Result := 0;
  end;
end;
{$ENDIF AUTILSOLD}

function StrToInt1(const S: APascalString; DefValue: AInteger = 0): AInteger; stdcall;
begin
  Result := StrToIntDefP(S, DefValue);
end;

function StrToIntDefP(const S: APascalString; DefValue: AInteger): AInteger; stdcall;
begin
  try
    if not(AUtilsMain.Utils_TryStrToInt(S, Result)) then
      Result := DefValue;
  except
    Result := DefValue;
  end;
end;

function StrToIntDefWS(const S: AWideString; DefValue: AInteger): AInteger; stdcall;
begin
  try
    if not(AUtilsMain.Utils_TryStrToInt(S, Result)) then
      Result := DefValue;
  except
    Result := DefValue;
  end;
end;

function StrToIntP(const S: APascalString): AInteger; stdcall;
begin
  Result := StrToIntDefP(S, 0);
end;

function StrToIntWS(const S: AWideString): AInteger; stdcall;
begin
  Result := StrToIntDefP(S, 0);
end;

function Time_Now: TDateTime; stdcall;
begin
  try
    Result := Utils_Time_Now;
  except
    Result := 0;
  end;
end;

{$IFDEF AUTILSOLD}
function Trim(const S: AWideString): AWideString; stdcall;
begin
  try
    Result := Utils_Trim(S);
  except
    Result := '';
  end;
end;
{$ELSE}
function Trim(const S: AString_Type; out Res: AString_Type): AInteger; stdcall;
begin
  try
    Result := AStrings.String_AssignWS(Res, Utils_Trim(AStrings.String_ToWideString(S)));
  except
    Result := 0;
  end;
end;
{$ENDIF AUTILSOLD}

function TrimP(const S: APascalString): APascalString; stdcall;
begin
  try
    Result := AUtilsMain.Utils_Trim(S);
  except
    Result := '';
  end;
end;

function TrimWS(const S: AWideString): AWideString; stdcall;
begin
  try
    Result := AUtilsMain.Utils_Trim(S);
  except
    Result := '';
  end;
end;

{$IFDEF AUTILSOLD}
function TryStrToDate(const S: AWideString; var Value: TDateTime): ABoolean; stdcall;
begin
  try
    Result := AUtilsMain.Utils_TryStrToDate(S, Value);
  except
    Result := False;
  end;
end;
{$ELSE}
function TryStrToDate(const S: AString_Type; var Value: TDateTime): ABoolean; stdcall;
begin
  try
    Result := AUtilsMain.Utils_TryStrToDate(AStrings.String_ToWideString(S), Value);
  except
    Result := False;
  end;
end;
{$ENDIF AUTILSOLD}

function TryStrToDateP(const S: APascalString; var Value: TDateTime): ABoolean; stdcall;
begin
  try
    Result := AUtilsMain.Utils_TryStrToDate(S, Value);
  except
    Result := False;
  end;
end;

function TryStrToDateWS(const S: AWideString; var Value: TDateTime): ABoolean; stdcall;
begin
  try
    Result := AUtilsMain.Utils_TryStrToDate(S, Value);
  except
    Result := False;
  end;
end;

{$IFDEF AUTILSOLD}
function TryStrToFloat(const S: AWideString; var Value: AFloat): ABoolean; stdcall;
begin
  try
    Result := AUtilsMain.Utils_TryStrToFloat(S, Value);
  except
    Result := False;
  end;
end;
{$ELSE}
function TryStrToFloat(const S: AString_Type; var Value: AFloat): ABoolean; stdcall;
begin
  try
    Result := AUtilsMain.Utils_TryStrToFloat(AStrings.String_ToWideString(S), Value);
  except
    Result := False;
  end;
end;
{$ENDIF AUTILSOLD}

{$IFDEF AUTILSOLD}
function TryStrToFloat32(const S: AWideString; var Value: AFloat32): ABoolean; stdcall;
begin
  try
    Result := AUtilsMain.Utils_TryStrToFloat32(S, Value);
  except
    Result := False;
  end;
end;
{$ELSE}
function TryStrToFloat32(const S: AString_Type; var Value: AFloat32): ABoolean; stdcall;
begin
  try
    Result := AUtilsMain.Utils_TryStrToFloat32(AStrings.String_ToWideString(S), Value);
  except
    Result := False;
  end;
end;
{$ENDIF AUTILSOLD}

function TryStrToFloat32P(const S: APascalString; var Value: AFloat32): ABoolean; stdcall;
begin
  try
    Result := AUtilsMain.Utils_TryStrToFloat32(S, Value);
  except
    Result := False;
  end;
end;

function TryStrToFloat32WS(const S: AWideString; var Value: AFloat32): ABoolean; stdcall;
begin
  try
    Result := AUtilsMain.Utils_TryStrToFloat32(S, Value);
  except
    Result := False;
  end;
end;

{$IFDEF AUTILSOLD}
function TryStrToFloat64(const S: AWideString; var Value: AFloat64): ABoolean; stdcall;
begin
  try
    Result := AUtilsMain.Utils_TryStrToFloat64(S, Value);
  except
    Result := False;
  end;
end;
{$ELSE}
function TryStrToFloat64(const S: AString_Type; var Value: AFloat64): ABoolean; stdcall;
begin
  try
    Result := AUtilsMain.Utils_TryStrToFloat64(AStrings.String_ToWideString(S), Value);
  except
    Result := False;
  end;
end;
{$ENDIF AUTILSOLD}

function TryStrToFloat64P(const S: APascalString; var Value: AFloat64): ABoolean; stdcall;
begin
  try
    Result := AUtilsMain.Utils_TryStrToFloat64(S, Value);
  except
    Result := False;
  end;
end;

function TryStrToFloat64WS(const S: AWideString; var Value: AFloat64): ABoolean; stdcall;
begin
  try
    Result := AUtilsMain.Utils_TryStrToFloat64(S, Value);
  except
    Result := False;
  end;
end;

function TryStrToFloatP(const S: APascalString; var Value: AFloat): ABoolean; stdcall;
begin
  try
    Result := AUtilsMain.Utils_TryStrToFloat(S, Value);
  except
    Result := False;
  end;
end;

function TryStrToFloatWS(const S: AWideString; var Value: AFloat): ABoolean; stdcall;
begin
  try
    Result := AUtilsMain.Utils_TryStrToFloat(S, Value);
  except
    Result := False;
  end;
end;

{$IFDEF AUTILSOLD}
function TryStrToInt(const S: AWideString; var Value: AInteger): ABoolean; stdcall;
begin
  try
    Result := Utils_TryStrToInt(S, Value);
  except
    Result := False;
  end;
end;
{$ELSE}
function TryStrToInt(const S: AString_Type; var Value: AInteger): ABoolean; stdcall;
begin
  try
    Result := AUtilsMain.Utils_TryStrToInt(AStrings.String_ToWideString(S), Value);
  except
    Result := False;
  end;
end;
{$ENDIF AUTILSOLD}

function TryStrToIntWS(const S: AWideString; var Value: AInteger): ABoolean; stdcall;
begin
  try
    Result := AUtilsMain.Utils_TryStrToInt(S, Value);
  except
    Result := False;
  end;
end;

function UpperStringP(const S: APascalString): APascalString; stdcall;
begin
  try
    Result := Utils_UpperString(S);
  except
    Result := '';
  end;
end;

{ Utils }

function Utils_Done(): AError;
begin
  Result := AUtils_Fin();
end;

function Utils_FloatToStr(Value: AFloat): APascalString; stdcall;
begin
  Result := AUtils_FloatToStrP(Value);
end;

function Utils_FloatToStrA(Value: AFloat; DigitsAfterComma: AInteger = 2): APascalString; stdcall;
begin
  Result := AUtils_FloatToStrAP(Value, DigitsAfterComma);
end;

function Utils_FloatToStrB(Value: AFloat; DigitsAfterComma: AInteger): APascalString; stdcall;
begin
  Result := AUtils_FloatToStrBP(Value, DigitsAfterComma);
end;

function Utils_FloatToStrC(Value: AFloat; DigitsAfterComma: AInteger): APascalString; stdcall;
begin
  Result := AUtils_FloatToStrCP(Value, DigitsAfterComma);
end;

function Utils_FloatToStrD(Value: AFloat): APascalString; stdcall;
begin
  Result := AUtils_FloatToStrDP(Value);
end;

function Utils_FormatFloat(Value: AFloat; Count, Digits: AInteger): APascalString; stdcall;
begin
  Result := AUtils_FormatFloatP(Value, Count, Digits);
end;

function Utils_FormatInt(Value, Count: AInteger): APascalString; stdcall;
begin
  Result := AUtils_FormatIntP(Value, Count);
end;

function Utils_FormatStr(const Value: APascalString; Len: AInteger): APascalString; stdcall;
begin
  Result := AUtils_FormatStrP(Value, Len);
end;

function Utils_FormatStrAnsi(const Value: AnsiString; Len: AInteger): AnsiString; stdcall;
begin
  Result := AUtils_FormatStrAnsi(Value, Len);
end;

function Utils_Init(): AError;
begin
  Result := AUtils_Init();
end;

function Utils_NormalizeFloat(Value: AFloat): AFloat; stdcall;
begin
  Result := AUtils_NormalizeFloat(Value);
end;

function Utils_NormalizeStr(const Value: APascalString): APascalString; stdcall;
begin
  Result := AUtils_NormalizeStrP(Value);
end;

function Utils_NormalizeStrSpace(const Value: APascalString): APascalString; stdcall;
begin
  Result := AUtilsMain.Utils_NormalizeStrSpace(Value);
end;

function Utils_Power(Base, Exponent: AFloat): AFloat; stdcall;
begin
  Result := AUtils_Power(Base, Exponent);
end;

function Utils_ReplaceComma(const S: APascalString; DecimalSeparator: AChar; ClearSpace: ABoolean): APascalString; stdcall;
begin
  AUtilsMain.Utils_ReplaceComma(S, DecimalSeparator, ClearSpace);
end;

procedure Utils_Sleep(Milliseconds: AUInt); stdcall;
begin
  AUtils_Sleep(Milliseconds);
end;

function Utils_String_ToLower(const S: APascalString): APascalString;
begin
  Result := SysUtils.LowerCase(S);
end;

function Utils_String_ToUpper(const S: APascalString): APascalString;
begin
  Result := AString_ToUpperP(S);
end;

function Utils_StrToDate(const Value: APascalString): TDateTime;
begin
  Result := SysUtils.StrToDate(Value);
end;

function Utils_StrToFloat(const Value: APascalString): AFloat;
begin
  Result := AUtils_StrToFloatP(Value);
end;

function Utils_StrToFloat1(const S: APascalString; DefValue: AFloat = 0): AFloat;
begin
  Result := StrToFloatDefP(S, DefValue);
end;

function Utils_StrToInt(const Value: APascalString): AInteger;
begin
  Result := SysUtils.StrToInt(Value);
end;

function Utils_StrToInt1(const S: APascalString; DefValue: AInteger = 0): AInteger;
begin
  Result := StrToInt1(S, DefValue);
end;

function Utils_Time_Now: TDateTime;
begin
  Result := GetNowDateTime();
end;

function Utils_Trim(const S: APascalString): APascalString;
begin
  Result := AUtilsMain.Utils_Trim(S);
end;

function Utils_TryStrToDate(const S: APascalString; var Value: TDateTime): Boolean;
begin
  Result := AUtilsMain.Utils_TryStrToDate(S, Value);
end;

function Utils_TryStrToFloat(const S: APascalString; var Value: AFloat): ABoolean;
begin
  Result := AUtilsMain.Utils_TryStrToFloat(S, Value);
end;

function Utils_TryStrToFloat32(const S: APascalString; var Value: AFloat32): ABoolean;
begin
  Result := AUtilsMain.Utils_TryStrToFloat32(S, Value);
end;

function Utils_TryStrToFloat64(const S: APascalString; var Value: AFloat64): ABoolean;
begin
  Result := AUtilsMain.Utils_TryStrToFloat64(S, Value);
end;

function Utils_TryStrToInt(const S: APascalString; var Value: AInteger): ABoolean;
begin
  Result := AUtilsMain.Utils_TryStrToInt(S, Value);
end;

function Utils_UpperString(const S: APascalString): APascalString;
begin
  Result := Utils_String_ToUpper(S);
end;

end.

