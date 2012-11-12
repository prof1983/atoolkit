{**
@Abstract Классы для записи собщений программы в БД или файл
@Author Prof1983 <prof1983@ya.ru>
@Created 16.08.2005
@LastMod 12.11.2012

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
  TALogFileText = class(TALogDocument)
  private
    //** Имя файла
    FFileName: WideString;
  public
    procedure SetFileName(const Value: WideString);
  public
    //** Добавить сообщение
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer; override;
    function Initialize(): AError; override;
    {class function SaveLog(Err: TLogTypeMessage; AStrMsg: string; AFileName: string = '';
        AFileNameOld: string = ''; AFilePath: string = ''): Boolean;}
  public
    constructor Create();
  public
    //** Имя файла
    property FileName: WideString read FFileName write SetFileName;
  end;

  //TLogFileText = TALogFileText;
  //TProfLogFileText3 = TALogFileText;

implementation

{ TALogFileText }

function TALogFileText.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;
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

constructor TALogFileText.Create();
begin
  inherited Create(lFile);
end;

function TALogFileText.Initialize(): AError;
begin
  Result := inherited Initialize();
  // Проверка сущестрования директории
  ForceDirectories(ExtractFilePath(FFileName));
end;

procedure TALogFileText.SetFileName(const Value: WideString);
begin
  FFileName := Value;
  // Проверка сущестрования директории
  ForceDirectories(ExtractFilePath(FFileName));
end;

{class function TALogFileText.SaveLog(Err: TLogTypeMessage; AStrMsg: string; AFileName: string = '';
    AFileNameOld: string = ''; AFilePath: string = ''): Boolean;
begin
  Result := ALogFileTextUtils.SaveLog(Err, AStrMsg, AFileName, AFileNameOld, AFilePath);
end;}

end.

