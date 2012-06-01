{**
@Abstract(Работа с XML)
@Author(Prof1983 prof1983@ya.ru)
@Created(09.10.2005)
@LastMod(22.05.2012)
@Version(0.5)

15.02.2012 - Перенес функции в ProfXmlUtils.pas
}
unit AXml3;

interface

uses
  ComObj, SysUtils, Variants, XmlDoc, XmlDom, XmlIntf,
  AConsts2, ATypes, AXmlNodeIntf, AXmlUtils;

type
  TProfXmlNode3 = class(TInterfacedObject, IProfXmlNode2, IXmlNode)
  private
    FController: IXmlNode;
    //procedure SetNodeName(const Value: WideString);
    //procedure SetXml(const Value: WideString);
  protected
    // Возвращает коллекцию вложеных нодов
    function Get_Collection(): IXmlNodeCollection; safecall;
  protected
    function GetAsString(): WideString;
    function GetXmlB(): WideString; safecall;
    procedure SetAsString(const Value: WideString);
    procedure SetXmlB(const Value: WideString); safecall;
  public // IXmlNode
    function GetAttribute(const AttrName: DOMString): OleVariant;
    function GetAttributeNodes: IXMLNodeList;
    function GetChildNodes: IXMLNodeList;
    function GetChildValue(const IndexOrName: OleVariant): OleVariant;
    function GetCollection: IXMLNodeCollection;
    function GetDOMNode: IDOMNode;
    function GetHasChildNodes: Boolean;
    function GetIsTextElement: Boolean;
    function GetLocalName: DOMString;
    function GetNamespaceURI: DOMString;
    function GetNodeName: DOMString;
    function GetNodeType: TNodeType;
    function GetNodeValue: OleVariant;
    function GetOwnerDocument: IXMLDocument;
    function GetParentNode: IXMLNode;
    function GetPrefix: DOMString;
    function GetReadOnly: Boolean;
    function GetText: DOMString;
    function GetXML: DOMString;
    procedure SetAttribute(const AttrName: DOMString; const Value: OleVariant);
    procedure SetChildValue(const IndexOrName: OleVariant; const Value: OleVariant);
    procedure SetNodeValue(const Value: OleVariant);
    procedure SetReadOnly(const Value: Boolean);
    procedure SetText(const Value: DOMString);
    { Methods }
    function AddChild(const TagName: DOMString; Index: Integer = -1): IXMLNode; overload;
    function AddChild(const TagName, NamespaceURI: DOMString;
      GenPrefix: Boolean = False; Index: Integer = -1): IXMLNode; overload;
    function CloneNode(Deep: Boolean): IXMLNode;
    procedure DeclareNamespace(const Prefix, URI: DOMString);
    function FindNamespaceURI(const TagOrPrefix: DOMString): DOMString;
    function FindNamespaceDecl(const NamespaceURI: DOMString): IXMLNode;
    function GetAttributeNS(const AttrName, NamespaceURI: DOMString): OleVariant;
    function HasAttribute(const Name: DOMString): Boolean; overload;
    function HasAttribute(const Name, NamespaceURI: DOMString): Boolean; overload;
    function NextSibling: IXMLNode;
    procedure Normalize;
    function PreviousSibling: IXMLNode;
    procedure Resync;
    procedure SetAttributeNS(const AttrName, NamespaceURI: DOMString; const Value: OleVariant);
    procedure TransformNode(const stylesheet: IXMLNode; var output: WideString); overload;
    procedure TransformNode(const stylesheet: IXMLNode; const output: IXMLDocument); overload;
  public
    constructor Create(AController: IXmlNode);
    function GetNodeByName(const AName: WideString): IXmlNode; safecall;
    function GetNodeByName2(const AName: WideString): IProfXmlNode2; safecall;
    function LoadFromXml(Xml: TProfXmlNode3): WordBool;
    function NewNode(const ANodeName: WideString): IXmlNode;
  public
    class function GetAsBoolA(ANode: IXmlNode): WordBool; safecall;
    class function GetAsDateTimeA(ANode: IXmlNode): TDateTime; safecall;
    class function GetAsFloat32A(ANode: IXmlNode): Float32; safecall;
    class function GetAsFloat64A(ANode: IXmlNode): Float64; safecall;
    class function GetAsInt32A(ANode: IXmlNode): Int32; safecall;
    class function GetAsInt64A(ANode: IXmlNode): Int64; safecall;
    class function GetAsStringA(ANode: IXmlNode): WideString; safecall;
  public
    function GetValueAsBool(var Value: WordBool): WordBool; safecall;
    function GetValueAsDateTime(var Value: TDateTime): WordBool; safecall;
    function GetValueAsFloat32(var Value: Float32): WordBool; safecall;
    function GetValueAsFloat64(var Value: Float64): WordBool; safecall;
    function GetValueAsInt32(var Value: Int32): WordBool; safecall;
    function GetValueAsInt64(var AValue: Int64): WordBool; safecall;
    function GetValueAsInteger(var AValue: Integer): WordBool; safecall;
    function GetValueAsString(var Value: WideString): WordBool; safecall;
    function GetValueAsUInt08(var Value: UInt08): WordBool; safecall;
    function GetValueAsUInt64(var Value: UInt64): WordBool; safecall;
  public
    class function GetValueAsBoolA(ANode: IXmlNode; var Value: WordBool): WordBool; safecall;
    class function GetValueAsDateTimeA(ANode: IXmlNode; var Value: TDateTime): WordBool; safecall;
    class function GetValueAsFloat32A(ANode: IXmlNode; var Value: Float32): WordBool; safecall;
    class function GetValueAsFloat64A(ANode: IXmlNode; var Value: Float64): WordBool; safecall;
    class function GetValueAsInt32A(ANode: IXmlNode; var Value: Int32): WordBool; safecall;
    class function GetValueAsInt64A(ANode: IXmlNode; var Value: Int64): WordBool; safecall;
    class function GetValueAsStringA(ANode: IXmlNode; var Value: WideString): WordBool; safecall;
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
    class function GetNodeByNameA(ANode: IXmlNode; const AName: WideString): IXmlNode; safecall;
    class function ReadBoolA(ANode: IXmlNode; const AName: WideString; var Value: WordBool): WordBool; safecall;
    class function ReadDateTimeA(ANode: IXmlNode; const AName: WideString; var Value: TDateTime): WordBool; safecall;
    class function ReadFloat32A(ANode: IXmlNode; const AName: WideString; var Value: Float32): WordBool; safecall;
    class function ReadFloat64A(ANode: IXmlNode; const AName: WideString; var Value: Float64): WordBool; safecall;
    class function ReadInt64A(ANode: IXmlNode; const AName: WideString; var Value: Int64): WordBool; safecall;
    class function ReadIntegerA(ANode: IXmlNode; const AName: WideString; var Value: Integer): WordBool; safecall;
    class function ReadStringA(ANode: IXmlNode; const AName: WideString; var Value: WideString): WordBool; safecall;
  public
    class function ReadBoolDef(ANode: IXmlNode; const AName: WideString; ADef: WordBool = False): WordBool; safecall;
    class function ReadDateTimeDef(ANode: IXmlNode; const AName: WideString; ADef: TDateTime = 0): TDateTime; safecall;
    class function ReadFloatDef(ANode: IXmlNode; const AName: WideString; ADef: Float64 = 0): Float64; safecall;
    class function ReadInt32Def(ANode: IXmlNode; const AName: WideString; ADef: Int32 = 0): Int32; safecall;
    class function ReadInt64Def(ANode: IXmlNode; const AName: WideString; ADef: Int64 = 0): Int64; safecall;
    class function ReadStringDef(ANode: IXmlNode; const AName: WideString; const ADef: WideString = ''): WideString; safecall;
  public
    class function WriteBoolA(ANode: IXmlNode; const AName: WideString; Value: WordBool): WordBool; safecall;
    class function WriteDateTimeA(ANode: IXmlNode; const AName: WideString; Value: TDateTime): WordBool; safecall;
    class function WriteFloat32A(ANode: IXmlNode; const AName: WideString; Value: Float32): WordBool; safecall;
    class function WriteFloat64A(ANode: IXmlNode; const AName: WideString; Value: Float64): WordBool; safecall;
    class function WriteIntegerA(ANode: IXmlNode; const AName: WideString; Value: Integer): WordBool; safecall;
    class function WriteStringA(ANode: IXmlNode; const AName, Value: WideString): WordBool; safecall;
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
    // Коллекция вложеных нодов
    property Collection: IXmlNodeCollection read Get_Collection;
    property AsString: WideString read GetAsString write SetAsString;
    property Controller: IXmlNode read FController write FController {implements IXmlNode};
    property XmlB: WideString read GetXmlB write SetXmlB;
  end;

