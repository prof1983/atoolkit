{**
@Abstract(Работа с XML)
@Author(Prof1983 prof1983@ya.ru)
@Created(09.10.2005)
@LastMod(04.05.2012)
@Version(0.5)
}
unit AXml2;

interface

uses
  SysUtils, Variants, XmlDoc, XmlDom, XmlIntf,
  ATypes, AXmlNodeIntf;

type
  TProfXmlNode2 = class(TXmlNode, IProfXmlNode2)
  private
    function Get_Collection: IXmlNodeCollection; safecall;
    //procedure SetNodeName(const Value: WideString);
    procedure SetXml(const Value: DOMString{WideString});
  protected
    function GetAsString(): WideString;
    function GetXmlB(): WideString; safecall;
    procedure SetAsString(const Value: WideString);
    procedure SetXmlB(const Value: WideString); safecall;
  public
    property Collection: IXmlNodeCollection read Get_Collection;
    constructor Create(const ADomNode: IDOMNode; const AParentNode: TXMLNode; const OwnerDoc: TXMLDocument);
    constructor CreateA();
    //function GetNode(Index: Integer): TProfXmlNode2;
    function GetNodeByName(const AName: WideString): IXmlNode; safecall;
    function GetNodeByName2(const AName: WideString): IProfXmlNode; safecall;
    function LoadFromXml(Xml: TProfXmlNode2): WordBool;
    function NewNode(const ANodeName: WideString): TProfXmlNode2;
  public
    function GetValueAsBool(var Value: WordBool): WordBool; safecall;
    function GetValueAsDateTime(var Value: TDateTime): WordBool; safecall;
    function GetValueAsInt32(var Value: Int32): WordBool; safecall;
    function GetValueAsInt64(var AValue: Int64): WordBool; safecall;
    function GetValueAsInteger(var AValue: Integer): WordBool; safecall;
    function GetValueAsString(var Value: WideString): WordBool; safecall;
    function GetValueAsUInt08(var Value: UInt08): WordBool; safecall;
    function GetValueAsUInt64(var Value: UInt64): WordBool; safecall;
  public
    function SetValueAsBool(Value: WordBool): WordBool; safecall;
    function SetValueAsFloat64(Value: Float64): WordBool; safecall;
    function SetValueAsInt32(AValue: Int32): WordBool; safecall;
    function SetValueAsString(const AValue: WideString): WordBool; safecall;
    function SetValueAsUInt08(AValue: UInt08): WordBool; safecall;
    function SetValueAsUInt64(AValue: UInt64): WordBool; safecall;
  public
    function ReadBool(const AName: WideString; var Value: WordBool): WordBool; virtual; safecall;
    function ReadDateTime(const AName: WideString; var Value: TDateTime): WordBool; virtual; safecall;
    function ReadFloat32(const AName: WideString; var Value: Float32): WordBool; virtual; safecall;
    function ReadFloat64(const AName: WideString; var Value: Float64): WordBool; virtual; safecall;
    function ReadInt08(const AName: WideString; var Value: Int08): WordBool; virtual; safecall;
    function ReadInt16(const AName: WideString; var Value: Int16): WordBool; virtual; safecall;
    function ReadInt32(const AName: WideString; var Value: Int32): WordBool; virtual; safecall;
    function ReadInt64(const AName: WideString; var Value: Int64): WordBool; virtual; safecall;
    function ReadInteger(const AName: WideString; var Value: Integer): WordBool; virtual; safecall;
    function ReadString(const AName: WideString; var Value: WideString): WordBool; virtual; safecall;
    function ReadUInt08(const AName: WideString; var Value: UInt08): WordBool; virtual; safecall;
    function ReadUInt16(const AName: WideString; var Value: UInt16): WordBool; virtual; safecall;
    function ReadUInt32(const AName: WideString; var Value: UInt32): WordBool; virtual; safecall;
    function ReadUInt64(const AName: WideString; var Value: UInt64): WordBool; virtual; safecall;
  public
    function SaveToString(var Value: WideString): Boolean;
    //function SetXmlA(const Value: WideString): WordBool; virtual; safecall;
  public
    function WriteBool(const AName: WideString; Value: WordBool): WordBool; virtual; safecall;
    function WriteDateTime(const AName: WideString; Value: TDateTime): WordBool; virtual; safecall;
    function WriteFloat32(const AName: WideString; Value: Float32): WordBool; virtual; safecall;
    function WriteFloat64(const AName: WideString; Value: Float64): WordBool; virtual; safecall;
    function WriteInt32(const AName: WideString; Value: Int32): WordBool; virtual; safecall;
    function WriteInt64(const AName: WideString; Value: Int64): WordBool; virtual; safecall;
    function WriteInteger(const AName: WideString; Value: Integer): WordBool; virtual; safecall;
    function WriteString(const AName, Value: WideString): WordBool; virtual; safecall;
    function WriteUInt08(const AName: WideString; Value: UInt08): WordBool; virtual; safecall;
    function WriteUInt64(const AName: WideString; Value: UInt64): WordBool; virtual; safecall;
    function WriteXml(const AName, AValue: WideString): WordBool; virtual; safecall;
  public
    property AsString: WideString read GetAsString write SetAsString;
    property NodeName: DOMString{WideString} read GetNodeName; //write SetNodeName;
    property NodeValue: OleVariant read GetNodeValue write SetNodeValue;
    property Xml: DOMString{WideString} read GetXml write SetXml;
    property XmlB: WideString read GetXmlB write SetXmlB;
  end;
  TProfXmlNode = TProfXmlNode2;

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
    FToLog: TProcToLog;
  protected
    function GetChildNodeClass(const Node: IDOMNode): TXMLNodeClass; override;
    function GetDocumentElement(): IProfXmlNode; safecall;
    function Get_DocumentElement(): TProfXmlNode2;
  public
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: String; AParams: array of const): Boolean;
    constructor Create(const AFileName: WideString = ''; const AElementName: WideString = 'Config'; AToLog: TProcToLog = nil);
    procedure Free();
    function Initialize(): WordBool; virtual;
    function LoadFromString(const Value: WideString): WordBool;
    property OnToLog: TProcToLog read FToLog write FToLog;
    function SaveToString(var Value: WideString): Boolean;
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

