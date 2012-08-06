{**
@Abstract AUtils - Main
@Author Prof1983 <prof1983@ya.ru>
@Created 28.09.2011
@LastMod 06.08.2012
}
unit AUtilsMain;

interface

uses
  SysUtils, ABase, AStringUtils;

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

uses
  AUtils;

function Utils_ExtractFileExt(const FileName: APascalString): APascalString;
begin
  Result := SysUtils.ExtractFileExt(FileName);
end;

function Utils_ExtractFilePath(const FileName: APascalString): APascalString;
begin
  Result := SysUtils.ExtractFilePath(FileName);
end;

function Utils_FileExists(const FileName: APascalString): ABoolean;
begin
  Result := SysUtils.FileExists(FileName);
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
  Result := SysUtils.FloatToStrF(Value, ffFixed, 10, DigitsAfterComma);
end;

function Utils_FloatToStrB(Value: AFloat; DigitsAfterComma: AInteger): APascalString;
begin
  Result := AUtilsMain.Utils_ReplaceComma(Utils_FloatToStrA(Value, DigitsAfterComma), '.');
end;

function Utils_FloatToStrC(Value: AFloat; DigitsAfterComma: AInteger): APascalString;
begin
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
end;

function Utils_FloatToStrD(Value: AFloat): APascalString;
begin
  Result := SysUtils.FormatFloat(',0.00', Value);
end;

function Utils_FormatFloat(Value: AFloat; DigitsBeforeComma, DigitsAfterComma: AInteger): APascalString;
var
  FormatS: string;
begin
  if (DigitsBeforeComma >= 0) and (DigitsBeforeComma <= 9) and (DigitsAfterComma >= 0) and (DigitsAfterComma <= 9) then
  begin
    FormatS := '%' + Chr(Ord('0')+DigitsBeforeComma) + '.' + Chr(Ord('0')+DigitsAfterComma) + 'f';
    Result := Format(FormatS,[Value]);
  end
  else
    Result := Utils_FloatToStrB(Value, DigitsAfterComma);
end;

function Utils_IntToStr(Value: AInteger): APascalString;
begin
  Result := SysUtils.IntToStr(Value);
end;

function Utils_NormalizeStrSpace(const Value: APascalString): APascalString;
var
  I: Integer;
  J: Integer;
begin
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
 