{**
@Abstract AUtils - Main
@Author Prof1983 <prof1983@ya.ru>
@Created 28.09.2011
@LastMod 29.11.2012
}
unit AUtilsMain;

interface

uses
  SysUtils, ABase, AStrings, AStringUtils, ASystemMain;

// --- AUtils ---

function AUtils_ChangeFileExtP(const FileName, Extension: APascalString): APascalString; stdcall;

function AUtils_ChangeFileExtWS(const FileName, Extension: AWideString): AWideString; stdcall;

function AUtils_DateToStrP(Value: TDateTime): APascalString; stdcall;

function AUtils_DateToStrWS(Value: TDateTime): AWideString; stdcall;

function AUtils_DeleteFileP(const FileName: APascalString): AError; stdcall;

function AUtils_DeleteFileWS(const FileName: AWideString): AError; stdcall;

function AUtils_DirectoryExistsP(const Directory: APascalString): ABoolean; stdcall;

function AUtils_ExpandFileNameP(const FileName: APascalString): APascalString; stdcall;

function AUtils_ExpandFileNameWS(const FileName: AWideString): AWideString; stdcall;

function AUtils_ExtractFileExt(const FileName: AString_Type; out Res: AString_Type): AInteger; stdcall;

function AUtils_ExtractFileExtP(const FileName: APascalString): APascalString; stdcall;

function AUtils_ExtractFileExtWS(const FileName: AWideString): AWideString; stdcall;

function AUtils_ExtractFileNameP(const FileName: APascalString): APascalString; stdcall;

function AUtils_ExtractFilePath(const FileName: AString_Type; out Res: AString_Type): AInteger; stdcall;

function AUtils_ExtractFilePathP(const FileName: APascalString): APascalString; stdcall;

function AUtils_ExtractFilePathWS(const FileName: AWideString): AWideString; stdcall;

function AUtils_FileExists(const FileName: AString_Type): ABoolean; stdcall;

function AUtils_FileExistsP(const FileName: APascalString): ABoolean; stdcall;

function AUtils_FileExistsWS(const FileName: AWideString): ABoolean; stdcall;

function AUtils_Fin(): AError; stdcall;

function AUtils_FloatToStr(Value: AFloat; out Res: AString_Type): AInteger; stdcall;

function AUtils_FloatToStr2P(Value: AFloat; DigitsAfterComma: AInteger;
    ReplaceComma, Delimer: ABoolean): APascalString; stdcall;

function AUtils_FloatToStr2WS(Value: AFloat; DigitsAfterComma: AInteger;
    ReplaceComma, Delimer: ABoolean): AWideString; stdcall;

function AUtils_FloatToStrAP(Value: AFloat; DigitsAfterComma: AInteger = 2): APascalString; stdcall;

function AUtils_FloatToStrBP(Value: AFloat; DigitsAfterComma: Integer = 2): APascalString; stdcall;

function AUtils_FloatToStrCP(Value: AFloat; DigitsAfterComma: Integer = 2): APascalString; stdcall;

function AUtils_FloatToStrDP(Value: AFloat): APascalString; stdcall;

function AUtils_FloatToStrP(Value: AFloat): APascalString; stdcall;

function AUtils_FloatToStrWS(Value: AFloat): AWideString; stdcall;

function AUtils_FormatFloat(Value: AFloat; Count, Digits: AInteger;
    out Res: AString_Type): AInteger; stdcall;

function AUtils_FormatFloatP(Value: AFloat; DigitsBeforeComma, DigitsAfterComma: AInteger): APascalString; stdcall;

function AUtils_FormatFloatWS(Value: AFloat; DigitsBeforeComma, DigitsAfterComma: AInteger): AWideString; stdcall;

function AUtils_FormatInt(Value, Count: AInteger; out Res: AString_Type): AInteger; stdcall;

function AUtils_FormatIntP(Value, Count: AInteger): APascalString; stdcall;

function AUtils_FormatIntWS(Value, Count: AInteger): AWideString; stdcall;

function AUtils_FormatStr(const Value: AString_Type; Len: AInteger; out Res: AString_Type): AInteger; stdcall;