constructor TProfXmlDocument.Create(const AFileName: WideString = ''; const AElementName: WideString = 'Config'; AToLog: TProcToLog = nil);
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

{ TProfXmlNode2 }

constructor TProfXmlNode2.Create(const ADomNode: IDOMNode; const AParentNode: TXMLNode; const OwnerDoc: TXMLDocument);
begin
  inherited;
end;

constructor TProfXmlNode2.CreateA();
begin
  inherited Create(nil, nil, nil);
  //FNode := ANode;
end;

function TProfXmlNode2.GetAsString(): WideString;
begin
  {if Assigned(FNode) and ((VarType(FNode.NodeValue) = varOleStr) or (VarType(FNode.NodeValue) = varStrArg) or (VarType(FNode.NodeValue) = varString)) then
    Result := FNode.NodeValue
  else
    Result := '';}
  if ((VarType(NodeValue) = varOleStr) or (VarType(NodeValue) = varStrArg) or (VarType(NodeValue) = varString)) then
    Result := NodeValue
  else
    Result := '';
end;

function TProfXmlNode2.Get_Collection(): IXmlNodeCollection;
begin
  //if Assigned(FNode) then Result := FNode.Collection else Result := nil;
  Result := IXmlNodeCollection(Self.Collection);
end;

{function TProfXmlNode2.GetCountNodes(): Integer;
begin
  if Assigned(FNode) then
    Result := FNode.Collection.Count
  else
    Result := 0;
end;}

{function TProfXmlNode2.GetNode(Index: Integer): TProfXmlNode2;
var
  Node: IXmlNode;
begin
  Node := FNode.Collection.Nodes[Index];
  if Assigned(Node) then
    Result := TProfXmlNode2.Create(Node)
  else
    Result := nil;
end;}

function TProfXmlNode2.GetNodeByName(const AName: WideString): IXmlNode;
var
  Node: IXmlNode;
begin
  // Поиск XML нода
  Node := Self.ChildNodes.FindNode(AName);
  // Если нету - создание XML нода
  if not(Assigned(Node)) then
    Node := Self.AddChild(AName);
  Result := Node; //as IXmlNode;
end;

function TProfXmlNode2.GetNodeByName2(const AName: WideString): IProfXmlNode;
var
  Node: IXmlNode;
