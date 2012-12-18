{**
@Abstract Класс главной форма - оболочка для TForm
@Author Prof1983 <prof1983@ya.ru>
@Created 16.11.2005
@LastMod 18.12.2012
}
unit AFormMain;

interface

uses
  Classes, Forms, SysUtils, XmlIntf,
  ABase, AConsts2, ALogDocumentsAll, AFormObj, ALogDocuments, ALogNodeUtils,
  AUiForm,
  ASystemData,
  ATypes, AXmlDocumentImpl, AXmlDocumentUtils, AXmlNodeUtils, AXmlUtils;

type
  TProfFormMain = class(TAFormObject)
  protected
    FConfigDir: APascalString;
    FConfigFileName: WideString;
    //FConfigFilePath: WideString; - Use ASystemData.FConfigPath
    FIsConfigDocumentInit: Boolean; // ConfigDocument инициализирован в этом объекте
    FIsLogDocumentsInit: Boolean;   // LogDocuments инициализирован в этом объекте
    FLogDir: APascalString;
    FLogFilePath: WideString;
    FLogID: Integer;
    FLogName: string;
    FLogTypeSet: TLogTypeSet;
    //FExePath: APascalString; - Use ASystemData.FExePath
  protected
    FLogDocuments: TALogDocuments; //ALog: TLogDocumentsAll;
  public
      //** Финализация программы (конфигурации, логирование)
    procedure Done(); virtual; deprecated; // Use Finalize()
      //** Финализация программы (конфигурации, логирование)
    function Finalize(): AError; override;
    function GetExePath(): APascalString;
      //** Инициализация программы (конфигурации, логирование)
    procedure Init(); virtual;
      //** Initialize config
    procedure InitConfig(); virtual;
      //** Initialize log
    procedure InitLog(); virtual;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property ALog: TALogDocuments read FLogDocuments write FLogDocuments;
      //** Имя файла конфигураций (с путем или без него)
    property ConfigFileName: WideString read FConfigFileName write FConfigFileName;
      //** Путь к файлу конфигураций (если ConfigFileName = '' то берется имя .exe файла без расширения)
    //property ConfigFilePath: WideString read FConfigFilePath write FConfigFilePath; - Use ASystem
      //** Путь к файлу логирования .txt
    property LogFilePath: WideString read FLogFilePath write FLogFilePath;
      //** ID программы для подключения к системе логирования
    property LogID: Integer read FLogID write FLogID;
      //** Имя программы для подключения к системе логирования
    property LogName: string read FLogName write FLogName;
      //** Устанавливаем в какие места выводить Log
    property LogTypeSet: TLogTypeSet read FLogTypeSet write FLogTypeSet;
  end;

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
  if (FExePath = '') then
    FExePath := ExtractFilePath(ParamStr(0));
  Result := FExePath;
end;

procedure TProfFormMain.Init();
begin
  GetExePath();
  InitConfig();
  AUiForm.Form_LoadConfig(Self, FConfig);
  InitLog();
end;

procedure TProfFormMain.InitConfig();
var
  ExeName: String;
  //Doc: TProfXmlDocument;
  Conf: AXmlNode;
begin
  if (FConfigDocument1 = 0) and (FConfig = 0) then
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
    FConfigDocument1 := AXmlDocument_New();
    AXmlDocument_SetFileNameP(FConfigDocument1, FConfigFileName);
    AXmlDocument_Initialize(FConfigDocument1);
    // Проверим наличие файла----
    FIsConfigDocumentInit := True;
  except
  end;
  if (FConfig = 0) and (FConfigDocument1 <> 0) then
  try
    Conf := AXmlDocument_GetDocumentElement(FConfigDocument1);
    FConfig := AXmlNode_GetChildNodeByName(Conf, 'FormMain')
  except
  end;
end;

procedure TProfFormMain.InitLog();
var
  ExePath: APascalString;
  //LogConfig: IXmlNode;
begin
  if (Length(FLogFilePath) = 0) then
  begin
    ExePath := GetExePath();
    if (Length(FLogDir) > 0) then
      FLogFilePath := ExePath + FLogDir
    else
      FLogFilePath := ExePath;
  end;
  FLogFilePath := ExpandFileName(FLogFilePath);
  if (Length(FLogFilePath) > 0) and (FLogFilePath[Length(FLogFilePath)] <> '/')
  and (FLogFilePath[Length(FLogFilePath)] <> '\') then
    FLogFilePath := FLogFilePath + '\';

  if not(Assigned(FLogDocuments)) then
  begin
    //if Assigned(FConfig) then conf := FConfig.GetNodeByName('Logs');
    FLogDocuments := TLogDocumentsAll.Create(nil, FLogTypeSet, FLogFilePath, FLogID, FLogName);
    FIsLogDocumentsInit := True;
  end;

  //FLog := FLogDocuments.GetDocumentElement();
  if (FLog = 0) then
    FLog := ALogNode_New(0, 0, '', 0);
  ALogNode_SetOnAddToLog(FLog, FLogDocuments.AddToLog);
  {LogConfig := AXmlUtils.ProfXmlNode_GetNodeByName(FConfig, 'Logs');
  ALog := TLogDocumentsAll.Create(LogConfig, FLogTypeSet, FLogFilePath, FLogID, FLogName);
  FLog := ALog;}
end;

end.