function AUtils_FormatStrAnsi(const Value: AnsiString; Len: AInteger): AnsiString; stdcall;

function AUtils_FormatStrP(const Value: APascalString; Len: AInteger): APascalString; stdcall;

function AUtils_FormatStrStrP(const FormatStr, S: APascalString): APascalString; stdcall;

function AUtils_FormatStrStrWS(const FormatStr, S: AWideString): AWideString; stdcall;

function AUtils_FormatStrWS(const Value: AWideString; Len: AInteger): AWideString; stdcall;

function AUtils_Init(): AError; stdcall;

function AUtils_IntToStr(Value: AInteger; out Res: AString_Type): AInteger; stdcall;

function AUtils_IntToStrP(Value: AInteger): APascalString; stdcall;

function AUtils_IntToStrWS(Value: AInteger): AWideString; stdcall;

function AUtils_NormalizeFloat(Value: AFloat): AFloat; stdcall;

function AUtils_NormalizeStr(const Value: AString_Type; out Res: AString_Type): AInteger; stdcall;

function AUtils_NormalizeStrP(const Value: APascalString): APascalString; stdcall;

function AUtils_NormalizeStrSpace(const Value: AString_Type; out Res: AString_Type): AInteger; stdcall;

function AUtils_NormalizeStrSpaceP(const Value: APascalString): APascalString; stdcall;

function AUtils_NormalizeStrSpaceWS(const Value: AWideString): AWideString; stdcall;

function AUtils_NormalizeStrWS(const Value: AWideString): AWideString; stdcall;

function AUtils_Power(Base, Exponent: AFloat): AFloat; stdcall;

function AUtils_ReplaceComma(const S: AString_Type; DecimalSeparator: AChar;
    ClearSpace: ABoolean; out Res: AString_Type): AInteger; stdcall;

function AUtils_ReplaceCommaP(const S: APascalString; DecimalSeparator: AChar = #0;
    ClearSpace: ABoolean = True): APascalString; stdcall;

function AUtils_ReplaceCommaWS(const S: AWideString; DecimalSeparator: AChar = #0;
    ClearSpace: ABoolean = True): AWideString; stdcall;

function AUtils_Round2(Value: Real; Digits1, DigitsAfterComma: Integer): Real; stdcall;

function AUtils_Sleep(Milliseconds: AUInt): AError; stdcall;

function AUtils_StrToFloatP(const Value: APascalString): AFloat; stdcall;

// --- Utils ---

function Utils_ExtractFileExt(const FileName: APascalString): APascalString;

function Utils_ExtractFilePath(const FileName: APascalString): APascalString;

function Utils_FileExists(const FileName: APascalString): ABoolean;

//** Преобразует число в строку.
function Utils_FloatToStr(Value: AFloat): APascalString;

//** Преобразует число в строку.
function Utils_FloatToStr2(Value: AFloat; DigitsAfterComma: Integer; ReplaceComma, Delimer: ABoolean): APascalString;

//** Преобразует число в строку c двумя знаками после запятой
function Utils_FloatToStrA(Value: AFloat; DigitsAfterComma: AInteger = 2): APascalString;

//** Преобразует число в строку для записи в БД (SQL). Для SQL необходим разделитель - точка.
function Utils_FloatToStrB(Value: AFloat; DigitsAfterComma: Integer = 2): APascalString;

function Utils_FloatToStrC(Value: AFloat; DigitsAfterComma: Integer = 2): APascalString;

function Utils_FloatToStrD(Value: AFloat): APascalString;

function Utils_FormatFloat(Value: AFloat; DigitsBeforeComma, DigitsAfterComma: AInteger): APascalString;

//** Преобразует число в строку.
function Utils_IntToStr(Value: AInteger): APascalString;

function Utils_NormalizeStrSpace(const Value: APascalString): APascalString;

{ Заменяет все точки на запятые или все запятые на точки в зависимости от региональных настроек.
  Если параметр DecimalSeparator указан, то региональные настройки игнорируются. }