type
  TProfXmlDocument3 = class
  private
    FController: IXmlDocument;
    FDefFileName: WideString;
    FDefElementName: WideString;
    FToLog: TProcToLog;
  protected
    function Get_DocumentElement(): IXmlNode;
  public
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: String; AParams: array of const): Boolean;
    constructor Create(const AFileName: WideString = ''; const AElementName: WideString = 'Config'; AToLog: TProcToLog = nil);
    procedure Free();
    function Initialize(): WordBool; virtual;
    function LoadFromString(const Value: WideString): WordBool;
    function SaveToString(var Value: WideString): Boolean;
  public
    property Controller: IXmlDocument read FController write FController;
    property DefElementName: WideString read FDefElementName write FDefElementName;
    property DefFileName: WideString read FDefFileName write FDefFileName;
    property DocumentElement: IXmlNode read Get_DocumentElement;
    property OnToLog: TProcToLog read FToLog write FToLog;
  end;

type
  TProfXmlDocument = TProfXmlDocument3;
  TProfXmlNode = TProfXmlNode3;

function ProfXmlDocument_SaveToFile3(Document: TProfXmlDocument3; const AFileName: WideString): WordBool;

implementation

{ Public }

function ProfXmlDocument_SaveToFile3(Document: TProfXmlDocument3; const AFileName: WideString): WordBool;
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
    Document.FController.SaveToFile(AFileName);
    Result := True;
  except
  end;
end;

{ TProfXmlDocument }

function TProfXmlDocument3.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: String; AParams: array of const): Boolean;
begin
  Result := False;
  if Assigned(FToLog) then
  try
    //Result := (FToLog(OLE_GROUP_MESSAGE[AGroup], OLE_TYPE_MESSAGE[AType], Format(AStrMsg, AParams)) > 0);
    Result := (FToLog(AGroup, AType, Format(AStrMsg, AParams)) > 0);
  except
  end;
