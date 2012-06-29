{**
@Abstract(Класс работы с XML нодами)
@Author(Prof1983 prof1983@ya.ru)
@Created(07.03.2007)
@LastMod(29.06.2012)
@Version(0.5)
}
unit AXmlNodeImpl;

// TODO: Разделить на AXmlNodeObj и AXmlNodeImpl.

interface

uses
  Classes, SysUtils, Variants, XmlDom, XmlIntf,
  AAttributesIntf, ABase, ABaseUtils2, AConsts2, AEntityImpl, ANodeIntf, ATypes,
  AXmlAttributesImpl, AXmlAttributesUtils, AXmlCollectionImpl, AXmlDocumentImpl,
  AXmlNodeIntf, AXmlNodeUtils, AXmlNodeListUtils, AXmlUtils;
  // --- for TProfXmlNode4 ---
  //ComObj, XmlDoc,


type //** Класс работы с XML нодами
  TProfXmlNode = class(TANamedEntity, IProfNode)
  protected
    //** Объект работы с атрибутами
    FAttributes: TProfXmlAttributes;
    FNode: IXmlNode;
    FNodes: array of TProfXmlNode;
    procedure SetNode(Value: IXmlNode);
  public
    function GetAsBool(): WordBool; safecall;
    function GetAsDateTime(): TDateTime; safecall;
    function GetAsFloat32(): Float32; safecall;
    function GetAsFloat64(): Float64; safecall;
    function GetAsInt32(): Integer; safecall;
    function GetAsInt64(): Int64; safecall;
    function GetAsString(): WideString; safecall;
  public
    //** Возвращает объект работы с атрибутами
//    function GetAttributes(): IProfXmlAttributes; safecall;
    //** Получить вложеный нод по индесу
    function GetNodeByIndex(AIndex: Integer): IProfNode; safecall;
    //** Получить вложеный нод по имени (AXmlNode_GetChildNodeByName)
    function GetNodeByName(const AName: WideString): AProfXmlNode;
    //** Возвращает колличество вложенных нодов
    function GetNodeCount(): Integer; safecall;
    //** Получить имя нода
    function GetNodeName(): WideString; safecall;
    function GetXmlString(): WideString; safecall;
    procedure SetXmlString(const Value: WideString); safecall;
  protected
    function GetAttributes(): IProfAttributes; safecall;
    function GetChildNodes(): IProfNodes; safecall;
  public
    class function GetValueAsBoolA(ANode: IXmlNode; var Value: WordBool): WordBool; safecall;
    class function GetValueAsDateTimeA(ANode: IXmlNode; var Value: TDateTime): WordBool; safecall;
    class function GetValueAsFloat32A(ANode: IXmlNode; var Value: Float32): WordBool; safecall;
    class function GetValueAsFloat64A(ANode: IXmlNode; var Value: Float64): WordBool; safecall;
    class function GetValueAsInt32A(ANode: IXmlNode; var Value: Integer): WordBool; safecall;
    class function GetValueAsInt64A(ANode: IXmlNode; var Value: Int64): WordBool; safecall;
    class function GetValueAsStringA(ANode: IXmlNode; var Value: WideString): WordBool; safecall;
  protected
    function GetValueAsBool(var Value: WordBool): WordBool; safecall;
    function GetValueAsDateTime(var Value: TDateTime): WordBool; safecall;
    function GetValueAsFloat32(var Value: Float32): WordBool; safecall;
    function GetValueAsFloat64(var Value: Float64): WordBool; safecall;
    function GetValueAsInt32(var Value: Integer): WordBool; safecall;
    function GetValueAsInt64(var AValue: Int64): WordBool; safecall;
    function GetValueAsString(var Value: WideString): WordBool; safecall;
  protected
    procedure SetAsString(const Value: WideString); safecall;
  protected
    function SetValueAsBool(Value: WordBool): WordBool; safecall;
    function SetValueAsFloat64(Value: Float64): WordBool; safecall;
    function SetValueAsInt32(AValue: Integer): WordBool; safecall;
    function SetValueAsString(const AValue: WideString): WordBool; safecall;
    function SetValueAsUInt08(AValue: Byte): WordBool; safecall;
  public
    class function ReadBoolA(ANode: IXmlNode; const AName: WideString; var Value: WordBool): WordBool; safecall;
    class function ReadDateTimeA(ANode: IXmlNode; const AName: WideString; var Value: TDateTime): WordBool; safecall;
    class function ReadFloat32A(ANode: IXmlNode; const AName: WideString; var Value: Float32): WordBool; safecall;
    class function ReadFloat64A(ANode: IXmlNode; const AName: WideString; var Value: Float64): WordBool; safecall;
    class function ReadInt32A(ANode: IXmlNode; const AName: WideString; var Value: Integer): WordBool; safecall;
    class function ReadInt64A(ANode: IXmlNode; const AName: WideString; var Value: Int64): WordBool; safecall;
    class function ReadStringA(ANode: IXmlNode; const AName: WideString; var Value: WideString): WordBool; safecall;
  public
    function ReadBool(const Name: WideString; var Value: WordBool): WordBool; safecall;
    function ReadBoolDef(const Name: WideString; DefValue: WordBool): WordBool; safecall;
    function ReadDateTime(const Name: WideString; var Value: TDateTime): WordBool; safecall;
    function ReadDateTimeDef(const Name: WideString; DefValue: TDateTime): TDateTime; safecall;
    function ReadFloat64(const Name: WideString; var Value: Double): WordBool; safecall;
    function ReadFloat64Def(const Name: WideString; DefValue: Double): Double; safecall;
    function ReadInt32(const Name: WideString; var Value: Integer): WordBool; safecall;
    function ReadInt32Def(const Name: WideString; DefValue: Integer): Integer; safecall;
    function ReadInt64(const Name: WideString; var Value: Int64): WordBool; safecall;
    function ReadInt64Def(const Name: WideString; DefValue: Int64): Int64; safecall;
    function ReadString(const Name: WideString; var Value: WideString): WordBool; safecall;
    function ReadStringDef(const Name: WideString; const DefValue: WideString): WideString; safecall;
  public
    class function WriteBoolA(ANode: IXmlNode; const AName: WideString; Value: WordBool): WordBool; safecall;
    class function WriteDateTimeA(ANode: IXmlNode; const AName: WideString; Value: TDateTime): WordBool; safecall;
    class function WriteFloat32A(ANode: IXmlNode; const AName: WideString; Value: Real): WordBool; safecall;
    class function WriteFloat64A(ANode: IXmlNode; const AName: WideString; Value: Double): WordBool; safecall;
    class function WriteInt32A(ANode: IXmlNode; const AName: WideString; Value: Integer): WordBool; safecall;
    class function WriteInt64A(ANode: IXmlNode; const AName: WideString; Value: Int64): WordBool; safecall;
    class function WriteStringA(ANode: IXmlNode; const AName, Value: WideString): WordBool; safecall;
  public
    function WriteBool(const AName: WideString; Value: WordBool): WordBool; safecall;
    function WriteDateTime(const AName: WideString; AValue: TDateTime): WordBool; safecall;
    function WriteFloat64(const AName: WideString; Value: Float64): WordBool; safecall;
    function WriteInt32(const AName: WideString; Value: Int32): WordBool; safecall;
    function WriteInt64(const AName: WideString; Value: Int64): WordBool; safecall;
    function WriteString(const AName, Value: WideString): WordBool; safecall;
    //function WriteXml(const AName, Value: WideString): WordBool; safecall;
  public
    constructor Create();
    procedure Free();
  public
    property AsString: WideString read GetAsString write SetAsString;
  public
    property Node: IXmlNode read FNode write SetNode;
    //** Вложеные ноды по индексу
    property NodeByIndex[Index: Integer]: IProfNode read GetNodeByIndex;
    //** Вложеные ноды по имени
    property NodeByName[const Name: WideString]: AProfXmlNode read GetNodeByName;
    //** Колличество вложеных нодов
    property NodeCount: Integer read GetNodeCount;
    //** Имя нода
    property NodeName: WideString read GetNodeName;
  end;

  TProfXmlNode2 = class(TInterfacedObject{TXmlNode}, IProfXmlNode2{, IXmlNode})
  protected
    FChildNodes: AXmlNodeList;
    FNode: IXmlNode{TXmlNode};
  protected
    function Get_Attribute(Name: WideString): WideString;
    function Get_Collection: IXmlNodeCollection; safecall;
    function Get_Xml(): WideString;
    procedure Set_Attribute(Name, Value: WideString);
    procedure Set_Xml(const Value: WideString);
  public
    function GetAsString(): WideString;
    function GetChildNodes(): AXmlNodeList;
    function GetCollection(): IXmlNodeCollection;
    function GetCountNodes(): Integer;
    function GetNode(Index: Integer): TProfXmlNode2;
    function GetNodeByName(const AName: WideString): IXmlNode; safecall;
    function GetNodeByName1(const AName: WideString): TProfXmlNode2;
    function GetNodeByName2(const AName: WideString): IProfXmlNode; safecall;
    function GetNodeName(): WideString;
    function GetNodeValue(): OleVariant;
    function GetXml(): WideString;
    function GetXmlB(): WideString;
    procedure SetAsString(const Value: WideString);
    procedure SetNodeName(const Value: WideString);
    procedure SetNodeValue(Value: OleVariant);
    procedure SetXml(const Value: {DOMString}WideString);
    procedure SetXmlB(const Value: WideString); safecall;
  public
    function AddFromXml(Xml: TProfXmlNode2): TError;
    function LoadFromXml(Xml: TProfXmlNode2): WordBool;
    function NewNode(const ANodeName: WideString): TProfXmlNode2;
    function SaveToString(var Value: WideString): Boolean;
    function SetXmlA(const Value: WideString): WordBool; virtual;
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
    constructor Create(Node: IXmlNode);
    //constructor Create(const ADomNode: IDOMNode; const AParentNode: TXMLNode; const OwnerDoc: TXMLDocument);
    //constructor CreateA();
  public
    property AsString: WideString read GetAsString write SetAsString;
    property Collection: IXmlNodeCollection read GetCollection;
    property Node: IXmlNode read FNode; //implements IXmlNode;
    property NodeName: WideString read GetNodeName write SetNodeName;
    property NodeValue: OleVariant read GetNodeValue write SetNodeValue;
    property Xml: {DOMString}WideString read GetXml write SetXml;
    property XmlB: WideString read GetXmlB write SetXmlB;
  end;

  // Use unXml3.TProfXmlNode
  // XML элемент
  TProfXmlNode1 = class(TInterfacedObject, IProfXmlNodeNew, IProfXmlNode2006)
  protected
    FAttributes: TAttributes;
    FCollection: TProfXmlCollection;
    FDocument: TProfXmlDocument1;
    FName: WideString;
    FValue: WideString;
  private
    procedure GetNameAndAttributes(Value: WideString);
    function ReadNodes(var Value: WideString; CloseTag: WideString): Boolean;
  private
    function _GetValueAsBool(): WordBool;
    function _GetValueAsString(): WideString;
    procedure _SetValueAsBool(Value: WordBool);
    procedure _SetValueAsString(Value: WideString);
  public // IProfXmlNodeNew
    function Attributes_Count(): Integer;
    function Get_Attribute(const Name: WideString): WideString;
    function Get_Attribute_Name(Index: Integer): WideString;
    function Get_Attribute_Value(Index: Integer): WideString;
    function Get_Collection(): AXmlCollection; //IProfXmlCollection;
    function Get_NodeName(): WideString;
    function Get_NodeValue(): WideString;
    function Get_Xml(): WideString;
    procedure Set_Attribute(const Name, Value: WideString);
    procedure Set_NodeName(const Value: WideString);
    procedure Set_NodeValue(const Value: WideString);
    procedure Set_Xml(const Value: WideString);
  public
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: string; AParams: array of const): Boolean;
    function Clear(): AError;
    function FindNode(Name: WideString): TProfXmlNode1;
  public
    function GetAttribute(const Name: WideString; UpperCase: Boolean = False): WideString;
    function GetCountNodes(): Integer;
    function GetName(): WideString;
    function GetNode(Index: Integer): TProfXmlNode1;
    function GetNodeByName(Name: WideString): TProfXmlNode1;
    procedure SetDocument_Priv(Document: AXmlDocument);
    procedure SetName(Value: WideString);
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
    function GetXml(): WideString;
    function GetXmlA(Prefix: WideString): WideString;
    {** Возвращает все дочерние ноды }
    function GetXmlB(): WideString;
    {**
      Создает новую дочернюю структуру, разбирая строку
      Value - элемент
    }
    function SetXml(const AValue: WideString): WordBool;
    {**
      Создает новую дочернюю структуру, разбирая строку
      Value - дочерние элементы
    }
    function SetXmlA(var Value: WideString; const CloseTag: WideString = ''): WordBool;
    function ToStrings(AStrings: TStrings; Prefix: WideString = ''): Boolean;
  public
    function ReadBool(const AName: WideString; var Value: WordBool): WordBool; virtual; safecall;
    function ReadDateTime(const AName: WideString; var Value: TDateTime): WordBool; virtual; safecall;
    function ReadFloat64(const AName: WideString; var Value: Float64): WordBool; virtual; safecall;
    function ReadInt32(const AName: WideString; var Value: Int32): WordBool; virtual; safecall;
    function ReadInt64(const AName: WideString; AValue: Int64): WordBool; virtual; safecall;
    function ReadInteger(const AName: WideString; var AValue: Integer): WordBool; virtual; safecall;
    function ReadString(const AName: WideString; var Value: WideString): WordBool; virtual; safecall;
    function ReadUInt08(const AName: WideString; var Value: UInt08): WordBool; virtual; safecall;
    function ReadUInt64(const AName: WideString; var Value: UInt64): WordBool; virtual; safecall;
    function ReadWideString(const AName: WideString; var Value: WideString): WordBool; virtual; safecall;
  public
    function SetValueAsBool(Value: WordBool): WordBool; safecall;
    function SetValueAsFloat64(Value: Float64): WordBool; safecall;
    function SetValueAsInt32(AValue: Int32): WordBool; safecall;
    function SetValueAsString(const AValue: WideString): WordBool; safecall;
    function SetValueAsUInt08(AValue: UInt08): WordBool; safecall;
    function SetValueAsUInt64(AValue: UInt64): WordBool; safecall;
  public
    function WriteBool(const AName: WideString; Value: WordBool): WordBool; virtual; safecall;
    function WriteDateTime(const AName: WideString; AValue: TDateTime): WordBool; virtual; safecall;
    function WriteFloat64(const AName: WideString; Value: Float64): WordBool; virtual; safecall;
    function WriteInt32(const AName: WideString; Value: Int32): WordBool; virtual; safecall;
    function WriteInt64(const AName: WideString; Value: Int64): WordBool; virtual; safecall;
    function WriteInteger(const AName: WideString; Value: Integer): WordBool; virtual; safecall;
    function WriteString(const AName, Value: WideString): WordBool; virtual; safecall;
    function WriteUInt08(const AName: WideString; AValue: UInt08): WordBool; virtual; safecall;
    function WriteUInt64(const AName: WideString; AValue: UInt64): WordBool; virtual; safecall;
    function WriteXml(const AName, Value: WideString): WordBool; safecall;
  public
    function Load(): Boolean; virtual;
    function LoadFromXml(AXml: TProfXmlNode1): Boolean;
    function NewNode(const AName: WideString): TProfXmlNode1;
    function NodeExist(AName: WideString): Boolean;
  public
    constructor Create(Document: AXmlDocument = 0);
    procedure Free(); virtual;
  public
    property Attributes[const Name: WideString]: WideString read Get_Attribute write Set_Attribute;
    property Attribute_Name[Index: Integer]: WideString read Get_Attribute_Name;
    property Attribute_Value[Index: Integer]: WideString read Get_Attribute_Value;
    property AsBoolean: WordBool read _GetValueAsBool write _SetValueAsBool;
    property AsString: WideString read _GetValueAsString write _SetValueAsString;
  public
    property Collection: TProfXmlCollection read FCollection;
    property Document: TProfXmlDocument1 read FDocument;
    property OwnerDocument: TProfXmlDocument1 read FDocument;
    property NodeName: WideString read Get_NodeName write Set_NodeName;
    //property NodeValue: WideString read Get_NodeValue write Set_NodeValue;
    property Xml: WideString read Get_Xml write Set_Xml;
  end;

  TProfXmlNode4 = class(TProfXmlNode2, IXmlNode)
  private
    FController: IXmlNode;
    //procedure SetNodeName(const Value: WideString);
    //procedure SetXml(const Value: WideString);
  protected
    // Возвращает коллекцию вложеных нодов
    function Get_Collection(): IXmlNodeCollection; safecall;
  protected
    function GetAsString(): WideString;
    function GetXmlB(): WideString;
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
    constructor Create(Controller: IXmlNode);
    function GetNodeByName(const AName: WideString): IXmlNode; safecall;
    function GetNodeByName2(const AName: WideString): IProfXmlNode2; safecall;
    function LoadFromXml(Xml: AProfXmlNode{TProfXmlNode4}): WordBool;
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

