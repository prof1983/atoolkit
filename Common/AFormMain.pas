{**
@Abstract Класс главной форма - оболочка для TForm
@Author Prof1983 <prof1983@ya.ru>
@Created 16.11.2005
@LastMod 19.12.2012
}
unit AFormMain;

interface

uses
  Classes, Forms, SysUtils, XmlIntf,
  ABase,
  AConsts2,
  AFormObj,
  ALogDocumentListObj,
  ALogDocumentsAllUtils,
  ALogNodeUtils,
  AUiForm,
  ASystemData,
  ATypes,
  AXmlDocumentImpl, AXmlDocumentUtils, AXmlNodeUtils, AXmlUtils;

type
  TProfFormMain = class(TAFormObject)
  protected
    //FConfigDir: APascalString; - Use ASystemData
    //FConfigFileName: WideString; - Use ASystemData
    FIsConfigDocumentInit: Boolean; // ConfigDocument инициализирован в этом объекте
    FIsLogDocumentsInit: Boolean;   // LogDocuments инициализирован в этом объекте
    //FLogDir: APascalString; - Use ASystemData
    //FLogFilePath: WideString; - Use ASystemData
    FLogID: Integer;
    FLogName: string;
    FLogTypeSet: TLogTypeSet;
  protected
    FLogDocuments: TALogDocumentListObject;
  public
      //** Финализация программы (конфигурации, логирование)
    procedure Done(); virtual; deprecated; // Use Finalize()
      //** Финализация программы (конфигурации, логирование)
    function Finalize(): AError; override;
    function GetExePath(): APascalString; deprecated; // Use AFormMain_GetExePath()
      //** Инициализация программы (конфигурации, логирование)
    procedure Init(); virtual;
      //** Initialize config
    procedure InitConfig(); virtual;
      //** Initialize log
    procedure InitLog(); virtual;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property ALog: TALogDocumentListObject{TALogDocuments} read FLogDocuments write FLogDocuments;
      //** Имя файла конфигураций (с путем или без него)
    //property ConfigFileName: WideString read FConfigFileName write FConfigFileName; - Use ASystemData
      //** Путь к файлу конфигураций (если ConfigFileName = '' то берется имя .exe файла без расширения)
    //property ConfigFilePath: WideString read FConfigFilePath write FConfigFilePath; - Use ASystem
      //** Путь к файлу логирования .txt
    //property LogFilePath: WideString read FLogFilePath write FLogFilePath; - Use ASystemData
      //** ID программы для подключения к системе логирования
    property LogID: Integer read FLogID write FLogID;
      //** Имя программы для подключения к системе логирования
    property LogName: string read FLogName write FLogName;
      //** Устанавливаем в какие места выводить Log
    property LogTypeSet: TLogTypeSet read FLogTypeSet write FLogTypeSet;
  end;

function AFormMain_GetExePathP(): APascalString;

function AFormMain_InitConfig(var ConfigDocument: ADocument; var Config: AConfig): AError;

function AFormMain_InitLog(LogTypeSet: TLogTypeSet; var LogDocuments: TALogDocumentListObject; var Log: ALogNode): AError;

implementation

// Function --------------------------------------------------------------------

function StrPosEnd(const St: WideString; C: WideChar): Integer;
// Ищет индекс символа C в строке St с конца строки. Возвращает 0, если символ не найден.
var
  I: Integer;
begin
  Result := 0;
  for I := Length(St) downto 1 do if St[I] = C then begin Result := I; Exit; end;
end;

// --- AFormMain ---

function AFormMain_GetExePathP(): APascalString;
begin
  if (FExePath = '') then
    FExePath := ExtractFilePath(ParamStr(0));
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
    ExeName := ExtractFileName(ParamStr(0));
    if (FConfigFileName = '') then
      FConfigFileName := ChangeFileExt(ExeName, '.'+FILE_EXT_CONF);
    // Получение полного имени файла
    if ExtractFilePath(FConfigFileName) = '' then
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
    FConfigFileName := ExpandFileName(FConfigFileName);
    // Проверка существования директории
    ForceDirectories(ExtractFilePath(FConfigFileName));
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
    FLogFilePath := ExpandFileName(FLogFilePath);
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

{ TProfFormMain }

constructor TProfFormMain.Create(AOwner: TComponent);
begin
  FLogID := 123;
  FLogName := ChangeFileExt(ExtractFileName(ParamStr(0)), '');
  inherited Create(AOwner);
  FIsConfigDocumentInit := False;
  FIsLogDocumentsInit := False;
end;

procedure TProfFormMain.Done();
begin
  Finalize();
end;

function TProfFormMain.Finalize(): AError;
begin
  if {FIsLogDocumentsInit and} Assigned(FLogDocuments) then
  try
    FLogDocuments.Finalize();
    //FLogDocuments.Free();
  finally
    FLogDocuments := nil;
  end;

  AUiForm.Form_SaveConfig(Self, FConfig);

  Result := inherited Finalize();

  if FIsConfigDocumentInit and (FConfigDocument1 <> 0) then
  try
    // Проверим наличие файла
    if not(FileExists(FConfigFileName)) then
    begin
      // Создадим каталог, если надо
      ForceDirectories(ExtractFilePath(FConfigFileName));
    end;

    AXmlDocument_SaveToFileP(FConfigDocument1, FConfigFileName);
    FreeAndNil(FConfigDocument1);
  except
  end;
end;

function TProfFormMain.GetExePath(): APascalString;
begin
  Result := AFormMain_GetExePathP();
end;

procedure TProfFormMain.Init();
begin
  AFormMain_GetExePathP();
  InitConfig();
  AUiForm.Form_LoadConfig(Self, FConfig);
  InitLog();
end;

procedure TProfFormMain.InitConfig();
begin
  if (AFormMain_InitConfig(FConfigDocument1, FConfig) = 1) then
    FIsConfigDocumentInit := True;
  ASystemData.FConfig := FConfig;
end;

procedure TProfFormMain.InitLog();
begin
  if (AFormMain_InitLog(FLogTypeSet, FLogDocuments, FLog) = 1) then
    FIsLogDocumentsInit := True;
end;

end.