end;

constructor TProfXmlDocument3.Create(const AFileName: WideString = ''; const AElementName: WideString = 'Config'; AToLog: TProcToLog = nil);
begin
  inherited Create();
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

procedure TProfXmlDocument3.Free();
begin
  {try
  if FDocument.FileName <> '' then FDocument.SaveToFile('');
  except
  end;}
  inherited Free;
end;

{function TProfXmlDocument.GetChildNodeClass(const Node: IDOMNode): TXMLNodeClass;
begin
  Result := TProfXmlNode;
end;}

{function TProfXmlDocument.GetDocumentElement(): IProfXmlNode2;
begin
  Result := IProfXmlNode2(DocumentElement);
end;}

function TProfXmlDocument3.Get_DocumentElement(): IXmlNode{TProfXmlNode};
begin
  Result := FController.DocumentElement
  //Result := TProfXmlNode(DocumentElement);
end;

function TProfXmlDocument3.Initialize(): WordBool;

  procedure CreateA();
  begin
    // Создаем документ
    AddToLog(lgGeneral, ltInformation, 'Создаем документ', []);
    Controller.FileName := '';
    // Активируем документ
    AddToLog(lgGeneral, ltInformation, 'Активируем документ', []);
    Controller.Active := True;
    // Задаем кодировку
    AddToLog(lgGeneral, ltInformation, 'Задаем кодировку "Windows-1251"', []);
    Controller.Encoding := 'Windows-1251';
    // Задаем версию
    AddToLog(lgGeneral, ltInformation, 'Задаем версию "1.0"', []);
    Controller.Version := '1.0';
    // Задаем отступы
    AddToLog(lgGeneral, ltInformation, 'Задаем отступы <2 пробела>', []);
    Controller.NodeIndentStr := '  ';
    // Создаем главный элемент документа
    AddToLog(lgGeneral, ltInformation, 'Создаем главный элемент документа "Config"', []);
    //if FDefElementName = '' then FDefElementName := 'Config';
    if FDefElementName <> '' then
    begin
      Controller.AddChild(FDefElementName);
      // Создаем дочерние элементы
      AddToLog(lgGeneral, ltInformation, 'Создаем дочерние элементы', []);
      // ...
    end;
  end;

begin
  Result := True;

  // Проверка сущестрования директории
  if FDefFileName <> '' then
    ForceDirectories(ExtractFilePath(FDefFileName));

  if not(Assigned(FController)) then
    FController := TXmlDocument.Create(nil);

  FController.ParseOptions := [poPreserveWhiteSpace];

  if FDefFileName = '' then
    CreateA()
  else
  try
    Controller.LoadFromFile(FDefFileName);
  except
    on E: Exception do
    begin
      // Произошла ошибка при открытиии файла
      AddToLog(lgGeneral, ltError, 'Произошла ошибка при открытиии файла конфигураций "%s"', [FDefFileName]);

      CreateA();

      // Сохраняем документ
      AddToLog(lgGeneral, ltInformation, 'Сохраняем документ', []);
      Controller.FileName := FDefFileName;
      Controller.SaveToFile('');
    end;
  end;
end;

function TProfXmlDocument3.LoadFromString(const Value: WideString): WordBool;
begin
  //FDocument.LoadFromXml(Value);
  Controller.XML.Text := Value;
  Result := True;
end;

{function TProfXmlDocument.NewNode(const ADomNode: IDOMNode; const AParentNode: TXMLNode;
    const OwnerDoc: TXMLDocument): TXmlNode;
begin
  Result := TProfXmlNode.Create(ADomNode, AParentNode, OwnerDoc);
end;}

// Use XmlDocument_SaveToFile()
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
    Controller.SaveToFile(AFileName);
    Result := True;
  except
  end;
end;*)

function TProfXmlDocument3.SaveToString(var Value: WideString): Boolean;
begin
  Result := False;
  try
    Value := Controller.XML.Text;
    Result := True;
  except
  end;
end;

{ TProfXmlNode }

function TProfXmlNode3.GetAttribute(const AttrName: DOMString): OleVariant;
begin
  Result := FController.Attributes[AttrName];
end;

function TProfXmlNode3.GetAttributeNodes: IXMLNodeList;
begin
  Result := FController.AttributeNodes;
end;

function TProfXmlNode3.GetChildNodes: IXMLNodeList;
begin
  Result := FController.ChildNodes;
end;

function TProfXmlNode3.GetChildValue(const IndexOrName: OleVariant): OleVariant;
begin
  Result := FController.ChildValues[IndexOrName];
end;

function TProfXmlNode3.GetCollection: IXMLNodeCollection;
begin
  Result := FController.Collection;
end;

function TProfXmlNode3.GetDOMNode: IDOMNode;
begin
  Result := FController.DOMNode;
end;

function TProfXmlNode3.GetHasChildNodes: Boolean;
begin
  Result := FController.HasChildNodes;
end;

function TProfXmlNode3.GetIsTextElement: Boolean;
begin
  Result := FController.IsTextElement;
end;

function TProfXmlNode3.GetLocalName: DOMString;
begin
  Result := FController.LocalName;
end;

function TProfXmlNode3.GetNamespaceURI: DOMString;
begin
  Result := FController.NamespaceURI;
end;