function Utils_ReplaceComma(const S: APascalString; DecimalSeparator: AChar = #0; ClearSpace: ABoolean = True): APascalString;

{ Округляет значение до указанного кол-ва значащих цифр и обрезает до указанного кол-ва знаков после запятой.
  Digits1 - кол-во значащих цифр (Meaning numbers)
  DigitsAfterComma - максимально необходимое кол-во знаков после запятой (Numbers after a comma) }
function Utils_Round2(Value: Real; Digits1, DigitsAfterComma: Integer): Real;

function Utils_String_ToLower(const S: APascalString): APascalString;

function Utils_String_ToUpper(const S: APascalString): APascalString;

{ Trims leading and trailing spaces and control characters from a string.
  Удаляет первые и последние пробелы }
function Utils_Trim(const S: APascalString): APascalString;

function Utils_TryStrToDate(const S: APascalString; var Value: TDateTime): ABoolean;

{ Преобразует строку в Float. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
function Utils_TryStrToFloat(const S: APascalString; var Value: AFloat): ABoolean;

{ Преобразует строку в Float32. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
function Utils_TryStrToFloat32(const S: APascalString; var Value: AFloat32): ABoolean;

{ Преобразует строку в Float64. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
function Utils_TryStrToFloat64(const S: APascalString; var Value: AFloat64): ABoolean;

function Utils_TryStrToInt(const S: APascalString; var Value: AInteger): ABoolean;

implementation

// --- AUtils ---

function AUtils_ChangeFileExtP(const FileName, Extension: APascalString): APascalString;
begin
  try
    Result := SysUtils.ChangeFileExt(FileName, Extension);
  except
    Result := '';
  end;
end;

function AUtils_ChangeFileExtWS(const FileName, Extension: AWideString): AWideString;
begin
  try
    Result := SysUtils.ChangeFileExt(FileName, Extension);
  except
    Result := '';
  end;
end;

function AUtils_DateToStrP(Value: TDateTime): APascalString;
begin
  try
    Result := SysUtils.DateToStr(Value);
  except
    Result := '';
  end;
end;

function AUtils_DateToStrWS(Value: TDateTime): AWideString;
begin
  try
    Result := SysUtils.DateToStr(Value);
  except
    Result := '';
  end;
end;

function AUtils_DeleteFileP(const FileName: APascalString): AError;
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

function AUtils_DeleteFileWS(const FileName: AWideString): AError;
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

function AUtils_DirectoryExistsP(const Directory: APascalString): ABoolean;
begin
  try
    Result := SysUtils.DirectoryExists(Directory);
  except
    Result := False;
  end;
end;

function AUtils_ExpandFileNameP(const FileName: APascalString): APascalString;
begin
  try
    Result := SysUtils.ExpandFileName(FileName);
  except
    Result := '';
  end;
end;

function AUtils_ExpandFileNameWS(const FileName: AWideString): AWideString;
begin
  try
    Result := SysUtils.ExpandFileName(FileName);
  except
    Result := '';
  end;
end;

function AUtils_ExtractFileExt(const FileName: AString_Type; out Res: AString_Type): AInteger;
begin
  try
    Result := AString_AssignP(Res,
        AUtils_ExtractFileExtP(AString_ToPascalString(FileName))
        );
  except
    Result := 0;
  end;
end;

function AUtils_ExtractFileExtP(const FileName: APascalString): APascalString;
begin
  try
    Result := SysUtils.ExtractFileExt(FileName);
  except
    Result := '';
  end;
end;

function AUtils_ExtractFileExtWS(const FileName: AWideString): AWideString;
begin
  try
    Result := SysUtils.ExtractFileExt(FileName);
  except
    Result := '';
  end;
end;

function AUtils_ExtractFileNameP(const FileName: APascalString): APascalString;
begin
  try
    Result := SysUtils.ExtractFileName(FileName);
  except
    Result := '';
  end;
end;

function AUtils_ExtractFilePath(const FileName: AString_Type; out Res: AString_Type): AInteger;
begin
  try
    Result := AString_AssignP(Res,
        AUtils_ExtractFilePathP(AString_ToPascalString(FileName))
        );
  except
    Result := 0;
  end;
end;

function AUtils_ExtractFilePathP(const FileName: APascalString): APascalString;
begin
  try
    Result := SysUtils.ExtractFilePath(FileName);
  except
    Result := '';
  end;
end;

function AUtils_ExtractFilePathWS(const FileName: AWideString): AWideString;
begin
  try
    Result := SysUtils.ExtractFilePath(FileName);
  except
    Result := '';
  end;
end;

function AUtils_FileExists(const FileName: AString_Type): ABoolean;
begin
  try
    Result := AUtils_FileExistsP(AString_ToPascalString(FileName));
  except
    Result := False;
  end;
end;

function AUtils_FileExistsP(const FileName: APascalString): ABoolean;
begin
  try
    Result := SysUtils.FileExists(FileName);
  except
    Result := False;
  end;
end;

function AUtils_FileExistsWS(const FileName: AWideString): ABoolean;
begin
  Result := AUtils_FileExistsP(FileName);
end;

function AUtils_Fin(): AError;
begin
  Result := 0;
end;

function AUtils_FloatToStr(Value: AFloat; out Res: AString_Type): AInteger;
begin
  try
    Result := AString_AssignP(Res, AUtils_FloatToStrP(Value));
  except
    Result := 0;
  end;
end;

function AUtils_FloatToStr2P(Value: AFloat; DigitsAfterComma: AInteger;
    ReplaceComma, Delimer: ABoolean): APascalString;
begin
  if Delimer then
    Result := AUtils_FloatToStrCP(Value, DigitsAfterComma)
  else
    Result := AUtils_FloatToStrAP(Value, DigitsAfterComma);
  if ReplaceComma then
    Result := AUtils_ReplaceCommaP(Result);
end;

function AUtils_FloatToStr2WS(Value: AFloat; DigitsAfterComma: AInteger;
    ReplaceComma, Delimer: ABoolean): AWideString;
begin
  try
    if Delimer then
      Result := AUtils_FloatToStrCP(Value, DigitsAfterComma)
    else
      Result := AUtils_FloatToStrAP(Value, DigitsAfterComma);
    if ReplaceComma then
      Result := AUtils_ReplaceCommaP(Result);
  except
    Result := '';
  end;
end;

function AUtils_FloatToStrAP(Value: AFloat; DigitsAfterComma: AInteger): APascalString;
begin
  try
    Result := SysUtils.FloatToStrF(Value, ffFixed, 10, DigitsAfterComma);
  except
    Result := '';
  end;
end;

function AUtils_FloatToStrBP(Value: AFloat; DigitsAfterComma: AInteger): APascalString; stdcall;
begin
  try
    Result := AUtilsMain.Utils_ReplaceComma(AUtils_FloatToStrAP(Value, DigitsAfterComma), '.');
  except
    Result := '';
  end;
end;

function AUtils_FloatToStrCP(Value: AFloat; DigitsAfterComma: AInteger): APascalString; stdcall;
begin
  try
    case DigitsAfterComma of
      0: Result := SysUtils.FormatFloat('### ### ### ##0', Value);
      1: Result := SysUtils.FormatFloat('### ### ### ##0.0', Value);
      2: Result := SysUtils.FormatFloat('### ### ### ##0.00', Value);
      3: Result := SysUtils.FormatFloat('### ### ### ##0.000', Value);
      4: Result := SysUtils.FormatFloat('### ### ### ##0.0000', Value);
      5: Result := SysUtils.FormatFloat('### ### ### ##0.00000', Value);
    else
      Result := SysUtils.FormatFloat('### ### ### ##0.00', Value);
    end;
  except
    Result := '';
  end;
end;

function AUtils_FloatToStrDP(Value: AFloat): APascalString; stdcall;
begin
  try
    Result := SysUtils.FormatFloat(',0.00', Value);
  except
    Result := '';
  end;
end;

function AUtils_FloatToStrP(Value: AFloat): APascalString;
begin
  try
    Result := SysUtils.FloatToStr(Value);
  except
    Result := '';
  end;
end;

function AUtils_FloatToStrWS(Value: AFloat): AWideString;
begin
  try
    Result := AUtilsMain.Utils_FloatToStr(Value);
  except
    Result := '';
  end;
end;

function AUtils_FormatFloat(Value: AFloat; Count, Digits: AInteger;
    out Res: AString_Type): AInteger;
begin
  try
    Result := AString_AssignP(Res, AUtils_FormatFloatP(Value, Count, Digits));
  except
    Result := 0;
  end;
end;

function AUtils_FormatFloatP(Value: AFloat; DigitsBeforeComma, DigitsAfterComma: AInteger): APascalString;
var
  FormatS: string;
begin
  try
    if (DigitsBeforeComma >= 0) and (DigitsBeforeComma <= 9) and (DigitsAfterComma >= 0) and (DigitsAfterComma <= 9) then
    begin
      FormatS := '%' + Chr(Ord('0')+DigitsBeforeComma) + '.' + Chr(Ord('0')+DigitsAfterComma) + 'f';
      Result := Format(FormatS,[Value]);
    end
    else
      Result := Utils_FloatToStrB(Value, DigitsAfterComma);
  except
    Result := '';
  end;
end;

function AUtils_FormatFloatWS(Value: AFloat; DigitsBeforeComma, DigitsAfterComma: AInteger): AWideString;
begin
  try
    Result := AUtilsMain.Utils_FormatFloat(Value, DigitsBeforeComma, DigitsAfterComma);
  except
    Result := '';
  end;
end;

function AUtils_FormatInt(Value, Count: AInteger; out Res: AString_Type): AInteger;
begin
  try
    Result := AString_AssignP(Res, AUtils_FormatIntP(Value, Count));
  except
    Result := 0;
  end;
end;

function AUtils_FormatIntP(Value, Count: AInteger): APascalString;
begin
  try
    if (Count > 0) and (Count <= 9) then
      Result := Format('%'+Chr(Ord('0')+Count)+'d',[Value])
    else
      Result := SysUtils.IntToStr(Value);
  except
    Result := '';
  end;
end;

function AUtils_FormatIntWS(Value, Count: AInteger): AWideString;
begin
  try
    Result := AUtils_FormatIntWS(Value, Count);
  except
    Result := '';
  end;
end;

function AUtils_FormatStr(const Value: AString_Type; Len: AInteger; out Res: AString_Type): AInteger;
begin
  try
    Result := AString_AssignP(Res,
        AUtils_FormatStrP(AString_ToPascalString(Value), Len)
        );
  except
    Result := 0;
  end;
end;

function AUtils_FormatStrAnsi(const Value: AnsiString; Len: AInteger): AnsiString;
begin
  if (Len = 0) then
  begin
    Result := '';
    Exit;
  end;

  try
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
  except
    Result := '';
  end;
end;

function AUtils_FormatStrP(const Value: APascalString; Len: AInteger): APascalString;
begin
  try
    Result := AUtils_FormatStrAnsi(Value, Len);
  except
    Result := '';
  end;
end;

function AUtils_FormatStrStrP(const FormatStr, S: APascalString): APascalString;
begin
  try
    Result := Format(FormatStr, [S]);
  except
    Result := FormatStr;
  end;
end;

function AUtils_FormatStrStrWS(const FormatStr, S: AWideString): AWideString;
begin
  try
    Result := Format(FormatStr, [S]);
  except
    Result := FormatStr;
  end;
end;

function AUtils_FormatStrWS(const Value: AWideString; Len: AInteger): AWideString;
begin
  try
    Result := AUtils_FormatStrAnsi(AnsiString(Value), Len);
  except
    Result := '';
  end;
end;

function AUtils_Init(): AError;
begin
  if (ASystem_Init() < 0) then
  begin
    Result := -2;
    Exit;
  end;

  Result := 0;
end;

function AUtils_IntToStr(Value: AInteger; out Res: AString_Type): AInteger;
begin
  try
    Result := AString_AssignP(Res, AUtils_IntToStrP(Value));
  except
    Result := 0;
  end;
end;

function AUtils_IntToStrP(Value: AInteger): APascalString;
begin
  try
    Result := SysUtils.IntToStr(Value);
  except
    Result := '';
  end;
end;

function AUtils_IntToStrWS(Value: AInteger): AWideString;
begin
  try
    Result := SysUtils.IntToStr(Value);
  except
    Result := '';
  end;
end;

function AUtils_NormalizeFloat(Value: AFloat): AFloat;
begin
  try
    Result := AUtils_StrToFloatP(AUtils_FloatToStrAP(Value));
  except
    Result := 0;
  end;
end;

function AUtils_NormalizeStr(const Value: AString_Type; out Res: AString_Type): AInteger;
begin
  try
    Result := AString_AssignP(Res,
        AUtils_NormalizeStrP(AString_ToPascalString(Value))
        );
  except
    Result := 0;
  end;
end;

function AUtils_NormalizeStrP(const Value: APascalString): APascalString;
var
  I: Integer;
  S: string;
begin
  try
    S := Value;
    for I := 1 to Length(S) do
    begin
      if (Ord(S[I]) < 31) then // пробел
        S[I] := '#';
    end;
    Result := S;
  except
    Result := '';
  end;
end;

function AUtils_NormalizeStrSpace(const Value: AString_Type; out Res: AString_Type): AInteger;
begin
  try
    Result := AString_AssignP(Res,
        AUtils_NormalizeStrSpaceP(AString_ToPascalString(Value))
        );
  except
    Result := 0;
  end;
end;

function AUtils_NormalizeStrSpaceP(const Value: APascalString): APascalString; stdcall;
var
  I: Integer;
  J: Integer;
begin
  try
    SetLength(Result, Length(Value));
    I := 0;
    J := 0;
    while (I < Length(Value)) do
    begin
      Inc(I);
      Inc(J);
      if (I < Length(Value)) and (Value[I] = #13) and (Value[I+1] = #10) then
      begin
        Result[J] := ' ';
        Inc(I);
      end
      else if (Ord(Result[I]) < 31) then // пробел
        Result[J] := ' '
      else
        Result[J] := Value[I];
    end;
    SetLength(Result, J);
  except
    Result := '';
  end;
end;

function AUtils_NormalizeStrSpaceWS(const Value: AWideString): AWideString;
begin
  try
    Result := AUtilsMain.Utils_NormalizeStrSpace(Value);
  except
    Result := '';
  end;
end;

function AUtils_NormalizeStrWS(const Value: AWideString): AWideString;
begin
  Result := AUtils_NormalizeStrP(Value);
end;

function AUtils_Power(Base, Exponent: AFloat): AFloat;
begin
  try
    Result := Exp(Exponent * Ln(Base));
  except
    Result := 0;
  end;
end;

function AUtils_ReplaceComma(const S: AString_Type; DecimalSeparator: AChar;
    ClearSpace: ABoolean; out Res: AString_Type): AInteger;
begin
  try
    Result := AString_AssignP(Res,
        AUtils_ReplaceCommaP(AString_ToPascalString(S), DecimalSeparator, ClearSpace)
        );
  except
    Result := 0;
  end;
end;

function AUtils_ReplaceCommaP(const S: APascalString; DecimalSeparator: AChar;
    ClearSpace: ABoolean): APascalString;
begin
  try
    Result := AUtilsMain.Utils_ReplaceComma(S, DecimalSeparator, ClearSpace);
  except
    Result := '';
  end;
end;

function AUtils_ReplaceCommaWS(const S: AWideString; DecimalSeparator: AChar;
    ClearSpace: ABoolean): AWideString;
begin
  try
    Result := AUtilsMain.Utils_ReplaceComma(S, DecimalSeparator, ClearSpace);
  except
    Result := '';
  end;
end;

function AUtils_Round2(Value: Real; Digits1, DigitsAfterComma: Integer): Real;
begin
  try
    Result := Utils_Round2(Value, Digits1, DigitsAfterComma);
  except
    Result := 0;
  end;
end;

function AUtils_Sleep(Milliseconds: AUInt): AError;
begin
  try
    ASystem_ProcessMessages();
    SysUtils.Sleep(Milliseconds);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AUtils_StrToFloatP(const Value: APascalString): AFloat;
begin
  try
    Result := SysUtils.StrToFloat(Value);
  except
    Result := 0;
  end;
end;

// --- Utils ---

function Utils_ExtractFileExt(const FileName: APascalString): APascalString;
begin
  Result := AUtils_ExtractFileExtP(FileName);
end;

function Utils_ExtractFilePath(const FileName: APascalString): APascalString;
begin
  Result := AUtils_ExtractFilePathP(FileName);
end;

function Utils_FileExists(const FileName: APascalString): ABoolean;
begin
  Result := AUtils_FileExistsP(FileName);
end;

function Utils_FloatToStr(Value: AFloat): APascalString;
begin
  Result := AUtils_FloatToStrP(Value);
end;

function Utils_FloatToStr2(Value: AFloat; DigitsAfterComma: Integer; ReplaceComma, Delimer: ABoolean): APascalString;
begin
  Result := AUtils_FloatToStr2P(Value, DigitsAfterComma, ReplaceComma, Delimer);
end;

function Utils_FloatToStrA(Value: AFloat; DigitsAfterComma: AInteger = 2): APascalString;
begin
  Result := AUtils_FloatToStrAP(Value, DigitsAfterComma);
end;

function Utils_FloatToStrB(Value: AFloat; DigitsAfterComma: AInteger): APascalString;
begin
  Result := AUtils_FloatToStrBP(Value, DigitsAfterComma);
end;

function Utils_FloatToStrC(Value: AFloat; DigitsAfterComma: AInteger): APascalString;
begin
  Result := AUtils_FloatToStrCP(Value, DigitsAfterComma);
end;

function Utils_FloatToStrD(Value: AFloat): APascalString;
begin
  Result := AUtils_FloatToStrDP(Value);
end;

function Utils_FormatFloat(Value: AFloat; DigitsBeforeComma, DigitsAfterComma: AInteger): APascalString;
begin
  Result := AUtils_FormatFloatP(Value, DigitsBeforeComma, DigitsAfterComma);
end;

function Utils_IntToStr(Value: AInteger): APascalString;
begin
  Result := SysUtils.IntToStr(Value);
end;

function Utils_NormalizeStrSpace(const Value: APascalString): APascalString;
begin
  Result := AUtils_NormalizeStrSpaceP(Value);
end;

function Utils_ReplaceComma(const S: APascalString; DecimalSeparator: AChar; ClearSpace: ABoolean): APascalString;
var
  ic: Integer;
  SS: APascalString;
begin
  if (DecimalSeparator = #0) then
  begin
    {$IFDEF VER220}
    DecimalSeparator := AChar(FormatSettings.DecimalSeparator);
    {$ELSE}
    DecimalSeparator := AChar(SysUtils.DecimalSeparator);
    {$ENDIF}
  end;
  if (DecimalSeparator <> '.') and (DecimalSeparator <> ',') then
    raise Exception.Create('Ошибка в ReplaceComma(). Значение DecimalSeparator должно быть точка или запятая.');

  // 44 - запятая; 46 - точка
  ic := 1;
  SS := '';
  while (ic <= (Length(S))) do
  begin
    if not(ClearSpace) or (S[ic] <> ' ') then
    begin
      if (DecimalSeparator = '.') then
      begin
        if S[ic] = ',' then
          SS := SS + '.'
        else
          SS := SS + S[ic];
      end
      else
      begin
        if (S[ic] = '.') then
          SS := SS + ','
        else
          SS := SS + S[ic];
      end;
    end;
    ic := ic + 1;
  end;
  Result := SS;
end;

function Utils_String_ToLower(const S: APascalString): APascalString;
begin
  Result := SysUtils.LowerCase(S);
end;

function Utils_Round2(Value: Real; Digits1, DigitsAfterComma: Integer): Real;

  function DigitToValue(Digits: Integer): Integer;
  begin
    case Digits of
      1: Result := 1;
      2: Result := 10;
      3: Result := 100;
      4: Result := 1000;
      5: Result := 10000;
      6: Result := 100000;
      7: Result := 1000000;
      8: Result := 10000000;
      9: Result := 100000000;
    else
      Result := 1000000000;
    end;
  end;

  // Округляем до указанного кол-ва значащих цифр
  function Round2(Value: Real): Real;
  var
    E: Real;
  begin
    if (Value < 0.000000001) then
    begin
      Result := 0;
      Exit;
    end
    else if (Value < 0.00000001) then
      E := 1000000000
    else if (Value < 0.0000001) then
      E := 100000000
    else if (Value < 0.000001) then
      E := 10000000
    else if (Value < 0.00001) then
      E := 1000000
    else if (Value < 0.0001) then
      E := 100000
    else if (Value < 0.001) then
      E := 10000
    else if (Value < 0.01) then
      E := 1000
    else if (Value < 0.1) then
      E := 100
    else
      E := 10;

    E := E*DigitToValue(Digits1);

    Result := Round(Value*E) / E;
  end;

var
  E: Real;
  IsOtr: Boolean;
begin
  if (Digits1 < 0) then
    Digits1 := 0;
  if (DigitsAfterComma < 0) then
    DigitsAfterComma := 0;

  if (Value < 0) then
  begin
    IsOtr := True;
    Value := -Value;
  end
  else
    IsOtr := False;

  // Обрезаем необходимое кол-во знаков после запятой
  if (DigitsAfterComma = 0) then
    Value := Round(Value)
  else
  begin
    E := DigitToValue(DigitsAfterComma+1);
    Value := Round(Value*E) / E;
  end;

  // Округляем до указанного кол-ва значащих цифр
  if (Value < 1) then
    Result := Round2(Value)
  else if (Value < 10000) then
    Result := Round2(Value/10000)*10000
  else if (Value < 100000000) then
    Result := Round2(Value/100000000)*100000000
  else if (Value < 1000000000000) then
    Result := Round2(Value/1000000000000)*1000000000000
  else //if (Value < 10000000000000000) then
    Result := Round2(Value/10000000000000000)*10000000000000000;

  if IsOtr then
    Result := -Result;
end;

function Utils_String_ToUpper(const S: APascalString): APascalString;
begin
  Result := AStringUtils.AString_ToUpperP(S);
end;

function Utils_Trim(const S: APascalString): APascalString;
begin
  Result := SysUtils.Trim(S);
end;

function Utils_TryStrToDate(const S: APascalString; var Value: TDateTime): Boolean;
begin
  Result := SysUtils.TryStrToDate(S, Value);
end;

function Utils_TryStrToFloat(const S: APascalString; var Value: AFloat): ABoolean;
begin
  {$IFDEF AFloat32}
  Result := Utils_TryStrToFloat32(S, Value);
  {$ELSE}
  Result := Utils_TryStrToFloat64(S, Value);
  {$ENDIF}
end;

function Utils_TryStrToFloat32(const S: APascalString; var Value: AFloat32): ABoolean;
var
  Value1: Extended;
  S1: string;
begin
  S1 := SysUtils.Trim(Utils_ReplaceComma(S));
  if (S1 <> '') then
  begin
    Result := SysUtils.TryStrToFloat(S1, Value1);
    if Result then
      Value := Value1;
  end
  else
    Result := False;
end;

function Utils_TryStrToFloat64(const S: APascalString; var Value: AFloat64): ABoolean;
var
  Value1: Extended;
  S1: string;
begin
  S1 := SysUtils.Trim(Utils_ReplaceComma(S));
  if (S1 <> '') then
  begin
    Result := SysUtils.TryStrToFloat(S1, Value1);
    if Result then
      Value := Value1;
  end
  else
    Result := False;
end;

function Utils_TryStrToInt(const S: APascalString; var Value: AInteger): ABoolean;
begin
  Result := SysUtils.TryStrToInt(SysUtils.Trim(S), Value);
end;

end.
 