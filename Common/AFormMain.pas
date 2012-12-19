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
  AFormMainUtils,
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