function TProfXmlNode3.GetNodeName: DOMString;
begin
  Result := FController.NodeName;
end;

function TProfXmlNode3.GetNodeType: TNodeType;
begin
  Result := FController.NodeType;
end;

function TProfXmlNode3.GetNodeValue: OleVariant;
begin
  Result := FController.NodeValue;
end;

function TProfXmlNode3.GetOwnerDocument: IXMLDocument;
begin
  Result := FController.OwnerDocument;
end;

function TProfXmlNode3.GetParentNode: IXMLNode;
begin
  Result := FController.ParentNode;
end;

function TProfXmlNode3.GetPrefix: DOMString;
begin
  Result := FController.Prefix;
end;

function TProfXmlNode3.GetReadOnly: Boolean;
begin
  Result := FController.ReadOnly;
end;

function TProfXmlNode3.GetText: DOMString;
begin
  Result := FController.Text;
end;

function TProfXmlNode3.GetXML: DOMString;
begin
  Result := FController.XML;
end;

procedure TProfXmlNode3.SetAttribute(const AttrName: DOMString; const Value: OleVariant);
begin
  FController.Attributes[AttrName] := Value;
end;

procedure TProfXmlNode3.SetChildValue(const IndexOrName: OleVariant; const Value: OleVariant);
begin
  FController.ChildValues[IndexOrName] := Value;
end;

procedure TProfXmlNode3.SetNodeValue(const Value: OleVariant);
begin
  FController.NodeValue := Value;
end;

procedure TProfXmlNode3.SetReadOnly(const Value: Boolean);
begin
  FController.ReadOnly := Value;
end;

procedure TProfXmlNode3.SetText(const Value: DOMString);
begin
  FController.Text := Value;
end;

function TProfXmlNode3.AddChild(const TagName: DOMString; Index: Integer = -1): IXMLNode;
begin
  Result := FController.AddChild(TagName, Index);
end;

function TProfXmlNode3.AddChild(const TagName, NamespaceURI: DOMString;
  GenPrefix: Boolean = False; Index: Integer = -1): IXMLNode;
begin
  Result := FController.AddChild(TagName, NamespaceURI, GenPrefix, Index);
end;

function TProfXmlNode3.CloneNode(Deep: Boolean): IXMLNode;
begin
  Result := FController.CloneNode(Deep);
end;

procedure TProfXmlNode3.DeclareNamespace(const Prefix, URI: DOMString);
begin
  FController.DeclareNamespace(Prefix, URI);
end;

function TProfXmlNode3.FindNamespaceURI(const TagOrPrefix: DOMString): DOMString;
begin
  Result := FController.FindNamespaceURI(TagOrPrefix);
end;

function TProfXmlNode3.FindNamespaceDecl(const NamespaceURI: DOMString): IXMLNode;
begin
  Result := FController.FindNamespaceDecl(NamespaceURI);
end;

function TProfXmlNode3.GetAttributeNS(const AttrName, NamespaceURI: DOMString): OleVariant;
begin
  Result := FController.GetAttributeNS(AttrName, NamespaceURI);
end;

function TProfXmlNode3.HasAttribute(const Name: DOMString): Boolean;
begin
  Result := FController.HasAttribute(Name);
end;

function TProfXmlNode3.HasAttribute(const Name, NamespaceURI: DOMString): Boolean;
begin
  Result := FController.HasAttribute(Name, NamespaceURI);
end;

function TProfXmlNode3.NextSibling: IXMLNode;
begin
  Result := FController.NextSibling();
end;

procedure TProfXmlNode3.Normalize;
begin
  FController.Normalize();
end;

function TProfXmlNode3.PreviousSibling: IXMLNode;
begin
  Result := FController.PreviousSibling();
end;

procedure TProfXmlNode3.Resync;
begin
  FController.Resync();
end;

procedure TProfXmlNode3.SetAttributeNS(const AttrName, NamespaceURI: DOMString; const Value: OleVariant);
begin
  FController.SetAttributeNS(AttrName, NamespaceURI, Value);
end;

procedure TProfXmlNode3.TransformNode(const stylesheet: IXMLNode; var output: WideString);
begin
  FController.TransformNode(Stylesheet, Output);
end;

procedure TProfXmlNode3.TransformNode(const stylesheet: IXMLNode; const output: IXMLDocument);
begin
  FController.TransformNode(Stylesheet, Output);
end;

function TProfXmlNode3.Get_Collection(): IXmlNodeCollection;
begin
  Result := FController.Collection;
end;

constructor TProfXmlNode3.Create(AController: IXmlNode);
begin
  inherited Create();
  FController := AController;
end;

class function TProfXmlNode3.GetAsBoolA(ANode: IXMLNode): WordBool;
var
  Res: WordBool;
begin
  if ProfXmlNode_GetValueAsBool(ANode, Res) then
    Result := Res
  else
    Result := False;
  {Result := False;
  GetValueAsBoolA(ANode, Result);}
end;

class function TProfXmlNode3.GetAsDateTimeA(ANode: IXMLNode): TDateTime;
var
  Res: TDateTime;
begin
  if ProfXmlNode_GetValueAsDateTime(ANode, Res) then
    Result := Res
  else
    Result := 0;
  {Result := 0;
  GetValueAsDateTimeA(ANode, Result);}
end;