implementation

// --- Private ---

{**
  Выделить имя и атрибуты их строки "tag attr1="value1" attr2="value2""
}
procedure _GetNameAndAttributes(Value: WideString; var FAttributes: TAttributes; var FName: WideString);
//procedure GetNameAndAttributes(Value: WideString; var FAttributes: TAttributes; var FName: WideString);
var
  I: Integer;
  AName: WideString;
  AValue: WideString;
begin
  I := Pos(' ', Value);
  // Выделение имени
  if I = 0 then
  begin
    FName := Value;
    Exit;
  end
  else
  begin
    FName := Copy(Value, 1, I - 1);
    Value := Copy(Value, I + 1, Length(Value));
  end;
  // Выделение атрибутов
  repeat
    // Выделение имени атрибута
    I := Pos('=', Value);
    if I = 0 then Exit;
    AName := Copy(Value, 1, I - 1);
    Value := Copy(Value, I + 1, Length(Value));
    // Выделение значения
    if Length(Value) > 0 then
    begin
      if Value[1] = '"' then // Если есть открывающая кавычка
      begin
        Value := Copy(Value, 2, Length(Value));
        I := Pos('"', Value); // Закрывающая кавычка
        AValue := Copy(Value, 1, I - 1);
        Value := Copy(Value, I + 1, Length(Value));
        Value := StrDeleteSpace(Value, [dsFirst, dsLast, dsRep]);
      end
      else
      begin // Если нет открывающей кавычки
        I := Pos(' ', Value);
        AValue := Copy(Value, 1, I - 1);
        Value := Copy(Value, I + 1, Length(Value));
        Value := StrDeleteSpace(Value, [dsFirst, dsLast, dsRep]);
      end;
    end
    else
      AValue := ''; // Пустое значение
    // Создание атрибута
    SetAttribute(FAttributes, AName, AValue);
  until Length(Value) = 0;
end;

{ TProfXmlNode }

constructor TProfXmlNode.Create();
begin
  inherited Create();
  FAttributes := TProfXmlAttributes.Create();
end;

procedure TProfXmlNode.Free();
var
  i: Integer;
begin
  for i := 0 to High(FNodes) do
    FNodes := nil;
  SetLength(FNodes, 0);
  FNode := nil;
end;

function TProfXmlNode.GetAsBool(): WordBool;
begin
  Result := False;
  GetValueAsBool(Result);
end;

function TProfXmlNode.GetAsDateTime(): TDateTime;
begin
  Result := 0;
  GetValueAsDateTime(Result);
end;

function TProfXmlNode.GetAsFloat32(): Float32;
begin
  Result := 0;
  GetValueAsFloat32(Result);
end;

function TProfXmlNode.GetAsFloat64(): Float64;
begin
  Result := 0;
  GetValueAsFloat64(Result);
end;

function TProfXmlNode.GetAsInt32(): Integer;
begin
  Result := 0;
  GetValueAsInt32(Result);
end;

function TProfXmlNode.GetAsInt64(): Int64;
begin
  Result := 0;
  GetValueAsInt64(Result);
end;

function TProfXmlNode.GetAsString(): WideString;
begin
  Result := '';
  GetValueAsString(Result);
end;

function TProfXmlNode.GetAttributes(): IProfAttributes;
begin
  Result := FAttributes;
end;

function TProfXmlNode.GetChildNodes(): IProfNodes;
begin
  Result := nil;
  // ...
end;

function TProfXmlNode.GetNodeByIndex(AIndex: Integer): IProfNode;
var
  i: Integer;
