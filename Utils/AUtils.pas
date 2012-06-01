{**
@Abstract(AUtils)
@Author(Prof1983 prof1983@ya.ru)
@Created(30.09.2009)
@LastMod(22.05.2012)
@Version(0.5)

0.3.2
[+] TrimP, ExpandFileNameP, DirectoryExistsP (05.09.2011)
[+] String_ToUpperP (19.09.2011)
[*] FormatStrP (19.09.2011)
}
unit AUtils;

{$IFNDEF A0}
  {$DEFINE ALOCAL}
{$ENDIF}

interface

uses
  SysUtils, {$IFNDEF FPC}Windows,{$ENDIF}
  ABase, ABaseUtils,
  {$IFDEF ALOCAL}AStrings{$ELSE}AStrings0{$ENDIF},
  {$IFDEF ALOCAL}ASystem{$ELSE}ASystem0{$ENDIF};

function Init(): AError; stdcall;
function Done(): AError; stdcall;

function ChangeFileExtP(const FileName, Extension: APascalString): APascalString; stdcall;

function DeleteFileP(const FileName: APascalString): AError; stdcall;

function DirectoryExistsP(const Directory: APascalString): ABoolean; stdcall;

function ExpandFileNameP(const FileName: APascalString): APascalString; stdcall;

function ExtractFileExt(const FileName: AString_Type; out Res: AString_Type): AInteger; stdcall;

function ExtractFileExtP(const FileName: APascalString): APascalString; stdcall;

function ExtractFileExtWS(const FileName: AWideString): AWideString; stdcall;

function ExtractFilePath(const FileName: AString_Type; out Res: AString_Type): AInteger; stdcall;

function ExtractFilePathP(const FileName: APascalString): APascalString; stdcall;

function ExtractFilePathWS(const FileName: AWideString): AWideString; stdcall;

function FileExists(const FileName: AString_Type): ABoolean; stdcall;

function FileExistsP(const FileName: APascalString): ABoolean; stdcall;

function FileExistsWS(const FileName: AWideString): ABoolean; stdcall;

// Преобразует число в строку.
{$IFDEF AOLD}
function FloatToStr(Value: AFloat): APascalString; stdcall;
{$ELSE}
function FloatToStr(Value: AFloat; out Res: AString_Type): AInteger; stdcall;
{$ENDIF AOLD}

// Преобразует число в строку c двумя знаками после запятой.
//function FloatToStrA(Value: AFloat; DigitsAfterComma: Integer = 2): APascalString; stdcall;
function FloatToStrA(Value: AFloat; DigitsAfterComma: AInteger; out Res: AString_Type): AInteger; stdcall;

// Преобразует число в строку c двумя знаками после запятой.
function FloatToStrAP(Value: AFloat; DigitsAfterComma: Integer = 2): APascalString; stdcall;

// Преобразует число в строку для записи в БД (SQL). Для SQL необходим разделитель - точка.
function FloatToStrB(Value: AFloat; Digits: AInteger; out Res: AString_Type): AInteger; stdcall;

// Преобразует число в строку для записи в БД (SQL). Для SQL необходим разделитель - точка.
function FloatToStrBP(Value: AFloat; DigitsAfterComma: Integer = 2): APascalString; stdcall;

function FloatToStrC(Value: AFloat; Digits: AInteger; out Res: AString_Type): AInteger; stdcall;

function FloatToStrCP(Value: AFloat; DigitsAfterComma: Integer = 2): APascalString; stdcall;

function FloatToStrD(Value: AFloat; out Res: AString_Type): AInteger; stdcall;

function FloatToStrDP(Value: AFloat): APascalString; stdcall;

// Преобразует число в строку.
function FloatToStrP(Value: AFloat): APascalString; stdcall;

// Преобразует число в строку.
function FloatToStrWS(Value: AFloat): AWideString; stdcall;

function FormatFloat1(Value: AFloat; Count, Digits: AInteger; out Res: AString_Type): AInteger; stdcall;

function FormatFloatP(Value: AFloat; DigitsBeforeComma, DigitsAfterComma: AInteger): APascalString; stdcall;

function FormatFloatWS(Value: AFloat; DigitsBeforeComma, DigitsAfterComma: AInteger): AWideString; stdcall;

// Преобразует число в строку формата "%Nd".
function FormatInt(Value, Count: AInteger; out Res: AString_Type): AInteger; stdcall;

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

// Применяет Format() к строке с одним строковым параметром. Например: "Ошибка в %s".
function FormatStrStr(const FormatStr, S: APascalString): APascalString; stdcall;

{$IFDEF AOLD}
function IntToStr(Value: AInteger): APascalString; stdcall;
{$ELSE}
function IntToStr(Value: AInteger; out Res: AString_Type): AInteger; stdcall;
{$ENDIF AOLD}

function IntToStrP(Value: AInteger): APascalString; stdcall;

function IntToStrWS(Value: AInteger): AWideString; stdcall;

function NormalizeFloat(Value: AFloat): AFloat; stdcall;