class function TProfXmlNode3.GetAsFloat32A(ANode: IXMLNode): Float32;
var
  Res: Float32;
begin
  if ProfXmlNode_GetValueAsFloat32(ANode, Res) then
    Result := Res
  else
    Result := 0;
  {Result := 0;
  GetValueAsFloat32A(ANode, Result);}
end;

class function TProfXmlNode3.GetAsFloat64A(ANode: IXMLNode): Float64;
var
  Res: Float64;
begin
  if ProfXmlNode_GetValueAsFloat64(ANode, Res) then
    Result := Res
  else
    Result := 0;
  {Result := 0;
  GetValueAsFloat64A(ANode, Result);}
end;

class function TProfXmlNode3.GetAsInt32A(ANode: IXMLNode): Int32;
var
  Res: Int32;
begin
  if ProfXmlNode_GetValueAsInt32(ANode, Res) then
    Result := Res
  else
    Result := 0;
  {Result := 0;
  GetValueAsInt32A(ANode, Result);}
end;

class function TProfXmlNode3.GetAsInt64A(ANode: IXMLNode): Int64;
var
  Res: Int64;
begin
  if ProfXmlNode_GetValueAsInt64(ANode, Res) then
    Result := Res
  else
    Result := 0;
  {Result := 0;
  GetValueAsInt64A(ANode, Result);}
end;

function TProfXmlNode3.GetAsString(): WideString;
begin
  {if Assigned(FNode) and ((VarType(FNode.NodeValue) = varOleStr) or (VarType(FNode.NodeValue) = varStrArg) or (VarType(FNode.NodeValue) = varString)) then
    Result := FNode.NodeValue
  else
    Result := '';}
  if ((VarType(Controller.NodeValue) = varOleStr) or (VarType(Controller.NodeValue) = varStrArg) or (VarType(Controller.NodeValue) = varString)) then
    Result := Controller.NodeValue
  else
    Result := '';
end;

class function TProfXmlNode3.GetAsStringA(ANode: IXMLNode): WideString;
begin
  Result := '';
  GetValueAsStringA(ANode, Result);
end;

function TProfXmlNode3.GetNodeByName(const AName: WideString): IXmlNode;
var
  Node: IXmlNode;
begin
  // Поиск XML нода
  Node := FController.ChildNodes.FindNode(AName);
  // Если нету - создание XML нода
  if not(Assigned(Node)) then
    Node := FController.AddChild(AName);
  Result := Node; //as IXmlNode;
end;

function TProfXmlNode3.GetNodeByName2(const AName: WideString): IProfXmlNode2;
var
  Node: IXmlNode;
begin
  {
  // Поиск XML нода
  Node := FController.ChildNodes.FindNode(AName);
  // Если нету - создание XML нода
  if not(Assigned(Node)) then
    Node := AddChild(AName);
  Result := Node as IProfXmlNode2;
  }
end;

class function TProfXmlNode3.GetNodeByNameA(ANode: IXmlNode; const AName: WideString): IXmlNode;
{var
  Node: IXmlNode;}
begin
  Result := ProfXmlNode_GetNodeByName(ANode, AName);
  {Result := nil;
  if not(Assigned(ANode)) then Exit;
  // Поиск XML нода
  Node := ANode.ChildNodes.FindNode(AName);
  // Если нету - создание XML нода
  if not(Assigned(Node)) then
    Node := ANode.AddChild(AName);
  Result := Node as IXmlNode;}
end;

function TProfXmlNode3.GetValueAsBool(var Value: WordBool): WordBool;
begin
  Result := ProfXmlNode_GetValueAsBool(FController, Value);
  //Result := GetValueAsBoolA(FController, Value);
end;

class function TProfXmlNode3.GetValueAsBoolA(ANode: IXmlNode; var Value: WordBool): WordBool;
begin
  Result := ProfXmlNode_GetValueAsBool(ANode, Value);
  {Result := Assigned(ANode);
  if not(Result) then Exit;
  Result := False;
  try
    case VarType(ANode.NodeValue) of
      varBoolean:
        Value := ANode.NodeValue;
    else
      Value := StrToBool(ANode.NodeValue);
    end;
  except
    Result := False;
  end;}
end;

function TProfXmlNode3.GetValueAsDateTime(var Value: TDateTime): WordBool;
begin
  Result := ProfXmlNode_GetValueAsDateTime(FController, Value);
  //Result := GetValueAsDateTimeA(FController, Value);
end;

class function TProfXmlNode3.GetValueAsDateTimeA(ANode: IXmlNode; var Value: TDateTime): WordBool;
begin
  Result := ProfXmlNode_GetValueAsDateTime(ANode, Value);
  {try
    Value := ANode.NodeValue;
  except
  end;}
end;

function TProfXmlNode3.GetValueAsFloat32(var Value: Float32): WordBool;
begin
  Result := ProfXmlNode_GetValueAsFloat32(FController, Value);
  //Result := GetValueAsFloat32A(FController, Value);
end;

class function TProfXmlNode3.GetValueAsFloat32A(ANode: IXmlNode; var Value: Float32): WordBool;
{var
  Code: Integer;}
