{**
@Abstract(Класс главной форма - оболочка для TForm)
@Author(Prof1983 prof1983@ya.ru)
@Created(16.11.2005)
@LastMod(28.06.2012)
@Version(0.5)
}
unit AFormMain20061002;

interface

uses
  Classes, Forms, SysUtils,
  AConfig2007, AForm2006, ALogDocumentsAll, ATypes, AXml2006, AXmlDocumentUtils;

type
  TProfFormMain = class(TProfForm)
  private
    FConfigFileName: WideString;
    FConfigFilePath: WideString;
    FLogFilePath: WideString;
    FLogID: Integer;
    FLogName: string;
    FLogTypeSet: TLogTypeSet;
  protected
    ALog: TLogDocumentsAll;
  public
    constructor Create(AOwner: TComponent); override;
      //** Финализация программы (конфигурации, логирование)
    procedure Done(); virtual;
      //** Инициализация программы (конфигурации, логирование)
    procedure Init(); virtual;
      {** Initialize config }
    procedure InitConfig(); virtual;
      {** Initialize log }
    procedure InitLog(); virtual;
  published
      //** Имя файла конфигураций (с путем или без него)
    property ConfigFileName: WideString read FConfigFileName write FConfigFileName;
      //** Путь к файлу конфигураций (если ConfigFileName = '' то берется имя .exe файла без расширения)
    property ConfigFilePath: WideString read FConfigFilePath write FConfigFilePath;
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
end;

procedure TProfFormMain.Done();
begin
  {
  if Assigned(ALog) then
  try
    ALog.Finalize();
    ALog.Free();
  finally
    ALog := nil;
  end;
  }

  ConfigureSave();
  if Assigned(FConfigDocument) then
  try
    {$IFDEF VER150}
    // Проверим наличие файла
    if (not FileExists(FConfigFileName)) then
    begin
      // Создадим каталог, если надо
      ForceDirectories(ExtractFilePath(FConfigFileName));
    end;
    {$ENDIF}

    AXmlDocument_SaveToFile1(FConfigDocument, FConfigFileName);
    FreeAndNil(FConfigDocument);
  except
  end;
end;

procedure TProfFormMain.Init();
begin
  InitConfig();
  InitLog();
end;

procedure TProfFormMain.InitConfig();
begin
  if not(Assigned(FConfigDocument)) and not(Assigned(FConfig)) then
  try
    if (FConfigFileName = '') then
      FConfigFileName := ChangeFileExt(ExtractFileName(ParamStr(0)), '.config');
    // Получение полного имени файла
    if (ExtractFilePath(FConfigFileName) = '') then
    begin
      if (FConfigFilePath = '') then
        FConfigFileName := ExtractFilePath(ParamStr(0)) + FConfigFileName
      else
        FConfigFileName := FConfigFilePath + FConfigFileName;
    end;
    // Проверка существования директории
    ForceDirectories(ExtractFilePath(FConfigFileName));
    // Создание объекта
    FConfigDocument := TConfigDocument1.Create(FConfigFileName);
    // Проверим наличие файла
    FConfig := FConfigDocument.DocumentElement.GetNodeByName('FormMain');
    ConfigureLoad();
  except
  end;
end;

procedure TProfFormMain.InitLog();
begin
  ALog := TLogDocumentsAll.Create(nil{FConfig.GetNodeByName('Logs')}, FLogTypeSet, FLogFilePath, FLogID, FLogName);
  FLog := ALog;
end;

end.
