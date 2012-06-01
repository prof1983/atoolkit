{**
@Abstract(Класс работы с XML документом)
@Author(Prof1983 prof1983@ya.ru)
@Created(07.03.2007)
@LastMod(21.05.2012)
@Version(0.5)
}
unit AXmlDocument;

interface

uses
  SysUtils, XmlDoc, XmlIntf,
  ABase, AConsts2, ANodeIntf, AXmlDocumentIntf, AXmlNodeImpl;

type // XML документ. Класс реализует интерфейс IProfXmlDocument
  TProfXmlDocument = class(TProfXmlNode, IProfXmlDocument)
  private
      // XML документ
    FDocument: IXmlDocument;
      // Название главного элемента документа (используется при создании XML документа)
    FDocumentElementName: WideString;
      // Имя файла XML документа
    FFileName: WideString;
  protected
    procedure CreateDocument();
  protected
    function GetDocumentElement(): IProfNode; safecall;
      // Возвращает имя файла документа
    function GetFileName(): WideString; safecall;
    { Открыт ли документ?
      Реализация метода IsDocumentOpened должна проверить соответствующие свойства Объекта для определения состояния документа. }
    function GetIsDocumentOpened(): WordBool; safecall;
    procedure SetFileName(const Value: WideString); safecall;
  public // IProfDocument
    { Открыт ли документ?
      Реализация метода IsOpened должна проверить соответствующие свойства
      Объекта для определения состояния документа. }
    function GetIsOpened(): WordBool; safecall;
  public // IProfDocument
      // Закрыть документ
    procedure CloseDocument(); safecall;
      // Загрузить из файла
    function LoadFromFile(const FileName: WideString): WordBool; safecall;
      // Загрузить из строки (Не рекомендуется использовать)
    function LoadFromString(const Value: WideString): WordBool;
      // Сохранить в файл
    function SaveToFile(const FileName: WideString): WordBool; safecall;
      // Открыть документ
    function OpenDocument(): AError; safecall;
      // (не рекомендуется использовать)
    procedure OpenA();
  public
    constructor Create();
    procedure Initialize();
  public
      // XML документ (не рекомендуется использовать)
    property Document: IXmlDocument read FDocument;
      // ProfNode
    property DocumentElement: IProfNode read GetDocumentElement;
      // Название главного элемента документа (используется при создании XML документа)
    property DocumentElementName: WideString read FDocumentElementName write FDocumentElementName;
      // Имя файла XML документа
    property FileName: WideString read GetFileName write SetFileName;
  end;

implementation

{ TProfXmlDocumentA }

procedure TProfXmlDocument.CloseDocument();
begin
  if Assigned(FDocument) then
  begin
    //FDocument.SaveToFile(FFileName);
    FDocument := nil;
  end;
end;

constructor TProfXmlDocument.Create();
begin
  inherited Create();
  FDocumentElementName := 'Config';
end;

procedure TProfXmlDocument.CreateDocument();
begin
  // Создаем документ
  //AddToLog(lgGeneral, ltInformation, 'Создаем документ', []);
  FDocument.FileName := '';
  // Активируем документ
  //AddToLog(lgGeneral, ltInformation, 'Активируем документ', []);
  FDocument.Active := True;
  // Задаем кодировку
  //AddToLog(lgGeneral, ltInformation, 'Задаем кодировку "Windows-1251"', []);
  FDocument.Encoding := 'Windows-1251';
  // Задаем версию
  //AddToLog(lgGeneral, ltInformation, 'Задаем версию "1.0"', []);
  FDocument.Version := '1.0';
  // Задаем отступы
  //AddToLog(lgGeneral, ltInformation, 'Задаем отступы <2 пробела>', []);
  FDocument.NodeIndentStr := '  ';
  // Создаем главный элемент документа
  //AddToLog(lgGeneral, ltInformation, 'Создаем главный элемент документа "Config"', []);
  //if FDefElementName = '' then FDefElementName := 'Config';
  if FDocumentElementName <> '' then
  begin
    FDocument.AddChild(FDocumentElementName);
    // Создаем дочерние элементы
    //AddToLog(lgGeneral, ltInformation, 'Создаем дочерние элементы', []);
    // ...
  end;
end;

function TProfXmlDocument.GetDocumentElement(): IProfNode;
begin
  Result := Self;
end;

function TProfXmlDocument.GetFileName(): WideString;
begin
  Result := FFileName;
end;

function TProfXmlDocument.GetIsDocumentOpened(): WordBool;
begin
  Result := Assigned(FDocument);
  if Result then
  try
    Result := FDocument.Active;
  except
  end;
end;

function TProfXmlDocument.GetIsOpened: WordBool;
begin
  Result := GetIsDocumentOpened;
end;

procedure TProfXmlDocument.Initialize();
begin
  if not(Assigned(FDocument)) then
    FDocument := TXmlDocument.Create(nil);
end;

function TProfXmlDocument.LoadFromFile(const FileName: WideString): WordBool;
begin
  FDocument.LoadFromFile(FileName);
end;

function TProfXmlDocument.LoadFromString(const Value: WideString): WordBool;
begin
  Result := Assigned(FDocument);
  if not(Result) then Exit;
  Result := False;
  // Закрываем документ
  if FDocument.Active then
    FDocument.Active := False;
  // Задаем XML
  FDocument.XML.Clear();
  FDocument.XML.Add(Value);
  // Открываем XML документ
  try
    FDocument.Active := True;
    Self.OpenA();
    Result := True;
  except
  end;
end;

procedure TProfXmlDocument.OpenA();
begin
  SetNode(FDocument.DocumentElement);
end;

function TProfXmlDocument.OpenDocument(): AError;
var
  FCreate: Boolean;
begin
  FCreate := True;
  Result := RESULT_OK;

  if FCreate then
  begin
//  // Проверка сущестрования директории
//  if FFileName <> '' then
//    ForceDirectories(ExtractFilePath(FFileName));
  end;

  Initialize();

  FDocument.ParseOptions := [poPreserveWhiteSpace];

  if FFileName = '' then
  begin
    if FCreate then
    begin
      CreateDocument();
      Result := RESULT_XML_DOCUMENT_CREATE;
    end
    else
      Result := RESULT_XML_DOCUMENT_NOTCREATE;
  end
  else
  try
    FDocument.LoadFromFile(FFileName);
    SetNode(FDocument.DocumentElement);
    Result := RESULT_OK;
  except
    on E: Exception do
    begin
      Result := RESULT_ERROR;
      if FCreate then
      begin
        // Произошла ошибка при открытиии файла
        //AddToLog(lgGeneral, ltError, 'Произошла ошибка при открытиии файла конфигураций "%s"', [FDefFileName]);

        CreateDocument();
        Result := RESULT_XML_DOCUMENT_CREATE;

        // Сохраняем документ
        //AddToLog(lgGeneral, ltInformation, 'Сохраняем документ', []);
        FDocument.FileName := FFileName;
        FDocument.SaveToFile('');

        SetNode(FDocument.DocumentElement);
      end;
    end;
  end;
end;

function TProfXmlDocument.SaveToFile(const FileName: WideString): WordBool;
begin
  Result := False;
  if Assigned(FDocument) and FDocument.Active then
  try
    FDocument.SaveToFile(FileName);
    Result := True;
  except
  end;
end;

procedure TProfXmlDocument.SetFileName(const Value: WideString);
begin
  FFileName := Value;
end;

end.