begin
  Result := nil;
  if Assigned(FNode) then
  try
    if (Length(FNodes) = 0) and (FNode.ChildNodes.Count > 0) then
    try
      // Заполнение FNodes
      SetLength(FNodes, FNode.ChildNodes.Count);
      for i := 0 to High(FNodes) do
      begin
        FNodes[i] := TProfXmlNode.Create();
        FNodes[i].SetNode(FNode.ChildNodes.Nodes[i]);
      end;
    except
      SetLength(FNodes, 0);
      Exit;
    end;
    if (AIndex >= 0) and (AIndex < Length(FNodes)) then
      Result := FNodes[AIndex];
  except
  end;
end;

function TProfXmlNode.GetNodeByName(const AName: WideString): AProfXmlNode;
var
  i: Integer;
begin
  if not(Assigned(FNode)) then
  begin
    Result := 0;
    Exit;
  end;
  try
    if (Length(FNodes) = 0) and (FNode.ChildNodes.Count > 0) then
    try
      // Заполнение FNodes
      SetLength(FNodes, FNode.ChildNodes.Count);
      for i := 0 to High(FNodes) do
      begin
        FNodes[i] := TProfXmlNode.Create();
        FNodes[i].SetNode(FNode.ChildNodes.Nodes[i]);
      end;
    except
      SetLength(FNodes, 0);
      Exit;
    end;
    for i := 0 to High(FNodes) do
    begin
      if (FNodes[i].NodeName = AName) then
      begin
        Result := AProfXmlNode(FNodes[i]);
        Exit;
      end;
    end;
  except
    Result := 0;
  end;
end;

function TProfXmlNode.GetNodeCount(): Integer;
begin
  if not(Assigned(FNode)) then
  begin
    Result := -1;
    Exit;
  end;
  try
    Result := FNode.ChildNodes.Count;
  except
    Result := -1;
  end;
end;

function TProfXmlNode.GetNodeName(): WideString;
begin
  Result := '';
  if Assigned(FNode) then
  try
    Result := FNode.NodeName;
  except
  end;
end;

function TProfXmlNode.GetValueAsBool(var Value: WordBool): WordBool;
begin
  Result := GetValueAsBoolA(FNode, Value);
end;

class function TProfXmlNode.GetValueAsBoolA(ANode: IXmlNode; var Value: WordBool): WordBool;
begin
  Result := Assigned(ANode);
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
  end;
end;

function TProfXmlNode.GetValueAsDateTime(var Value: TDateTime): WordBool;
begin
  Result := GetValueAsDateTimeA(FNode, Value);
end;

class function TProfXmlNode.GetValueAsDateTimeA(ANode: IXmlNode; var Value: TDateTime): WordBool;
begin
  try
    Value := ANode.NodeValue;
  except
  end;
end;

function TProfXmlNode.GetValueAsFloat32(var Value: Float32): WordBool;
begin
  Result := GetValueAsFloat32A(FNode, Value);
end;

class function TProfXmlNode.GetValueAsFloat32A(ANode: IXmlNode; var Value: Float32): WordBool;
var
  Code: Integer;
begin
  Result := Assigned(ANode);
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
  end;
end;

function TProfXmlNode.GetValueAsFloat64(var Value: Float64): WordBool;
begin
  Result := GetValueAsFloat64A(FNode, Value);
end;

class function TProfXmlNode.GetValueAsFloat64A(ANode: IXmlNode; var Value: Float64): WordBool;
var
  s: string;
begin
  Result := Assigned(ANode);
  if not(Result) then Exit;
  try
    if (VarType(ANode.NodeValue) = varDouble) then
    begin
      Value := ANode.NodeValue;
    end
    else if (VarType(ANode.NodeValue) = varString) or (VarType(ANode.NodeValue) = varOleStr) then
    begin
      s := ANode.NodeValue;
      Result := TryStrToFloat(s, Value);
    end
    else
      Result := False;
  except
    Result := False;
  end;
end;

function TProfXmlNode.GetValueAsInt32(var Value: Integer): WordBool;
begin
  Result := GetValueAsInt32A(FNode, Value);
end;

class function TProfXmlNode.GetValueAsInt32A(ANode: IXmlNode; var Value: Integer): WordBool;
var
  Code: Integer;
begin
  Result := Assigned(ANode);
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
  end;
end;

function TProfXmlNode.GetValueAsInt64(var AValue: Int64): WordBool;
begin
  Result := GetValueAsInt64A(FNode, AValue);
end;

class function TProfXmlNode.GetValueAsInt64A(ANode: IXmlNode; var Value: Int64): WordBool;
var
  tmp: Integer;
begin
  tmp := Value;
  Result := GetValueAsInt32A(ANode, tmp);
  Value := tmp;
end;

function TProfXmlNode.GetValueAsString(var Value: WideString): WordBool;
begin
  Result := GetValueAsStringA(FNode, Value);
end;

class function TProfXmlNode.GetValueAsStringA(ANode: IXmlNode; var Value: WideString): WordBool;
begin
  Result := Assigned(ANode);
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
  end;
end;

function TProfXmlNode.GetXmlString(): WideString;
begin
  if Assigned(FNode) then
  try
    Result := FNode.XML;
  except
  end;
end;

function TProfXmlNode.ReadBool(const Name: WideString; var Value: WordBool): WordBool;
begin
  Result := ReadBoolA(FNode, Name, Value);
end;

class function TProfXmlNode.ReadBoolA(ANode: IXmlNode; const AName: WideString; var Value: WordBool): WordBool;
var
  Node: IXmlNode;
begin
  Result := Assigned(ANode);
  if not(Result) then Exit;
  Node := ANode.ChildNodes.FindNode(AName);
  Result := Assigned(Node);
  if not(Result) then Exit;
  Result := GetValueAsBoolA(Node, Value);
end;

function TProfXmlNode.ReadBoolDef(const Name: WideString; DefValue: WordBool): WordBool;
begin
  Result := DefValue;
  ReadBool(Name, Result)
end;

function TProfXmlNode.ReadDateTime(const Name: WideString; var Value: TDateTime): WordBool;
begin
  Result := ReadDateTimeA(FNode, Name, Value);
end;

class function TProfXmlNode.ReadDateTimeA(ANode: IXmlNode; const AName: WideString; var Value: TDateTime): WordBool;
var
  S: WideString;
begin
  Result := ReadStringA(ANode, AName, S);
  if not(Result) then Exit;
  try
    Value := StrToDateTime(S);
    Result := True;
  except
    Result := False;
  end;
end;

function TProfXmlNode.ReadDateTimeDef(const Name: WideString; DefValue: TDateTime): TDateTime;
begin
  Result := DefValue;
  ReadDateTime(Name, Result);
end;

class function TProfXmlNode.ReadFloat32A(ANode: IXmlNode; const AName: WideString; var Value: Float32): WordBool;
var
  Node: IXmlNode;
begin
  Result := Assigned(ANode);
  if not(Result) then Exit;
  try
    Node := ANode.ChildNodes.FindNode(AName);
    Result := Assigned(Node);
    if not(Result) then Exit;
    Result := GetValueAsFloat32A(Node, Value);
  except
    Result := False;
  end;
end;

function TProfXmlNode.ReadFloat64(const Name: WideString; var Value: Double): WordBool;
begin
  Result := ReadFloat64A(FNode, Name, Value);
end;

class function TProfXmlNode.ReadFloat64A(ANode: IXmlNode; const AName: WideString; var Value: Float64): WordBool;
var
  Node: IXmlNode;
begin
  Result := Assigned(ANode);
  if not(Result) then Exit;
  try
    Node := ANode.ChildNodes.FindNode(AName);
    Result := Assigned(Node);
    if not(Result) then Exit;
    Result := GetValueAsFloat64A(Node, Value);
  except
    Result := False;
  end;
end;

function TProfXmlNode.ReadFloat64Def(const Name: WideString; DefValue: Double): Double;
begin
  Result := DefValue;
  ReadFloat64(Name, Result);
end;

function TProfXmlNode.ReadInt32(const Name: WideString; var Value: Integer): WordBool;
begin
  Result := ReadInt32A(FNode, Name, Value);
end;

class function TProfXmlNode.ReadInt32A(ANode: IXmlNode; const AName: WideString; var Value: Integer): WordBool;
var
  Node: IXmlNode;
begin
  Result := Assigned(ANode);
  if not(Result) then Exit;
  try
    Node := ANode.ChildNodes.FindNode(AName);
    Result := Assigned(Node);
    if not(Result) then Exit;
    Result := GetValueAsInt32A(Node, Value);
  except
    Result := False;
  end;
end;

function TProfXmlNode.ReadInt32Def(const Name: WideString; DefValue: Integer): Integer;
begin
  Result := DefValue;
  ReadInt32(Name, Result);
end;

function TProfXmlNode.ReadInt64(const Name: WideString; var Value: Int64): WordBool;
begin
  Result := ReadInt64A(FNode, Name, Value);
end;

class function TProfXmlNode.ReadInt64A(ANode: IXmlNode; const AName: WideString; var Value: Int64): WordBool;
var
  tmp: Integer;
begin
  tmp := Value;
  Result := ReadInt32A(ANode, AName, tmp);
  Value := tmp;
end;

function TProfXmlNode.ReadInt64Def(const Name: WideString; DefValue: Int64): Int64;
begin
  Result := DefValue;
  ReadInt64(Name, Result);
end;

function TProfXmlNode.ReadString(const Name: WideString; var Value: WideString): WordBool;
begin
  Result := ReadStringA(FNode, Name, Value);
end;

class function TProfXmlNode.ReadStringA(ANode: IXmlNode; const AName: WideString; var Value: WideString): WordBool;
var
  Node: IXmlNode;
begin
  Result := Assigned(ANode);
  if not(Result) then Exit;
  Node := ANode.ChildNodes.FindNode(AName);
  Result := Assigned(Node);
  if not(Result) then Exit;
  Result := GetValueAsStringA(Node, Value);
end;

function TProfXmlNode.ReadStringDef(const Name, DefValue: WideString): WideString;
begin
  Result := DefValue;
  ReadString(Name, Result);
end;

procedure TProfXmlNode.SetAsString(const Value: WideString);
begin
  // TODO: ...
end;

procedure TProfXmlNode.SetNode(Value: IXmlNode);
begin
  FNode := Value;
  FAttributes.Node := Value;
end;

function TProfXmlNode.SetValueAsBool(Value: WordBool): WordBool;
begin
  // TODO: ...
end;

function TProfXmlNode.SetValueAsFloat64(Value: Float64): WordBool;
begin
  // TODO: ...
end;

function TProfXmlNode.SetValueAsInt32(AValue: Integer): WordBool;
begin
  // TODO: ...