// Заменяет не отображаемые символы строки на #
function NormalizeStr(const Value: AString_Type; out Res: AString_Type): AInteger; stdcall;

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
function ReplaceComma(const S: AString_Type; DecimalSeparator: AChar {= #0};
    ClearSpace: ABoolean {= True}; out Res: AString_Type): AInteger; stdcall;

{ Заменяет все точки на запятые или все запятые на точки в зависимости от региональных настроек.
  Если параметр DecimalSeparator указан, то региональные настройки игнорируются. }
function ReplaceCommaP(const S: APascalString; DecimalSeparator: AChar = #0;
    ClearSpace: ABoolean = True): APascalString; stdcall;

{ Заменяет все точки на запятые или все запятые на точки в зависимости от региональных настроек.
  Если параметр DecimalSeparator указан, то региональные настройки игнорируются. }
function ReplaceCommaWS(const S: AWideString; DecimalSeparator: AChar = #0;
    ClearSpace: ABoolean = True): AWideString; stdcall;

function StrToDate(const Value: AString_Type): TDateTime; stdcall;

function StrToDateWS(const Value: AWideString): TDateTime; stdcall;

function StrToFloat(const Value: AString_Type): AFloat; stdcall;

{ Преобразует строку в Float. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы.
  Use StrToFloatDefP(S,0) }
{$IFDEF AOLD}
function StrToFloat1(const S: APascalString; DefValue: AFloat = 0): AFloat; stdcall; deprecated;
{$ELSE}
function StrToFloat1(const S: AString_Type; DefValue: AFloat = 0): AFloat; stdcall; deprecated;
{$ENDIF AOLD}

{ Преобразует строку в Float. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
function StrToFloatDefP(const S: APascalString; DefValue: AFloat): AFloat; stdcall;

{ Преобразует строку в Float. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
function StrToFloatDefWS(const S: AWideString; DefValue: AFloat): AFloat; stdcall;

function StrToFloatP(const S: APascalString): AFloat; stdcall;

function StrToFloatWS(const S: AWideString): AFloat; stdcall;

function StrToInt(const Value: AString_Type): AInteger; stdcall;

//function StrToInt1(const S: AString_Type; DefValue: AInteger = 0): AInteger; stdcall;

// Use StrToIntDefP(S,0)
function StrToInt1(const S: APascalString; DefValue: AInteger = 0): AInteger; stdcall; deprecated;

function StrToIntDefP(const S: APascalString; DefValue: AInteger): AInteger; stdcall;

function StrToIntDefWS(const S: AWideString; DefValue: AInteger): AInteger; stdcall;

function StrToIntP(const S: APascalString): AInteger; stdcall;

function StrToIntWS(const S: AWideString): AInteger; stdcall;

// Переводит все символы строки в нижний регистр
function String_ToLowerP(const S: APascalString): APascalString; stdcall;

// Переводит все символы строки в верхний регистр.
function String_ToUpper(const S: AString_Type; out Res: AString_Type): AInteger; stdcall;

// Переводит все символы строки в верхний регистр.
function String_ToUpperP(const S: APascalString): APascalString; stdcall;

function String_ToUpperWS(const S: AWideString): AWideString; stdcall;

function TryStrToDate(const S: AString_Type; var Value: TDateTime): ABoolean; stdcall;

function TryStrToDateP(const S: APascalString; var Value: TDateTime): ABoolean; stdcall;

function TryStrToDateWS(const S: AWideString; var Value: TDateTime): ABoolean; stdcall;

{ Преобразует строку в Float. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
function TryStrToFloat(const S: AString_Type; var Value: AFloat): ABoolean; stdcall;

{ Преобразует строку в Float. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
function TryStrToFloatP(const S: APascalString; var Value: AFloat): ABoolean; stdcall;

{ Преобразует строку в Float32. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
function TryStrToFloat32(const S: AString_Type; var Value: AFloat32): ABoolean; stdcall;
//function TryStrToFloat32(const S: APascalString; var Value: AFloat32): ABoolean; stdcall;

{ Преобразует строку в Float32. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
function TryStrToFloat32P(const S: APascalString; var Value: AFloat32): ABoolean; stdcall;

{ Преобразует строку в Float64. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
//function TryStrToFloat64(const S: APascalString; var Value: AFloat64): ABoolean; stdcall;
function TryStrToFloat64(const S: AString_Type; var Value: AFloat64): ABoolean; stdcall;

{ Преобразует строку в Float64. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
function TryStrToFloat64P(const S: APascalString; var Value: AFloat64): ABoolean; stdcall;

{ Преобразует строку в Float64. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
function TryStrToFloat64WS(const S: AWideString; var Value: AFloat64): ABoolean; stdcall;

// Use TryStrToIntWS()
function TryStrToInt(const S: AString_Type; var Value: AInteger): ABoolean; stdcall;
//function TryStrToInt(const S: APascalString; var Value: AInteger): ABoolean; stdcall; deprecated;

function TryStrToIntWS(const S: AWideString; var Value: AInteger): ABoolean; stdcall;

// Use String_ToUpperP()
function UpperStringP(const S: APascalString): APascalString; stdcall; deprecated;

{ Trims leading and trailing spaces and control characters from a string.
  Удаляет первые и последние пробелы }
//function Trim(const S: APascalString): APascalString; stdcall;
function Trim(const S: AString_Type; out Res: AString_Type): AInteger; stdcall;

{ Trims leading and trailing spaces and control characters from a string.
  Удаляет первые и последние пробелы. }
function TrimP(const S: APascalString): APascalString; stdcall;

{ Trims leading and trailing spaces and control characters from a string.
  Удаляет первые и последние пробелы. }
function TrimWS(const S: AWideString): AWideString; stdcall;

function Sleep(Milliseconds: AUInt): AError; stdcall;

procedure Sleep02(Milliseconds: AUInt); stdcall;

function Time_Now(): TDateTime; stdcall;

{ Utils }

// TODO: Убрать stdcall
// TODO: Перенести в AUtilsMain

// Преобразует число в строку
function Utils_FloatToStr(Value: AFloat): APascalString; stdcall;
// Преобразует число в строку c двумя знаками после запятой
function Utils_FloatToStrA(Value: AFloat; DigitsAfterComma: Integer = 2): APascalString; stdcall;

// Преобразует число в строку для записи в БД (SQL). Для SQL необходим разделитель - точка.
// Use FloatToStrB()
function Utils_FloatToStrB(Value: AFloat; DigitsAfterComma: Integer = 2): APascalString; stdcall; deprecated;

// Use FloatToStrC()
function Utils_FloatToStrC(Value: AFloat; DigitsAfterComma: Integer = 2): APascalString; stdcall; deprecated;

function Utils_FloatToStrD(Value: AFloat): APascalString; stdcall;

function Utils_NormalizeFloat(Value: AFloat): AFloat; stdcall;

// Заменяет не отображаемые символы строки на #
function Utils_NormalizeStr(const Value: APascalString): APascalString; stdcall;

// Заменяет не отображаемые символы строки на пробелы, перенос строки #13#10 заменяет на один пробел
// Use NormalizeStrSpaceP()
function Utils_NormalizeStrSpace(const Value: APascalString): APascalString; stdcall; deprecated;

{ Заменяет все точки на запятые или все запятые на точки в зависимости от региональных настроек.
  Если параметр DecimalSeparator указан, то региональные настройки игнорируются. }
// Use ReplaceComma()
function Utils_ReplaceComma(const S: APascalString; DecimalSeparator: AChar = #0; ClearSpace: ABoolean = True): APascalString; stdcall; deprecated;

//function Utils_StrToFloatDefP(const S: APascalString; DefValue: AFloat = 0): AFloat; stdcall;
//function Utils_StrToIntDefP(const S: APascalString; DefValue: AInteger = 0): AInteger; stdcall;
function Utils_FileExists(const FileName: APascalString): ABoolean; stdcall;
procedure Utils_Sleep(Milliseconds: AUInt); stdcall;
function Utils_Time_Now: TDateTime; stdcall;
function Utils_IntToStr(Value: AInteger): APascalString; stdcall;
function Utils_StrToFloat(const Value: APascalString): AFloat; stdcall;
function Utils_StrToFloat1(const S: APascalString; DefValue: AFloat = 0): AFloat; stdcall; deprecated;
function Utils_StrToInt(const Value: APascalString): AInteger; stdcall;
// Use AUtils.StrToInt1
function Utils_StrToInt1(const S: APascalString; DefValue: AInteger = 0): AInteger; stdcall; deprecated;
function Utils_ExtractFilePath(const FileName: APascalString): APascalString; stdcall;

{ Возведение числа Base в степень Exponent.
  Analog: SysUtils.Power(Base, Exponent) }
function Utils_Power(Base, Exponent: AFloat): AFloat; stdcall;

// Use TryStrToDateWS()
function Utils_TryStrToDate(const S: APascalString; var Value: TDateTime): ABoolean; stdcall; deprecated;

{ Преобразует строку в Float. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
// Use TryStrToFloat()
function Utils_TryStrToFloat(const S: APascalString; var Value: AFloat): ABoolean; stdcall; deprecated;

{ Преобразует строку в Float32. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
// Use TryStrToFloat32()
function Utils_TryStrToFloat32(const S: APascalString; var Value: AFloat32): ABoolean; stdcall; deprecated;

{ Преобразует строку в Float64. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
// Use TryStrToFloat64()
function Utils_TryStrToFloat64(const S: APascalString; var Value: AFloat64): ABoolean; stdcall; deprecated;

// Use TryStrToInt()
function Utils_TryStrToInt(const S: APascalString; var Value: AInteger): ABoolean; stdcall; deprecated;

function Utils_ExtractFileExt(const FileName: APascalString): APascalString; stdcall;
// Use String_ToUpperP()
function Utils_UpperString(const S: APascalString): APascalString; stdcall; deprecated;
// Use FormatFloatWS()
function Utils_FormatFloat(Value: AFloat; Count, Digits: AInteger): APascalString; stdcall; deprecated;
// Преобразует число в строку формата "%Nd".
function Utils_FormatInt(Value, Count: AInteger): APascalString; stdcall;
function Utils_FormatStr(const Value: APascalString; Len: AInteger): APascalString; stdcall;
function Utils_FormatStrAnsi(const Value: AnsiString; Len: AInteger): AnsiString; stdcall;
function Utils_StrToDate(const Value: APascalString): TDateTime; stdcall;

function Utils_String_ToLower(const S: APascalString): APascalString;
function Utils_String_ToUpper(const S: APascalString): APascalString;

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
  try
    Result := SysUtils.ChangeFileExt(FileName, Extension);
  except
    Result := '';
  end;
end;

function DeleteFileP(const FileName: APascalString): AError; stdcall;
begin
  try
    if SysUtils.DeleteFile(FileName) then
      Result := 0
    else
      Result := -2;
  except
    Result := -1;
  end;
end;

function DirectoryExistsP(const Directory: APascalString): ABoolean; stdcall;
begin
  try
    Result := SysUtils.DirectoryExists(Directory);
  except
    Result := False;
  end;
end;

function Done(): AError; stdcall;
begin
  Result := 0;
end;

function ExpandFileNameP(const FileName: APascalString): APascalString; stdcall;
begin
  try
    Result := SysUtils.ExpandFileName(FileName);
  except
    Result := '';
  end;
end;

function ExtractFileExt(const FileName: AString_Type; out Res: AString_Type): AInteger; stdcall;
begin
  try
    Result := AStrings.String_AssignWS(Res,
        Utils_ExtractFileExt(AStrings.String_ToWideString(FileName))
        );
  except
    Result := 0;
  end;
end;

function ExtractFileExtP(const FileName: APascalString): APascalString; stdcall;
begin
  try
    Result := SysUtils.ExtractFileExt(FileName);
  except
    Result := '';
  end;
end;

function ExtractFileExtWS(const FileName: AWideString): AWideString; stdcall;
begin
  try
    Result := SysUtils.ExtractFileExt(FileName);
  except
    Result := '';
  end;
end;

function ExtractFilePath(const FileName: AString_Type; out Res: AString_Type): AInteger; stdcall;
begin
  try
    Result := AStrings.String_AssignWS(Res,
        Utils_ExtractFilePath(AStrings.String_ToWideString(FileName))
        );
  except
    Result := 0;
  end;
end;

function ExtractFilePathP(const FileName: APascalString): APascalString; stdcall;
begin
  try
    Result := SysUtils.ExtractFilePath(FileName);
  except
    Result := '';
  end;
end;

function ExtractFilePathWS(const FileName: AWideString): AWideString; stdcall;
begin
  try
    Result := SysUtils.ExtractFilePath(FileName);
  except
    Result := '';
  end;
end;

function FileExists(const FileName: AString_Type): ABoolean; stdcall;
begin
  try
    Result := Utils_FileExists(AStrings.String_ToWideString(FileName));
  except
    Result := False;
  end;
end;

function FileExistsP(const FileName: APascalString): ABoolean; stdcall;
begin
  try
    Result := Utils_FileExists(FileName);
  except
    Result := False;
  end;
end;

function FileExistsWS(const FileName: AWideString): ABoolean; stdcall;
begin
  try
    Result := Utils_FileExists(FileName);
  except
    Result := False;
  end;
end;

{$IFDEF AOLD}
function FloatToStr(Value: AFloat): APascalString; stdcall;
begin
  Result := SysUtils.FloatToStr(Value);
end;
{$ELSE}
function FloatToStr(Value: AFloat; out Res: AString_Type): AInteger; stdcall;
begin
  try
    Result := AStrings.String_AssignWS(Res, Utils_FloatToStr(Value));
  except
    Result := 0;
  end;
end;
{$ENDIF AOLD}

{
function FloatToStrA(Value: AFloat; DigitsAfterComma: Integer = 2): APascalString; stdcall;
begin
  try
    Result := Utils_FloatToStrA(Value, DigitsAfterComma);
  except
    Result := '';
  end;
end;
}

function FloatToStrA(Value: AFloat; DigitsAfterComma: AInteger; out Res: AString_Type): AInteger; stdcall;
begin
  try
    Result := AStrings.String_AssignWS(Res, Utils_FloatToStrA(Value, DigitsAfterComma));
  except
    Result := 0;
  end;
end;

function FloatToStrAP(Value: AFloat; DigitsAfterComma: Integer = 2): APascalString; stdcall;
begin
  try
    Result := Utils_FloatToStrA(Value, DigitsAfterComma);
  except
    Result := '';
  end;
end;

function FloatToStrB(Value: AFloat; Digits: AInteger; out Res: AString_Type): AInteger; stdcall;
begin
  try
    Result := AStrings.String_AssignWS(Res, AUtils.FloatToStrBP(Value, Digits));
  except
    Result := 0;
  end;
end;

function FloatToStrBP(Value: AFloat; DigitsAfterComma: Integer = 2): APascalString; stdcall;
begin
  try
    Result := AUtilsMain.Utils_FloatToStrB(Value, DigitsAfterComma);
  except
    Result := '';
  end;
end;

function FloatToStrC(Value: AFloat; Digits: AInteger; out Res: AString_Type): AInteger; stdcall;
begin
  try
    Result := AStrings.String_AssignWS(Res, AUtilsMain.Utils_FloatToStrC(Value, Digits));
  except
    Result := 0;
  end;
end;

function FloatToStrCP(Value: AFloat; DigitsAfterComma: Integer = 2): APascalString; stdcall;
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
    Result := AStrings.String_AssignWS(Res, Utils_FloatToStrD(Value));
  except
    Result := 0;
  end;
end;

function FloatToStrDP(Value: AFloat): APascalString; stdcall;
begin
  try
    Result := Utils_FloatToStrD(Value);
  except
    Result := '';
  end;
end;

function FloatToStrP(Value: AFloat): APascalString; stdcall;
begin
  try
    Result := Utils_FloatToStr(Value);
  except
    Result := '';
  end;
end;

function FloatToStrWS(Value: AFloat): AWideString; stdcall;
begin
  try
    Result := Utils_FloatToStr(Value);
  except
    Result := '';
  end;
end;

function FormatFloat1(Value: AFloat; Count, Digits: AInteger; out Res: AString_Type): AInteger; stdcall;
begin
  try
    Result := AStrings.String_AssignWS(Res, AUtilsMain.Utils_FormatFloat(Value, Count, Digits));
  except
    Result := 0;
  end;
end;

function FormatFloatP(Value: AFloat; DigitsBeforeComma, DigitsAfterComma: AInteger): APascalString; stdcall;
begin
  try
    Result := AUtilsMain.Utils_FormatFloat(Value, DigitsBeforeComma, DigitsAfterComma);
  except
    Result := '';
  end;
end;

function FormatFloatWS(Value: AFloat; DigitsBeforeComma, DigitsAfterComma: AInteger): AWideString; stdcall;
begin
  try
    Result := AUtilsMain.Utils_FormatFloat(Value, DigitsBeforeComma, DigitsAfterComma);
  except
    Result := '';
  end;
end;

function FormatInt(Value, Count: AInteger; out Res: AString_Type): AInteger; stdcall;
begin
  try
    Result := AStrings.String_AssignWS(Res, Utils_FormatInt(Value, Count));
  except
    Result := 0;
  end;
end;

function FormatIntP(Value, Count: AInteger): APascalString; stdcall;
begin
  try
    Result := Utils_FormatInt(Value, Count);
  except
    Result := '';
  end;
end;

function FormatIntWS(Value, Count: AInteger): AWideString; stdcall;
begin
  try
    Result := Utils_FormatInt(Value, Count);
  except
    Result := '';
  end;
end;

function FormatStr(const Value: AString_Type; Len: AInteger; out Res: AString_Type): AInteger; stdcall;
begin
  try
    Result := AStrings.String_AssignWS(Res,
        Utils_FormatStr(AStrings.String_ToWideString(Value), Len)
        );
  except
    Result := 0;
  end;
end;

function FormatStrAnsi(const Value: AnsiString; Len: AInteger): AnsiString; stdcall;
begin
  try
    Result := Utils_FormatStrAnsi(Value, Len);
  except
    Result := '';
  end;
end;

function FormatStrP(const Value: APascalString; Len: AInteger): APascalString; stdcall;
begin
  try
    Result := Utils_FormatStrAnsi(Value, Len);
  except
    Result := '';
  end;
end;

function FormatStrWS(const Value: AWideString; Len: AInteger): AWideString; stdcall;
begin
  try
    Result := Utils_FormatStrAnsi(Value, Len);
  except
    Result := '';
  end;
end;

function FormatStrStr(const FormatStr, S: APascalString): APascalString; stdcall;
begin
  try
    Result := Format(FormatStr, [S]);
  except
    Result := FormatStr;
  end;
end;

function Init(): AError; stdcall;
begin
  if (ASystem.Init() < 0) then
  begin
    Result := -2;
    Exit;
  end;

  Result := 0;
end;

{$IFDEF AOLD}
function IntToStr(Value: AInteger): APascalString; stdcall;
begin
  try
    Result := SysUtils.IntToStr(Value);
  except
    Result := '';
  end;
end;
{$ELSE}
function IntToStr(Value: AInteger; out Res: AString_Type): AInteger; stdcall;
begin
  try
    Result := AStrings.String_AssignWS(Res, Utils_IntToStr(Value));
  except
    Result := 0;
  end;
end;
{$ENDIF AOLD}

function IntToStrP(Value: AInteger): APascalString; stdcall;
begin
  try
    Result := SysUtils.IntToStr(Value);
  except
    Result := '';
  end;
end;

function IntToStrWS(Value: AInteger): AWideString; stdcall;
begin
  try
    Result := SysUtils.IntToStr(Value);
  except
    Result := '';
  end;
end;

function NormalizeFloat(Value: AFloat): AFloat; stdcall;
begin
  try
    Result := Utils_NormalizeFloat(Value);
  except
    Result := 0;
  end;
end;

function NormalizeStr(const Value: AString_Type; out Res: AString_Type): AInteger; stdcall;
begin
  try
    Result := AStrings.String_AssignWS(Res,
        Utils_NormalizeStr(AStrings.String_ToWideString(Value))
        );
  except
    Result := 0;
  end;
end;

function NormalizeStrP(const Value: APascalString): APascalString; stdcall;
begin
  try
    Result := Utils_NormalizeStr(Value);
  except
    Result := '';
  end;
end;

function NormalizeStrWS(const Value: AWideString): AWideString; stdcall;
begin
  try
    Result := Utils_NormalizeStr(Value);
  except
    Result := '';
  end;
end;

function NormalizeStrSpace(const Value: AString_Type; out Res: AString_Type): AInteger; stdcall;
begin
  try
    Result := AStrings.String_AssignWS(Res,
        AUtilsMain.Utils_NormalizeStrSpace(AStrings.String_ToWideString(Value))
        );
  except
    Result := 0;
  end;
end;

function NormalizeStrSpaceP(const Value: APascalString): APascalString; stdcall;
begin
  try
    Result := AUtilsMain.Utils_NormalizeStrSpace(Value);
  except
    Result := '';
  end;
end;

function NormalizeStrSpaceWS(const Value: AWideString): AWideString; stdcall;
begin
  try
    Result := AUtilsMain.Utils_NormalizeStrSpace(Value);
  except
    Result := '';
  end;
end;

function Power(Base, Exponent: AFloat): AFloat; stdcall;
begin
  try
    Result := Utils_Power(Base, Exponent); 
  except
    Result := 0;
  end;
end;

function ReplaceComma(const S: AString_Type; DecimalSeparator: AChar;
    ClearSpace: ABoolean; out Res: AString_Type): AInteger; stdcall;
begin
  try
    Result := AStrings.String_AssignWS(Res,
        AUtilsMain.Utils_ReplaceComma(AStrings.String_ToWideString(S), DecimalSeparator, ClearSpace)
        );
  except
    Result := 0;
  end;
end;

function ReplaceCommaP(const S: APascalString; DecimalSeparator: AChar = #0;
    ClearSpace: ABoolean = True): APascalString; stdcall;
begin
  try
    Result := AUtilsMain.Utils_ReplaceComma(S, DecimalSeparator, ClearSpace);
  except
    Result := '';
  end;
end;

function ReplaceCommaWS(const S: AWideString; DecimalSeparator: AChar = #0;
    ClearSpace: ABoolean = True): AWideString; stdcall;
begin
  try
    Result := AUtilsMain.Utils_ReplaceComma(S, DecimalSeparator, ClearSpace);
  except
    Result := '';
  end;
end;

function Sleep(Milliseconds: AUInt): AError; stdcall;
begin
  try
    Utils_Sleep(Milliseconds);
    Result := 0;
  except
    Result := -1;
  end;
end;

procedure Sleep02(Milliseconds: AUInt); stdcall;
begin
  try
    Utils_Sleep(Milliseconds);
  except
  end;
end;

function String_ToLowerP(const S: APascalString): APascalString; stdcall;
begin
  try
    Result := Utils_String_ToLower(S);
  except
    Result := '';
  end;
end;

function String_ToUpper(const S: AString_Type; out Res: AString_Type): AInteger; stdcall;
begin
  try
    Result := AStrings.String_AssignWS(Res, AUtilsMain.Utils_String_ToUpper(AStrings.String_ToWideString(S)));
  except
    Result := 0;
  end;
end;

function String_ToUpperP(const S: APascalString): APascalString; stdcall;
begin
  try
    Result := Utils_String_ToUpper(S);
  except
    Result := '';
  end;
end;

function String_ToUpperWS(const S: AWideString): AWideString; stdcall;
begin
  try
    Result := Utils_String_ToUpper(S);
  except
    Result := '';
  end;
end;

function StrToDate(const Value: AString_Type): TDateTime; stdcall;
begin
  try
    Result := Utils_StrToDate(AStrings.String_ToWideString(Value));
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

function StrToFloat(const Value: AString_Type): AFloat; stdcall;
begin
  try
    Result := Utils_StrToFloat(AStrings.String_ToWideString(Value));
  except
    Result := 0;
  end;
end;

{$IFDEF AOLD}
function StrToFloat1(const S: APascalString; DefValue: AFloat = 0): AFloat; stdcall;
begin
  Result := StrToFloatDefP(S, DefValue);
end;
{$ELSE}
function StrToFloat1(const S: AString_Type; DefValue: AFloat): AFloat; stdcall;
begin
  try
    Result := Utils_StrToFloat1(AStrings.String_ToWideString(S), DefValue);
  except
    Result := 0;
  end;
end;
{$ENDIF AOLD}

function StrToFloatDefP(const S: APascalString; DefValue: AFloat): AFloat; stdcall;
var
  Value: AFloat32;
begin
  if TryStrToFloat32P(S, Value) then
    Result := Value
  else
    Result := DefValue;
end;

function StrToFloatDefWS(const S: AWideString; DefValue: AFloat): AFloat; stdcall;
var
  Value: AFloat32;
begin
  if TryStrToFloat32P(S, Value) then
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

function StrToInt(const Value: AString_Type): AInteger; stdcall;
begin
  try
    Result := Utils_StrToInt(AStrings.String_ToWideString(Value));
  except
    Result := 0;
  end;
end;

{
function StrToInt1(const S: AString_Type; DefValue: AInteger): AInteger; stdcall;
begin
  try
    Result := Utils_StrToInt1(AStrings.String_ToWideString(S), DefValue);
  except
    Result := 0;
  end;
end;
}

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

{
function Trim(const S: APascalString): APascalString; stdcall;
begin
  try
    Result := Utils_Trim(S);
  except
    Result := '';
  end;
end;
}

function Trim(const S: AString_Type; out Res: AString_Type): AInteger; stdcall;
begin
  try
    Result := AStrings.String_AssignWS(Res, Utils_Trim(AStrings.String_ToWideString(S)));
  except
    Result := 0;
  end;
end;

function TrimP(const S: APascalString): APascalString; stdcall;
begin
  try
    Result := Utils_Trim(S);
  except
    Result := '';
  end;
end;

function TrimWS(const S: AWideString): AWideString; stdcall;
begin
  try
    Result := Utils_Trim(S);
  except
    Result := '';
  end;
end;

function TryStrToDate(const S: AString_Type; var Value: TDateTime): ABoolean; stdcall;
begin
  try
    Result := AUtilsMain.Utils_TryStrToDate(AStrings.String_ToWideString(S), Value);
  except
    Result := False;
  end;
end;

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

function TryStrToFloat(const S: AString_Type; var Value: AFloat): ABoolean; stdcall;
begin
  try
    Result := AUtilsMain.Utils_TryStrToFloat(AStrings.String_ToWideString(S), Value);
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

function TryStrToFloat32(const S: AString_Type; var Value: AFloat32): ABoolean; stdcall;
begin
  try
    Result := AUtilsMain.Utils_TryStrToFloat32(AStrings.String_ToWideString(S), Value);
  except
    Result := False;
  end;
end;

{
function TryStrToFloat32(const S: APascalString; var Value: AFloat32): ABoolean; stdcall;
begin
  try
    Result := AUtilsMain.Utils_TryStrToFloat32(S, Value);
  except
    Result := False;
  end;
end;
}

function TryStrToFloat32P(const S: APascalString; var Value: AFloat32): ABoolean; stdcall;
begin
  try
    Result := AUtilsMain.Utils_TryStrToFloat32(S, Value);
  except
    Result := False;
  end;
end;

{
function TryStrToFloat64(const S: APascalString; var Value: AFloat64): ABoolean; stdcall;
begin
  try
    Result := AUtilsMain.Utils_TryStrToFloat64(S, Value);
  except
    Result := False;
  end;
end;
}

function TryStrToFloat64(const S: AString_Type; var Value: AFloat64): ABoolean; stdcall;
begin
  try
    Result := AUtilsMain.Utils_TryStrToFloat64(AStrings.String_ToWideString(S), Value);
  except
    Result := False;
  end;
end;

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

function TryStrToInt(const S: AString_Type; var Value: AInteger): ABoolean; stdcall;
begin
  try
    Result := AUtilsMain.Utils_TryStrToInt(AStrings.String_ToWideString(S), Value);
  except
    Result := False;
  end;
end;

{
function TryStrToInt(const S: APascalString; var Value: AInteger): ABoolean; stdcall;
begin
  try
    Result := Utils_TryStrToInt(S, Value);
  except
    Result := False;
  end;
end;
}

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

function Utils_ExtractFileExt(const FileName: APascalString): APascalString; stdcall;
begin
  Result := SysUtils.ExtractFileExt(FileName);
end;

function Utils_ExtractFilePath(const FileName: APascalString): APascalString; stdcall;
begin
  Result := SysUtils.ExtractFilePath(FileName);
end;

function Utils_FileExists(const FileName: APascalString): ABoolean; stdcall;
begin
  Result := SysUtils.FileExists(FileName);
end;

function Utils_FloatToStr(Value: AFloat): APascalString; stdcall;
begin
  Result := SysUtils.FloatToStr(Value);
end;

function Utils_FloatToStrA(Value: AFloat; DigitsAfterComma: AInteger = 2): APascalString; stdcall;
begin
  Result := SysUtils.FloatToStrF(Value, ffFixed, 10, DigitsAfterComma);
end;

function Utils_FloatToStrB(Value: AFloat; DigitsAfterComma: AInteger): APascalString; stdcall;
begin
  Result := AUtilsMain.Utils_FloatToStrB(Value, DigitsAfterComma);
end;

function Utils_FloatToStrC(Value: AFloat; DigitsAfterComma: AInteger): APascalString; stdcall;
begin
  Result := AUtilsMain.Utils_FloatToStrC(Value, DigitsAfterComma);
end;

function Utils_FloatToStrD(Value: AFloat): APascalString; stdcall;
begin
  Result := SysUtils.FormatFloat(',0.00', Value);
end;

function Utils_FormatFloat(Value: AFloat; Count, Digits: AInteger): APascalString; stdcall;
begin
  Result := AUtilsMain.Utils_FormatFloat(Value, Count, Digits);
end;

function Utils_FormatInt(Value, Count: AInteger): APascalString; stdcall;
begin
  if (Count > 0) and (Count <= 9) then
    Result := Format('%'+Chr(Ord('0')+Count)+'d',[Value])
  else
    Result := SysUtils.IntToStr(Value);
end;

function Utils_FormatStr(const Value: APascalString; Len: AInteger): APascalString; stdcall;
begin
  Result := Utils_FormatStrAnsi(Value, Len);
end;

function Utils_FormatStrAnsi(const Value: AnsiString; Len: AInteger): AnsiString; stdcall;
begin
  if (Len = 0) then
  begin
    Result := '';
    Exit;
  end;

  if (Length(Value) = Abs(Len)) then
    Result := Value
  else if (Length(Value) > Abs(Len)) then
    Result := Copy(Value, 1, Abs(Len))
  else
  begin
    if (Len > 0) then
      Result := Value
    else
    begin
      Len := -Len;
      SetLength(Result, Len);
      FillChar(Result[1], Len, ' ');
      Move(Value[1], Result[Len-Length(Value)+1], Length(Value));
    end;
  end;
end;

function Utils_IntToStr(Value: AInteger): APascalString; stdcall;
begin
  Result := SysUtils.IntToStr(Value);
end;

function Utils_NormalizeFloat(Value: AFloat): AFloat; stdcall;
begin
  Result := Utils_StrToFloat(Utils_FloatToStrA(Value));
end;

function Utils_NormalizeStr(const Value: APascalString): APascalString; stdcall;
var
  I: Integer;
  S: string;
begin
  S := Value;
  for I := 1 to Length(S) do
  begin
    if (Ord(S[I]) < 31) then // пробел
      S[I] := '#';
  end;
  Result := S;
end;

function Utils_NormalizeStrSpace(const Value: APascalString): APascalString; stdcall;
begin
  Result := AUtilsMain.Utils_NormalizeStrSpace(Value);
end;

function Utils_Power(Base, Exponent: AFloat): AFloat; stdcall;
begin
  Result := Exp(Exponent * Ln(Base));
end;

function Utils_ReplaceComma(const S: APascalString; DecimalSeparator: AChar; ClearSpace: ABoolean): APascalString; stdcall;
begin
  AUtilsMain.Utils_ReplaceComma(S, DecimalSeparator, ClearSpace);
end;

procedure Utils_Sleep(Milliseconds: AUInt); stdcall;
begin
  ASystem.ProcessMessages();
  SysUtils.Sleep(Milliseconds);
end;

function Utils_String_ToLower(const S: APascalString): APascalString;
begin
  Result := SysUtils.LowerCase(S);
end;

function Utils_String_ToUpper(const S: APascalString): APascalString;
begin
  Result := SysUtils.AnsiUpperCase(S);
end;

function Utils_StrToDate(const Value: APascalString): TDateTime;
begin
  Result := SysUtils.StrToDate(Value);
end;

function Utils_StrToFloat(const Value: APascalString): AFloat;
begin
  Result := SysUtils.StrToFloat(Value);
end;

function Utils_StrToFloat1(const S: APascalString; DefValue: AFloat = 0): AFloat;
begin
  Result := StrToFloatDefP(S, DefValue);
end;

{function Utils_StrToFloatDefP(const S: APascalString; DefValue: AFloat): AFloat; stdcall;
begin
  Result := StrToFloat1(S, DefValue);
end;}

function Utils_StrToInt(const Value: APascalString): AInteger;
begin
  Result := SysUtils.StrToInt(Value);
end;

function Utils_StrToInt1(const S: APascalString; DefValue: AInteger = 0): AInteger;
begin
  Result := StrToInt1(S, DefValue);
end;

{function Utils_StrToIntDefP(const S: APascalString; DefValue: AInteger): AInteger; stdcall;
begin
  if not(Utils_TryStrToInt(S, Result)) then
    Result := DefValue;
end;}

function Utils_Time_Now: TDateTime;
begin
  Result := Now;
end;

function Utils_TryStrToDate(const S: APascalString; var Value: TDateTime): Boolean;
begin
  Result := AUtilsMain.Utils_TryStrToDate(S, Value);
end;

function Utils_TryStrToFloat(const S: APascalString; var Value: AFloat): ABoolean;
begin
  Result := AUtilsMain.Utils_TryStrToFloat32(S, Value);
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

