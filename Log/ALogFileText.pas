{**
@Abstract(Классы для записи собщений программы в БД или файл)
@Author(Prof1983 <prof1983@ya.ru>)
@Created(16.08.2005)
@LastMod(13.07.2012)

Uses
  @link ABase
  @link ALogDocumentImpl
  @link ALogFileTextUtils
  @link ATypes
}
unit ALogFileText;

interface

uses
  Classes, SysUtils,
  ABase, ALogDocumentImpl, ALogFileTextUtils, ATypes;

type //** Запись в файл
  TProfLogFileText3 = class(TALogDocument)
  private
    //** Имя файла
    FFileName: WideString;
  public
    //** Добавить сообщение
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer; override;
    function Initialize(): AError; override;
    class function SaveLog(Err: TLogTypeMessage; AStrMsg: string; AFileName: string = ''; AFileNameOld: string = ''; AFilePath: string = ''): Boolean;
  public
    constructor Create();
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

constructor TProfLogFileText3.Create();
begin
  inherited Create(lFile);
end;

function TProfLogFileText3.Initialize(): AError;
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

