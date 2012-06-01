{**
@Abstract(Классы для записи собщений программы в БД или файл)
@Author(Prof1983 prof1983@ya.ru)
@Created(16.08.2005)
@LastMod(27.04.2012)
@Version(0.5)
}
unit ALogFileText;

interface

uses
  Classes, SysUtils,
  ALogDocumentImpl, ALogFileTextUtils, ATypes;

type //** Запись в файл
  TProfLogFileText3 = class(TProfLogDocument3)
  private
    //** Имя файла
    FFileName: WideString;
  public
    //** Добавить сообщение
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer; override;
    constructor Create(); //(AConfig: IProfXmlNode; AFileName: WideString);
    function Initialize(): TProfError; override; safecall;
    class function SaveLog(Err: TLogTypeMessage; AStrMsg: string; AFileName: string = ''; AFileNameOld: string = ''; AFilePath: string = ''): Boolean;
  public
    //** Имя файла
    property FileName: WideString read FFileName write FFileName;
  end;

implementation

{ TProfLogFileText }

function TProfLogFileText3.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;
var
  S: string;
begin
  inherited AddToLog(AGroup, AType, AStrMsg);
  if AStrMsg = '-' then
    S:= {CHR_LOG_GROUP_MESSAGE[AGroup] +} ': ---------------------------------------------------------------'
  else if AStrMsg = '=' then
    S:= {CHR_LOG_GROUP_MESSAGE[AGroup] +} ': ==============================================================='
  else
    S := {CHR_LOG_GROUP_MESSAGE[AGroup] +} ': ' + AStrMsg;
  SaveLog(TLogTypeMessage(AType), S, FFileName, FFileName + '.old');
  Result := 1;
end;

constructor TProfLogFileText3.Create(); //(AConfig: IProfXmlNode; AFileName: WideString);
begin
  inherited Create(); //(lFile);
  FLogType := lFile;
//  FFileName := AFileName;
  // Проверка сущестрования директории
//  ForceDirectories(ExtractFilePath(FFileName));
end;

function TProfLogFileText3.Initialize(): TProfError;
begin
  Result := inherited Initialize();
  // Проверка сущестрования директории
  ForceDirectories(ExtractFilePath(FFileName));
end;

class function TProfLogFileText3.SaveLog(Err: TLogTypeMessage; AStrMsg: string; AFileName: string = ''; AFileNameOld: string = ''; AFilePath: string = ''): Boolean;
begin
  Result := ALogFileTextUtils.SaveLog(Err, AStrMsg, AFileName, AFileNameOld, AFilePath);
end;

end.

