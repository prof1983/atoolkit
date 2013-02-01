{**
@Abstract AUtils - Main
@Author Prof1983 <prof1983@ya.ru>
@Created 28.09.2011
@LastMod 29.01.2013
}
unit AUtilsMain;

{define AStdCall}

interface

uses
  SysUtils,
  ABase,
  AStringMain,
  AStringUtils,
  ASystemMain;

// --- AUtils ---

function AUtils_ChangeFileExt(const FileName, Extension: AString_Type;
    out Res: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_ChangeFileExtP(const FileName, Extension: APascalString): APascalString;

function AUtils_DateToStr(Value: TDateTime; out Res: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_DateToStrP(Value: TDateTime): APascalString;

function AUtils_DeleteFile(const FileName: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_DeleteFileP(const FileName: APascalString): AError;

function AUtils_DirectoryExists(const Directory: AString_Type): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_DirectoryExistsP(const Directory: APascalString): ABoolean;

function AUtils_ExpandFileName(const FileName: AString_Type; out Res: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_ExpandFileNameP(const FileName: APascalString): APascalString;

function AUtils_ExtractFileExt(const FileName: AString_Type; out Res: AString_Type): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_ExtractFileExtP(const FileName: APascalString): APascalString;

function AUtils_ExtractFileName(const FileName: AString_Type; out Res: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_ExtractFileNameP(const FileName: APascalString): APascalString;

function AUtils_ExtractFilePath(const FileName: AString_Type; out Res: AString_Type): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_ExtractFilePathP(const FileName: APascalString): APascalString;

function AUtils_FileExists(const FileName: AString_Type): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_FileExistsP(const FileName: APascalString): ABoolean;

function AUtils_Fin(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_FloatToStr(Value: AFloat; out Res: AString_Type): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_FloatToStr2(Value: AFloat; DigitsAfterComma: AInteger;
    ReplaceComma, Delimer: ABoolean; out Res: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_FloatToStr2P(Value: AFloat; DigitsAfterComma: AInteger;
    ReplaceComma, Delimer: ABoolean): APascalString;

function AUtils_FloatToStrAP(Value: AFloat; DigitsAfterComma: AInteger = 2): APascalString;

function AUtils_FloatToStrBP(Value: AFloat; DigitsAfterComma: Integer = 2): APascalString;

function AUtils_FloatToStrCP(Value: AFloat; DigitsAfterComma: Integer = 2): APascalString;

function AUtils_FloatToStrDP(Value: AFloat): APascalString;

function AUtils_FloatToStrP(Value: AFloat): APascalString;

function AUtils_ForceDirectoriesP(const Dir: APascalString): AError;

function AUtils_FormatFloat(Value: AFloat; Count, Digits: AInteger;
    out Res: AString_Type): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_FormatFloatP(Value: AFloat; DigitsBeforeComma, DigitsAfterComma: AInteger): APascalString;

function AUtils_FormatInt(Value, Count: AInteger; out Res: AString_Type): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_FormatIntP(Value, Count: AInteger): APascalString;

function AUtils_FormatStr(const Value: AString_Type; Len: AInteger; out Res: AString_Type): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_FormatStrAnsi(const Value: AnsiString; Len: AInteger): AnsiString; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_FormatStrP(const Value: APascalString; Len: AInteger): APascalString;

function AUtils_FormatStrStrP(const FormatStr, S: APascalString): APascalString;

function AUtils_GetNowDateTime(): TDateTime; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_Init(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_IntToStr(Value: AInteger; out Res: AString_Type): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_IntToStrP(Value: AInteger): APascalString;

function AUtils_NormalizeFloat(Value: AFloat): AFloat; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_NormalizeStr(const Value: AString_Type; out Res: AString_Type): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_NormalizeStrP(const Value: APascalString): APascalString;

function AUtils_NormalizeStrSpace(const Value: AString_Type; out Res: AString_Type): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_NormalizeStrSpaceP(const Value: APascalString): APascalString;

function AUtils_Power(Base, Exponent: AFloat): AFloat; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_ReplaceComma(const S: AString_Type; DecimalSeparator: AChar;
    ClearSpace: ABoolean; out Res: AString_Type): AInteger; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_ReplaceCommaP(const S: APascalString; DecimalSeparator: AChar = #0;
    ClearSpace: ABoolean = True): APascalString;

function AUtils_Round2(Value: Real; Digits1, DigitsAfterComma: Integer): Real; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_Sleep(Milliseconds: AUInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_StrToDateP(const Value: APascalString): TDateTime;

{** Преобразует строку в Float. Разделителем может быть как точка, так и запятая.
    В исходной строке могут присутствовать начальные и конечные пробелы. }
function AUtils_StrToFloatDefP(const S: APascalString; DefValue: AFloat): AFloat;

function AUtils_StrToFloatP(const Value: APascalString): AFloat;

function AUtils_StrToIntDefP(const S: APascalString; DefValue: AInteger): AInteger;

function AUtils_StrToIntP(const Value: APascalString): AInteger;

function AUtils_TrimP(const S: APascalString): APascalString;

function AUtils_TryStrToDateP(const S: APascalString; var Value: TDateTime): ABoolean;

{** Преобразует строку в Float. Разделителем может быть как точка, так и запятая.
    В исходной строке могут присутствовать начальные и конечные пробелы. }
function AUtils_TryStrToFloatP(const S: APascalString; var Value: AFloat): ABoolean;

{** Преобразует строку в Float32. Разделителем может быть как точка, так и запятая.
    В исходной строке могут присутствовать начальные и конечные пробелы. }
function AUtils_TryStrToFloat32P(const S: APascalString; var Value: AFloat32): ABoolean;

{** Преобразует строку в Float64. Разделителем может быть как точка, так и запятая.
    В исходной строке могут присутствовать начальные и конечные пробелы. }
function AUtils_TryStrToFloat64P(const S: APascalString; var Value: AFloat64): ABoolean;

function AUtils_TryStrToIntP(const S: APascalString; var Value: AInteger): ABoolean;

implementation

// --- Private ---

function _DigitToValue(Digits: Integer): Integer;
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

{** Заменяет все точки на запятые или все запятые на точки в зависимости от региональных настроек.
    Если параметр DecimalSeparator указан, то региональные настройки игнорируются. }
function _ReplaceComma(const S: APascalString; DecimalSeparator: AChar; ClearSpace: ABoolean): APascalString;
//function Utils_ReplaceComma(const S: APascalString; DecimalSeparator: AChar = #0; ClearSpace: ABoolean = True): APascalString;
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

{** Округляем до указанного кол-ва значащих цифр }
function _Round1(Value: Real; Digits1: AInt): Real;
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

  E := E * _DigitToValue(Digits1);

  Result := Round(Value*E) / E;
end;

{** Округляет значение до указанного кол-ва значащих цифр и обрезает до указанного кол-ва знаков после запятой.
    @param Digits1 - кол-во значащих цифр (Meaning numbers)
    @param DigitsAfterComma - максимально необходимое кол-во знаков после запятой (Numbers after a comma) }
function _Round2(Value: Real; Digits1, DigitsAfterComma: Integer): Real;
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
    E := _DigitToValue(DigitsAfterComma+1);
    Value := Round(Value*E) / E;
  end;

  // Округляем до указанного кол-ва значащих цифр
  if (Value < 1) then
    Result := _Round1(Value, Digits1)
  else if (Value < 10000) then
    Result := _Round1(Value/10000,Digits1)*10000
  else if (Value < 100000000) then
    Result := _Round1(Value/100000000,Digits1)*100000000
  else if (Value < 1000000000000) then
    Result := _Round1(Value/1000000000000,Digits1)*1000000000000
  else //if (Value < 10000000000000000) then
    Result := _Round1(Value/10000000000000000,Digits1)*10000000000000000;

  if IsOtr then
    Result := -Result;
end;

// --- AUtils ---

function AUtils_ChangeFileExt(const FileName, Extension: AString_Type;
    out Res: AString_Type): AError;
var
  S: APascalString;
begin
  S := AUtils_ChangeFileExtP(AString_ToPascalString(FileName), AString_ToPascalString(Extension));
  Result := AString_AssignP(Res, S);
end;

function AUtils_ChangeFileExtP(const FileName, Extension: APascalString): APascalString;
begin
  try
    Result := SysUtils.ChangeFileExt(FileName, Extension);
  except
    Result := '';
  end;
end;

function AUtils_DateToStr(Value: TDateTime; out Res: AString_Type): AError;
var
  S: APascalString;
begin
  S := AUtils_DateToStrP(Value);
  Result := AString_AssignP(Res, S);
end;

function AUtils_DateToStrP(Value: TDateTime): APascalString;
begin
  try
    Result := SysUtils.DateToStr(Value);
  except
    Result := '';
  end;
end;

function AUtils_DeleteFile(const FileName: AString_Type): AError;
begin
  Result := AUtils_DeleteFileP(AString_ToPascalString(FileName));
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

function AUtils_DirectoryExists(const Directory: AString_Type): ABoolean;
begin
  Result := AUtils_DirectoryExistsP(AString_ToPascalString(Directory));
end;

function AUtils_DirectoryExistsP(const Directory: APascalString): ABoolean;
begin
  try
    Result := SysUtils.DirectoryExists(Directory);
  except
    Result := False;
  end;
end;

function AUtils_ExpandFileName(const FileName: AString_Type; out Res: AString_Type): AError;
var
  S: APascalString;
begin
  S := AUtils_ExpandFileNameP(AString_ToPascalString(FileName));
  Result := AString_AssignP(Res, S);
end;

function AUtils_ExpandFileNameP(const FileName: APascalString): APascalString;
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

function AUtils_ExtractFileName(const FileName: AString_Type; out Res: AString_Type): AError;
var
  S: APascalString;
begin
  S := AUtils_ExtractFileNameP(AString_ToPascalString(FileName));
  Result := AString_AssignP(Res, S);
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

function AUtils_FloatToStr2(Value: AFloat; DigitsAfterComma: AInteger;
    ReplaceComma, Delimer: ABoolean; out Res: AString_Type): AError;
var
  S: APascalString;
begin
  S := AUtils_FloatToStr2P(Value, DigitsAfterComma, ReplaceComma, Delimer);
  Result := AString_AssignP(Res, S);
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

function AUtils_FloatToStrAP(Value: AFloat; DigitsAfterComma: AInteger): APascalString;
begin
  try
    Result := SysUtils.FloatToStrF(Value, ffFixed, 10, DigitsAfterComma);
  except
    Result := '';
  end;
end;

function AUtils_FloatToStrBP(Value: AFloat; DigitsAfterComma: AInteger): APascalString;
begin
  try
    Result := _ReplaceComma(AUtils_FloatToStrAP(Value, DigitsAfterComma), '.', True);
  except
    Result := '';
  end;
end;

function AUtils_FloatToStrCP(Value: AFloat; DigitsAfterComma: AInteger): APascalString;
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

function AUtils_FloatToStrDP(Value: AFloat): APascalString;
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

function AUtils_ForceDirectoriesP(const Dir: APascalString): AError;
begin
  try
    if ForceDirectories(Dir) then
      Result := 0
    else
      Result := -2;
  except
    Result := -1;
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
      Result := AUtils_FloatToStrBP(Value, DigitsAfterComma);
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
    Result := APascalString(AUtils_FormatStrAnsi(AnsiString(Value), Len));
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

function AUtils_GetNowDateTime(): TDateTime;
begin
  try
    Result := SysUtils.Now();
  except
    Result := 0;
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

function AUtils_NormalizeStrSpaceP(const Value: APascalString): APascalString;
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
    Result := _ReplaceComma(S, DecimalSeparator, ClearSpace);
  except
    Result := '';
  end;
end;

function AUtils_Round2(Value: Real; Digits1, DigitsAfterComma: Integer): Real;
begin
  try
    Result := _Round2(Value, Digits1, DigitsAfterComma);
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

function AUtils_StrToDateP(const Value: APascalString): TDateTime;
begin
  try
    Result := SysUtils.StrToDate(Value);
  except
    Result := 0;
  end;
end;

function AUtils_StrToFloatDefP(const S: APascalString; DefValue: AFloat): AFloat;
var
  Value: AFloat64;
begin
  if AUtils_TryStrToFloat64P(S, Value) then
    Result := Value
  else
    Result := DefValue;
end;

function AUtils_StrToFloatP(const Value: APascalString): AFloat;
begin
  if not(AUtils_TryStrToFloatP(Value, Result)) then
    Result := 0;
end;

function AUtils_StrToIntDefP(const S: APascalString; DefValue: AInteger): AInteger;
begin
  try
    if not(AUtils_TryStrToIntP(S, Result)) then
      Result := DefValue;
  except
    Result := DefValue;
  end;
end;

function AUtils_StrToIntP(const Value: APascalString): AInteger;
begin
  if not(AUtils_TryStrToIntP(Value, Result)) then
    Result := 0;
end;

function AUtils_TrimP(const S: APascalString): APascalString;
begin
  try
    Result := SysUtils.Trim(S);
  except
    Result := '';
  end;
end;

function AUtils_TryStrToDateP(const S: APascalString; var Value: TDateTime): ABoolean;
begin
  try
    Result := SysUtils.TryStrToDate(S, Value);
  except
    Result := False;
  end;
end;

function AUtils_TryStrToFloatP(const S: APascalString; var Value: AFloat): ABoolean;
begin
  {$IFDEF AFloat32}
  Result := AUtils_TryStrToFloat32P(S, Value);
  {$ELSE}
  Result := AUtils_TryStrToFloat64P(S, Value);
  {$ENDIF}
end;

function AUtils_TryStrToFloat32P(const S: APascalString; var Value: AFloat32): ABoolean;
var
  Value1: Extended;
  S1: string;
begin
  try
    S1 := SysUtils.Trim(_ReplaceComma(S, #0, True));
    if (S1 <> '') then
    begin
      Result := SysUtils.TryStrToFloat(S1, Value1);
      if Result then
        Value := Value1;
    end
    else
      Result := False;
  except
    Result := False;
  end;
end;

function AUtils_TryStrToFloat64P(const S: APascalString; var Value: AFloat64): ABoolean;
var
  Value1: Extended;
  S1: string;
begin
  try
    S1 := SysUtils.Trim(_ReplaceComma(S, #0, True));
    if (S1 <> '') then
    begin
      Result := SysUtils.TryStrToFloat(S1, Value1);
      if Result then
        Value := Value1;
    end
    else
      Result := False;
  except
    Result := False;
  end;
end;

function AUtils_TryStrToIntP(const S: APascalString; var Value: AInteger): ABoolean;
begin
  try
    Result := SysUtils.TryStrToInt(SysUtils.Trim(S), Value);
  except
    Result := False;
  end;
end;

end.
 