begin
  Result := ProfXmlNode_GetValueAsFloat32(ANode, Value);
  {Result := Assigned(ANode);
  if not(Result) then Exit;
  try
    if (VarType(ANode.NodeValue) = varSingle) then
    begin
      Value := ANode.NodeValue;
    end
    else if (VarType(ANode.NodeValue) = varString) or (VarType(ANode.NodeValue) = varOleStr) then
    begin
      Val(ANode.NodeValue, Value, Code);
      Result := (Code = 0);
    end
    else
      Result := False;
  except
    Result := False;
  end;}
end;

function TProfXmlNode3.GetValueAsFloat64(var Value: Float64): WordBool;
begin
  Result := ProfXmlNode_GetValueAsFloat64(FController, Value);
  //Result := GetValueAsFloat64A(FController, Value);
end;

class function TProfXmlNode3.GetValueAsFloat64A(ANode: IXmlNode; var Value: Float64): WordBool;
{var
  Code: Integer;}
begin
  Result := ProfXmlNode_GetValueAsFloat64(ANode, Value)
  {Result := Assigned(ANode);
  if not(Result) then Exit;
  try
    if (VarType(ANode.NodeValue) = varDouble) then
    begin
      Value := ANode.NodeValue;
    end
    else if (VarType(ANode.NodeValue) = varString) or (VarType(ANode.NodeValue) = varOleStr) then
    begin
      Val(ANode.NodeValue, Value, Code);
      Result := (Code = 0);
    end
    else
      Result := False;
  except
    Result := False;
  end;}
end;

function TProfXmlNode3.GetValueAsInt32(var Value: Int32): WordBool;
begin
  Result := ProfXmlNode_GetValueAsInt32(FController, Value);
  //Result := GetValueAsInt32A(FController, Value);
end;

class function TProfXmlNode3.GetValueAsInt32A(ANode: IXmlNode; var Value: Int32): WordBool;
{var
  Code: Integer;}
begin
  Result := ProfXmlNode_GetValueAsInt32(ANode, Value);
  {Result := Assigned(ANode);
  if not(Result) then Exit;
  try
    if (VarType(ANode.NodeValue) = varInteger) then
    begin
      Value := ANode.NodeValue;
    end
    else if (VarType(ANode.NodeValue) = varString) or (VarType(ANode.NodeValue) = varOleStr) then
    begin
      Val(ANode.NodeValue, Value, Code);
      Result := (Code = 0);
    end
    else
      Result := False;
  except
    Result := False;
  end;}
end;

function TProfXmlNode3.GetValueAsInt64(var AValue: Int64): WordBool;
begin
  Result := ProfXmlNode_GetValueAsInt64(FController, AValue);
  //Result := GetValueAsInt64A(FController, AValue);
end;

class function TProfXmlNode3.GetValueAsInt64A(ANode: IXmlNode; var Value: Int64): WordBool;
begin
  Result := ProfXmlNode_GetValueAsInt64(ANode, Value);
  {try
    Value := ANode.NodeValue;
  except
  end;}
end;

function TProfXmlNode3.GetValueAsInteger(var AValue: Integer): WordBool;
begin
  Result := GetValueAsInt32(AValue);
end;

function TProfXmlNode3.GetValueAsString(var Value: WideString): WordBool;
begin
  Result := GetValueAsStringA(FController, Value);
end;

class function TProfXmlNode3.GetValueAsStringA(ANode: IXmlNode; var Value: WideString): WordBool;
begin
  Result := ProfXmlNode_GetValueAsString(ANode, Value);
  {Result := Assigned(ANode);
  if not(Result) then Exit;
  try
    if (VarType(ANode.NodeValue) = varString) or (VarType(ANode.NodeValue) = varOleStr) then
    begin
      Value := ANode.NodeValue;
      Result := True;
    end
    else
      Result := False;
  except
    Result := False;
  end;}
end;

function TProfXmlNode3.GetValueAsUInt08(var Value: UInt08): WordBool;
begin
  try
    Value := FController.NodeValue;
  except
  end;
end;

function TProfXmlNode3.GetValueAsUInt64(var Value: UInt64): WordBool;
begin
  try
    Value := FController.NodeValue;
  except
  end;
end;

function TProfXmlNode3.GetXmlB(): WideString;
begin
  Result := '';
  // ...
end;

function TProfXmlNode3.LoadFromXml(Xml: TProfXmlNode): WordBool;
begin
  Result := False;
  // ...
end;

function TProfXmlNode3.NewNode(const ANodeName: WideString): IXmlNode;
begin
  Result := nil;
  if Assigned(FController) then
    Result := FController.AddChild(ANodeName);
end;

function TProfXmlNode3.ReadBool(const AName: WideString; var Value: WordBool): WordBool;
begin
  Result := ReadBoolA(FController, AName, Value);
end;

class function TProfXmlNode3.ReadBoolA(ANode: IXmlNode; const AName: WideString; var Value: WordBool): WordBool;
begin
  Result := ProfXmlNode_ReadBool(ANode, AName, Value);
end;

class function TProfXmlNode3.ReadBoolDef(ANode: IXmlNode; const AName: WideString; ADef: WordBool): WordBool;
begin
  Result := ProfXmlNode_ReadBoolDef(ANode, AName, ADef);
end;

function TProfXmlNode3.ReadDateTime(const AName: WideString; var Value: TDateTime): WordBool;
begin
  Result := ProfXmlNode_ReadDateTime(FController, AName, Value);
end;

class function TProfXmlNode3.ReadDateTimeA(ANode: IXmlNode; const AName: WideString; var Value: TDateTime): WordBool;
begin
  Result := ProfXmlNode_ReadDateTime(ANode, AName, Value);
