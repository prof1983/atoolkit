{**
@Author Prof1983 <prof1983@ya.ru>
@Created 19.12.2012
@LastMod 19.12.2012
}
unit AFormMainUtils;

interface

uses
  ABase,
  AConsts2,
  ALogDocumentListObj,
  ALogDocumentsAllUtils,
  ALogNodeUtils,
  ASystemData,
  ATypes,
  AUtilsMain,
  AXmlDocumentUtils,
  AXmlNodeUtils;

// --- AFormMain ---

function AFormMain_GetExePathP(): APascalString;

function AFormMain_InitConfig(var ConfigDocument: ADocument; var Config: AConfig): AError;

function AFormMain_InitLog(LogTypeSet: TLogTypeSet; var LogDocuments: TALogDocumentListObject; var Log: ALogNode): AError;

implementation

// --- AFormMain ---

function AFormMain_GetExePathP(): APascalString;
begin
  if (FExePath = '') then
    FExePath := AUtils_ExtractFilePathP(ParamStr(0));
  Result := FExePath;
end;

function AFormMain_InitConfig(var ConfigDocument: ADocument; var Config: AConfig): AError;
var
  ExeName: String;
  Conf: AXmlNode;
begin
  Result := 0;
  if (ConfigDocument = 0) and (Config = 0) then
  try
    ExeName := AUtils_ExtractFileNameP(ParamStr(0));
    if (FConfigFileName = '') then
      FConfigFileName := AUtils_ChangeFileExtP(ExeName, '.'+FILE_EXT_CONF);
    // Получение полного имени файла
    if AUtils_ExtractFilePathP(FConfigFileName) = '' then
    begin
      if (FConfigPath = '') then
      begin
        if (Length(FConfigDir) > 0) then
        begin
          if (FConfigDir[Length(FConfigDir)] <> '/') and (FConfigDir[Length(FConfigDir)] <> '\') then
            FConfigFileName := FExePath + FConfigDir + '\' + FConfigFileName
          else
            FConfigFileName := FExePath + FConfigDir + FConfigFileName;
        end
        else
          FConfigFileName := FExePath + FConfigFileName
      end
      else
        FConfigFileName := FConfigPath + FConfigFileName;
    end;
    FConfigFileName := AUtils_ExpandFileNameP(FConfigFileName);
    // Проверка существования директории
    AUtils_ForceDirectoriesP(AUtils_ExtractFilePathP(FConfigFileName));
    // Создание объекта
    ConfigDocument := AXmlDocument_New();
    AXmlDocument_SetFileNameP(ConfigDocument, FConfigFileName);
    AXmlDocument_Initialize(ConfigDocument);
    Result := 1;
  except
    Result := -1;
  end;
  if (Config = 0) and (ConfigDocument <> 0) then
  try
    Conf := AXmlDocument_GetDocumentElement(ConfigDocument);
    Config := AXmlNode_GetChildNodeByName(Conf, 'FormMain')
  except
    Result := -1;
  end;
end;

function AFormMain_InitLog(LogTypeSet: TLogTypeSet; var LogDocuments: TALogDocumentListObject; var Log: ALogNode): AError;
var
  ExePath: APascalString;
begin
  Result := 0;
  try
    if (Length(FLogFilePath) = 0) then
    begin
      ExePath := AFormMain_GetExePathP();
      if (Length(FLogDir) > 0) then
        FLogFilePath := ExePath + FLogDir
      else
        FLogFilePath := ExePath;
    end;
    FLogFilePath := AUtils_ExpandFileNameP(FLogFilePath);
    if (Length(FLogFilePath) > 0) and (FLogFilePath[Length(FLogFilePath)] <> '/')
    and (FLogFilePath[Length(FLogFilePath)] <> '\') then
      FLogFilePath := FLogFilePath + '\';

    if not(Assigned(LogDocuments)) then
    begin
      LogDocuments := ALogDocumentsAll_Create(LogTypeSet, FLogFilePath);
      Result := 1;
    end;

    if (Log = 0) then
      Log := ALogNode_New(0, 0, '', 0);
    ALogNode_SetOnAddToLog(Log, LogDocuments.AddToLogW);
  except
    Result := -1;
  end;
end;

end.
