{**
@Abstract Классы для записи собщений программы в БД или файл
@Author Prof1983 <prof1983@ya.ru>
@Created 16.08.2005
@LastMod 18.12.2012

Uses
  @link ABase
  @link ALogDocumentImpl
  @link ALogFileTextUtils
  @link ATypes
}
unit ALogFileTextObj;

interface

uses
  ABase,
  ALogDocumentObj,
  ALogFileTextUtils,
  ATypes,
  AUtilsMain;

type //** Запись в файл
  TALogFileText = class(TALogDocumentObject)
  private
    //** Имя файла
    FFileName: WideString;
  public
    procedure SetFileName(const Value: WideString);
  public
    //** Добавить сообщение
    function AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
        const StrMsg: APascalString): AInt; override;
    function Initialize(): AError; override;
  public
    constructor Create();
  public
    //** Имя файла
    property FileName: WideString read FFileName write SetFileName;
  end;

implementation

{ TALogFileText }

function TALogFileText.AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
    const StrMsg: APascalString): AInt;
var
  S: string;
begin
  inherited AddToLog(LogGroup, LogType, StrMsg);
  if (StrMsg = '-') then
    S:= {CHR_LOG_GROUP_MESSAGE[AGroup] +} ': ---------------------------------------------------------------'
  else if (StrMsg = '=') then
    S:= {CHR_LOG_GROUP_MESSAGE[AGroup] +} ': ==============================================================='
  else
    S := {CHR_LOG_GROUP_MESSAGE[AGroup] +} ': ' + StrMsg;
  SaveLog(TLogTypeMessage(LogType), S, FFileName, FFileName + '.old');
  Result := 1;
end;

constructor TALogFileText.Create();
begin
  inherited Create();
  FLogType := lFile;
end;

function TALogFileText.Initialize(): AError;
begin
  Result := inherited Initialize();
  // Проверка сущестрования директории
  AUtils_ForceDirectoriesP(AUtils_ExtractFilePathP(FFileName));
end;

procedure TALogFileText.SetFileName(const Value: WideString);
begin
  FFileName := Value;
  // Проверка сущестрования директории
  AUtils_ForceDirectoriesP(AUtils_ExtractFilePathP(FFileName));
end;

end.