end;

class function TProfXmlNode3.ReadDateTimeDef(ANode: IXmlNode; const AName: WideString; ADef: TDateTime): TDateTime;
begin
  Result := ProfXmlNode_ReadDateTimeDef(ANode, AName, ADef);
end;

function TProfXmlNode3.ReadFloat32(const AName: WideString; var Value: Float32): WordBool;
begin
  Result := ProfXmlNode_ReadFloat32(FController, AName, Value);
end;

class function TProfXmlNode3.ReadFloat32A(ANode: IXmlNode; const AName: WideString; var Value: Float32): WordBool;
begin
  Result := ProfXmlNode_ReadFloat32(ANode, AName, Value);
end;

function TProfXmlNode3.ReadFloat64(const AName: WideString; var Value: Float64): WordBool;
begin
  Result := ProfXmlNode_ReadFloat64(FController, AName, Value);
end;

class function TProfXmlNode3.ReadFloat64A(ANode: IXmlNode; const AName: WideString; var Value: Float64): WordBool;
begin
  Result := ProfXmlNode_ReadFloat64(ANode, AName, Value);
end;

class function TProfXmlNode3.ReadFloatDef(ANode: IXmlNode; const AName: WideString; ADef: Float64): Float64;
begin
  Result := ProfXmlNode_ReadFloatDef(ANode, AName, ADef);
end;

function TProfXmlNode3.ReadInt08(const AName: WideString; var Value: Int08): WordBool;
var
  tmpValue: Integer;
begin
  Result := ReadInteger(AName, tmpValue);
  if Result then Value := tmpValue;
end;

function TProfXmlNode3.ReadInt16(const AName: WideString; var Value: Int16): WordBool;
var
  tmpValue: Integer;
begin
  Result := ReadInteger(AName, tmpValue);
  if Result then Value := tmpValue;
end;

function TProfXmlNode3.ReadInt32(const AName: WideString; var Value: Int32): WordBool;
begin
  Result := ReadInteger(AName, Value);
end;

class function TProfXmlNode3.ReadInt32Def(ANode: IXmlNode; const AName: WideString; ADef: Int32): Int32;
begin
  Result := ADef;
  ReadIntegerA(ANode, AName, Result);
end;

function TProfXmlNode3.ReadInt64(const AName: WideString; var Value: Int64): WordBool;
var
  tmpValue: Integer;
begin
  Result := ReadInteger(AName, tmpValue);
  if Result then Value := tmpValue;
end;

class function TProfXmlNode3.ReadInt64A(ANode: IXmlNode; const AName: WideString; var Value: Int64): WordBool;
var
  tmpValue: Integer;
begin
  Result := ReadIntegerA(ANode, AName, tmpValue);
  if Result then Value := tmpValue;
end;

class function TProfXmlNode3.ReadInt64Def(ANode: IXmlNode; const AName: WideString; ADef: Int64): Int64;
begin
  Result := ADef;
  ReadInt64A(ANode, AName, Result);
end;

function TProfXmlNode3.ReadInteger(const AName: WideString; var Value: Integer): WordBool;
begin
  Result := ReadIntegerA(FController, AName, Value);
end;

class function TProfXmlNode3.ReadIntegerA(ANode: IXmlNode; const AName: WideString; var Value: Integer): WordBool;
begin
  Result := ProfXmlNode_ReadInt(ANode, AName, Value);
end;

function TProfXmlNode3.ReadString(const AName: WideString; var Value: WideString): WordBool;
begin
  Result := ReadStringA(FController, AName, Value);
end;

class function TProfXmlNode3.ReadStringA(ANode: IXmlNode; const AName: WideString; var Value: WideString): WordBool;
begin
  Result := ProfXmlNode_ReadString(ANode, AName, Value);
end;

class function TProfXmlNode3.ReadStringDef(ANode: IXmlNode; const AName: WideString; const ADef: WideString): WideString;
begin
  Result := ADef;
  ReadStringA(ANode, AName, Result);
end;

function TProfXmlNode3.ReadUInt08(const AName: WideString; var Value: UInt08): WordBool;
var
  tmpValue: Integer;
begin
  Result := ReadInteger(AName, tmpValue);
  if not(Result) then Exit;
  Value := tmpValue;
end;

function TProfXmlNode3.ReadUInt16(const AName: WideString; var Value: UInt16): WordBool;
var
  tmpValue: Integer;
begin
  Result := ReadInteger(AName, tmpValue);
  if not(Result) then Exit;
  Value := tmpValue;
end;

function TProfXmlNode3.ReadUInt32(const AName: WideString; var Value: UInt32): WordBool;
var
  tmpValue: Integer;
begin
  Result := ReadInteger(AName, tmpValue);
  if not(Result) then Exit;
  Value := tmpValue;
end;

function TProfXmlNode3.ReadUInt64(const AName: WideString; var Value: UInt64): WordBool;
var
  tmpValue: Integer;
begin
  Result := ReadInteger(AName, tmpValue);
  if not(Result) then Exit;
  Value := tmpValue;
end;

function TProfXmlNode3.SaveToString(var Value: WideString): Boolean;
begin
  Result := Assigned(FController);
  Value := FController.Xml;
end;