end;

function TProfXmlNode.SetValueAsString(const AValue: WideString): WordBool;
begin
  // TODO: ...
end;

function TProfXmlNode.SetValueAsUInt08(AValue: Byte): WordBool;
begin
  // TODO: ...
end;

procedure TProfXmlNode.SetXmlString(const Value: WideString);
begin
//  if Assigned(FNode) then
//  try
//    FNode.XML := Value;
//  except
//  end;
end;

function TProfXmlNode.WriteBool(const AName: WideString; Value: WordBool): WordBool;
begin
  Result := WriteBoolA(FNode, AName, Value);
end;

class function TProfXmlNode.WriteBoolA(ANode: IXmlNode; const AName: WideString; Value: WordBool): WordBool;
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

function TProfXmlNode.WriteDateTime(const AName: WideString; AValue: TDateTime): WordBool;
begin
  Result := WriteDateTimeA(FNode, AName, AValue);
end;

class function TProfXmlNode.WriteDateTimeA(ANode: IXmlNode; const AName: WideString; Value: TDateTime): WordBool;
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

class function TProfXmlNode.WriteFloat32A(ANode: IXmlNode; const AName: WideString; Value: Real): WordBool;
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

function TProfXmlNode.WriteFloat64(const AName: WideString; Value: Double): WordBool;
begin
  Result := WriteFloat64A(FNode, AName, Value);
end;

class function TProfXmlNode.WriteFloat64A(ANode: IXmlNode; const AName: WideString; Value: Double): WordBool;
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

function TProfXmlNode.WriteInt32(const AName: WideString; Value: Integer): WordBool;
begin
  Result := WriteInt32A(FNode, AName, Value);
end;

class function TProfXmlNode.WriteInt32A(ANode: IXmlNode; const AName: WideString; Value: Integer): WordBool;
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

function TProfXmlNode.WriteInt64(const AName: WideString; Value: Int64): WordBool;
begin
  Result := WriteInt64A(FNode, AName, Value);
end;

class function TProfXmlNode.WriteInt64A(ANode: IXmlNode; const AName: WideString; Value: Int64): WordBool;
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

function TProfXmlNode.WriteString(const AName, Value: WideString): WordBool;
begin
  Result := WriteStringA(FNode, AName, Value);
end;

class function TProfXmlNode.WriteStringA(ANode: IXmlNode; const AName, Value: WideString): WordBool;
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

{ TProfXmlNode1 }

function TProfXmlNode1.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: String; AParams: array of const): Boolean;
begin
  if Assigned(FDocument) then
    Result := FDocument.AddToLog(AGroup, AType, AStrMsg, AParams)
  else
    Result := False;
end;

function TProfXmlNode1.Attributes_Count: Integer;
begin
  Result := Length(FAttributes);
end;

function TProfXmlNode1.Clear(): AError;
begin
  SetLength(FAttributes, 0);
  FCollection.Clear;
  Result := 0;
end;

constructor TProfXmlNode1.Create(Document: AXmlDocument);
begin
  inherited Create;
  Self._AddRef();
  FCollection := TProfXmlCollection.Create(AProfXmlNode1(Self));
  FDocument := TProfXmlDocument1(Document);
  FName := '';
  FValue := '';
end;

function TProfXmlNode1.FindNode(Name: WideString): TProfXmlNode1;
begin
  Result := TProfXmlNode1(FCollection.FindNode(Name));
end;

procedure TProfXmlNode1.Free;
begin
  Clear();
  FCollection.Free();
  FCollection := nil;
  Self._Release();
  inherited Free;
end;

function TProfXmlNode1.GetAttribute(const Name: WideString; UpperCase: Boolean = False): WideString;
begin
  Result := AXmlAttribures_GetAttribute(FAttributes, Name, UpperCase);
end;

function TProfXmlNode1.GetCountNodes: Int32;
begin
  Result := FCollection.GetCount();
end;

function TProfXmlNode1.GetName: WideString;
begin
  Result := FName;
end;

procedure TProfXmlNode1.GetNameAndAttributes(Value: WideString);
begin
  _GetNameAndAttributes(Value, FAttributes, FName);
end;

function TProfXmlNode1.GetNode(Index: Int32): TProfXmlNode1;
begin
  Result := TProfXmlNode1(FCollection.Nodes[Index]);
end;

function TProfXmlNode1.GetNodeByName(Name: WideString): TProfXmlNode1;
begin
  Result := TProfXmlNode1(FCollection.NodesByName[Name]);
end;

function TProfXmlNode1.GetValueAsBool(var Value: WordBool): WordBool;
begin
  Value := (FValue = 'True');
  Result := True;
end;

function TProfXmlNode1.GetValueAsDateTime(var Value: TDateTime): WordBool;
begin
  try
    Value := StrToDateTime(FValue);
    Result := True;
  except
    Result := False;
  end;
end;

function TProfXmlNode1.GetValueAsInt32(var Value: Int32): WordBool;
var
  Code: Integer;
begin
  Val(FValue, Value, Code);
  Result := (Code = 0);
end;

function TProfXmlNode1.GetValueAsInt64(var AValue: Int64): WordBool;
var
  Code: Integer;
begin
  Val(FValue, AValue, Code);
  Result := (Code = 0);
end;

function TProfXmlNode1.GetValueAsInteger(var AValue: Integer): WordBool;
var
  Code: Integer;
begin
  Val(FValue, AValue, Code);
  Result := (Code = 0);
end;

function TProfXmlNode1.GetValueAsString(var Value: WideString): WordBool;
begin
  Value := FValue;
  Result := True;
end;

function TProfXmlNode1.GetValueAsUInt08(var Value: UInt08): WordBool;
var
  Code: Integer;
begin
  Val(FValue, Value, Code);
  Result := (Code = 0);
end;

function TProfXmlNode1.GetValueAsUInt64(var Value: UInt64): WordBool;
var
  Code: Integer;
begin
  Val(FValue, Value, Code);
  Result := (Code = 0);
end;

function TProfXmlNode1.GetXml(): WideString;
// Возвращает в виде одной строки без отступов и знаков переноса
var
  I: Int32;
  Attr: WideString;
begin
  // Атрибуты
  Attr := '';
  for I := 0 to High(FAttributes) do
    Attr := Attr + ' ' + FAttributes[I].Name+'="'+FAttributes[I].Value+'"';

  if GetCountNodes > 0 then begin
    Result := '<'+FName+Attr+'>';
    Result := Result + GetXmlB;
    Result := Result + '</'+FName+'>';
  end else begin
    if FName <> '' then begin
      if FValue = '' then
        Result := '<'+FName+Attr+' />'
      else
        Result := '<'+FName+Attr+'>'+StrHtmlFromStr(FValue)+'</'+FName+'>';
    end;
  end;
end;

function TProfXmlNode1.GetXmlA(Prefix: WideString): WideString;
// Возвращает в виде одной строки с отступами и знаками переноса
var
  I: Int32;
  Attr: WideString;
begin
  // Атрибуты
  Attr := '';
  for I := 0 to High(FAttributes) do
    Attr := Attr + ' ' + FAttributes[I].Name+'="'+FAttributes[I].Value+'"';

  if (GetCountNodes > 0) then
  begin
    Result := Prefix + '<'+FName+Attr+'>' + #13#10;
    for I := 0 to FCollection.GetCount() - 1 do
    begin
      Result := Result + TProfXmlNode1(FCollection.Nodes[I]).GetXmlA(Prefix + '  ');
    end;
    Result := Result + Prefix + '</'+FName+'>'+#13#10;
  end else begin
    if FName <> '' then Result := Prefix + '<'+FName+Attr+'>'+StrHtmlFromStr(FValue)+'</'+FName+'>'+#13#10;
  end;
end;

function TProfXmlNode1.GetXmlB: WideString;
var
  I: Int32;
begin
  Result := '';
  for I := 0 to FCollection.GetCount() - 1 do
  begin
    Result := Result + TProfXmlNode1(FCollection.Nodes[I]).GetXml;
  end;
end;

function TProfXmlNode1.Get_Attribute(const Name: WideString): WideString;
begin
  Result := GetAttribute(Name);
end;

function TProfXmlNode1.Get_Attribute_Name(Index: Integer): WideString;
begin
  if (Index >= 0) and (Index < Length(FAttributes)) then
    Result := FAttributes[Index].Name
  else
    Result := '';
end;

function TProfXmlNode1.Get_Attribute_Value(Index: Integer): WideString;
begin
  if (Index >= 0) and (Index < Length(FAttributes)) then
    Result := FAttributes[Index].Value
  else
    Result := '';
end;

function TProfXmlNode1.Get_Collection(): AXmlCollection;
begin
  Result := AXmlCollection(FCollection);
end;

function TProfXmlNode1.Get_NodeName: WideString;
begin
  Result := FName;
end;

function TProfXmlNode1.Get_NodeValue: WideString;
begin
  Result := FValue;
end;

function TProfXmlNode1.Get_Xml: WideString;
begin
  Result := GetXml;
end;

function TProfXmlNode1.Load: Boolean;
begin
  Result := False;
end;

function TProfXmlNode1.LoadFromXml(AXml: TProfXmlNode1): Boolean;
var
  ANode: TProfXmlNode1;
  I: Int32;
begin
  Result := False;
  if not(Assigned(AXml)) then Exit;
  FValue := AXml.FValue;
  for I := 0 to AXml.GetCountNodes do begin
    ANode := AXml.GetNode(I);
    GetNodeByName(ANode.GetName).LoadFromXml(ANode);
  end;
  Result := True;
end;

function TProfXmlNode1.NewNode(const AName: WideString): TProfXmlNode1;
begin
  Result := TProfXmlNode1(FCollection.NewNode(AName));
end;

function TProfXmlNode1.NodeExist(AName: WideString): Boolean;
begin
  Result := Assigned(FindNode(AName));
end;

function TProfXmlNode1.ReadBool(const AName: WideString; var Value: WordBool): WordBool;
var
  Node: TProfXmlNode1;
begin
  Result := False;
  Node := FindNode(AName);
  if not(Assigned(Node)) then Exit;
  Result := Node.GetValueAsBool(Value);
end;

function TProfXmlNode1.ReadDateTime(const AName: WideString; var Value: TDateTime): WordBool;
var
  Node: TProfXmlNode1;
begin
  Result := False;
  Node := FindNode(AName);
  if not(Assigned(Node)) then Exit;
  Result := Node.GetValueAsDateTime(Value);
