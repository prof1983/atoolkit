{**
@Abstract(Работа с XML)
@Author(Prof1983 prof1983@ya.ru)
@Created(09.10.2005)
@LastMod(03.07.2012)
@Version(0.5)
}
unit AXml2;

interface

uses
  SysUtils, Variants, XmlDoc, XmlDom, XmlIntf,
  ATypes, AXmlNodeImpl, AXmlNodeIntf;

type
  TProfXmlNode = AXmlNodeImpl.TProfXmlNode2;

type
  TProfXmlNodeCollection = class(TXmlNodeCollection)
  private
    function GetNode(Index: Integer): TProfXmlNode;
  public
    property Nodes[Index: Integer]: TProfXmlNode read GetNode;
  end;

type
  TProfXmlDocument = class(TXmlDocument)
  private
    FDefFileName: WideString;
    FDefElementName: WideString;
    FToLog: TAddToLogProc;
  protected
    function GetChildNodeClass(const Node: IDOMNode): TXMLNodeClass; override;
    function GetDocumentElement(): IProfXmlNode; safecall;
    function Get_DocumentElement(): TProfXmlNode2;
  public
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: String; AParams: array of const): Boolean;
    function Initialize(): WordBool; virtual;
    function LoadFromString(const Value: WideString): WordBool;
    function SaveToString(var Value: WideString): Boolean;
  public
    constructor Create(const AFileName: WideString = ''; const AElementName: WideString = 'Config'; AToLog: TAddToLogProc = nil);
    procedure Free();
  public
    property OnToLog: TAddToLogProc read FToLog write FToLog;
  end;

implementation

{ TProfXmlDocument }

function TProfXmlDocument.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: String; AParams: array of const): Boolean;
begin
  Result := False;
  if Assigned(FToLog) then
  try
    Result := (FToLog(AGroup, AType, Format(AStrMsg, AParams)) > 0);
  except
  end;
end;

constructor TProfXmlDocument.Create(const AFileName: WideString = ''; const AElementName: WideString = 'Config'; AToLog: TAddToLogProc = nil);
begin
  inherited Create(nil);
  FToLog := AToLog;
  FDefFileName := AFileName;
  FDefElementName := AElementName;
end;

{function TProfXmlDocument.CreateNode(const NameOrData: DOMString; NodeType: TNodeType = ntElement;
    const AddlData: DOMString = ''): IXmlNode;
begin
  Result := TProfXmlNode.Create(CreateDOMNode(DOMDocument, NameOrData,
    NodeType, AddlData), nil, Self);
end;}

procedure TProfXmlDocument.Free();
begin
  {try
  if FDocument.FileName <> '' then FDocument.SaveToFile('');
  except
  end;}
  inherited Free;
end;

function TProfXmlDocument.GetChildNodeClass(const Node: IDOMNode): TXMLNodeClass;
begin
  Result := TProfXmlNode;
end;

function TProfXmlDocument.GetDocumentElement(): IProfXmlNode;
begin
  Result := IProfXmlNode(DocumentElement);
end;

function TProfXmlDocument.Get_DocumentElement(): TProfXmlNode;
begin
  Result := TProfXmlNode(DocumentElement);
end;

function TProfXmlDocument.Initialize(): WordBool;
begin
  Result := True;
  if FDefFileName <> '' then
  try
    Self.LoadFromFile(FDefFileName);
  except
    on E: Exception do
    begin
      // Произошла ошибка при открытиии файла
      AddToLog(lgGeneral, ltError, 'Произошла ошибка при открытиии файла конфигураций "%s"', [FDefFileName]);
      // Создаем документ
      AddToLog(lgGeneral, ltInformation, 'Создаем документ', []);
      Self.FileName := '';
      // Активируем документ
      AddToLog(lgGeneral, ltInformation, 'Активируем документ', []);
      //FDocument.Active := True;
      Self.Active := True;
      // Задаем кодировку
      AddToLog(lgGeneral, ltInformation, 'Задаем кодировку "Windows-1251"', []);
      //FDocument.Encoding := 'Windows-1251';
      Self.Encoding := 'Windows-1251';
      // Задаем версию
      AddToLog(lgGeneral, ltInformation, 'Задаем версию "1.0"', []);
      Self.Version := '1.0';
      // Задаем отступы
      AddToLog(lgGeneral, ltInformation, 'Задаем отступы <2 пробела>', []);
      Self.NodeIndentStr := '  ';
      // Создаем главный элемент документа
      AddToLog(lgGeneral, ltInformation, 'Создаем главный элемент документа "Config"', []);
      //Self.CreateElement('Config', 'B111');
      if FDefElementName = '' then FDefElementName := 'Config';
      Self.AddChild(FDefElementName);
      // Создаем дочерние элементы
      AddToLog(lgGeneral, ltInformation, 'Создаем дочерние элементы', []);
      // ...
      // Сохраняем документ
      AddToLog(lgGeneral, ltInformation, 'Сохраняем документ', []);
      //FDocument.FileName := AFileName;
      Self.FileName := FDefFileName;
      //FDocument.SaveToFile('');
      Self.SaveToFile('');
    end;
  end;
end;

function TProfXmlDocument.LoadFromString(const Value: WideString): WordBool;
begin
  //FDocument.LoadFromXml(Value);
  Self.XML.Text := Value;
  Result := True;
end;

{function TProfXmlDocument.NewNode(const ADomNode: IDOMNode; const AParentNode: TXMLNode;
    const OwnerDoc: TXMLDocument): TXmlNode;
begin
  Result := TProfXmlNode.Create(ADomNode, AParentNode, OwnerDoc);
end;}

(*function TProfXmlDocument.SaveToFile(const AFileName: WideString): WordBool;
begin
  {try
    FDocument.SaveToFile(AFileName);
    Result := True;
  except
    on E: Exception do begin
      AddToLog(lgGeneral, ltError, err_SaveToFile, [AFileName, E.Message]);
      Result := False;
    end;
  end;}
  Result := False;
  try
    inherited SaveToFile(AFileName);
    Result := True;
  except
  end;
end;*)

function TProfXmlDocument.SaveToString(var Value: WideString): Boolean;
begin
  Result := False;
  try
    Value := Self.XML.Text;
    Result := True;
  except
  end;

  {try
    Value := FDocument.XML.Text;
    Result := True;
  except
    Result := False;
  end;}
end;

// TProfXmlNodeCollection ------------------------------------------------------

function TProfXmlNodeCollection.GetNode(Index: Integer): TProfXmlNode;
begin
  Result := TProfXmlNode(inherited GetNode(Index));
end;

end.