procedure TProfXmlNode3.SetAsString(const Value: WideString);
begin
  if Assigned(FController) then
    Controller.NodeValue := Value; // Не правильно
end;

function TProfXmlNode3.SetValueAsBool(Value: WordBool): WordBool;
begin
  if Assigned(FController) then
    Controller.NodeValue := Value;
end;

function TProfXmlNode3.SetValueAsFloat64(Value: Float64): WordBool;
begin
  if Assigned(FController) then
    Controller.NodeValue := Value;
end;

function TProfXmlNode3.SetValueAsInt32(AValue: Int32): WordBool;
begin
  if Assigned(FController) then
    Controller.NodeValue := AValue;
end;

function TProfXmlNode3.SetValueAsString(const AValue: WideString): WordBool;
begin
  if Assigned(FController) then
    Controller.NodeValue := AValue;
end;

function TProfXmlNode3.SetValueAsUInt08(AValue: UInt08): WordBool;
begin
  if Assigned(FController) then
    Controller.NodeValue := AValue;
end;

function TProfXmlNode3.SetValueAsUInt64(AValue: UInt64): WordBool;
begin
  if Assigned(FController) then
    Controller.NodeValue := AValue;
end;

{procedure TProfXmlNode.SetXml(const Value: WideString);
begin
  if Assigned(FController) then
    Controller.SetText(Value);
end;}

procedure TProfXmlNode3.SetXmlB(const Value: WideString);
begin
  // ...
end;

function TProfXmlNode3.WriteBool(const AName: WideString; Value: WordBool): WordBool;
begin
  Result := ProfXmlNode_WriteBool(FController, AName, Value);
end;

class function TProfXmlNode3.WriteBoolA(ANode: IXmlNode; const AName: WideString; Value: WordBool): WordBool;
begin
  Result := ProfXmlNode_WriteBool(ANode, AName, Value);
end;

function TProfXmlNode3.WriteDateTime(const AName: WideString; Value: TDateTime): WordBool;
begin
  Result := WriteDateTimeA(FController, AName, Value);
end;

class function TProfXmlNode3.WriteDateTimeA(ANode: IXmlNode; const AName: WideString; Value: TDateTime): WordBool;
var
  Node: IXmlNode;
begin
  Result := Assigned(ANode);
  if not(Result) then Exit;
  try
    Node := ANode.ChildNodes.FindNode(AName);
    if Assigned(Node) then
      Node.NodeValue := Value
    else
      ANode.AddChild(AName).NodeValue := Value;
    Result := True;
  except
    Result := False;
  end;
end;

function TProfXmlNode3.WriteFloat32(const AName: WideString; Value: Float32): WordBool;
begin
  Result := WriteFloat32A(FController, AName, Value);
end;

class function TProfXmlNode3.WriteFloat32A(ANode: IXmlNode; const AName: WideString; Value: Float32): WordBool;
var
  Node: IXmlNode;
begin
  Result := Assigned(ANode);
  if not(Result) then Exit;
  try
    Node := ANode.ChildNodes.FindNode(AName);
    if Assigned(Node) then
      Node.NodeValue := Value
    else
      ANode.AddChild(AName).NodeValue := Value;
    Result := True;
  except
    Result := False;
  end;
end;

function TProfXmlNode3.WriteFloat64(const AName: WideString; Value: Float64): WordBool;
begin
  Result := WriteFloat64A(FController, AName, Value);
end;

class function TProfXmlNode3.WriteFloat64A(ANode: IXmlNode; const AName: WideString; Value: Float64): WordBool;
begin
  Result := ProfXmlNode_WriteFloat64(ANode, AName, Value);
end;

function TProfXmlNode3.WriteInt32(const AName: WideString; Value: Int32): WordBool;
begin
  Result := WriteInteger(AName, Value);
end;

function TProfXmlNode3.WriteInt64(const AName: WideString; Value: Int64): WordBool;
begin
  Result := WriteInt32(AName, Value);
end;

function TProfXmlNode3.WriteInteger(const AName: WideString; Value: Integer): WordBool;
begin
  Result := WriteIntegerA(FController, AName, Value);
end;

class function TProfXmlNode3.WriteIntegerA(ANode: IXmlNode; const AName: WideString; Value: Integer): WordBool;
begin
  Result := ProfXmlNode_WriteInt(ANode, AName, Value);
end;

function TProfXmlNode3.WriteString(const AName, Value: WideString): WordBool;
begin
  Result := WriteStringA(FController, AName, Value);
end;

class function TProfXmlNode3.WriteStringA(ANode: IXmlNode; const AName, Value: WideString): WordBool;
begin
  Result := ProfXmlNode_WriteString(ANode, AName, Value);
end;

function TProfXmlNode3.WriteUInt08(const AName: WideString; Value: UInt08): WordBool;
begin
  Result := WriteInteger(AName, Value);
end;

function TProfXmlNode3.WriteUInt64(const AName: WideString; Value: UInt64): WordBool;
begin
  Result := WriteInteger(AName, Value);
end;

function TProfXmlNode3.WriteXml(const AName, AValue: WideString): WordBool;
var
  Node: IXmlNode;
begin
  Node := Controller.ChildNodes.FindNode(AName);
  if Assigned(Node) then
    Node.NodeValue := AValue
  else
    Controller.AddChild(AName).NodeValue := AValue;
  Result := True;
end;

end.
