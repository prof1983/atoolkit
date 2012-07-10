{**
@Abstract(Класс главной форма - оболочка для TForm)
@Author(Prof1983 prof1983@ya.ru)
@Created(16.11.2005)
@LastMod(10.07.2012)
@Version(0.5)
}
unit AFormMain;

interface

uses
  Classes, Forms, SysUtils, XmlIntf,
  ABase, AConsts2, ALogDocumentsAll, AForm2007, ALogDocuments,
  ATypes, AXmlDocumentImpl, AXmlNodeUtils, AXmlUtils;

type
  TProfFormMain = class(TProfForm)
  protected
    FConfigDir: APascalString;
    FConfigFileName: WideString;
    FConfigFilePath: WideString;
    FIsConfigDocumentInit: Boolean; // ConfigDocument инициализирован в этом объекте
    FIsLogDocumentsInit: Boolean;   // LogDocuments инициализирован в этом объекте
    FLogDir: APascalString;
    FLogFilePath: WideString;
    FLogID: Integer;
    FLogName: string;
    FLogTypeSet: TLogTypeSet;
  protected
    FLogDocuments: TALogDocuments;
  public
    constructor Create(AOwner: TComponent); override;
      //** Финализация программы (конфигурации, логирование)
    procedure Done(); virtual; deprecated; // Use Finalize()
      //** Финализация программы (конфигурации, логирование)
    function Finalize(): WordBool; virtual;
      //** Инициализация программы (конфигурации, логирование)
    procedure Init(); virtual;
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
  FIsConfigDocumentInit := False;
  FIsLogDocumentsInit := False;
end;

procedure TProfFormMain.Done();
begin
  Finalize();
end;

function TProfFormMain.Finalize(): WordBool;
begin
  {if FIsLogDocumentsInit and Assigned(FLogDocuments) then
  try
    FLogDocuments.Finalize();
    FLogDocuments.Free();
  finally
    FLogDocuments := nil;
  end;}

  ConfigureSave();

  Result := inherited Finalize();

  if FIsConfigDocumentInit and Assigned(FConfigDocument1) then
  try
    { $IFDEF VER150}
    // Проверим наличие файла
    if (not FileExists(FConfigFileName)) then
    begin
      // Создадим каталог, если надо
      ForceDirectories(ExtractFilePath(FConfigFileName));
    end;
    { $ENDIF}

    FConfigDocument1.SaveToFile(FConfigFileName);
    FreeAndNil(FConfigDocument1);
    //FConfigDocument := nil;
  except
  end;
end;

procedure TProfFormMain.Init();
var
  doc: TProfXmlDocument;
  Conf: AXmlNode;
  ExeName: String;
  ExePath: String;
begin
  ExePath := ExtractFilePath(ParamStr(0));
  if not(Assigned(FConfigDocument1)) and (FConfig = 0) then
  try
    ExeName := ExtractFileName(ParamStr(0));
    if (FConfigFileName = '') then
      FConfigFileName := ChangeFileExt(ExeName, '.'+FILE_EXT_CONF);
    // Получение полного имени файла
    if ExtractFilePath(FConfigFileName) = '' then
    begin
      if (FConfigFilePath = '') then
      begin
        if (Length(FConfigDir) > 0) then
        begin
          if (FConfigDir[Length(FConfigDir)] <> '/') and (FConfigDir[Length(FConfigDir)] <> '\') then
            FConfigFileName := ExePath + FConfigDir + '\' + FConfigFileName
          else
            FConfigFileName := ExePath + FConfigDir + FConfigFileName;
        end
        else
          FConfigFileName := ExePath + FConfigFileName
      end
      else
        FConfigFileName := FConfigFilePath + FConfigFileName;
    end;
    FConfigFileName := ExpandFileName(FConfigFileName);
    // Проверка существования директории
    {$IFDEF VER150}
    ForceDirectories(ExtractFilePath(FConfigFileName));
    {$ENDIF}
    // Создание объекта
    doc := TProfXmlDocument.Create(FConfigFileName);
    doc.Initialize();
    FConfigDocument1 := doc;
    // Проверим наличие файла----
    FIsConfigDocumentInit := True;
  except
  end;
  if (FConfig = 0) and Assigned(FConfigDocument1) then
  try
    Conf := FConfigDocument1.FDocumentElement;
    FConfig := AXmlNode_GetChildNodeByName(Conf, 'FormMain')
  except
  end;

  ConfigureLoad();

  if (Length(FLogFilePath) = 0) then
  begin
    if (Length(FLogDir) > 0) then
      FLogFilePath := ExePath + FLogDir
    else
      FLogFilePath := ExePath;
  end;
  FLogFilePath := ExpandFileName(FLogFilePath);
  if (FLogFilePath[Length(FLogFilePath)] <> '/') and (FLogFilePath[Length(FLogFilePath)] <> '\') then
    FLogFilePath := FLogFilePath + '\';

  if not(Assigned(FLogDocuments)) then
  begin
    //if Assigned(FConfig) then conf := FConfig.GetNodeByName('Logs');
    FLogDocuments := TLogDocumentsAll.Create(nil, FLogTypeSet, FLogFilePath, FLogID, FLogName);
    FIsLogDocumentsInit := True;
  end;
  FLog := FLogDocuments.GetDocumentElement();
end;

end.