end;

function TProfXmlNode1.ReadFloat64(const AName: WideString; var Value: Float64): WordBool;
var
  Code: Cardinal;
  S: WideString;
begin
  Result := ReadString(AName, S);
  if not(Result) then Exit;
  Val(S, Value, Code);
  Result := (Code = 0);
end;

function TProfXmlNode1.ReadInt32(const AName: WideString; var Value: Int32): WordBool;
var
  Node: TProfXmlNode1;
begin
  Result := False;
  Node := FindNode(AName);
  if not(Assigned(Node)) then Exit;
  Result := Node.GetValueAsInt32(Value);
end;

function TProfXmlNode1.ReadInt64(const AName: WideString; AValue: Int64): WordBool;
begin
  Result := NodeExist(AName);
  if not(Result) then Exit;
  Result := FindNode(AName).GetValueAsInt64(AValue);
end;

function TProfXmlNode1.ReadInteger(const AName: WideString; var AValue: Integer): WordBool;
begin
  Result := NodeExist(AName);
  if not(Result) then Exit;
  Result := FindNode(AName).GetValueAsInteger(AValue);
end;

function TProfXmlNode1.ReadNodes(var Value: WideString; CloseTag: WideString): Boolean;
// Чтение вложеных элементов до закрывающего тега
// Value - строка
// CloseTag - закрывающий тег (без </ >)
var
  I: Integer;
  I2: Integer;
  N: TProfXmlNode1;
  Tag: WideString;
begin
  Result := False;
  //FValue := '';
  if Value = '' then Exit;
  repeat
    I := Pos('<', Value);
    // Запись значения
    if (I = 0) then
      FValue := FValue + Value
    else
      FValue := FValue + Copy(Value, 1, I - 1);
    if I = 0 then
    begin
      Result := True;
      Exit;
    end;
    FValue := Copy(Value, 1, I - 1);
    // Очистка от предшествующих символов
    Value := Copy(Value, I + 1, Length(Value));
    I := Pos('>', Value);
    if I = 0 then
    begin
      AddToLog(lgGeneral, ltError, err_Xml_ReadNodes_1, []);
      Result := False;
      Exit;
    end;
    I2 := Pos(WideString('/>'), Value);
    if (I2 > 0) and (I2 < I) then // "< ... />"
    begin
      Tag := Copy(Value, 1, I - 1);
      Delete(Value, 1, I + 1);
      N := NewNode('');
      N.GetNameAndAttributes(Tag);
    end
    else
    begin                      // "< > ... </ >"
      Tag := Copy(Value, 1, I - 1);
      Delete(Value, 1, I);

      if Tag = '/'+CloseTag then
      begin
        Result := True;
        Exit;
      end;

      N := NewNode('');
      N.GetNameAndAttributes(Tag);
      N.SetXmlA(Value, N.NodeName);
    end;
  until False;
end;

function TProfXmlNode1.ReadString(const AName: WideString; var Value: WideString): WordBool;
begin
  if NodeExist(AName) then
    Result := FindNode(AName).GetValueAsString(Value)
  else
    Result := False;
end;

function TProfXmlNode1.ReadUInt08(const AName: WideString; var Value: UInt08): WordBool;
var
  Node: TProfXmlNode1;
begin
  Result := False;
  Node := FindNode(AName);
  if not(Assigned(Node)) then Exit;
  Result := Node.GetValueAsUInt08(Value);
end;

function TProfXmlNode1.ReadUInt64(const AName: WideString; var Value: UInt64): WordBool;
var
  Node: TProfXmlNode1;
begin
  Result := False;
  Node := FindNode(AName);
  if not(Assigned(Node)) then Exit;
  Result := Node.GetValueAsUInt64(Value);
end;

function TProfXmlNode1.ReadWideString(const AName: WideString; var Value: WideString): WordBool;
var
  Node: TProfXmlNode1;
begin
  Result := False;
  Node := FindNode(AName);
  if not(Assigned(Node)) then Exit;
  Result := Node.GetValueAsString(Value);
end;

procedure TProfXmlNode1.SetDocument_Priv(Document: AXmlDocument);
begin
  FDocument := TProfXmlDocument1(Document);
end;

procedure TProfXmlNode1.SetName(Value: WideString);
begin
  FName := Value;
end;

function TProfXmlNode1.SetValueAsBool(Value: WordBool): WordBool;
begin
  {$IFDEF VER150}
  FValue := BoolToStr(Value, True);
  {$ELSE}
  if Value then FValue := 'True' else FValue := 'False';
  {$ENDIF}
  Result := True;
end;

function TProfXmlNode1.SetValueAsFloat64(Value: Float64): WordBool;
begin
  FValue := FloatToStr(Value);
  Result := True;
end;

function TProfXmlNode1.SetValueAsInt32(AValue: Int32): WordBool;
begin
  FValue := IntToStr(AValue);
  Result := True;
end;

function TProfXmlNode1.SetValueAsString(const AValue: WideString): WordBool;
begin
  FValue := AValue;
  Result := True;
end;

function TProfXmlNode1.SetValueAsUInt08(AValue: UInt08): WordBool;
begin
  FValue := IntToStr(AValue);
  Result := True;
end;

function TProfXmlNode1.SetValueAsUInt64(AValue: UInt64): WordBool;
begin
  FValue := IntToStr(AValue);
  Result := True;
end;

function TProfXmlNode1.SetXml(const AValue: WideString): WordBool;
var
  I: Integer;
  I2: Integer;
  Tag: string;
  Value: WideString;
begin
  Result := False;
  FValue := '';
  Value := AValue;
  //repeat
    I := Pos('<', Value);
    // Запись значения
    if (I = 0) then
      FValue := FValue + Value
    else
      FValue := FValue + Copy(Value, 1, I - 1);
    FValue := StrHtmlToStr(FValue);  // Преобразование символов
    if I = 0 then
    begin
      Result := True;
      Exit;
    end;
    FValue := Copy(Value, 1, I - 1);
    Delete(Value, 1, I);
    I := Pos('>', Value);
    I2 := Pos(WideString('/>'), Value);
    if (I = 0) then
    begin
      AddToLog(lgGeneral, ltError, 'Не найден закрывающий символ ">"', []);
      Exit;
    end;
    if I2 <> I - 1 then I2 := 0; // I2 должен отставать от I на 1 символ
    if I2 = 0 then
      Tag := Copy(Value, 1, I - 1)
    else
      Tag := Copy(Value, 1, I2 - 1);
    Delete(Value, 1, I); // Удаление начала описания нода
    // ..........

    GetNameAndAttributes(Tag); // Выделить имя и атрибуты их строки "tag attr1="value1" attr2="value2""
    Value := strDeleteSpace(Value, [dsFirst, dsLast]);
    Result := ReadNodes(Value, FName); // Читать ноды из строки до закрывающего тега
  //until False;
end;

function TProfXmlNode1.SetXmlA(var Value: WideString; const CloseTag: WideString = ''): WordBool;
begin
  Result := ReadNodes(Value, CloseTag);
end;

procedure TProfXmlNode1.Set_Attribute(const Name, Value: WideString);
begin
  AXmlAttributes_SetAttribute(FAttributes, Name, Value);
end;

procedure TProfXmlNode1.Set_NodeName(const Value: WideString);
begin
  FName := Value;
end;

procedure TProfXmlNode1.Set_NodeValue(const Value: WideString);
begin
  FValue := Value;
end;

procedure TProfXmlNode1.Set_Xml(const Value: WideString);
begin
  SetXml(Value);
end;

function TProfXmlNode1.ToStrings(AStrings: TStrings; Prefix: WideString = ''): Boolean;
var
  I: Int32;
begin
  Result := False;
  if not(Assigned(AStrings)) then Exit;
  if GetCountNodes > 0 then
  begin
    AStrings.Add(Prefix + '<'+FName+'>');
    for I := 0 to FCollection.GetCount() - 1 do
    begin
      TProfXmlNode1(FCollection.Nodes[I]).ToStrings(AStrings, Prefix + '  ');
    end;
    AStrings.Add(Prefix + '</'+FName+'>');
  end
  else
  begin
    if FValue = '' then
      AStrings.Add(Prefix + '<'+FName+'/>')
    else
      AStrings.Add(Prefix + '<'+FName+'>'+FValue+'</'+FName+'>');
  end;
  Result := True;
end;

function TProfXmlNode1.WriteBool(const AName: WideString; Value: WordBool): WordBool;
begin
  Result := GetNodeByName(AName).SetValueAsBool(Value);
end;

function TProfXmlNode1.WriteDateTime(const AName: WideString; AValue: TDateTime): WordBool;
begin
  Result := GetNodeByName(AName).SetValueAsFloat64(AValue);
end;

function TProfXmlNode1.WriteFloat64(const AName: WideString; Value: Float64): WordBool;
begin
  Result := GetNodeByName(AName).SetValueAsFloat64(Value);
end;

function TProfXmlNode1.WriteInt32(const AName: WideString; Value: Int32): WordBool;
begin
  Result := GetNodeByName(AName).SetValueAsInt32(Value);
end;

function TProfXmlNode1.WriteInt64(const AName: WideString; Value: Int64): WordBool;
begin
  Result := WriteInt32(AName, Value);
end;

function TProfXmlNode1.WriteInteger(const AName: WideString; Value: Integer): WordBool;
begin
  Result := WriteInt32(AName, Value);
end;

function TProfXmlNode1.WriteString(const AName, Value: WideString): WordBool;
begin
  if AName = '' then Exit;
  Result := GetNodeByName(AName).SetValueAsString(Value);
end;

function TProfXmlNode1.WriteUInt08(const AName: WideString; AValue: UInt08): WordBool;
begin
  Result := GetNodeByName(AName).SetValueAsUInt08(AValue);
end;

function TProfXmlNode1.WriteUInt64(const AName: WideString; AValue: UInt64): WordBool;
begin
  Result := GetNodeByName(AName).SetValueAsUInt64(AValue);
end;

function TProfXmlNode1.WriteXml(const AName, Value: WideString): WordBool;
begin
  Result := GetNodeByName(AName).SetXml(Value);
end;

function TProfXmlNode1._GetValueAsBool: WordBool;
begin
  Result := False;
  GetValueAsBool(Result);
end;

function TProfXmlNode1._GetValueAsString: WideString;
begin
  Result := '';
  GetValueAsString(Result);
end;

procedure TProfXmlNode1._SetValueAsBool(Value: WordBool);
begin
  SetValueAsBool(Value);
