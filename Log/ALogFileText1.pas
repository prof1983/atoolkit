{**
@Abstract(Классы для записи собщений программы в БД или файл)
@Author(Prof1983 prof1983@ya.ru)
@Created(16.08.2005)
@LastMod(25.02.2009)
@Version(0.0.5)
}
unit LogFileText;

interface

uses
  Classes, SysUtils, ABase, ABaseIntf;

type
  //** @abstract(Запись в файл)
  TALogFileText = class(TInterfacedObject, IALogger)
  private
    FFile: TFileStream;
    // Имя файла
    FFileName: AString;
  public
    //** Добавить сообщение
    function AddToLog(const Msg, Params: AString): Integer;
    constructor Create(FileName: AString);
    destructor Destroy; override;
    function Initialize: Integer;
  public
    //** Имя файла
    property FileName: AString read FFileName write FFileName;
  end;

implementation

{procedure CopyOneFile(const Src, Target: String);
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
end;}

{ TProfLogFileText }

function TALogFileText.AddToLog(const Msg, Params: WideString): Integer;
var
  S: string;
begin
  if (Msg = '-') then
    S:= '---------------------------------------------------------------'
  else if (Msg = '=') then
    S:= '==============================================================='
  else
    S := Msg;
  S := S + #13#10;
  if Assigned(FFile) then
    FFile.Write(S[1], Length(S));
  Result := 1;
end;

constructor TALogFileText.Create(FileName: AString);
begin
  inherited Create();
  FFileName := FileName;
end;

destructor TALogFileText.Destroy;
begin
  FFile.Free();
  FFile := nil;
  inherited;
end;

function TALogFileText.Initialize: Integer;
begin
  // Проверка сущестрования директории
  ForceDirectories(ExtractFilePath(FFileName));
  FFile := TFileStream.Create(FileName, fmCreate);
  Result := 0;
end;

(*class function TALogFileText.SaveLog(Err: TLogTypeMessage; AStrMsg: string; AFileName: string = ''; AFileNameOld: string = ''; AFilePath: string = ''): Boolean;
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
end;*)

end.

