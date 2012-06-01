{**
@Abstract(Функции для работы с текстовыми лог-файлами)
@Author(Prof1983 prof1983@ya.ru)
@Created(20.03.2012)
@LastMod(26.04.2012)
@Version(0.5)
}
unit ALogFileTextUtils;

interface

uses
  Classes, SysUtils,
  ATypes;

function SaveLog(Err: TLogTypeMessage; AStrMsg: string; AFileName: string = ''; AFileNameOld: string = ''; AFilePath: string = ''): Boolean;

implementation

{ Private }

procedure CopyOneFile(const Src, Target: String);
var
  S: TFileStream;
  T: TFileStream;
begin
  try
  S := TFileStream.Create(Src, fmOpenRead);
  try
    T := TFileStream.Create(Target, fmOpenWrite or fmCreate);
    try
      T.CopyFrom(S, S.Size)
    finally
      FreeAndNil(T);
    end;
  finally
    FreeAndNil(S);
  end;
  except
  end;
end;

{ Public }

function SaveLog(Err: TLogTypeMessage; AStrMsg: string; AFileName: string = ''; AFileNameOld: string = ''; AFilePath: string = ''): Boolean;
var
  ErrorIni: TextFile;
  SearchRec: TSearchRec;
  Res: LongInt;
  DT: string;
  dir: string;
begin
  Result := False;
  try
    if AFileName = '' then
      AFileName := ChangeFileExt(ExtractFileName(ParamStr(0)), '.log');
    if AFileNameOld = '' then
      AFileNameOld := AFileName + '.old';

    if (Length(AStrMsg) = 1) then
      if (AStrMsg[1] = '=') then
        AStrMsg := '============================================================='
      else if (AStrMsg[1] = '-') then
        AStrMsg := '-------------------------------------------------------------';

    if ExtractFilePath(AFileName) = '' then
    begin
      dir := ExtractFilePath(ParamStr(0));
      AFileName := dir + AFileName;
    end
    else
    begin
      dir := ExtractFilePath(AFileName);
      ChDir(dir);
    end;
    if ExtractFilePath(AFileNameOld) = '' then
      AFileNameOld := dir + AFileNameOld
    else
    begin
      ChDir(ExtractFilePath(AFileNameOld));
    end;

    Res := FindFirst(AFileName, faAnyFile, SearchRec);
    if (Res = 0) then
    try
      if (SearchRec.Size > 500000) then
      begin
        if FileExists(AFileNameOld) then DeleteFile(PChar(AFileNameOld));
        CopyOneFile(SearchRec.Name, AFileNameOld);
        if FileExists(AFileName) then DeleteFile(PChar(AFileName));
      end;
    finally
      SysUtils.FindClose(SearchRec);
    end;

    // запись сообщений в LOG файл
    AssignFile(ErrorIni, AFileName);
    {$I-}
    if FileExists(AFileName) then
      Append(ErrorIni)
    else
      ReWrite(ErrorIni);
    {$I+}
    if IOResult <> 0 then Exit;

    DT := FormatDateTime('yyyy.mm.dd hh:nn:ss:zzzz', Now);
    case err of
      ltNone:        Writeln(ErrorIni, DT+' '+AStrMsg);
      ltWarning:     WriteLn(ErrorIni, DT+' WARNING '+AStrMsg);
      ltInformation: WriteLn(ErrorIni, DT+' INFO    '+AStrMsg);
      ltError:       WriteLn(ErrorIni, DT+' ERROR   '+AStrMsg);
    else
      WriteLn(ErrorIni, DT+' UNCNOWN('+IntToStr(Integer(err))+') '+AStrMsg);
    end;
    CloseFile(ErrorIni);
    Result := True;
  except
    Result := False;
    //on E: Exception do
    //  ShowError(0, 'Ошибка при записи логов', '"%s" <%s.%s>', [E.Message, 'unProfGlobals', 'SaveLog']);
  end;
end;

end.
