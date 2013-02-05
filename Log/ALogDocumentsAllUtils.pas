{**
@Author Prof1983 <prof1983@ya.ru>
@Created 14.09.2006
@LastMod 05.02.2013
}
unit ALogDocumentsAllUtils;

interface

uses
  ABase,
  ABaseUtils2,
  ALogDocumentFormObj,
  ALogDocumentListObj,
  ALogFileTextObj,
  ALogProgramObj,
  ASystemMain,
  ATypes,
  AUtilsMain;

function ALogDocumentsAll_Create(SetLogType: TLogTypeSet; const LogFilePath: WideString = ''): TALogDocumentListObject;

implementation

// --- ALogDocumentsAll ---

function ALogDocumentsAll_Create(SetLogType: TLogTypeSet; const LogFilePath: WideString): TALogDocumentListObject;
var
  I: Integer;
  LogFile: TALogFileText;
  LogFileName: WideString;
  LogForm: TALogFormDocument;
  LogProgram: TALogProgramObject;
  Docs: TALogDocumentListObject;
  ExeName: APascalString;
begin
  Docs := TALogDocumentListObject.Create();

  if (lWindow in SetLogType) then
  try
    LogForm := TALogFormDocument.Create();
    LogForm.Initialize();
    Docs.AddLogDocument(LogForm);
  except
  end;

  if (lFile in SetLogType) then
  try
    ExeName := ASystem_GetExeNameP();
    LogFileName := AUtils_ExtractFileNameP(ExeName);
    I := StrPosEnd(LogFileName, '.');
    if I > 0 then LogFileName := Copy(LogFileName, 0, I - 1);
    if (LogFilePath = '') then
      LogFileName := AUtils_ExtractFilePathP(ExeName) + LogFileName + '.log'
    else
      LogFileName := LogFilePath + LogFileName + '.log';

    LogFile := TALogFileText.Create();
    LogFile.SetFileName(LogFileName);
    LogFile.Initialize();
    Docs.AddLogDocument(LogFile);
  except
  end;

  if (lProgram in SetLogType) then
  try
    LogProgram := TALogProgramObject.Create();
    Docs.AddLogDocument(LogProgram);
  except
  end;

  Result := Docs;
end;

end.
