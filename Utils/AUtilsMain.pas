{**
@Abstract AUtils - Main
@Author Prof1983 <prof1983@ya.ru>
@Created 28.09.2011
@LastMod 02.04.2013
}
unit AUtilsMain;

{define AStdCall}

{$I A.inc}

interface

uses
  SysUtils,
  ABase,
  AStringBaseUtils,
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

function AUtils_DirectoryExists(const Directory: AString_Type): ABool; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_DirectoryExistsP(const Directory: APascalString): ABool;

function AUtils_ExpandFileName(const FileName: AString_Type; out Res: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_ExpandFileNameP(const FileName: APascalString): APascalString;

function AUtils_ExtractFileExt(const FileName: AString_Type; out Res: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_ExtractFileExtP(const FileName: APascalString): APascalString;

function AUtils_ExtractFileName(const FileName: AString_Type; out Res: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_ExtractFileNameP(const FileName: APascalString): APascalString;

function AUtils_ExtractFilePath(const FileName: AString_Type; out Res: AString_Type): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_ExtractFilePathP(const FileName: APascalString): APascalString;

function AUtils_FileExists(const FileName: AString_Type): ABool; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_FileExistsP(const FileName: APascalString): ABool;

function AUtils_Fin(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_FloatToStr(Value: AFloat; out Res: AString_Type): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_FloatToStr2(Value: AFloat; DigitsAfterComma: AInt;
    ReplaceComma, Delimer: ABool; out Res: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_FloatToStr2P(Value: AFloat; DigitsAfterComma: AInt;
    ReplaceComma, Delimer: ABool): APascalString;

function AUtils_FloatToStrAP(Value: AFloat; DigitsAfterComma: AInt = 2): APascalString; deprecated {$ifdef ADeprText}'Use AUtils_FloatToStr2P()'{$endif};

function AUtils_FloatToStrBP(Value: AFloat; DigitsAfterComma: AInt = 2): APascalString; deprecated {$ifdef ADeprText}'Use AUtils_FloatToStr2P()'{$endif};

function AUtils_FloatToStrCP(Value: AFloat; DigitsAfterComma: AInt = 2): APascalString; deprecated {$ifdef ADeprText}'Use AUtils_FloatToStr2P()'{$endif};

function AUtils_FloatToStrDP(Value: AFloat): APascalString;

function AUtils_FloatToStrP(Value: AFloat): APascalString;

function AUtils_ForceDirectories(const Dir: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_ForceDirectoriesA(Dir: AStr): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_ForceDirectoriesP(const Dir: APascalString): AError;

function AUtils_FormatFloat(Value: AFloat; DigitsBeforeComma, DigitsAfterComma: AInt;
    out Res: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_FormatFloatP(Value: AFloat; DigitsBeforeComma, DigitsAfterComma: AInt): APascalString;

function AUtils_FormatInt(Value, Count: AInt; out Res: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_FormatIntP(Value, Count: AInt): APascalString;

function AUtils_FormatStr(const Value: AString_Type; Len: AInt; out Res: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_FormatStrAnsi(const Value: AnsiString; Len: AInt): AnsiString; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_FormatStrP(const Value: APascalString; Len: AInt): APascalString;

function AUtils_FormatStrStr(const FormatStr, S: AString_Type; out Res: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_FormatStrStrA(FormatStr, S: AStr; Res: AStr; MaxLen: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_FormatStrStrP(const FormatStr, S: APascalString): APascalString;

function AUtils_GetNowDateTime(): TDateTime; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_Init(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_IntToStr(Value: AInt; out Res: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_IntToStrP(Value: AInt): APascalString;

function AUtils_NormalizeFloat(Value: AFloat): AFloat; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_NormalizeStr(const Value: AString_Type; out Res: AString_Type): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_NormalizeStrP(const Value: APascalString): APascalString;

function AUtils_NormalizeStrSpace(const Value: AString_Type; out Res: AString_Type): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_NormalizeStrSpaceP(const Value: APascalString): APascalString;

function AUtils_Power(Base, Exponent: AFloat): AFloat; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_ReplaceComma(const S: AString_Type; DecimalSeparator: AChar;
    ClearSpace: ABool; out Res: AString_Type): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_ReplaceCommaP(const S: APascalString; DecimalSeparator: AChar = #0;
    ClearSpace: ABool = True): APascalString;

function AUtils_Round2(Value: AFloat; Digits1, DigitsAfterComma: AInt): AFloat; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_Sleep(Milliseconds: AUInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_StrToDate(const Value: AString_Type): TDateTime; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_StrToDateP(const Value: APascalString): TDateTime;

function AUtils_StrToFloat(const Value: AString_Type): AFloat; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_StrToFloatDef(const S: AString_Type; DefValue: AFloat): AFloat; {$ifdef AStdCall}stdcall;{$endif}

{** Преобразует строку в Float. Разделителем может быть как точка, так и запятая.
    В исходной строке могут присутствовать начальные и конечные пробелы. }
function AUtils_StrToFloatDefP(const S: APascalString; DefValue: AFloat): AFloat;

function AUtils_StrToFloatP(const Value: APascalString): AFloat;

function AUtils_StrToInt(const Value: AString_Type): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_StrToIntDef(const S: AString_Type; DefValue: AInt): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_StrToIntDefP(const S: APascalString; DefValue: AInt): AInt;

function AUtils_StrToIntP(const Value: APascalString): AInt;

function AUtils_Trim(var S: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_TrimP(const S: APascalString): APascalString;

function AUtils_TryStrToDate(const S: AString_Type; var Value: TDateTime): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_TryStrToDateP(const S: APascalString; var Value: TDateTime): ABool;

{** Преобразует строку в Float. Разделителем может быть как точка, так и запятая.
    В исходной строке могут присутствовать начальные и конечные пробелы. }
function AUtils_TryStrToFloatP(const S: APascalString; var Value: AFloat): ABool;

function AUtils_TryStrToFloat32(const S: AString_Type; var Value: AFloat32): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Преобразует строку в Float32. Разделителем может быть как точка, так и запятая.
    В исходной строке могут присутствовать начальные и конечные пробелы. }
function AUtils_TryStrToFloat32P(const S: APascalString; var Value: AFloat32): ABool;

function AUtils_TryStrToFloat64(const S: AString_Type; var Value: AFloat64): AError; {$ifdef AStdCall}stdcall;{$endif}

{** Преобразует строку в Float64. Разделителем может быть как точка, так и запятая.
    В исходной строке могут присутствовать начальные и конечные пробелы. }
function AUtils_TryStrToFloat64P(const S: APascalString; var Value: AFloat64): ABool;

function AUtils_TryStrToInt(const S: AString_Type; var Value: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AUtils_TryStrToIntP(const S: APascalString; var Value: AInt): ABool;

function AUtils_StrToUpperP(const S: APascalString): APascalString;

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

function _FormatFloat(Value: AFloat; Digits, DigitsAfterComma: AInt): APascalString;
var
  FormatS: string;
begin
  if (Digits < 0) or (Digits > 99) or (DigitsAfterComma < 0) or (DigitsAfterComma > 9) then
  begin
    Result := AUtils_FloatToStr2P(Value, DigitsAfterComma, True, False);
    Exit;
  end;

  if (Digits >= 10) then
    FormatS := '%' + Chr(Ord('0')+(Digits div 10)) + Chr(Ord('0')+(Digits mod 10)) + '.' + Chr(Ord('0')+DigitsAfterComma) + 'f'
  else
    FormatS := '%' + Chr(Ord('0')+Digits) + '.' + Chr(Ord('0')+DigitsAfterComma) + 'f';
  Result := Format(FormatS, [Value]);
end;

{** Заменяет все точки на запятые или все запятые на точки в зависимости от региональных настроек.
    Если параметр DecimalSeparator указан, то региональные настройки игнорируются. }
function _ReplaceComma(const S: APascalString; DecimalSeparator: AChar; ClearSpace: ABool): APascalString;
var
  ic: Integer;
  SS: APascalString;
begin
  if (DecimalSeparator = #0) then
  begin
    {$ifdef DelphiXEUp}
    DecimalSeparator := AChar(FormatSettings.DecimalSeparator);
    {$else}
    DecimalSeparator := AChar(SysUtils.DecimalSeparator);
    {$endif}
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

function AUtils_DirectoryExists(const Directory: AString_Type): ABool;
begin
  Result := AUtils_DirectoryExistsP(AString_ToPascalString(Directory));
end;

function AUtils_DirectoryExistsP(const Directory: APascalString): ABool;
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

function AUtils_ExtractFileExt(const FileName: AString_Type; out Res: AString_Type): AError;
begin
  try
    Result := AString_AssignP(Res,
        AUtils_ExtractFileExtP(AString_ToPascalString(FileName))
        );
  except
    Result := -1;
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

function AUtils_ExtractFilePath(const FileName: AString_Type; out Res: AString_Type): AInt;
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

function AUtils_FileExists(const FileName: AString_Type): ABool;
begin
  try
    Result := AUtils_FileExistsP(AString_ToPascalString(FileName));
  except
    Result := False;
  end;
end;

function AUtils_FileExistsP(const FileName: APascalString): ABool;
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

function AUtils_FloatToStr(Value: AFloat; out Res: AString_Type): AInt;
begin
  try
    Result := AString_AssignP(Res, AUtils_FloatToStrP(Value));
  except
    Result := 0;
  end;
end;

function AUtils_FloatToStr2(Value: AFloat; DigitsAfterComma: AInt;
    ReplaceComma, Delimer: ABool; out Res: AString_Type): AError;
var
  S: APascalString;
begin
  S := AUtils_FloatToStr2P(Value, DigitsAfterComma, ReplaceComma, Delimer);
  Result := AString_AssignP(Res, S);
end;

function AUtils_FloatToStr2P(Value: AFloat; DigitsAfterComma: AInt;
    ReplaceComma, Delimer: ABool): APascalString;
var
  S: APascalString;
begin
  try
    if Delimer then
    begin
      case DigitsAfterComma of
        0: S := SysUtils.FormatFloat('### ### ### ##0', Value);
        1: S := SysUtils.FormatFloat('### ### ### ##0.0', Value);
        2: S := SysUtils.FormatFloat('### ### ### ##0.00', Value);
        3: S := SysUtils.FormatFloat('### ### ### ##0.000', Value);
        4: S := SysUtils.FormatFloat('### ### ### ##0.0000', Value);
        5: S := SysUtils.FormatFloat('### ### ### ##0.00000', Value);
      else
        S := SysUtils.FormatFloat('### ### ### ##0.00', Value);
      end;
    end
    else
      S := SysUtils.FloatToStrF(Value, ffFixed, 10, DigitsAfterComma);
    if ReplaceComma then
      Result := _ReplaceComma(S, '.', True)
    else
      Result := S;
  except
    Result := '';
  end;
end;

function AUtils_FloatToStrAP(Value: AFloat; DigitsAfterComma: AInt): APascalString;
begin
  Result := AUtils_FloatToStr2P(Value, DigitsAfterComma, False, False);
end;

function AUtils_FloatToStrBP(Value: AFloat; DigitsAfterComma: AInt): APascalString;
begin
  Result := AUtils_FloatToStr2P(Value, DigitsAfterComma, True, False);
end;

function AUtils_FloatToStrCP(Value: AFloat; DigitsAfterComma: AInt): APascalString;
begin
  Result := AUtils_FloatToStr2P(Value, DigitsAfterComma, False, True);
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

function AUtils_ForceDirectories(const Dir: AString_Type): AError;
begin
  Result := AUtils_ForceDirectoriesP(AString_ToPascalString(Dir));
end;

function AUtils_ForceDirectoriesA(Dir: AStr): AError;
begin
  Result := AUtils_ForceDirectoriesP(Dir);
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

function AUtils_FormatFloat(Value: AFloat; DigitsBeforeComma, DigitsAfterComma: AInt;
    out Res: AString_Type): AError;
begin
  try
    Result := AString_AssignP(Res, AUtils_FormatFloatP(Value, DigitsBeforeComma, DigitsAfterComma));
  except
    Result := 0;
  end;
end;

function AUtils_FormatFloatP(Value: AFloat; DigitsBeforeComma, DigitsAfterComma: AInt): APascalString;
begin
  try
    if (DigitsAfterComma > 0) then
      Inc(DigitsAfterComma);
    Result := _FormatFloat(Value, DigitsBeforeComma + DigitsAfterComma, DigitsAfterComma);
  except
    Result := '';
  end;
end;

function AUtils_FormatInt(Value, Count: AInt; out Res: AString_Type): AError;
begin
  try
    Result := AString_AssignP(Res, AUtils_FormatIntP(Value, Count));
  except
    Result := -1;
  end;
end;

function AUtils_FormatIntP(Value, Count: AInt): APascalString;
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

function AUtils_FormatStr(const Value: AString_Type; Len: AInt; out Res: AString_Type): AError;
begin
  try
    Result := AString_AssignP(Res,
        AUtils_FormatStrP(AString_ToPascalString(Value), Len)
        );
  except
    Result := -1;
  end;
end;

function AUtils_FormatStrAnsi(const Value: AnsiString; Len: AInt): AnsiString;
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

function AUtils_FormatStrP(const Value: APascalString; Len: AInt): APascalString;
begin
  try
    Result := APascalString(AUtils_FormatStrAnsi(AnsiString(Value), Len));
  except
    Result := '';
  end;
end;

function AUtils_FormatStrStr(const FormatStr, S: AString_Type; out Res: AString_Type): AError;
begin
  Result := AString_AssignP(Res, AUtils_FormatStrStrP(AString_ToPascalString(FormatStr), AString_ToPascalString(S)));
end;

function AUtils_FormatStrStrA(FormatStr, S: AStr; Res: AStr; MaxLen: AInt): AError;
var
  SRes: APascalString;
begin
  SRes := AUtils_FormatStrStrP(AStr_ToPascalString(FormatStr), AStr_ToPascalString(S));
  Result := AStr_AssignP(Res, SRes, MaxLen);
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

function AUtils_IntToStr(Value: AInt; out Res: AString_Type): AError;
begin
  try
    Result := AString_AssignP(Res, AUtils_IntToStrP(Value));
  except
    Result := -1;
  end;
end;

function AUtils_IntToStrP(Value: AInt): APascalString;
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
    Result := AUtils_StrToFloatP(AUtils_FloatToStr2P(Value, 2, False, False));
  except
    Result := 0;
  end;
end;

function AUtils_NormalizeStr(const Value: AString_Type; out Res: AString_Type): AInt;
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

function AUtils_NormalizeStrSpace(const Value: AString_Type; out Res: AString_Type): AInt;
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
    ClearSpace: ABool; out Res: AString_Type): AInt;
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
    ClearSpace: ABool): APascalString;
begin
  try
    Result := _ReplaceComma(S, DecimalSeparator, ClearSpace);
  except
    Result := '';
  end;
end;

function AUtils_Round2(Value: AFloat; Digits1, DigitsAfterComma: AInt): AFloat;
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

function AUtils_StrToDate(const Value: AString_Type): TDateTime;
begin
  try
    Result := AUtils_StrToDateP(AString_ToPascalString(Value));
  except
    Result := 0;
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

function AUtils_StrToFloat(const Value: AString_Type): AFloat;
begin
  try
    Result := AUtils_StrToFloatP(AString_ToPascalString(Value));
  except
    Result := 0;
  end;
end;

function AUtils_StrToFloatDef(const S: AString_Type; DefValue: AFloat): AFloat;
begin
  try
    Result := AUtils_StrToFloatDefP(AString_ToPascalString(S), DefValue);
  except
    Result := DefValue;
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

function AUtils_StrToInt(const Value: AString_Type): AInt;
begin
  try
    Result := AUtils_StrToIntP(AString_ToPascalString(Value));
  except
    Result := 0;
  end;
end;

function AUtils_StrToIntDef(const S: AString_Type; DefValue: AInt): AInt;
begin
  try
    Result := AUtils_StrToIntDefP(AString_ToPascalString(S), DefValue);
  except
    Result := DefValue;
  end;
end;

function AUtils_StrToIntDefP(const S: APascalString; DefValue: AInt): AInt;
begin
  try
    if not(AUtils_TryStrToIntP(S, Result)) then
      Result := DefValue;
  except
    Result := DefValue;
  end;
end;

function AUtils_StrToIntP(const Value: APascalString): AInt;
begin
  if not(AUtils_TryStrToIntP(Value, Result)) then
    Result := 0;
end;

function AUtils_Trim(var S: AString_Type): AError;
begin
  try
    Result := AString_AssignP(S, SysUtils.Trim(AString_ToPascalString(S)));
  except
    Result := -1;
  end;
end;

function AUtils_TrimP(const S: APascalString): APascalString;
begin
  try
    Result := SysUtils.Trim(S);
  except
    Result := '';
  end;
end;

function AUtils_TryStrToDate(const S: AString_Type; var Value: TDateTime): AError;
begin
  try
    if AUtils_TryStrToDateP(AString_ToPascalString(S), Value) then
      Result := 0
    else
      Result := -2;
  except
    Result := -1;
  end;
end;

function AUtils_TryStrToDateP(const S: APascalString; var Value: TDateTime): ABool;
begin
  try
    Result := SysUtils.TryStrToDate(S, Value);
  except
    Result := False;
  end;
end;

function AUtils_TryStrToFloat32(const S: AString_Type; var Value: AFloat32): AError;
begin
  try
    if AUtils_TryStrToFloat32P(AString_ToPascalString(S), Value) then
      Result := 0
    else
      Result := -2;
  except
    Result := -1;
  end;
end;

function AUtils_TryStrToFloat32P(const S: APascalString; var Value: AFloat32): ABool;
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

function AUtils_TryStrToFloat64(const S: AString_Type; var Value: AFloat64): AError;
begin
  try
    if AUtils_TryStrToFloat64P(AString_ToPascalString(S), Value) then
      Result := 0
    else
      Result := -2;
  except
    Result := -1;
  end;
end;

function AUtils_TryStrToFloat64P(const S: APascalString; var Value: AFloat64): ABool;
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

function AUtils_TryStrToFloatP(const S: APascalString; var Value: AFloat): ABool;
begin
  {$ifdef AFloat32}
  Result := AUtils_TryStrToFloat32P(S, Value);
  {$else}
  Result := AUtils_TryStrToFloat64P(S, Value);
  {$endif}
end;

function AUtils_TryStrToInt(const S: AString_Type; var Value: AInt): AError;
begin
  try
    if AUtils_TryStrToIntP(AString_ToPascalString(S), Value) then
      Result := 0
    else
      Result := -2;
  except
    Result := -1;
  end;
end;

function AUtils_TryStrToIntP(const S: APascalString; var Value: AInt): ABool;
begin
  try
    Result := SysUtils.TryStrToInt(SysUtils.Trim(S), Value);
  except
    Result := False;
  end;
end;

function AUtils_StrToUpperP(const S: APascalString): APascalString;
begin
  try
    Result := SysUtils.UpperCase(S);
  except
    Result := '';
  end;
end;

end.
 