begin
  {
  // Поиск XML нода
  Node := ChildNodes.FindNode(AName);
  // Если нету - создание XML нода
  if not(Assigned(Node)) then
    Node := AddChild(AName);
  Result := Node as IProfXmlNode;
  }
end;

{// -----------------------------------------------------------------------------
function TProfXmlNode2.GetNodeName(): WideString;
begin
  if Assigned(FNode) then Result := FNode.NodeName else Result := '';
end;}

{// -----------------------------------------------------------------------------
function TProfXmlNode2.GetNodeValue(): OleVariant;
begin
  if Assigned(FNode) then Result := FNode.NodeValue;
end;}

function TProfXmlNode2.GetValueAsBool(var Value: WordBool): WordBool;
begin
  // ...
end;

function TProfXmlNode2.GetValueAsDateTime(var Value: TDateTime): WordBool;
begin
  // ...
end;

function TProfXmlNode2.GetValueAsInt32(var Value: Int32): WordBool;
begin
  // ...
end;

function TProfXmlNode2.GetValueAsInt64(var AValue: Int64): WordBool;
begin
  // ...
end;

function TProfXmlNode2.GetValueAsInteger(var AValue: Integer): WordBool;
begin
  // ...
end;

function TProfXmlNode2.GetValueAsString(var Value: WideString): WordBool;
begin
  // ...
end;

function TProfXmlNode2.GetValueAsUInt08(var Value: UInt08): WordBool;
begin
  // ...
end;

function TProfXmlNode2.GetValueAsUInt64(var Value: UInt64): WordBool;
begin
  // ...
end;

function TProfXmlNode2.GetXmlB(): WideString;
begin
  Result := '';
  // ...
end;

{function TProfXmlNode2.Get_Attribute(Name: WideString): WideString;
begin
  Result := FNode.GetAttribute(Name);
end;}

{function TProfXmlNode2.Get_Xml(): WideString;
begin
  if Assigned(FNode) then
    Result := FNode.XML
  else
    Result := '';
end;}

function TProfXmlNode2.LoadFromXml(Xml: TProfXmlNode): WordBool;
begin
  Result := False;
  // ...
end;

function TProfXmlNode2.NewNode(const ANodeName: WideString): TProfXmlNode;
begin
  Result := nil;
  // ...
end;

function TProfXmlNode2.ReadBool(const AName: WideString; var Value: WordBool): WordBool;
var
  Node: IXmlNode;
begin
  //Result := Assigned(FNode);
  //if not(Result) then Exit;
  Node := ChildNodes.FindNode(AName);
  Result := Assigned(Node);
  if not(Result) then Exit;
  Result := (VarType(Node.NodeValue) = varBoolean);
  if not(Result) then Exit;
  Value := Node.NodeValue;
end;

function TProfXmlNode2.ReadDateTime(const AName: WideString; var Value: TDateTime): WordBool;
var
  S: WideString;
begin
  Result := ReadString(AName, S);
  if not(Result) then Exit;
  try
    Value := StrToDateTime(S);
    Result := True;
  except
    Result := False;
  end;
end;

function TProfXmlNode2.ReadFloat32(const AName: WideString; var Value: Float32): WordBool;
var
  Code: Integer;
  Node: IXmlNode;
begin
  //Result := Assigned(FNode);
  //if not(Result) then Exit;
  try
    Node := ChildNodes.FindNode(AName);
    Result := Assigned(Node);
    if not(Result) then Exit;
    if (VarType(Node.NodeValue) = varSingle) then
    begin
      Value := Node.NodeValue;
    end
    else if (VarType(Node.NodeValue) = varString) or (VarType(Node.NodeValue) = varOleStr) then
    begin
      Val(Node.NodeValue, Value, Code);
      Result := (Code = 0);
    end
    else
      Result := False;
  except
    Result := False;
  end;
end;

function TProfXmlNode2.ReadFloat64(const AName: WideString; var Value: Float64): WordBool;
var
  Code: Integer;
  Node: IXmlNode;
