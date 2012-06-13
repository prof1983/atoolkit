{**
@Abstract(Классы для записи собщений программы в БД или файл)
@Author(Prof1983 prof1983@ya.ru)
@Created(16.08.2005)
@LastMod(13.06.2012)
@Version(0.5)
}
unit ALogFile;

// TODO: Use ALogFileText.pas

interface

uses
  SysUtils,
  ALogDocumentImpl, ALogFileTextUtils, ALogGlobals, ATypes, AXmlNodeIntf;

type //** Запись в файл
  TLogFileText = class(TLogDocument1)
  private
    FFileName: WideString;
  public
      //** Добавить сообщение
    function AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: string; AParams: array of const): Boolean; override;
    constructor Create(AConfig: IProfXmlNode2; AFileName: WideString);
      //** Имя файла
    property FileName: WideString read FFileName write FFileName;
      //** Добавить сообщение
    function ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString; AParams: array of const): Integer; override;
      //** Добавить сообщение
    function ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer; override;
      //** Добавить сообщение
    function ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage;
        const AStrMsg: WideString): Integer; override;
  end;

implementation

{ TLogFileText }

function TLogFileText.AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: string; AParams: array of const): Boolean;
var
  S: string;
begin
  if AStrMsg = '-' then
    S:= CHR_LOG_GROUP_MESSAGE[AGroup] + ': ---------------------------------------------------------------'
  else if AStrMsg = '=' then
    S:= CHR_LOG_GROUP_MESSAGE[AGroup] + ': ==============================================================='
  else
  try
    S := CHR_LOG_GROUP_MESSAGE[AGroup] + ': ' + Format(AStrMsg, AParams);
  except
    S := CHR_LOG_GROUP_MESSAGE[AGroup] + ': ' + AStrMsg;
  end;
  SaveLog(AType, S, FFileName, FFileName + '.old');
  Result := True;
end;

constructor TLogFileText.Create(AConfig: IProfXmlNode2; AFileName: WideString);
begin
  inherited Create(lFile);
  FFileName := AFileName;
  // Проверка сущестрования директории
  ForceDirectories(ExtractFilePath(FFileName));
end;

function TLogFileText.ToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString; AParams: array of const): Integer;
begin
  Result := ToLogA(AGroup, AType, AStrMsg);
end;

function TLogFileText.ToLogA(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: WideString): Integer;
var
  S: string;
begin
  inherited ToLogA(AGroup, AType, AStrMsg);
  if AStrMsg = '-' then
    S:= CHR_LOG_GROUP_MESSAGE[AGroup] + ': ---------------------------------------------------------------'
  else if AStrMsg = '=' then
    S:= CHR_LOG_GROUP_MESSAGE[AGroup] + ': ==============================================================='
  else
    S := CHR_LOG_GROUP_MESSAGE[AGroup] + ': ' + AStrMsg;
  SaveLog(TLogTypeMessage(AType), S, FFileName, FFileName + '.old');
  Result := 1;
end;

function TLogFileText.ToLogE(AGroup: EnumGroupMessage; AType: EnumTypeMessage;
    const AStrMsg: WideString): Integer;
var
  S: string;
begin
  inherited ToLogE(AGroup, AType, AStrMsg);
  if AStrMsg = '-' then
    S:= CHR_LOG_GROUP_MESSAGE[IntToLogGroupMessage(AGroup)] + ': ---------------------------------------------------------------'
  else if AStrMsg = '=' then
    S:= CHR_LOG_GROUP_MESSAGE[IntToLogGroupMessage(AGroup)] + ': ==============================================================='
  else
    S := CHR_LOG_GROUP_MESSAGE[IntToLogGroupMessage(AGroup)] + ': ' + AStrMsg;
  SaveLog(TLogTypeMessage(AType), S, FFileName, FFileName + '.old');
  Result := 1;
end;

end.

