{**
@Abstract(Класс, объединяющий вывод логов сразу в несколько мест)
@Author(Prof1983 prof1983@ya.ru)
@Created(14.09.2006)
@LastMod(26.04.2012)
@Version(0.5)
}
unit ALogDocumentsAll;

interface

uses
  Classes, Forms, SysUtils, XmlIntf,
  ABaseUtils2, ALogDocumentForm2007, ALogDocuments2007, ALogFile, ALogProgram,
  ATypes;

type
  TLogDocumentsAll = class(TLogDocuments)
  public
    constructor Create(AConfig: IXmlNode; ASetLogType: TLogTypeSet; ALogFilePath: WideString = ''; LogId: Integer = 123; LogName: String = 'Program123');
  end;

implementation

{ TLogDocumentsAll }

constructor TLogDocumentsAll.Create(AConfig: IXmlNode; ASetLogType: TLogTypeSet; ALogFilePath: WideString = ''; LogId: Integer = 123; LogName: string = 'Program123');
var
  Config1: IXmlNode;
  I: Integer;
  LogFile: TLogFileText;
  LogFileName: WideString;
  LogForm: TLogForm;
  LogProgram: TLogProgram;
begin
  inherited Create();

  if lWindow in ASetLogType then
  try
    Config1 := nil;
    LogForm := TLogForm.Create(Config1);
    try
    LogForm.ConfigureLoad();
    except
    end;
    LogForm.Initialize();
    AddLogDocument(LogForm);
  except
  end;

  if lFile in ASetLogType then
  try
    LogFileName := ExtractFileName(Application.ExeName);
    I := StrPosEnd(LogFileName, '.');
    if I > 0 then LogFileName := Copy(LogFileName, 0, I - 1);
    if ALogFilePath = '' then
      LogFileName := ExtractFilePath(Application.ExeName) + LogFileName + '.log'
    else
      LogFileName := ALogFilePath + LogFileName + '.log';

    LogFile := TLogFileText.Create(nil, LogFileName);
    LogFile.ConfigureLoad();
    LogFile.Initialize();
    AddLogDocument(LogFile);
  except
  end;

  if lProgram in ASetLogType then
  try
    LogProgram := TLogProgram.Create();
    AddLogDocument(LogProgram);
  except
  end;
end;

end.