begin
  //Result := Assigned(FNode);
  //if not(Result) then Exit;
  try
    Node := ChildNodes.FindNode(AName);
    Result := Assigned(Node);
    if not(Result) then Exit;
    if (VarType(Node.NodeValue) = varDouble) then
    begin
      Value := Node.NodeValue;
    end
    else if (VarType(Node.NodeValue) = varString) or (VarType(Node.NodeValue) = varOleStr) then
    begin
      Val(Node.NodeValue, Value, Code);
      Result := (Code = 0);
    end
    else
      Result := False;
  except
    Result := False;
  end;
end;

function TProfXmlNode2.ReadInt08(const AName: WideString; var Value: Int08): WordBool;
var
  tmpValue: Integer;
begin
  Result := ReadInteger(AName, tmpValue);
  if Result then Value := tmpValue;
end;

function TProfXmlNode2.ReadInt16(const AName: WideString; var Value: Int16): WordBool;
var
  tmpValue: Integer;
begin
  Result := ReadInteger(AName, tmpValue);
  if Result then Value := tmpValue;
end;

function TProfXmlNode2.ReadInt32(const AName: WideString; var Value: Int32): WordBool;
begin
  Result := ReadInteger(AName, Value);
end;

function TProfXmlNode2.ReadInt64(const AName: WideString; var Value: Int64): WordBool;
var
  tmpValue: Integer;
begin
  Result := ReadInteger(AName, tmpValue);
  if Result then Value := tmpValue;
end;

function TProfXmlNode2.ReadInteger(const AName: WideString; var Value: Integer): WordBool;
var
  Code: Integer;
  Node: IXmlNode;
begin
  //Result := Assigned(FNode);
  //if not(Result) then Exit;
  try
    Node := ChildNodes.FindNode(AName);
    Result := Assigned(Node);
    if not(Result) then Exit;
    if (VarType(Node.NodeValue) = varInteger) then
    begin
      Value := Node.NodeValue;
    end
    else if (VarType(Node.NodeValue) = varString) or (VarType(Node.NodeValue) = varOleStr) then
    begin
      Val(Node.NodeValue, Value, Code);
      Result := (Code = 0);
    end
    else
      Result := False;
  except
    Result := False;
  end;
end;

function TProfXmlNode2.ReadString(const AName: WideString; var Value: WideString): WordBool;
var
  Node: IXmlNode;
begin
  //Result := Assigned(FNode);
  //if not(Result) then Exit;
  Node := ChildNodes.FindNode(AName);
  Result := Assigned(Node);
  if not(Result) then Exit;
  if (VarType(Node.NodeValue) = varString) or (VarType(Node.NodeValue) = varOleStr) then
  begin
    Value := Node.NodeValue;
    Result := True;
  end
  else
    Result := False;
end;

function TProfXmlNode2.ReadUInt08(const AName: WideString; var Value: UInt08): WordBool;
var
  tmpValue: Integer;
begin
  Result := ReadInteger(AName, tmpValue);
  if not(Result) then Exit;
  Value := tmpValue;
end;

function TProfXmlNode2.ReadUInt16(const AName: WideString; var Value: UInt16): WordBool;
var
  tmpValue: Integer;
begin
  Result := ReadInteger(AName, tmpValue);
  if not(Result) then Exit;
  Value := tmpValue;
end;

function TProfXmlNode2.ReadUInt32(const AName: WideString; var Value: UInt32): WordBool;
var
  tmpValue: Integer;
begin
  Result := ReadInteger(AName, tmpValue);
  if not(Result) then Exit;
  Value := tmpValue;
end;

function TProfXmlNode2.ReadUInt64(const AName: WideString; var Value: UInt64): WordBool;
var
  tmpValue: Integer;
begin
  Result := ReadInteger(AName, tmpValue);
  if not(Result) then Exit;
  Value := tmpValue;
end;

function TProfXmlNode2.SaveToString(var Value: WideString): Boolean;
begin
  Result := False;
  // ...
end;

procedure TProfXmlNode2.SetAsString(const Value: WideString);
begin
  Self.NodeValue := Value;
end;

{procedure TProfXmlNode2.SetNodeName(const Value: WideString);
begin
  //FNode.NodeName := Value;
  Self.
end;}

function TProfXmlNode2.SetValueAsBool(Value: WordBool): WordBool;
begin
  Self.NodeValue := Value;
end;

function TProfXmlNode2.SetValueAsFloat64(Value: Float64): WordBool;
begin
  Self.NodeValue := Value;
end;

