{**
@Abstract(Классы для записи собщений программы в БД или файл)
@Author(Prof1983 prof1983@ya.ru)
@Created(16.08.2005)
@LastMod(03.07.2012)
@Version(0.5)
}
unit ALogFile;

// TODO: Use ALogFileText.pas

interface

uses
  SysUtils,
  ALogDocumentImpl, ALogFileTextUtils, ALogGlobals, ATypes, AXmlNodeIntf;

type //** Запись в файл
  TLogFileText = class(TALogDocument)
  private
    FFileName: WideString;
  public
      //** Записывает сообщение в файл
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; override;
    constructor Create(AConfig: IProfXmlNode2; AFileName: WideString);
  public
      //** Имя файла
    property FileName: WideString read FFileName write FFileName;
  end;

implementation

{ TLogFileText }

function TLogFileText.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
  const AStrMsg: WideString): Integer;
var
  S: string;
begin
  if (AStrMsg = '-') then
    S:= CHR_LOG_GROUP_MESSAGE[AGroup] + ': ---------------------------------------------------------------'
  else if (AStrMsg = '=') then
    S:= CHR_LOG_GROUP_MESSAGE[AGroup] + ': ==============================================================='
  else
    S := CHR_LOG_GROUP_MESSAGE[AGroup] + ': ' + AStrMsg;
  SaveLog(AType, S, FFileName, FFileName + '.old');
  Result := 0;
end;

constructor TLogFileText.Create(AConfig: IProfXmlNode2; AFileName: WideString);
begin
  inherited Create(lFile);
  FFileName := AFileName;
  // Проверка сущестрования директории
  ForceDirectories(ExtractFilePath(FFileName));
end;

end.