end;

procedure TProfXmlNode1._SetValueAsString(Value: WideString);
begin
  SetValueAsString(Value);
end;

{ TProfXmlNode2 }

function TProfXmlNode2.AddFromXml(Xml: TProfXmlNode2): TError;
begin
  if Self.LoadFromXml(Xml) then
    Result := 0
  else
    Result := -1;
end;

constructor TProfXmlNode2.Create(Node: IXmlNode);
begin
  inherited Create;
  FNode := Node; //TXmlNode.Create(CreateDOMNode(
end;
{constructor TProfXmlNode2.Create(const ADomNode: IDOMNode; const AParentNode: TXMLNode; const OwnerDoc: TXMLDocument);
begin
  inherited;
end;}
{constructor TProfXmlNode2.CreateA();
begin
  inherited Create(nil, nil, nil);
  //FNode := ANode;
end;}

function TProfXmlNode2.GetAsString(): WideString;
begin
  if Assigned(FNode) and ((VarType(FNode.NodeValue) = varOleStr) or (VarType(FNode.NodeValue) = varStrArg) or (VarType(FNode.NodeValue) = varString)) then
    Result := FNode.NodeValue
  else
    Result := '';
  {if ((VarType(FNode.NodeValue) = varOleStr) or (VarType(FNode.NodeValue) = varStrArg) or (VarType(FNode.NodeValue) = varString)) then
    Result := FNode.NodeValue
  else
    Result := '';}
end;

function TProfXmlNode2.GetChildNodes(): AXmlNodeList;
begin
  if (FChildNodes = 0) then
    FChildNodes := AXmlNodeList_New(FNode.ChildNodes);
  Result := FChildNodes;
end;

function TProfXmlNode2.GetCollection(): IXmlNodeCollection;
begin
  if Assigned(FNode) then
    Result := FNode.Collection
  else
    Result := nil;
end;

function TProfXmlNode2.GetCountNodes(): Integer;
begin
  if Assigned(FNode) then
    Result := FNode.Collection.Count
  else
    Result := 0;
end;

function TProfXmlNode2.GetNode(Index: Integer): TProfXmlNode2;
var
  Node: IXmlNode;
begin
  Node := FNode.Collection.Nodes[Index];
  if Assigned(Node) then
    Result := TProfXmlNode2.Create(Node)
  else
    Result := nil;
end;

function TProfXmlNode2.GetNodeByName(const AName: WideString): IXmlNode;
var
  Node: IXmlNode;
begin
  if not(Assigned(FNode)) then
  begin
    Result := nil;
    Exit;
  end;
  // Поиск XML нода
  Node := FNode.ChildNodes.FindNode(AName);
  // Если нету - создание XML нода
  if not(Assigned(Node)) then
    Node := FNode.AddChild(AName);
  Result := Node; //as IXmlNode;
end;

function TProfXmlNode2.GetNodeByName1(const AName: WideString): TProfXmlNode2;
var
  Node: IXmlNode;
begin
  // Поиск XML нода
  Node := FNode.ChildNodes.FindNode(AName);
  // Если нету - создание XML нода
  if not(Assigned(Node)) then begin
    Node := FNode.AddChild(AName);
    //Result.NodeValue := '';
  end;
  // Создание Config нода
  Result := TProfXmlNode2.Create(Node);
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

function TProfXmlNode2.GetNodeName(): WideString;
begin
  if Assigned(FNode) then
    Result := FNode.NodeName
  else
    Result := '';
end;

function TProfXmlNode2.GetNodeValue(): OleVariant;
begin
  if Assigned(FNode) then
    Result := FNode.NodeValue;
end;

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

function TProfXmlNode2.GetXml(): WideString;
begin
  if Assigned(FNode) then
    Result := FNode.XML
  else
    Result := '';
end;

function TProfXmlNode2.GetXmlB(): WideString;
begin
  Result := '';
  // ...
end;

function TProfXmlNode2.Get_Attribute(Name: WideString): WideString;
begin
  Result := FNode.GetAttribute(Name);
end;

function TProfXmlNode2.Get_Collection(): IXmlNodeCollection;
begin
  //if Assigned(FNode) then Result := FNode.Collection else Result := nil;
  Result := IXmlNodeCollection(Self.Collection);
end;

function TProfXmlNode2.Get_Xml(): WideString;
begin
  Result := GetXml();
end;

function TProfXmlNode2.LoadFromXml(Xml: TProfXmlNode2): WordBool;
begin
  Result := False;
  // ...
end;

function TProfXmlNode2.NewNode(const ANodeName: WideString): TProfXmlNode2;
begin
  Result := nil;
  // ...
end;

function TProfXmlNode2.ReadBool(const AName: WideString; var Value: WordBool): WordBool;
var
  Node: IXmlNode;
begin
  if not(Assigned(FNode)) then
  begin
    Exit;
    Result := False;
  end;
  Node := FNode.ChildNodes.FindNode(AName);
  if not(Assigned(Node)) then
  begin
    Exit;
    Result := False;
  end;
  if not(VarType(Node.NodeValue) = varBoolean) then
  begin
    Exit;
    Result := False;
  end;
  Value := Node.NodeValue;
  Result := True;
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
  if not(Assigned(FNode)) then
  begin
    Result := False;
    Exit;
  end;
  try
    Node := FNode.ChildNodes.FindNode(AName);
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
  if not(Assigned(FNode)) then
  begin
    Result := False;
    Exit;
  end;
  try
    Node := FNode.ChildNodes.FindNode(AName);
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
  if not(Assigned(FNode)) then
  begin
    Exit;
    Result := False;
  end;
  try
    Node := FNode.ChildNodes.FindNode(AName);
    Result := Assigned(Node);
    if not(Result) then Exit;
    if (VarType(Node.NodeValue) = varInteger) then begin
      Value := Node.NodeValue;
    end else if (VarType(Node.NodeValue) = varString) or (VarType(Node.NodeValue) = varOleStr) then begin
      Val(Node.NodeValue, Value, Code);
      Result := (Code = 0);
    end else Result := False;
  except
    Result := False;
  end;
end;

function TProfXmlNode2.ReadString(const AName: WideString; var Value: WideString): WordBool;
var
  Node: IXmlNode;
begin
  if not(Assigned(FNode)) then
  begin
    Exit;
    Result := False;
  end;
  Node := FNode.ChildNodes.FindNode(AName);
  if not(Assigned(Node)) then
  begin
    Exit;
    Result := False;
  end;
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

procedure TProfXmlNode2.SetNodeName(const Value: WideString);
begin
  //FNode.NodeName := Value;
end;

procedure TProfXmlNode2.SetNodeValue(Value: OleVariant);
begin
  try
    if Assigned(FNode) then
      FNode.NodeValue := Value;
  except
  end;
end;

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

procedure TProfXmlNode2.SetXml(const Value: {DOMString}WideString);
begin
  Self.FNode.Text := Value;
end;

function TProfXmlNode2.SetXmlA(const Value: WideString): WordBool;
begin
  //if Assigned(FNode) then
  //  FNode.Xml := Value;
  Result := False;
  // ...
end;

procedure TProfXmlNode2.SetXmlB(const Value: WideString);
begin
  // ...
end;

procedure TProfXmlNode2.Set_Attribute(Name, Value: WideString);
begin
  FNode.SetAttribute(Name, Value);
end;

procedure TProfXmlNode2.Set_Xml(const Value: WideString);
begin
  SetXml(Value);
end;

function TProfXmlNode2.WriteBool(const AName: WideString; Value: WordBool): WordBool;
var
  Node: IXmlNode;
begin
  if not(Assigned(FNode)) then
  begin
    Result := False;
    Exit;
  end;
  Node := FNode.ChildNodes.FindNode(AName);
  if Assigned(Node) then
    Node.NodeValue := Value
  else
    FNode.AddChild(AName).NodeValue := Value;
  Result := True;
end;

function TProfXmlNode2.WriteDateTime(const AName: WideString; Value: TDateTime): WordBool;
var
  Node: IXmlNode;
begin
  try
    Node := FNode.ChildNodes.FindNode(AName);
    if Assigned(Node) then
      Node.NodeValue := Value
    else
      FNode.AddChild(AName).NodeValue := Value;
    Result := True;
  except
    Result := False;
  end;
end;

function TProfXmlNode2.WriteFloat32(const AName: WideString; Value: Float32): WordBool;
var
  Node: IXmlNode;
begin
  if not(Assigned(FNode)) then
  begin
    Result := False;
    Exit;
  end;
  try
    Node := FNode.ChildNodes.FindNode(AName);
    if Assigned(Node) then
      Node.NodeValue := Value
    else
      FNode.AddChild(AName).NodeValue := Value;
    Result := True;
  except
    Result := False;
  end;
end;

function TProfXmlNode2.WriteFloat64(const AName: WideString; Value: Float64): WordBool;
var
  Node: IXmlNode;
begin
  if not(Assigned(FNode)) then
  begin
    Result := False;
    Exit;
  end;
  try
    Node := FNode.ChildNodes.FindNode(AName);
    if Assigned(Node) then
      Node.NodeValue := Value
    else
      FNode.AddChild(AName).NodeValue := Value;
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
  if not(Assigned(FNode)) then
  begin
    Result := False;
    Exit;
  end;
  try
    Node := FNode.ChildNodes.FindNode(AName);
    if Assigned(Node) then
      Node.NodeValue := Value
    else
      FNode.AddChild(AName).NodeValue := Value;
    Result := True;
  except
    Result := False;
  end;
end;

function TProfXmlNode2.WriteString(const AName, Value: WideString): WordBool;
var
  Node: IXmlNode;
begin
  if not(Assigned(FNode)) then
  begin
    Result := False;
    Exit;
  end;
  Node := FNode.ChildNodes.FindNode(AName);
  if Assigned(Node) then
    Node.NodeValue := Value
  else
    FNode.AddChild(AName).NodeValue := Value;
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
  if not(Assigned(FNode)) then
  begin
    Result := False;
    Exit;
  end;
  Node := FNode.ChildNodes.FindNode(AName);
  if Assigned(Node) then
    Node.NodeValue := AValue
  else
    FNode.AddChild(AName).NodeValue := AValue;
  Result := True;
end;

{ TProfXmlNode4 }

function TProfXmlNode4.GetAttribute(const AttrName: DOMString): OleVariant;
begin
  Result := FController.Attributes[AttrName];
end;

function TProfXmlNode4.GetAttributeNodes: IXMLNodeList;
begin
  Result := FController.AttributeNodes;