function TProfXmlNode2.SetValueAsInt32(AValue: Int32): WordBool;
begin
  Self.NodeValue := AValue;
end;

function TProfXmlNode2.SetValueAsString(const AValue: WideString): WordBool;
begin
  Self.NodeValue := AValue;
end;

function TProfXmlNode2.SetValueAsUInt08(AValue: UInt08): WordBool;
begin
  Self.NodeValue := AValue;
end;

function TProfXmlNode2.SetValueAsUInt64(AValue: UInt64): WordBool;
begin
  Self.NodeValue := AValue;
end;

procedure TProfXmlNode2.SetXml(const Value: DOMString{WideString});
begin
  SetText(Value);
end;

{function TProfXmlNode2.SetXmlA(const Value: WideString): WordBool;
begin
  Result := False;
  // ...
end;}

procedure TProfXmlNode2.SetXmlB(const Value: WideString);
begin
  // ...
end;

function TProfXmlNode2.WriteBool(const AName: WideString; Value: WordBool): WordBool;
var
  Node: IXmlNode;
begin
  Node := ChildNodes.FindNode(AName);
  if Assigned(Node) then
    Node.NodeValue := Value
  else
    AddChild(AName).NodeValue := Value;
  Result := True;
end;

function TProfXmlNode2.WriteDateTime(const AName: WideString; Value: TDateTime): WordBool;
var
  Node: IXmlNode;
begin
  try
    Node := ChildNodes.FindNode(AName);
    if Assigned(Node) then
      Node.NodeValue := Value
    else
      AddChild(AName).NodeValue := Value;
    Result := True;
  except
    Result := False;
  end;
end;

function TProfXmlNode2.WriteFloat32(const AName: WideString; Value: Float32): WordBool;
var
  Node: IXmlNode;
begin
  try
    Node := ChildNodes.FindNode(AName);
    if Assigned(Node) then
      Node.NodeValue := Value
    else
      AddChild(AName).NodeValue := Value;
    Result := True;
  except
    Result := False;
  end;
end;

function TProfXmlNode2.WriteFloat64(const AName: WideString; Value: Float64): WordBool;
var
  Node: IXmlNode;
begin
  try
    Node := ChildNodes.FindNode(AName);
    if Assigned(Node) then
      Node.NodeValue := Value
    else
      AddChild(AName).NodeValue := Value;
    Result := True;
  except
    Result := False;
  end;
end;

function TProfXmlNode2.WriteInt32(const AName: WideString; Value: Int32): WordBool;
begin
  Result := WriteInteger(AName, Value);
end;

function TProfXmlNode2.WriteInt64(const AName: WideString; Value: Int64): WordBool;
begin
  Result := WriteInt32(AName, Value);
end;

function TProfXmlNode2.WriteInteger(const AName: WideString; Value: Integer): WordBool;
var
  Node: IXmlNode;
begin
  try
    Node := ChildNodes.FindNode(AName);
    if Assigned(Node) then
      Node.NodeValue := Value
    else
      AddChild(AName).NodeValue := Value;
    Result := True;
  except
    Result := False;
  end;
end;

function TProfXmlNode2.WriteString(const AName, Value: WideString): WordBool;
var
  Node: IXmlNode;
begin
  Node := ChildNodes.FindNode(AName);
  if Assigned(Node) then
    Node.NodeValue := Value
  else
    AddChild(AName).NodeValue := Value;
  Result := True;
end;

function TProfXmlNode2.WriteUInt08(const AName: WideString; Value: UInt08): WordBool;
begin
  Result := WriteInteger(AName, Value);
end;

function TProfXmlNode2.WriteUInt64(const AName: WideString; Value: UInt64): WordBool;
begin
  Result := WriteInteger(AName, Value);
end;

function TProfXmlNode2.WriteXml(const AName, AValue: WideString): WordBool;
var
  Node: IXmlNode;
begin
  Node := ChildNodes.FindNode(AName);
  if Assigned(Node) then
    Node.NodeValue := AValue
  else
    AddChild(AName).NodeValue := AValue;
  Result := True;
end;

// TProfXmlNodeCollection ------------------------------------------------------

function TProfXmlNodeCollection.GetNode(Index: Integer): TProfXmlNode;
begin
  Result := TProfXmlNode(inherited GetNode(Index));
end;

end.
