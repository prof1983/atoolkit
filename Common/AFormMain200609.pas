{**
@Abstract(Класс главной форма - оболочка для TForm)
@Author(Prof1983 prof1983@ya.ru)
@Created(16.11.2005)
@LastMod(05.07.2012)
@Version(0.5)
}
unit AFormMain200609;

interface

uses
  Classes, Forms, SysUtils, XmlIntf,
  AConfig2007, ALogDocumentsAll, AForm2007, ATypes, AXmlUtils,
  ALogDocuments;

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
    // Финализация программы (конфигурации, логирование)
    procedure Done(); virtual;
    // Инициализация программы (конфигурации, логирование)
    procedure Init(); virtual;
  published
    // Имя файла конфигураций (с путем или без него)
    property ConfigFileName: WideString read FConfigFileName write FConfigFileName;
    // Путь к файлу конфигураций (если ConfigFileName = '' то берется имя .exe файла без расширения)
    property ConfigFilePath: WideString read FConfigFilePath write FConfigFilePath;
    // Путь к файлу логирования .txt
    property LogFilePath: WideString read FLogFilePath write FLogFilePath;
    // ID программы для подключения к системе логирования
    property LogID: Integer read FLogID write FLogID;
    // Имя программы для подключения к системе логирования
    property LogName: string read FLogName write FLogName;
    // Устанавливаем в какие места выводить Log
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
  if Assigned(ALog) then
  try
    try
      ALog.Finalize();
      //ALog.Free();
    finally
      ALog := nil;
    end;
  except
  end;

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

    FConfigDocument.SaveToFile(FConfigFileName);
    FreeAndNil(FConfigDocument);
  except
  end;
end;

procedure TProfFormMain.Init();
var
  Path: string;
  LogConfig: IXmlNode;
begin
  if not(Assigned(FConfigDocument)) and not(Assigned(FConfig)) then
  try
    if FConfigFileName = '' then
      FConfigFileName := ChangeFileExt(ExtractFileName(ParamStr(0)), '.config');
    // Получение полного имени файла
    if ExtractFilePath(FConfigFileName) = '' then
    begin
      if FConfigFilePath = '' then
        FConfigFileName := ExtractFilePath(ParamStr(0)) + FConfigFileName
      else
        FConfigFileName := FConfigFilePath + FConfigFileName;
    end;
    // Проверка существования директории
    {$IFDEF VER150}
    Path := ExpandFileName(FConfigFileName);
    Path := ExtractFilePath(Path);
    ForceDirectories(Path);
    {$ENDIF}
    // Создание объекта
    FConfigDocument := TConfigDocument.Create1(FConfigFileName).Controller;
    // Проверим наличие файла----
    if Assigned(FConfigDocument) then
      FConfig := AXmlUtils.ProfXmlNode_GetNodeByName(FConfigDocument.DocumentElement, 'FormMain')
    else
      FConfig := nil;
    ConfigureLoad();
  except
  end;

  LogConfig := AXmlUtils.ProfXmlNode_GetNodeByName(FConfig, 'Logs');
  ALog := TLogDocumentsAll.Create(LogConfig, FLogTypeSet, FLogFilePath, FLogID, FLogName);
  FLog := ALog;
end;

end.