end;

function TProfXmlNode4.GetChildNodes: IXMLNodeList;
begin
  Result := FController.ChildNodes;
end;

function TProfXmlNode4.GetChildValue(const IndexOrName: OleVariant): OleVariant;
begin
  Result := FController.ChildValues[IndexOrName];
end;

function TProfXmlNode4.GetCollection: IXMLNodeCollection;
begin
  Result := FController.Collection;
end;

function TProfXmlNode4.GetDOMNode: IDOMNode;
begin
  Result := FController.DOMNode;
end;

function TProfXmlNode4.GetHasChildNodes: Boolean;
begin
  Result := FController.HasChildNodes;
end;

function TProfXmlNode4.GetIsTextElement: Boolean;
begin
  Result := FController.IsTextElement;
end;

function TProfXmlNode4.GetLocalName: DOMString;
begin
  Result := FController.LocalName;
end;

function TProfXmlNode4.GetNamespaceURI: DOMString;
begin
  Result := FController.NamespaceURI;
end;

function TProfXmlNode4.GetNodeName: DOMString;
begin
  Result := FController.NodeName;
end;

function TProfXmlNode4.GetNodeType: TNodeType;
begin
  Result := FController.NodeType;
end;

function TProfXmlNode4.GetNodeValue: OleVariant;
begin
  Result := FController.NodeValue;
end;

function TProfXmlNode4.GetOwnerDocument: IXMLDocument;
begin
  Result := FController.OwnerDocument;
end;

function TProfXmlNode4.GetParentNode: IXMLNode;
begin
  Result := FController.ParentNode;
end;

function TProfXmlNode4.GetPrefix: DOMString;
begin
  Result := FController.Prefix;
end;

function TProfXmlNode4.GetReadOnly: Boolean;
begin
  Result := FController.ReadOnly;
end;

function TProfXmlNode4.GetText: DOMString;
begin
  Result := FController.Text;
end;

function TProfXmlNode4.GetXML: DOMString;
begin
  Result := FController.XML;
end;

procedure TProfXmlNode4.SetAttribute(const AttrName: DOMString; const Value: OleVariant);
begin
  FController.Attributes[AttrName] := Value;
end;

procedure TProfXmlNode4.SetChildValue(const IndexOrName: OleVariant; const Value: OleVariant);
begin
  FController.ChildValues[IndexOrName] := Value;
end;

procedure TProfXmlNode4.SetNodeValue(const Value: OleVariant);
begin
  FController.NodeValue := Value;
end;

procedure TProfXmlNode4.SetReadOnly(const Value: Boolean);
begin
  FController.ReadOnly := Value;
end;

procedure TProfXmlNode4.SetText(const Value: DOMString);
begin
  FController.Text := Value;
end;

function TProfXmlNode4.AddChild(const TagName: DOMString; Index: Integer = -1): IXMLNode;
begin
  Result := FController.AddChild(TagName, Index);
end;

function TProfXmlNode4.AddChild(const TagName, NamespaceURI: DOMString;
  GenPrefix: Boolean = False; Index: Integer = -1): IXMLNode;
begin
  Result := FController.AddChild(TagName, NamespaceURI, GenPrefix, Index);
end;

function TProfXmlNode4.CloneNode(Deep: Boolean): IXMLNode;
begin
  Result := FController.CloneNode(Deep);
end;

procedure TProfXmlNode4.DeclareNamespace(const Prefix, URI: DOMString);
begin
  FController.DeclareNamespace(Prefix, URI);
end;

function TProfXmlNode4.FindNamespaceURI(const TagOrPrefix: DOMString): DOMString;
begin
  Result := FController.FindNamespaceURI(TagOrPrefix);
end;

function TProfXmlNode4.FindNamespaceDecl(const NamespaceURI: DOMString): IXMLNode;
begin
  Result := FController.FindNamespaceDecl(NamespaceURI);
end;

function TProfXmlNode4.GetAttributeNS(const AttrName, NamespaceURI: DOMString): OleVariant;
begin
  Result := FController.GetAttributeNS(AttrName, NamespaceURI);
end;

function TProfXmlNode4.HasAttribute(const Name: DOMString): Boolean;
begin
  Result := FController.HasAttribute(Name);
end;

function TProfXmlNode4.HasAttribute(const Name, NamespaceURI: DOMString): Boolean;
begin
  Result := FController.HasAttribute(Name, NamespaceURI);
end;

function TProfXmlNode4.NextSibling: IXMLNode;
begin
  Result := FController.NextSibling();
end;

procedure TProfXmlNode4.Normalize;
begin
  FController.Normalize();
end;

function TProfXmlNode4.PreviousSibling: IXMLNode;
begin
  Result := FController.PreviousSibling();
end;

procedure TProfXmlNode4.Resync;
begin
  FController.Resync();
end;

procedure TProfXmlNode4.SetAttributeNS(const AttrName, NamespaceURI: DOMString; const Value: OleVariant);
begin
  FController.SetAttributeNS(AttrName, NamespaceURI, Value);
end;

procedure TProfXmlNode4.TransformNode(const stylesheet: IXMLNode; var output: WideString);
begin
  FController.TransformNode(Stylesheet, Output);
end;

procedure TProfXmlNode4.TransformNode(const stylesheet: IXMLNode; const output: IXMLDocument);
begin
  FController.TransformNode(Stylesheet, Output);
end;

function TProfXmlNode4.Get_Collection(): IXmlNodeCollection;
begin
  Result := FController.Collection;
end;

constructor TProfXmlNode4.Create(Controller: IXmlNode);
begin
  inherited Create(Controller);
  FController := Controller;
end;

class function TProfXmlNode4.GetAsBoolA(ANode: IXMLNode): WordBool;
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

class function TProfXmlNode4.GetAsDateTimeA(ANode: IXMLNode): TDateTime;
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

class function TProfXmlNode4.GetAsFloat32A(ANode: IXMLNode): Float32;
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

class function TProfXmlNode4.GetAsFloat64A(ANode: IXMLNode): Float64;
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

class function TProfXmlNode4.GetAsInt32A(ANode: IXMLNode): Int32;
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

class function TProfXmlNode4.GetAsInt64A(ANode: IXMLNode): Int64;
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

function TProfXmlNode4.GetAsString(): WideString;
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

class function TProfXmlNode4.GetAsStringA(ANode: IXMLNode): WideString;
begin
  Result := '';
  GetValueAsStringA(ANode, Result);
end;

function TProfXmlNode4.GetNodeByName(const AName: WideString): IXmlNode;
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

function TProfXmlNode4.GetNodeByName2(const AName: WideString): IProfXmlNode2;
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

class function TProfXmlNode4.GetNodeByNameA(ANode: IXmlNode; const AName: WideString): IXmlNode;
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

function TProfXmlNode4.GetValueAsBool(var Value: WordBool): WordBool;
begin
  Result := ProfXmlNode_GetValueAsBool(FController, Value);
  //Result := GetValueAsBoolA(FController, Value);
end;

class function TProfXmlNode4.GetValueAsBoolA(ANode: IXmlNode; var Value: WordBool): WordBool;
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

function TProfXmlNode4.GetValueAsDateTime(var Value: TDateTime): WordBool;
begin
  Result := ProfXmlNode_GetValueAsDateTime(FController, Value);
  //Result := GetValueAsDateTimeA(FController, Value);
end;

class function TProfXmlNode4.GetValueAsDateTimeA(ANode: IXmlNode; var Value: TDateTime): WordBool;
begin
  Result := ProfXmlNode_GetValueAsDateTime(ANode, Value);
  {try
    Value := ANode.NodeValue;
  except
  end;}
end;

function TProfXmlNode4.GetValueAsFloat32(var Value: Float32): WordBool;
begin
  Result := ProfXmlNode_GetValueAsFloat32(FController, Value);
  //Result := GetValueAsFloat32A(FController, Value);
end;

class function TProfXmlNode4.GetValueAsFloat32A(ANode: IXmlNode; var Value: Float32): WordBool;
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

function TProfXmlNode4.GetValueAsFloat64(var Value: Float64): WordBool;
begin
  Result := ProfXmlNode_GetValueAsFloat64(FController, Value);
  //Result := GetValueAsFloat64A(FController, Value);
end;

class function TProfXmlNode4.GetValueAsFloat64A(ANode: IXmlNode; var Value: Float64): WordBool;
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

function TProfXmlNode4.GetValueAsInt32(var Value: Int32): WordBool;
begin
  Result := ProfXmlNode_GetValueAsInt32(FController, Value);
  //Result := GetValueAsInt32A(FController, Value);
end;

class function TProfXmlNode4.GetValueAsInt32A(ANode: IXmlNode; var Value: Int32): WordBool;
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

function TProfXmlNode4.GetValueAsInt64(var AValue: Int64): WordBool;
begin
  Result := ProfXmlNode_GetValueAsInt64(FController, AValue);
  //Result := GetValueAsInt64A(FController, AValue);
end;

class function TProfXmlNode4.GetValueAsInt64A(ANode: IXmlNode; var Value: Int64): WordBool;
begin
  Result := ProfXmlNode_GetValueAsInt64(ANode, Value);
  {try
    Value := ANode.NodeValue;
  except
  end;}
end;

function TProfXmlNode4.GetValueAsInteger(var AValue: Integer): WordBool;
begin
  Result := GetValueAsInt32(AValue);
end;

function TProfXmlNode4.GetValueAsString(var Value: WideString): WordBool;
begin
  Result := GetValueAsStringA(FController, Value);
end;

class function TProfXmlNode4.GetValueAsStringA(ANode: IXmlNode; var Value: WideString): WordBool;
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

function TProfXmlNode4.GetValueAsUInt08(var Value: UInt08): WordBool;
begin
  try
    Value := FController.NodeValue;
  except
  end;
end;

function TProfXmlNode4.GetValueAsUInt64(var Value: UInt64): WordBool;
begin
  try
    Value := FController.NodeValue;
  except
  end;
end;

function TProfXmlNode4.GetXmlB(): WideString;
begin
  Result := '';
  // ...
end;

function TProfXmlNode4.LoadFromXml(Xml: AProfXmlNode{TProfXmlNode4}): WordBool;
begin
  Result := False;
  // ...
end;

function TProfXmlNode4.NewNode(const ANodeName: WideString): IXmlNode;
begin
  Result := nil;
  if Assigned(FController) then
    Result := FController.AddChild(ANodeName);
end;

