{**
@Abstract(AUtils functions)
@Author(Prof1983 prof1983@ya.ru)
@Created(28.09.2011)
@LastMod(26.10.2011)
@Version(0.5)
}
unit AUtilsMain;

interface

uses
  SysUtils, ABase;

// Преобразует число в строку для записи в БД (SQL). Для SQL необходим разделитель - точка.
function Utils_FloatToStrB(Value: AFloat; DigitsAfterComma: Integer = 2): APascalString; stdcall;

function Utils_FloatToStrC(Value: AFloat; DigitsAfterComma: Integer = 2): APascalString; stdcall;

function Utils_FormatFloat(Value: AFloat; DigitsBeforeComma, DigitsAfterComma: AInteger): APascalString; stdcall;

function Utils_NormalizeStrSpace(const Value: APascalString): APascalString;

{ Заменяет все точки на запятые или все запятые на точки в зависимости от региональных настроек.
  Если параметр DecimalSeparator указан, то региональные настройки игнорируются. }
function Utils_ReplaceComma(const S: APascalString; DecimalSeparator: AChar = #0; ClearSpace: ABoolean = True): APascalString; stdcall;

function Utils_String_ToLower(const S: APascalString): APascalString;

function Utils_String_ToUpper(const S: APascalString): APascalString;

{ Trims leading and trailing spaces and control characters from a string.
  Удаляет первые и последние пробелы }
function Utils_Trim(const S: APascalString): APascalString;

function Utils_TryStrToDate(const S: APascalString; var Value: TDateTime): ABoolean; stdcall;

{ Преобразует строку в Float. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
function Utils_TryStrToFloat(const S: APascalString; var Value: AFloat): ABoolean; stdcall;

{ Преобразует строку в Float32. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
function Utils_TryStrToFloat32(const S: APascalString; var Value: AFloat32): ABoolean; stdcall;

{ Преобразует строку в Float64. Разделителем может быть как точка, так и запятая.
  В исходной строке могут присутствовать начальные и конечные пробелы. }
function Utils_TryStrToFloat64(const S: APascalString; var Value: AFloat64): ABoolean; stdcall;

function Utils_TryStrToInt(const S: APascalString; var Value: AInteger): ABoolean; stdcall;

implementation

function Utils_FloatToStrB(Value: AFloat; DigitsAfterComma: AInteger): APascalString; stdcall;
begin
  Result := AUtilsMain.Utils_ReplaceComma(SysUtils.FloatToStrF(Value, ffFixed, 10, DigitsAfterComma), '.');
end;

function Utils_FloatToStrC(Value: AFloat; DigitsAfterComma: AInteger): APascalString; stdcall;
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

function Utils_FormatFloat(Value: AFloat; DigitsBeforeComma, DigitsAfterComma: AInteger): APascalString; stdcall;
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

function Utils_ReplaceComma(const S: APascalString; DecimalSeparator: AChar; ClearSpace: ABoolean): APascalString; stdcall;
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

function Utils_String_ToUpper(const S: APascalString): APascalString;
begin
  Result := SysUtils.AnsiUpperCase(S);
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
  Result := Utils_TryStrToFloat32(S, Value);
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
 