function TProfXmlNode4.ReadBool(const AName: WideString; var Value: WordBool): WordBool;
begin
  Result := ReadBoolA(FController, AName, Value);
end;

class function TProfXmlNode4.ReadBoolA(ANode: IXmlNode; const AName: WideString; var Value: WordBool): WordBool;
begin
  Result := ProfXmlNode_ReadBool(ANode, AName, Value);
end;

class function TProfXmlNode4.ReadBoolDef(ANode: IXmlNode; const AName: WideString; ADef: WordBool): WordBool;
begin
  Result := ProfXmlNode_ReadBoolDef(ANode, AName, ADef);
end;

function TProfXmlNode4.ReadDateTime(const AName: WideString; var Value: TDateTime): WordBool;
begin
  Result := ProfXmlNode_ReadDateTime(FController, AName, Value);
end;

class function TProfXmlNode4.ReadDateTimeA(ANode: IXmlNode; const AName: WideString; var Value: TDateTime): WordBool;
begin
  Result := ProfXmlNode_ReadDateTime(ANode, AName, Value);
end;

class function TProfXmlNode4.ReadDateTimeDef(ANode: IXmlNode; const AName: WideString; ADef: TDateTime): TDateTime;
begin
  Result := ProfXmlNode_ReadDateTimeDef(ANode, AName, ADef);
end;

function TProfXmlNode4.ReadFloat32(const AName: WideString; var Value: Float32): WordBool;
begin
  Result := ProfXmlNode_ReadFloat32(FController, AName, Value);
end;

class function TProfXmlNode4.ReadFloat32A(ANode: IXmlNode; const AName: WideString; var Value: Float32): WordBool;
begin
  Result := ProfXmlNode_ReadFloat32(ANode, AName, Value);
end;

function TProfXmlNode4.ReadFloat64(const AName: WideString; var Value: Float64): WordBool;
begin
  Result := ProfXmlNode_ReadFloat64(FController, AName, Value);
end;

class function TProfXmlNode4.ReadFloat64A(ANode: IXmlNode; const AName: WideString; var Value: Float64): WordBool;
begin
  Result := ProfXmlNode_ReadFloat64(ANode, AName, Value);
end;

class function TProfXmlNode4.ReadFloatDef(ANode: IXmlNode; const AName: WideString; ADef: Float64): Float64;
begin
  Result := ProfXmlNode_ReadFloatDef(ANode, AName, ADef);
end;

function TProfXmlNode4.ReadInt08(const AName: WideString; var Value: Int08): WordBool;
var
  tmpValue: Integer;
begin
  Result := ReadInteger(AName, tmpValue);
  if Result then Value := tmpValue;
end;

function TProfXmlNode4.ReadInt16(const AName: WideString; var Value: Int16): WordBool;
var
  tmpValue: Integer;
begin
  Result := ReadInteger(AName, tmpValue);
  if Result then Value := tmpValue;
end;

function TProfXmlNode4.ReadInt32(const AName: WideString; var Value: Int32): WordBool;
begin
  Result := ReadInteger(AName, Value);
end;

class function TProfXmlNode4.ReadInt32Def(ANode: IXmlNode; const AName: WideString; ADef: Int32): Int32;
begin
  Result := ADef;
  ReadIntegerA(ANode, AName, Result);
end;

function TProfXmlNode4.ReadInt64(const AName: WideString; var Value: Int64): WordBool;
var
  tmpValue: Integer;
begin
  Result := ReadInteger(AName, tmpValue);
  if Result then Value := tmpValue;
end;

class function TProfXmlNode4.ReadInt64A(ANode: IXmlNode; const AName: WideString; var Value: Int64): WordBool;
var
  tmpValue: Integer;
begin
  Result := ReadIntegerA(ANode, AName, tmpValue);
  if Result then Value := tmpValue;
end;

class function TProfXmlNode4.ReadInt64Def(ANode: IXmlNode; const AName: WideString; ADef: Int64): Int64;
begin
  Result := ADef;
  ReadInt64A(ANode, AName, Result);
end;

function TProfXmlNode4.ReadInteger(const AName: WideString; var Value: Integer): WordBool;
begin
  Result := ReadIntegerA(FController, AName, Value);
end;

class function TProfXmlNode4.ReadIntegerA(ANode: IXmlNode; const AName: WideString; var Value: Integer): WordBool;
begin
  Result := ProfXmlNode_ReadInt(ANode, AName, Value);
end;

function TProfXmlNode4.ReadString(const AName: WideString; var Value: WideString): WordBool;
begin
  Result := ReadStringA(FController, AName, Value);
end;

class function TProfXmlNode4.ReadStringA(ANode: IXmlNode; const AName: WideString; var Value: WideString): WordBool;
begin
  Result := ProfXmlNode_ReadString(ANode, AName, Value);
end;

class function TProfXmlNode4.ReadStringDef(ANode: IXmlNode; const AName: WideString; const ADef: WideString): WideString;
begin
  Result := ADef;
  ReadStringA(ANode, AName, Result);
end;

function TProfXmlNode4.ReadUInt08(const AName: WideString; var Value: UInt08): WordBool;
var
  tmpValue: Integer;
begin
  Result := ReadInteger(AName, tmpValue);
  if not(Result) then Exit;
  Value := tmpValue;
end;

function TProfXmlNode4.ReadUInt16(const AName: WideString; var Value: UInt16): WordBool;
var
  tmpValue: Integer;
begin
  Result := ReadInteger(AName, tmpValue);
  if not(Result) then Exit;
  Value := tmpValue;
end;

function TProfXmlNode4.ReadUInt32(const AName: WideString; var Value: UInt32): WordBool;
var
  tmpValue: Integer;
begin
  Result := ReadInteger(AName, tmpValue);
  if not(Result) then Exit;
  Value := tmpValue;
end;

function TProfXmlNode4.ReadUInt64(const AName: WideString; var Value: UInt64): WordBool;
var
  tmpValue: Integer;
begin
  Result := ReadInteger(AName, tmpValue);
  if not(Result) then Exit;
  Value := tmpValue;
end;

function TProfXmlNode4.SaveToString(var Value: WideString): Boolean;
begin
  Result := Assigned(FController);
  Value := FController.Xml;
end;

procedure TProfXmlNode4.SetAsString(const Value: WideString);
begin
  if Assigned(FController) then
    Controller.NodeValue := Value; // Не правильно
end;

function TProfXmlNode4.SetValueAsBool(Value: WordBool): WordBool;
begin
  if Assigned(FController) then
    Controller.NodeValue := Value;
end;

function TProfXmlNode4.SetValueAsFloat64(Value: Float64): WordBool;
begin
  if Assigned(FController) then
    Controller.NodeValue := Value;
end;

function TProfXmlNode4.SetValueAsInt32(AValue: Int32): WordBool;
begin
  if Assigned(FController) then
    Controller.NodeValue := AValue;
end;

function TProfXmlNode4.SetValueAsString(const AValue: WideString): WordBool;
begin
  if Assigned(FController) then
    Controller.NodeValue := AValue;
end;

function TProfXmlNode4.SetValueAsUInt08(AValue: UInt08): WordBool;
begin
  if Assigned(FController) then
    Controller.NodeValue := AValue;
end;

function TProfXmlNode4.SetValueAsUInt64(AValue: UInt64): WordBool;
begin
  if Assigned(FController) then
    Controller.NodeValue := AValue;
end;

{procedure TProfXmlNode.SetXml(const Value: WideString);
begin
  if Assigned(FController) then
    Controller.SetText(Value);
end;}

procedure TProfXmlNode4.SetXmlB(const Value: WideString);
begin
  // ...
end;

function TProfXmlNode4.WriteBool(const AName: WideString; Value: WordBool): WordBool;
begin
  Result := ProfXmlNode_WriteBool(FController, AName, Value);
end;

class function TProfXmlNode4.WriteBoolA(ANode: IXmlNode; const AName: WideString; Value: WordBool): WordBool;
begin
  Result := ProfXmlNode_WriteBool(ANode, AName, Value);
end;

function TProfXmlNode4.WriteDateTime(const AName: WideString; Value: TDateTime): WordBool;
begin
  Result := WriteDateTimeA(FController, AName, Value);
end;

class function TProfXmlNode4.WriteDateTimeA(ANode: IXmlNode; const AName: WideString; Value: TDateTime): WordBool;
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

function TProfXmlNode4.WriteFloat32(const AName: WideString; Value: Float32): WordBool;
begin
  Result := WriteFloat32A(FController, AName, Value);
end;

class function TProfXmlNode4.WriteFloat32A(ANode: IXmlNode; const AName: WideString; Value: Float32): WordBool;
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

function TProfXmlNode4.WriteFloat64(const AName: WideString; Value: Float64): WordBool;
begin
  Result := WriteFloat64A(FController, AName, Value);
end;

class function TProfXmlNode4.WriteFloat64A(ANode: IXmlNode; const AName: WideString; Value: Float64): WordBool;
begin
  Result := ProfXmlNode_WriteFloat64(ANode, AName, Value);
end;

function TProfXmlNode4.WriteInt32(const AName: WideString; Value: Int32): WordBool;
begin
  Result := WriteInteger(AName, Value);
end;

function TProfXmlNode4.WriteInt64(const AName: WideString; Value: Int64): WordBool;
begin
  Result := WriteInt32(AName, Value);
end;

function TProfXmlNode4.WriteInteger(const AName: WideString; Value: Integer): WordBool;
begin
  Result := WriteIntegerA(FController, AName, Value);
end;

class function TProfXmlNode4.WriteIntegerA(ANode: IXmlNode; const AName: WideString; Value: Integer): WordBool;
begin
  Result := ProfXmlNode_WriteInt(ANode, AName, Value);
end;

function TProfXmlNode4.WriteString(const AName, Value: WideString): WordBool;
begin
  Result := WriteStringA(FController, AName, Value);
end;

class function TProfXmlNode4.WriteStringA(ANode: IXmlNode; const AName, Value: WideString): WordBool;
begin
  Result := ProfXmlNode_WriteString(ANode, AName, Value);
end;

function TProfXmlNode4.WriteUInt08(const AName: WideString; Value: UInt08): WordBool;
begin
  Result := WriteInteger(AName, Value);
end;

function TProfXmlNode4.WriteUInt64(const AName: WideString; Value: UInt64): WordBool;
begin
  Result := WriteInteger(AName, Value);
end;

function TProfXmlNode4.WriteXml(const AName, AValue: WideString): WordBool;
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
