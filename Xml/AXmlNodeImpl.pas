{**
@Abstract(Класс работы с XML нодами)
@Author(Prof1983 prof1983@ya.ru)
@Created(07.03.2007)
@LastMod(06.07.2012)
@Version(0.5)
}
unit AXmlNodeImpl;

// TODO: Разделить на AXmlNodeObj и AXmlNodeImpl.

interface

uses
  Classes, SysUtils, Variants, XmlDom, XmlIntf,
  AAttributesIntf, ABase, ABaseUtils2, AConsts2, AEntityImpl, ANodeIntf, ATypes,
  AXmlAttributesImpl, AXmlAttributesUtils, AXmlNodeCollectionUtils, AXmlDocumentImpl,
  AXmlNodeIntf, AXmlNodeListUtils, AXmlNodeUtils, AXmlUtils;

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
  protected // IProfNode
    function GetAttributes(): IProfAttributes; safecall;
    function GetChildNodes(): IProfNodes; safecall;
  public
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
    function WriteBool(const AName: WideString; Value: WordBool): WordBool; safecall;
    function WriteDateTime(const AName: WideString; AValue: TDateTime): WordBool; safecall;
    function WriteFloat64(const AName: WideString; Value: Float64): WordBool; safecall;
    function WriteInt32(const AName: WideString; Value: Int32): WordBool; safecall;
    function WriteInt64(const AName: WideString; Value: Int64): WordBool; safecall;
    function WriteString(const AName, Value: WideString): WordBool; safecall;
    //function WriteXml(const AName, Value: WideString): WordBool; safecall;
  public
    class function GetAsBoolA(Node: IXmlNode): WordBool; safecall;
    class function GetAsDateTimeA(Node: IXmlNode): TDateTime; safecall;
    class function GetAsFloat32A(Node: IXmlNode): Float32; safecall;
    class function GetAsFloat64A(Node: IXmlNode): Float64; safecall;
    class function GetAsInt32A(Node: IXmlNode): Int32; safecall;
    class function GetAsInt64A(Node: IXmlNode): Int64; safecall;
    class function GetAsStringA(Node: IXmlNode): WideString; safecall;
  public
    class function GetValueAsBoolA(ANode: IXmlNode; var Value: WordBool): WordBool; safecall;
    class function GetValueAsDateTimeA(ANode: IXmlNode; var Value: TDateTime): WordBool; safecall;
    class function GetValueAsFloat32A(ANode: IXmlNode; var Value: Float32): WordBool; safecall;
    class function GetValueAsFloat64A(ANode: IXmlNode; var Value: Float64): WordBool; safecall;
    class function GetValueAsInt32A(ANode: IXmlNode; var Value: Integer): WordBool; safecall;
    class function GetValueAsInt64A(ANode: IXmlNode; var Value: Int64): WordBool; safecall;
    class function GetValueAsStringA(ANode: IXmlNode; var Value: WideString): WordBool; safecall;
  public
    class function ReadBoolA(ANode: IXmlNode; const AName: WideString;
        var Value: WordBool): WordBool; safecall; deprecated; // Use ProfXmlNode_ReadBool()
    class function ReadDateTimeA(ANode: IXmlNode; const AName: WideString;
        var Value: TDateTime): WordBool; safecall; deprecated; // Use ProfXmlNode_ReadDateTime()
    class function ReadFloat32A(ANode: IXmlNode; const AName: WideString;
        var Value: Float32): WordBool; safecall; deprecated; // Use ProfXmlNode_ReadFloat32()
    class function ReadFloat64A(ANode: IXmlNode; const AName: WideString;
        var Value: Float64): WordBool; safecall; deprecated; // Use ProfXmlNode_ReadFloat64()
    class function ReadInt32A(ANode: IXmlNode; const AName: WideString;
        var Value: Integer): WordBool; safecall; deprecated; // Use ProfXmlNode_ReadInt32()
    class function ReadInt64A(ANode: IXmlNode; const AName: WideString;
        var Value: Int64): WordBool; safecall; deprecated; // Use ProfXmlNode_ReadInt64()
    class function ReadIntegerA(ANode: IXmlNode; const AName: WideString;
        var Value: Integer): WordBool; safecall; deprecated; // Use ProfXmlNode_ReadInt()
    class function ReadStringA(ANode: IXmlNode; const AName: WideString;
        var Value: WideString): WordBool; safecall; deprecated; // Use ProfXmlNode_ReadString()
  public
    class function WriteBoolA(Node: IXmlNode; const Name: APascalString;
        Value: ABool): ABool; safecall; deprecated; // Use ProfXmlNode_WriteBool()
    class function WriteDateTimeA(Node: IXmlNode; const Name: APascalString;
        Value: TDateTime): ABool; safecall; deprecated; // Use ProfXmlNode_WriteDateTime()
    class function WriteFloat32A(Node: IXmlNode; const Name: APascalString;
        Value: AFloat32): ABool; safecall; deprecated; // Use ProfXmlNode_WriteFloat32()
    class function WriteFloat64A(Node: IXmlNode; const Name: APascalString;
        Value: AFloat64): ABool; safecall; deprecated; // Use ProfXmlNode_WriteFloat64()
    class function WriteInt32A(Node: IXmlNode; const Name: APascalString;
        Value: AInt32): ABool; safecall; deprecated; // Use ProfXmlNode_WriteInt32()
    class function WriteInt64A(Node: IXmlNode; const Name: APascalString;
        Value: Int64): ABool; safecall; deprecated; // Use ProfXmlNode_WriteInt64()
    class function WriteIntegerA(Node: IXmlNode; const Name: APascalString;
        Value: AInt): ABool; safecall; deprecated; // Use ProfXmlNode_WriteInt()
    class function WriteStringA(Node: IXmlNode; const Name,
        Value: APascalString): ABool; safecall; deprecated; // Use ProfXmlNode_WriteString()
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

  TProfXmlNode2 = class(TInterfacedObject{TXmlNode}, IProfXmlNode1, IProfXmlNode2{, IXmlNode})
  protected
    FChildNodes: AXmlNodeList;
    FNode: IXmlNode{TXmlNode}; //FController: IXmlNode;
  protected // --- from FProfXmlNode1 ---
    FAttributes: TAttributes;
    FCollection: AXmlNodeCollection;
    FDocument: TProfXmlDocument1;
    FName: WideString;
    FValue: WideString;
  protected
    function _GetValueAsBool(): WordBool;
    function _GetValueAsString(): WideString;
    procedure _SetValueAsBool(Value: WordBool);
    procedure _SetValueAsString(Value: WideString);
  public // IProfXmlNode1
    function Attributes_Count(): Integer;
    function Get_Attribute(const Name: WideString): WideString;
    function Get_Attribute_Name(Index: Integer): WideString;
    function Get_Attribute_Value(Index: Integer): WideString;
      {** Возвращает коллекцию вложеных нодов }
    function Get_Collection(): AXmlNodeCollection;
    function Get_NodeName(): WideString;
    function Get_NodeValue(): WideString;
    function Get_Xml(): WideString;
    procedure Set_Attribute(const Name, Value: WideString);
    procedure Set_NodeName(const Value: WideString);
    procedure Set_NodeValue(const Value: WideString);
    procedure Set_Xml(const Value: WideString);
  public // IProfXmlNode2
    function GetAsString(): WideString;
      {** Возвращает все дочерние ноды }
    function GetXmlB(): WideString;
    procedure SetAsString(const Value: WideString);
    procedure SetXmlB(const Value: WideString); safecall;
  public // IProfXmlNode2
    function GetValueAsBool(var Value: WordBool): WordBool; safecall;
    function GetValueAsDateTime(var Value: TDateTime): WordBool; safecall;
    function GetValueAsFloat32(var Value: AFloat32): WordBool; safecall;
    function GetValueAsFloat64(var Value: AFloat64): WordBool; safecall;
    function GetValueAsInt32(var Value: AInt32): WordBool; safecall;
    function GetValueAsInt64(var AValue: AInt64): WordBool; safecall;
    function GetValueAsInteger(var AValue: AInt): WordBool; safecall;
    function GetValueAsString(var Value: WideString): WordBool; safecall;
    function GetValueAsUInt08(var Value: UInt08): WordBool; safecall;
    function GetValueAsUInt64(var Value: UInt64): WordBool; safecall;
  public // IProfXmlNode2
    function SetValueAsBool(Value: WordBool): WordBool; safecall;
    function SetValueAsFloat64(Value: Float64): WordBool; safecall;
    function SetValueAsInt32(Value: Int32): WordBool; safecall;
    function SetValueAsString(const Value: WideString): WordBool; safecall;
    function SetValueAsUInt08(Value: UInt08): WordBool; safecall;
    function SetValueAsUInt64(Value: UInt64): WordBool; safecall;
  public // IProfXmlNode2
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
    function ReadUInt64(const AName: WideString; var Value: AUInt64): WordBool; virtual; safecall;
    //function ReadWideString(const AName: WideString; var Value: WideString): WordBool; virtual; safecall;
  public // IProfXmlNode2
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
    function WriteXml(const Name, Value: WideString): WordBool; virtual; safecall;
  public
    procedure GetNameAndAttributes(Value: WideString);
    {**
      Чтение вложеных элементов до закрывающего тега
      @param Value - строка
      @param CloseTag - закрывающий тег (без </ >)
    }
    function ReadNodes(var Value: WideString; CloseTag: WideString): Boolean;
  public
    function GetAttribute(const Name: WideString; UpperCase: Boolean = False): WideString;
    function GetChildNodes(): AXmlNodeList;
    function GetCollection(): AXmlNodeCollection;
    function GetCountNodes(): Integer;
    function GetName(): WideString;
      {** @return TProfXmlNode1 or TProfXmlNode2 }
    function GetNode(Index: Integer): TProfXmlNode2;
    function GetNodeByName(const Name: WideString): IXmlNode; safecall;
      {** @return TProfXmlNode1 or TProfXmlNode2 }
    function GetNodeByName1(const Name: WideString): TProfXmlNode2;
    //function GetNodeByName2(const Name: WideString): IProfXmlNode; safecall; - Use GetNodeByName1
    function GetNodeName(): WideString;
    function GetNodeValue(): OleVariant;
      {** Возвращает в виде одной строки без отступов и знаков переноса }
    function GetXml(): WideString;
      {** Возвращает в виде одной строки с отступами и знаками переноса }
    function GetXmlA(Prefix: WideString): WideString;
    procedure SetDocument_Priv(Document: AXmlDocument);
    procedure SetName(const Value: WideString);
    procedure SetNodeName(const Value: WideString);
    procedure SetNodeValue(Value: OleVariant);
  public
    function AddFromXml(Xml: TProfXmlNode2): TError;
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: string; AParams: array of const): Boolean;
    function Clear(): AError;
      {** @return TProfXmlNode1 }
    function FindNode(const Name: WideString): AProfXmlNode; deprecated;
    function Load(): Boolean; virtual;
      {** @param Xml - TProfXmlNode4 or TProfXmlNode2 }
    function LoadFromXml(Xml: AProfXmlNode{TProfXmlNode1}): Boolean;
      {** @return TProfXmlNode1 or TProfXmlNode2 }
    function NewNode(const ANodeName: WideString): AProfXmlNode;
    function NodeExist(AName: WideString): Boolean;
    function SaveToString(var Value: WideString): Boolean;
    {**
      Создает новую дочернюю структуру, разбирая строку
      Value - элемент
    }
    function SetXml(const Value1: WideString): WordBool;
    {**
      Создает новую дочернюю структуру, разбирая строку
      Value - дочерние элементы
    }
    function SetXmlA(var Value: WideString; const CloseTag: WideString = ''): WordBool;
    //function SetXmlA(const Value: WideString): WordBool; virtual;
    function ToStrings(AStrings: TStrings; Prefix: WideString = ''): Boolean;
  public
    class function GetNodeByNameA(Node: IXmlNode;
        const Name: APascalString): IXmlNode; safecall; deprecated; // ProfXmlNode_GetNodeByName()
  public
    class function ReadBoolDef(ANode: IXmlNode; const AName: WideString;
        ADef: WordBool = False): WordBool; safecall; deprecated; // Use ProfXmlNode_ReadBoolDef()
    class function ReadDateTimeDef(ANode: IXmlNode; const AName: WideString;
        ADef: TDateTime = 0): TDateTime; safecall; deprecated; // Use ProfXmlNode_ReadDateTimeDef()
    class function ReadFloatDef(ANode: IXmlNode; const AName: WideString;
        ADef: Float64 = 0): Float64; safecall; deprecated; // Use ProfXmlNode_ReadFloatDef()
    class function ReadInt32Def(ANode: IXmlNode; const AName: WideString;
        ADef: Int32 = 0): Int32; safecall; deprecated; // Use ProfXmlNode_ReadInt32Def()
    class function ReadInt64Def(ANode: IXmlNode; const AName: WideString;
        ADef: Int64 = 0): Int64; safecall; deprecated; // Use ProfXmlNode_ReadInt64Def()
    class function ReadStringDef(ANode: IXmlNode; const AName: WideString;
        const ADef: WideString = ''): WideString; safecall; deprecated; // Use ProfXmlNode_ReadStringDef()
  public
    constructor Create(Node: IXmlNode);
    constructor Create1(Document: AXmlDocument = 0);
    //constructor Create(const ADomNode: IDOMNode; const AParentNode: TXMLNode; const OwnerDoc: TXMLDocument);
    //constructor CreateA();
    procedure Free(); virtual;
  public
    property Attributes[const Name: WideString]: WideString read Get_Attribute write Set_Attribute;
    property Attribute_Name[Index: Integer]: WideString read Get_Attribute_Name;
    property Attribute_Value[Index: Integer]: WideString read Get_Attribute_Value;
    property AsBoolean: WordBool read _GetValueAsBool write _SetValueAsBool;
    property AsString: WideString read _GetValueAsString write _SetValueAsString;
    //property AsString: WideString read GetAsString write SetAsString;
      {** Коллекция вложеных нодов }
    property Collection: AXmlNodeCollection read GetCollection;
    property Controller: IXmlNode read FNode write FNode {implements IXmlNode};
    property Document: TProfXmlDocument1 read FDocument;
    property Node: IXmlNode read FNode; //implements IXmlNode;
    property NodeName: WideString read GetNodeName write SetNodeName;
    property NodeValue: OleVariant read GetNodeValue write SetNodeValue;
    property OwnerDocument: TProfXmlDocument1 read FDocument;
    property ValueStr: WideString read FValue write FValue;
    //property Xml: WideString read GetXml write SetXml;
    property XmlB: WideString read GetXmlB write SetXmlB;
  end;

  TProfXmlNode1 = TProfXmlNode2;
  TProfXmlNode4 = TProfXmlNode2;
  (*TProfXmlNode4 = class(TProfXmlNode2, IXmlNode)
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
    property XmlB: WideString read GetXmlB write SetXmlB;
  end;*)

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

class function TProfXmlNode.GetAsBoolA(Node: IXmlNode): WordBool;
var
  Res: WordBool;
begin
  if ProfXmlNode_GetValueAsBool(Node, Res) then
    Result := Res
  else
    Result := False;
end;

function TProfXmlNode.GetAsDateTime(): TDateTime;
begin
  Result := 0;
  GetValueAsDateTime(Result);
end;

class function TProfXmlNode.GetAsDateTimeA(Node: IXmlNode): TDateTime;
var
  Res: TDateTime;
begin
  if ProfXmlNode_GetValueAsDateTime(Node, Res) then
    Result := Res
  else
    Result := 0;
end;

function TProfXmlNode.GetAsFloat32(): Float32;
begin
  Result := 0;
  GetValueAsFloat32(Result);
end;

class function TProfXmlNode.GetAsFloat32A(Node: IXmlNode): Float32;
var
  Res: Float32;
begin
  if ProfXmlNode_GetValueAsFloat32(Node, Res) then
    Result := Res
  else
    Result := 0;
end;

function TProfXmlNode.GetAsFloat64(): Float64;
begin
  Result := 0;
  GetValueAsFloat64(Result);
end;

class function TProfXmlNode.GetAsFloat64A(Node: IXmlNode): Float64;
var
  Res: Float64;
begin
  if ProfXmlNode_GetValueAsFloat64(Node, Res) then
    Result := Res
  else
    Result := 0;
end;

function TProfXmlNode.GetAsInt32(): Integer;
begin
  Result := 0;
  GetValueAsInt32(Result);
end;

class function TProfXmlNode.GetAsInt32A(Node: IXmlNode): Int32;
var
  Res: Int32;
begin
  if ProfXmlNode_GetValueAsInt32(Node, Res) then
    Result := Res
  else
    Result := 0;
end;

function TProfXmlNode.GetAsInt64(): Int64;
begin
  Result := 0;
  GetValueAsInt64(Result);
end;

class function TProfXmlNode.GetAsInt64A(Node: IXmlNode): Int64;
var
  Res: Int64;
begin
  if ProfXmlNode_GetValueAsInt64(Node, Res) then
    Result := Res
  else
    Result := 0;
end;

function TProfXmlNode.GetAsString(): WideString;
begin
  Result := '';
  GetValueAsString(Result);
end;

class function TProfXmlNode.GetAsStringA(Node: IXmlNode): WideString;
begin
  Result := '';
  GetValueAsStringA(Node, Result);
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
  Result := AXmlNode_GetChildNodeCount(AXmlNode(Self));
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
  Result := ProfXmlNode_GetValueAsBool(ANode, Value);
end;

function TProfXmlNode.GetValueAsDateTime(var Value: TDateTime): WordBool;
begin
  Result := GetValueAsDateTimeA(FNode, Value);
end;

class function TProfXmlNode.GetValueAsDateTimeA(ANode: IXmlNode; var Value: TDateTime): WordBool;
begin
  Result := ProfXmlNode_GetValueAsDateTime(ANode, Value);
end;

function TProfXmlNode.GetValueAsFloat32(var Value: Float32): WordBool;
begin
  Result := GetValueAsFloat32A(FNode, Value);
end;

class function TProfXmlNode.GetValueAsFloat32A(ANode: IXmlNode; var Value: Float32): WordBool;
begin
  Result := ProfXmlNode_GetValueAsFloat32(ANode, Value);
end;

function TProfXmlNode.GetValueAsFloat64(var Value: Float64): WordBool;
begin
  Result := GetValueAsFloat64A(FNode, Value);
end;

class function TProfXmlNode.GetValueAsFloat64A(ANode: IXmlNode; var Value: Float64): WordBool;
begin
  Result := ProfXmlNode_GetValueAsFloat64(ANode, Value)
end;

function TProfXmlNode.GetValueAsInt32(var Value: Integer): WordBool;
begin
  Result := GetValueAsInt32A(FNode, Value);
end;

class function TProfXmlNode.GetValueAsInt32A(ANode: IXmlNode; var Value: Integer): WordBool;
begin
  Result := ProfXmlNode_GetValueAsInt32(ANode, Value);
end;

function TProfXmlNode.GetValueAsInt64(var AValue: Int64): WordBool;
begin
  Result := GetValueAsInt64A(FNode, AValue);
end;

class function TProfXmlNode.GetValueAsInt64A(ANode: IXmlNode; var Value: Int64): WordBool;
begin
  Result := ProfXmlNode_GetValueAsInt64(ANode, Value);
end;

function TProfXmlNode.GetValueAsString(var Value: WideString): WordBool;
begin
  Result := GetValueAsStringA(FNode, Value);
end;

class function TProfXmlNode.GetValueAsStringA(ANode: IXmlNode; var Value: WideString): WordBool;
begin
  Result := ProfXmlNode_GetValueAsString(ANode, Value);
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
  Result := ProfXmlNode_ReadBool(FNode, Name, Value);
end;

class function TProfXmlNode.ReadBoolA(ANode: IXmlNode; const AName: WideString;
    var Value: WordBool): WordBool;
begin
  Result := ProfXmlNode_ReadBool(ANode, AName, Value);
end;

function TProfXmlNode.ReadBoolDef(const Name: WideString; DefValue: WordBool): WordBool;
begin
  Result := DefValue;
  ReadBool(Name, Result)
end;

function TProfXmlNode.ReadDateTime(const Name: WideString; var Value: TDateTime): WordBool;
begin
  Result := ProfXmlNode_ReadDateTime(FNode, Name, Value);
end;

class function TProfXmlNode.ReadDateTimeA(ANode: IXmlNode; const AName: WideString;
    var Value: TDateTime): WordBool;
begin
  Result := ProfXmlNode_ReadDateTime(ANode, AName, Value);
end;

function TProfXmlNode.ReadDateTimeDef(const Name: WideString; DefValue: TDateTime): TDateTime;
begin
  Result := DefValue;
  ReadDateTime(Name, Result);
end;

class function TProfXmlNode.ReadFloat32A(ANode: IXmlNode; const AName: WideString;
    var Value: Float32): WordBool;
begin
  Result := ProfXmlNode_ReadFloat32(ANode, AName, Value);
end;

function TProfXmlNode.ReadFloat64(const Name: WideString; var Value: Double): WordBool;
begin
  Result := ProfXmlNode_ReadFloat64(FNode, Name, Value);
end;

class function TProfXmlNode.ReadFloat64A(ANode: IXmlNode; const AName: WideString;
    var Value: Float64): WordBool;
begin
  Result := ProfXmlNode_ReadFloat64(ANode, AName, Value);
end;

function TProfXmlNode.ReadFloat64Def(const Name: WideString; DefValue: Double): Double;
begin
  Result := DefValue;
  ReadFloat64(Name, Result);
end;

function TProfXmlNode.ReadInt32(const Name: WideString; var Value: Integer): WordBool;
begin
  Result := (AXmlNode_ReadInt32(AXmlNode(Self), Name, Value) >= 0);
end;

class function TProfXmlNode.ReadInt32A(ANode: IXmlNode; const AName: WideString; var Value: Integer): WordBool;
begin
  Result := ProfXmlNode_ReadInt32(ANode, AName, Value);
end;

function TProfXmlNode.ReadInt32Def(const Name: WideString; DefValue: Integer): Integer;
begin
  Result := DefValue;
  ReadInt32(Name, Result);
end;

function TProfXmlNode.ReadInt64(const Name: WideString; var Value: Int64): WordBool;
begin
  Result := ProfXmlNode_ReadInt64(FNode, Name, Value);
end;

class function TProfXmlNode.ReadInt64A(ANode: IXmlNode; const AName: WideString;
    var Value: Int64): WordBool;
begin
  Result := ProfXmlNode_ReadInt64(ANode, AName, Value);
end;

function TProfXmlNode.ReadInt64Def(const Name: WideString; DefValue: Int64): Int64;
begin
  Result := DefValue;
  ReadInt64(Name, Result);
end;

class function TProfXmlNode.ReadIntegerA(ANode: IXmlNode; const AName: WideString;
    var Value: Integer): WordBool;
begin
  Result := ProfXmlNode_ReadInt(ANode, AName, Value);
end;

function TProfXmlNode.ReadString(const Name: WideString; var Value: WideString): WordBool;
var
  V: APascalString;
begin
  V := Value;
  Result := (AXmlNode_ReadString(AXmlNode(Self), Name, V) >= 0);
  Value := V;
end;

class function TProfXmlNode.ReadStringA(ANode: IXmlNode; const AName: WideString;
    var Value: WideString): WordBool;
begin
  Result := ProfXmlNode_ReadString(ANode, AName, Value);
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
  Result := (AXmlNode_WriteBool(AXmlNode(Self), AName, Value) >= 0);
end;

class function TProfXmlNode.WriteBoolA(Node: IXmlNode; const Name: APascalString;
    Value: ABool): ABool;
begin
  Result := ProfXmlNode_WriteBool(Node, Name, Value);
end;

function TProfXmlNode.WriteDateTime(const AName: WideString; AValue: TDateTime): WordBool;
begin
  Result := ProfXmlNode_WriteDateTime(FNode, AName, AValue);
end;

class function TProfXmlNode.WriteDateTimeA(Node: IXmlNode; const Name: APascalString;
    Value: TDateTime): ABool;
begin
  Result := ProfXmlNode_WriteDateTime(Node, Name, Value);
end;

class function TProfXmlNode.WriteFloat32A(Node: IXmlNode; const Name: APascalString;
    Value: AFloat32): ABool;
begin
  Result := ProfXmlNode_WriteFloat32(Node, Name, Value);
end;

function TProfXmlNode.WriteFloat64(const AName: WideString; Value: Double): WordBool;
begin
  Result := ProfXmlNode_WriteFloat64(FNode, AName, Value);
end;

class function TProfXmlNode.WriteFloat64A(Node: IXmlNode; const Name: APascalString;
    Value: AFloat64): ABool;
begin
  Result := ProfXmlNode_WriteFloat64(Node, Name, Value);
end;

function TProfXmlNode.WriteInt32(const AName: WideString; Value: Integer): WordBool;
begin
  Result := (AXmlNode_WriteInt(AXmlNode(Self), AName, Value) >= 0);
end;

class function TProfXmlNode.WriteInt32A(Node: IXmlNode; const Name: APascalString;
    Value: AInt32): ABool;
begin
  Result := ProfXmlNode_WriteInt32(Node, Name, Value);
end;

function TProfXmlNode.WriteInt64(const AName: WideString; Value: Int64): WordBool;
begin
  Result := ProfXmlNode_WriteInt64(FNode, AName, Value);
end;

class function TProfXmlNode.WriteInt64A(Node: IXmlNode; const Name: APascalString;
    Value: AInt64): ABool;
begin
  Result := ProfXmlNode_WriteInt64(Node, Name, Value);
end;

class function TProfXmlNode.WriteIntegerA(Node: IXmlNode; const Name: APascalString;
    Value: AInt): ABool;
begin
  Result := ProfXmlNode_WriteInt(Node, Name, Value);
end;

function TProfXmlNode.WriteString(const AName, Value: WideString): WordBool;
begin
  Result := ProfXmlNode_WriteString(FNode, AName, Value);
end;

class function TProfXmlNode.WriteStringA(Node: IXmlNode; const Name,
    Value: APascalString): ABool;
begin
  Result := ProfXmlNode_WriteString(Node, Name, Value);
end;

{ TProfXmlNode2 }

function TProfXmlNode2.AddFromXml(Xml: TProfXmlNode2): TError;
begin
  if Self.LoadFromXml(AProfXmlNode(Xml)) then
    Result := 0
  else
    Result := -1;
end;

function TProfXmlNode2.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: String; AParams: array of const): Boolean;
begin
  if Assigned(FDocument) then
    Result := FDocument.AddToLog(AGroup, AType, AStrMsg, AParams)
  else
    Result := False;
end;

function TProfXmlNode2.Attributes_Count: Integer;
begin
  Result := Length(FAttributes);
end;

function TProfXmlNode2.Clear(): AError;
begin
  SetLength(FAttributes, 0);
  AXmlNodeCollection_Clear(FCollection);
  Result := 0;
end;

constructor TProfXmlNode2.Create(Node: IXmlNode);
begin
  inherited Create;
  FChildNodes := 0;
  FNode := Node;
  if Assigned(FNode) then
    FCollection := AXmlNodeCollection_New2(FNode.Collection);
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

constructor TProfXmlNode2.Create1(Document: AXmlDocument);
begin
  inherited Create();
  FChildNodes := 0;
  FNode := nil;
  Self._AddRef();
  FCollection := AXmlNodeCollection_New1(AProfXmlNode1(Self));
  FDocument := TProfXmlDocument1(Document);
  FName := '';
  FValue := '';
end;

function TProfXmlNode2.FindNode(const Name: WideString): AProfXmlNode;
begin
  Result := AProfXmlNode(Self.GetNodeByName1(Name));
end;

procedure TProfXmlNode2.Free();
begin
  Clear();
  AXmlNodeCollection_Free(FCollection);
  FCollection := 0;
  Self._Release();
  inherited Free;
end;

function TProfXmlNode2.GetAsString(): WideString;
begin
  if Assigned(FNode) and ((VarType(FNode.NodeValue) = varOleStr) or (VarType(FNode.NodeValue) = varStrArg) or (VarType(FNode.NodeValue) = varString)) then
    Result := FNode.NodeValue
  else
    Result := '';
end;

function TProfXmlNode2.GetAttribute(const Name: WideString; UpperCase: Boolean = False): WideString;
var
  V: OleVariant;
begin
  if Assigned(FNode) then
  begin
    V := ProfXmlNode_GetAttribute(FNode, Name);
    if (VarType(V) = varString) or (VarType(V) = varOleStr) then
      Result := V
    else
      Result := '';
  end
  else
    Result := AXmlAttribures_GetAttribute(FAttributes, Name, UpperCase);
end;

function TProfXmlNode2.GetChildNodes(): AXmlNodeList;
begin
  if (FChildNodes = 0) then
  begin
    if Assigned(FNode) then
      FChildNodes := AXmlNodeList_New(FNode.ChildNodes)
    else
      FChildNodes := AXmlNodeList_New(nil);
  end;
  Result := FChildNodes;
end;

function TProfXmlNode2.GetCollection(): AXmlNodeCollection;
begin
  if (FCollection = 0) then
  begin
    if Assigned(FNode) then
      FCollection := AXmlNodeCollection_New2(FNode.Collection)
    else
      FCollection := AXmlNodeCollection_New1(AProfXmlNode(Self));
  end;
  Result := FCollection;
end;

function TProfXmlNode2.GetCountNodes(): Integer;
begin
  Result := AXmlNode_GetChildNodeCount(AXmlNode(Self));
end;

function TProfXmlNode2.GetName(): WideString;
begin
  if Assigned(FNode) then
    Result := FNode.NodeName
  else
    Result := FName;
end;

procedure TProfXmlNode2.GetNameAndAttributes(Value: WideString);
begin
  _GetNameAndAttributes(Value, FAttributes, FName);
end;

function TProfXmlNode2.GetNode(Index: Integer): TProfXmlNode2;
var
  Node: IXmlNode;
begin
  if Assigned(FNode) then
  begin
    Node := FNode.Collection.Nodes[Index];
    if Assigned(Node) then
      Result := TProfXmlNode2.Create(Node)
    else
      Result := nil;
  end
  else if (FCollection <> 0) then
    Result := TProfXmlNode2(AXmlNodeCollection_GetNode(FCollection, Index))
  else
    Result := nil;
end;

// TODO: Rename to GetNodeByName3()
function TProfXmlNode2.GetNodeByName(const Name: WideString): IXmlNode;
var
  Node: IXmlNode;
begin
  if not(Assigned(FNode)) then
  begin
    Result := nil;
    Exit;
  end;
  // Поиск XML нода
  Node := FNode.ChildNodes.FindNode(Name);
  // Если нету - создание XML нода
  if not(Assigned(Node)) then
    Node := FNode.AddChild(Name);
  Result := Node; //as IXmlNode;
end;

function TProfXmlNode2.GetNodeByName1(const Name: WideString): TProfXmlNode2;
var
  N: AXmlNode;
begin
  N := AXmlNode_GetChildNodeByName(AXmlNode(Self), Name);
  if (TObject(N) is TProfXmlNode2) then
    Result := TProfXmlNode2(N)
  else
    Result := nil;
end;

(*function TProfXmlNode2.GetNodeByName2(const Name: WideString): IProfXmlNode;
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
  Result := nil;
end;*)

class function TProfXmlNode2.GetNodeByNameA(Node: IXmlNode; const Name: APascalString): IXmlNode;
begin
  Result := ProfXmlNode_GetNodeByName(Node, Name);
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
var
  V: ABoolean;
  Res: AError;
begin
  V := Value;
  Res := AXmlNode_GetValueAsBool(AXmlNode(Self), V);
  Value := V;
  Result := (Res >= 0);
end;

function TProfXmlNode2.GetValueAsDateTime(var Value: TDateTime): WordBool;
begin
  if Assigned(FNode) then
    Result := ProfXmlNode_GetValueAsDateTime(FNode, Value)
  else
  try
    Value := StrToDateTime(FValue);
    Result := True;
  except
    Result := False;
  end;
end;

function TProfXmlNode2.GetValueAsFloat32(var Value: AFloat32): WordBool;
begin
  Result := ProfXmlNode_GetValueAsFloat32(FNode, Value);
end;

function TProfXmlNode2.GetValueAsFloat64(var Value: AFloat64): WordBool;
begin
  Result := ProfXmlNode_GetValueAsFloat64(FNode, Value);
end;

function TProfXmlNode2.GetValueAsInt32(var Value: AInt32): WordBool;
var
  Code: Integer;
begin
  if Assigned(FNode) then
    Result := ProfXmlNode_GetValueAsInt32(FNode, Value)
  else
  begin
    Val(FValue, Value, Code);
    Result := (Code = 0);
  end;
end;

function TProfXmlNode2.GetValueAsInt64(var AValue: AInt64): WordBool;
var
  Code: Integer;
begin
  if Assigned(FNode) then
    Result := ProfXmlNode_GetValueAsInt64(FNode, AValue)
  else
  begin
    Val(FValue, AValue, Code);
    Result := (Code = 0);
  end;
end;

function TProfXmlNode2.GetValueAsInteger(var AValue: AInt): WordBool;
begin
  Result := GetValueAsInt32(AValue);
end;

function TProfXmlNode2.GetValueAsString(var Value: WideString): WordBool;
var
  V: APascalString;
  Res: AError;
begin
  V := Value;
  Res := AXmlNode_GetValueAsString(AXmlNode(Self), V);
  Value := V;
  Result := (Res >= 0);
end;

function TProfXmlNode2.GetValueAsUInt08(var Value: UInt08): WordBool;
var
  Code: Integer;
begin
  if Assigned(FNode) then
  try
    Value := FNode.NodeValue;
  except
  end
  else
  begin
    Val(FValue, Value, Code);
    Result := (Code = 0);
  end;
end;

function TProfXmlNode2.GetValueAsUInt64(var Value: UInt64): WordBool;
var
  V: AUInt64;
  Res: AError;
begin
  V := Value;
  Res := AXmlNode_GetValueAsUInt64(AXmlNode(Self), V);
  Value := V;
  Result := (Res >= 0);
end;

function TProfXmlNode2.GetXml(): WideString;
var
  I: Int32;
  Attr: WideString;
begin
  if Assigned(FNode) then
    Result := FNode.XML
  else
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
end;

function TProfXmlNode2.GetXmlA(Prefix: WideString): WideString;
var
  I: Int32;
  Attr: WideString;
  Child: AXmlNode;
begin
  // Атрибуты
  Attr := '';
  for I := 0 to High(FAttributes) do
    Attr := Attr + ' ' + FAttributes[I].Name+'="'+FAttributes[I].Value+'"';

  if (GetCountNodes > 0) then
  begin
    Result := Prefix + '<'+FName+Attr+'>' + #13#10;
    for I := 0 to AXmlNodeCollection_GetCount(FCollection) - 1 do
    begin
      Child := AXmlNodeCollection_GetNode(FCollection, I);
      Result := Result + AXmlNode_GetXmlA(Child, Prefix + '  ');
    end;
    Result := Result + Prefix + '</'+FName+'>'+#13#10;
  end else begin
    if FName <> '' then Result := Prefix + '<'+FName+Attr+'>'+StrHtmlFromStr(FValue)+'</'+FName+'>'+#13#10;
  end;
end;

function TProfXmlNode2.GetXmlB(): WideString;
var
  I: Int32;
  Nodes: AXmlNodeList;
  Child: AXmlNode;
begin
  Nodes := GetChildNodes();
  if (Nodes = 0) then
  begin
    Result := '';
    Exit;
  end;

  Result := '';
  for I := 0 to AXmlNodeList_GetCount(Nodes) - 1 do
  begin
    Child := AXmlNodeList_GetNodeByIndex(Nodes, I);
    Result := Result + AXmlNode_GetXml(Child);
  end;
end;

function TProfXmlNode2.Get_Attribute(const Name: WideString): WideString;
begin
  Result := GetAttribute(Name); //Result := FNode.GetAttribute(Name);
end;

function TProfXmlNode2.Get_Attribute_Name(Index: Integer): WideString;
begin
  if (Index >= 0) and (Index < Length(FAttributes)) then
    Result := FAttributes[Index].Name
  else
    Result := '';
end;

function TProfXmlNode2.Get_Attribute_Value(Index: Integer): WideString;
begin
  if (Index >= 0) and (Index < Length(FAttributes)) then
    Result := FAttributes[Index].Value
  else
    Result := '';
end;

function TProfXmlNode2.Get_Collection(): AXmlNodeCollection;
begin
  Result := Self.GetCollection();
end;

function TProfXmlNode2.Get_NodeName(): WideString;
begin
  Result := FName;
end;

function TProfXmlNode2.Get_NodeValue(): WideString;
begin
  Result := FValue;
end;

function TProfXmlNode2.Get_Xml(): WideString;
begin
  Result := GetXml();
end;

function TProfXmlNode2.Load(): Boolean;
begin
  Result := False;
end;

function TProfXmlNode2.LoadFromXml(Xml: AProfXmlNode{TProfXmlNode1}): Boolean;
var
  ANode: TProfXmlNode1;
  I: Int32;
  Xml1: TProfXmlNode2;
begin
  Xml1 := TProfXmlNode2(Xml);
  Result := False;
  if not(Assigned(Xml1)) then Exit;
  FValue := Xml1.FValue;
  for I := 0 to Xml1.GetCountNodes do
  begin
    ANode := Xml1.GetNode(I);
    TProfXmlNode2(GetNodeByName(ANode.GetName)).LoadFromXml(AProfXmlNode(ANode));
  end;
  Result := True;
end;

function TProfXmlNode2.NewNode(const ANodeName: WideString): AProfXmlNode;
var
  Node: AXmlNode;
  Nodes: AXmlNodeList;
begin
  if Assigned(FNode) then
    Result := AProfXmlNode(TProfXmlNode2.Create(FNode.AddChild(ANodeName)))
  else if Assigned(Self.FDocument) then
  begin
    Node := AXmlNode1_New(AXmlDocument(Self.FDocument));
    Nodes := AXmlNode_GetChildNodes(AXmlNode(Self));
    Result := AXmlNodeList_Add(Nodes, Node);
  end
  else
  begin
    Result := 0;
    Exit;
  end;
end;

function TProfXmlNode2.NodeExist(AName: WideString): Boolean;
begin
  Result := (FindNode(AName) <> 0);
end;

function TProfXmlNode2.ReadBool(const AName: WideString; var Value: WordBool): WordBool;
var
  Node: IXmlNode;
  Node1: AProfXmlNode;
  V: ABoolean;
  Res: AError;
  Nodes: AXmlNodeList;
begin
  if Assigned(FNode) then
  begin
    Result := ProfXmlNode_ReadBool(FNode, AName, Value);
  end
  else
  begin
    V := Value;
    Result := (AXmlNode_ReadBool(AXmlNode(Self), AName, V) >= 0);
    Value := V;
  end;
end;

class function TProfXmlNode2.ReadBoolDef(ANode: IXmlNode; const AName: WideString;
    ADef: WordBool): WordBool;
begin
  Result := ProfXmlNode_ReadBoolDef(ANode, AName, ADef);
end;

function TProfXmlNode2.ReadDateTime(const AName: WideString; var Value: TDateTime): WordBool;
var
  S: WideString;
  Node: AProfXmlNode;
  Nodes: AXmlNodeList;
begin
  if Assigned(FNode) then
    Result := ProfXmlNode_ReadDateTime(FNode, AName, Value)
  else
  begin
    Nodes := AXmlNode_GetChildNodes(AXmlNode(Self));
    if (Nodes <> 0) then
    begin
      Node := AXmlNodeList_FindNode(Nodes, AName);
      if (Node = 0) then
      begin
        Result := False;
        Exit;
      end;
      Result := (AXmlNode_GetValueAsDateTime(Node, Value) >= 0);
    end
    else
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
  end;
end;

class function TProfXmlNode2.ReadDateTimeDef(ANode: IXmlNode; const AName: WideString;
    ADef: TDateTime): TDateTime;
begin
  Result := ProfXmlNode_ReadDateTimeDef(ANode, AName, ADef);
end;

function TProfXmlNode2.ReadFloat32(const AName: WideString; var Value: Float32): WordBool;
var
  Code: Integer;
  Node: IXmlNode;
  V64: Float64;
begin
  if Assigned(FNode) then
    Result := ProfXmlNode_ReadFloat32(FNode, AName, Value)
  else
  begin
    V64 := Value;
    Result := ReadFloat64(AName, V64);
    Value := V64;
  end;
end;

function TProfXmlNode2.ReadFloat64(const AName: WideString; var Value: Float64): WordBool;
var
  Code: Integer; //Code: Cardinal;
  Node: IXmlNode;
  S: WideString;
begin
  if Assigned(FNode) then
    Result := ProfXmlNode_ReadFloat64(FNode, AName, Value)
  else
  begin
    if not(ReadString(AName, S)) then
    begin
      Result := False;
      Exit;
    end;
    Val(S, Value, Code);
    Result := (Code = 0);
  end;
end;

class function TProfXmlNode2.ReadFloatDef(ANode: IXmlNode; const AName: WideString; ADef: Float64): Float64;
begin
  Result := ProfXmlNode_ReadFloatDef(ANode, AName, ADef);
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
  Result := (AXmlNode_ReadInt32(AXmlNode(Self), AName, Value) >= 0);
end;

class function TProfXmlNode2.ReadInt32Def(ANode: IXmlNode; const AName: WideString;
    ADef: Int32): Int32;
begin
  Result := ProfXmlNode_ReadInt32Def(ANode, AName, ADef);
end;

function TProfXmlNode2.ReadInt64(const AName: WideString; var Value: Int64): WordBool;
var
  tmpValue: Integer;
  Node: AProfXmlNode;
  Nodes: AXmlNodeList;
begin
  Nodes := AXmlNode_GetChildNodes(AXmlNode(Self));
  if (Nodes <> 0) then
  begin
    Node := AXmlNodeList_FindNode(Nodes, AName);
    Result := (AXmlNode_GetValueAsInt64(Node, Value) >= 0);
  end
  else
  begin
    Result := ReadInteger(AName, tmpValue);
    if Result then Value := tmpValue;
  end;
end;

class function TProfXmlNode2.ReadInt64Def(ANode: IXmlNode; const AName: WideString; ADef: Int64): Int64;
begin
  Result := ProfXmlNode_ReadInt64Def(ANode, AName, ADef);
end;

function TProfXmlNode2.ReadInteger(const AName: WideString; var Value: Integer): WordBool;
begin
  Result := (AXmlNode_ReadInt(AXmlNode(Self), AName, Value) >= 0);
end;

function TProfXmlNode2.ReadNodes(var Value: WideString; CloseTag: WideString): Boolean;
var
  I: Integer;
  I2: Integer;
  N: AProfXmlNode1;
  Tag: WideString;
  V: APascalString;
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
      AXmlNode_GetNameAndAttributes(N, Tag);
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
      AXmlNode_GetNameAndAttributes(N, Tag);
      V := Value;
      AXmlNode_SetXmlA(N, V, AXmlNode_GetName(N));
      Value := V;
    end;
  until False;
end;

function TProfXmlNode2.ReadString(const AName: WideString; var Value: WideString): WordBool;
var
  V: APascalString;
begin
  V := Value;
  Result := (AXmlNode_ReadString(AXmlNode(Self), AName, V) >= 0);
  Value := V;
end;

class function TProfXmlNode2.ReadStringDef(ANode: IXmlNode; const AName: WideString;
    const ADef: WideString): WideString;
begin
  Result := ProfXmlNode_ReadStringDef(ANode, AName, ADef);
end;

function TProfXmlNode2.ReadUInt08(const AName: WideString; var Value: UInt08): WordBool;
var
  tmpValue: Integer;
  Node: AProfXmlNode;
  Nodes: AXmlNodeList;
begin
  Nodes := AXmlNode_GetChildNodes(AXmlNode(Self));
  if (Nodes <> 0) then
  begin
    Node := AXmlNodeList_FindNode(Nodes, AName);
    if (Node = 0) then
    begin
      Result := False;
      Exit;
    end;
    Result := (AXmlNode_GetValueAsUInt08(Node, Value) >= 0);
  end
  else
  begin
    Result := ReadInteger(AName, tmpValue);
    if not(Result) then Exit;
    Value := tmpValue;
  end;
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

function TProfXmlNode2.ReadUInt64(const AName: WideString; var Value: AUInt64): WordBool;
var
  tmpValue: Integer;
  Node: AProfXmlNode;
  Nodes: AXmlNodeList;
begin
  Nodes := AXmlNode_GetChildNodes(AXmlNode(Self));
  if (Nodes <> 0) then
  begin
    Node := AXmlNodeList_FindNode(Nodes, AName);
    Result := (AXmlNode_GetValueAsUInt64(Node, Value) >= 0);
  end
  else
  begin
    Result := ReadInteger(AName, tmpValue);
    if not(Result) then Exit;
    Value := tmpValue;
  end;
end;

function TProfXmlNode2.SaveToString(var Value: WideString): Boolean;
begin
  if not(Assigned(FNode)) then
  begin
    Result := False;
    Exit;
  end;
  Value := FNode.Xml;
  Result := True;
end;

procedure TProfXmlNode2.SetDocument_Priv(Document: AXmlDocument);
begin
  FDocument := TProfXmlDocument1(Document);
end;

procedure TProfXmlNode2.SetAsString(const Value: WideString);
begin
  SetNodeValue(Value);
  {if Assigned(FNode) then
    FNode.NodeValue := Value; // Не правильно}
end;

procedure TProfXmlNode2.SetName(const Value: WideString);
begin
  FName := Value;
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
  if Assigned(FNode) then
  begin
    FNode.NodeValue := Value;
    Result := True;
  end
  else
  begin
    {$IFDEF VER150}
    FValue := BoolToStr(Value, True);
    {$ELSE}
    if Value then FValue := 'True' else FValue := 'False';
    {$ENDIF}
    Result := True;
  end;
end;

function TProfXmlNode2.SetValueAsFloat64(Value: Float64): WordBool;
begin
  if Assigned(FNode) then
  begin
    FNode.NodeValue := Value;
    Result := True;
  end
  else
  begin
    FValue := FloatToStr(Value);
    Result := True;
  end;
end;

function TProfXmlNode2.SetValueAsInt32(Value: Int32): WordBool;
begin
  if Assigned(FNode) then
  begin
    FNode.NodeValue := Value;
    Result := True;
  end
  else
  begin
    FValue := IntToStr(Value);
    Result := True;
  end;
end;

function TProfXmlNode2.SetValueAsString(const Value: WideString): WordBool;
begin
  Result := (AXmlNode_SetValueAsString(AXmlNode(Self), Value) >= 0);
end;

function TProfXmlNode2.SetValueAsUInt08(Value: UInt08): WordBool;
begin
  if Assigned(FNode) then
  begin
    FNode.NodeValue := Value;
    Result := True;
  end
  else
  begin
    FValue := IntToStr(Value);
    Result := True;
  end;
end;

function TProfXmlNode2.SetValueAsUInt64(Value: UInt64): WordBool;
begin
  if Assigned(FNode) then
  begin
    FNode.NodeValue := Value;
    Result := True;
  end
  else
  begin
    FValue := IntToStr(Value);
    Result := True;
  end;
end;

function TProfXmlNode2.SetXml(const Value1: WideString): WordBool;
var
  I: Integer;
  I2: Integer;
  Tag: string;
  Value: WideString;
begin
  if Assigned(FNode) then
  begin
    Self.FNode.Text := Value1;
    Result := True;
  end
  else
  begin
    Result := False;
    FValue := '';
    Value := Value1;
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
  end;
end;

{function TProfXmlNode2.SetXmlA(const Value: WideString): WordBool;
begin
  //if Assigned(FNode) then
  //  FNode.Xml := Value;
  Result := False;
  // ...
end;}
function TProfXmlNode2.SetXmlA(var Value: WideString; const CloseTag: WideString = ''): WordBool;
begin
  Result := ReadNodes(Value, CloseTag);
end;

procedure TProfXmlNode2.SetXmlB(const Value: WideString);
begin
  SetXml(Value);
end;

procedure TProfXmlNode2.Set_Attribute(const Name, Value: WideString);
begin
  AXmlAttributes_SetAttribute(FAttributes, Name, Value); //FNode.SetAttribute(Name, Value);
end;

procedure TProfXmlNode2.Set_NodeName(const Value: WideString);
begin
  FName := Value;
end;

procedure TProfXmlNode2.Set_NodeValue(const Value: WideString);
begin
  FValue := Value;
end;

procedure TProfXmlNode2.Set_Xml(const Value: WideString);
begin
  SetXml(Value);
end;

function TProfXmlNode2.ToStrings(AStrings: TStrings; Prefix: WideString = ''): Boolean;
var
  I: Int32;
  Node: AXmlNode;
begin
  Result := False;
  if not(Assigned(AStrings)) then Exit;
  if GetCountNodes > 0 then
  begin
    AStrings.Add(Prefix + '<'+FName+'>');
    for I := 0 to AXmlNodeCollection_GetCount(FCollection) - 1 do
    begin
      Node := AXmlNodeCollection_GetNode(FCollection, I);
      TProfXmlNode1(Node).ToStrings(AStrings, Prefix + '  ');
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

function TProfXmlNode2.WriteBool(const AName: WideString; Value: WordBool): WordBool;
begin
  Result := (AXmlNode_WriteBool(AXmlNode(Self), AName, Value) >= 0);
end;

function TProfXmlNode2.WriteDateTime(const AName: WideString; Value: TDateTime): WordBool;
var
  Nodes: AXmlNodeList;
  N: AXmlNode;
begin
  if Assigned(FNode) then
    Result := ProfXmlNode_WriteDateTime(FNode, AName, Value)
  else
  begin
    Nodes := AXmlNode_GetChildNodes(AXmlNode(Self));
    N := AXmlNodeList_GetNodeByName1(Nodes, AName);
    Result := (AXmlNode_SetValueAsFloat64(N, Value) >= 0);
  end;
end;

function TProfXmlNode2.WriteFloat32(const AName: WideString; Value: Float32): WordBool;
begin
  Result := ProfXmlNode_WriteFloat32(FNode, AName, Value);
end;

function TProfXmlNode2.WriteFloat64(const AName: WideString; Value: Float64): WordBool;
var
  Node: IXmlNode;
  Nodes: AXmlNodeList;
  N: AXmlNode;
begin
  if Assigned(FNode) then
    Result := ProfXmlNode_WriteFloat64(FNode, AName, Value)
  else
  begin
    Nodes := AXmlNode_GetChildNodes(AXmlNode(Self));
    N := AXmlNodeList_GetNodeByName1(Nodes, AName);
    Result := (AXmlNode_SetValueAsFloat64(N, Value) >= 0);
  end;
end;

function TProfXmlNode2.WriteInt32(const AName: WideString; Value: Int32): WordBool;
begin
  Result := (AXmlNode_WriteInt(AXmlNode(Self), AName, Value) >= 0);
end;

function TProfXmlNode2.WriteInt64(const AName: WideString; Value: Int64): WordBool;
begin
  Result := (AXmlNode_WriteInt(AXmlNode(Self), AName, Value) >= 0);
end;

function TProfXmlNode2.WriteInteger(const AName: WideString; Value: Integer): WordBool;
begin
  Result := (AXmlNode_WriteInt(AXmlNode(Self), AName, Value) >= 0);
end;

function TProfXmlNode2.WriteString(const AName, Value: WideString): WordBool;
var
  Node: IXmlNode;
begin
  Result := (AXmlNode_WriteString(AXmlNode(Self), AName, Value) >= 0);
end;

function TProfXmlNode2.WriteUInt08(const AName: WideString; Value: UInt08): WordBool;
begin
  if Assigned(FNode) then
    Result := WriteInteger(AName, Value)
  else
    Result := GetNodeByName1(AName).SetValueAsUInt08(Value);
end;

function TProfXmlNode2.WriteUInt64(const AName: WideString; Value: UInt64): WordBool;
begin
  if Assigned(FNode) then
    Result := WriteInteger(AName, Value)
  else
    Result := GetNodeByName1(AName).SetValueAsUInt64(Value);
end;

function TProfXmlNode2.WriteXml(const Name, Value: WideString): WordBool;
var
  Node: IXmlNode;
begin
  if Assigned(FNode) then
  begin
    Node := FNode.ChildNodes.FindNode(Name);
    if Assigned(Node) then
      Node.NodeValue := Value
    else
      FNode.AddChild(Name).NodeValue := Value;
    Result := True;
  end
  else
    Result := GetNodeByName1(Name).SetXml(Value);
end;

function TProfXmlNode2._GetValueAsBool: WordBool;
begin
  Result := False;
  GetValueAsBool(Result);
end;

function TProfXmlNode2._GetValueAsString: WideString;
begin
  Result := '';
  GetValueAsString(Result);
end;

procedure TProfXmlNode2._SetValueAsBool(Value: WordBool);
begin
  SetValueAsBool(Value);
end;

procedure TProfXmlNode2._SetValueAsString(Value: WideString);
begin
  SetValueAsString(Value);
end;

{ TProfXmlNode4 }

(*
function TProfXmlNode4.GetAttribute(const AttrName: DOMString): OleVariant;
begin
  Result := FNode.Attributes[AttrName];
end;

function TProfXmlNode4.GetAttributeNodes: IXMLNodeList;
begin
  Result := FNode.AttributeNodes;
end;

function TProfXmlNode4.GetChildNodes: IXMLNodeList;
begin
  Result := FNode.ChildNodes;
end;

function TProfXmlNode4.GetChildValue(const IndexOrName: OleVariant): OleVariant;
begin
  Result := FNode.ChildValues[IndexOrName];
end;

function TProfXmlNode4.GetCollection: IXMLNodeCollection;
begin
  Result := FNode.Collection;
end;

function TProfXmlNode4.GetDOMNode: IDOMNode;
begin
  Result := FNode.DOMNode;
end;

function TProfXmlNode4.GetHasChildNodes: Boolean;
begin
  Result := FNode.HasChildNodes;
end;

function TProfXmlNode4.GetIsTextElement: Boolean;
begin
  Result := FNode.IsTextElement;
end;

function TProfXmlNode4.GetLocalName: DOMString;
begin
  Result := FNode.LocalName;
end;

function TProfXmlNode4.GetNamespaceURI: DOMString;
begin
  Result := FNode.NamespaceURI;
end;

function TProfXmlNode4.GetNodeName: DOMString;
begin
  Result := FNode.NodeName;
end;

function TProfXmlNode4.GetNodeType: TNodeType;
begin
  Result := FNode.NodeType;
end;

function TProfXmlNode4.GetNodeValue: OleVariant;
begin
  Result := FNode.NodeValue;
end;

function TProfXmlNode4.GetOwnerDocument: IXMLDocument;
begin
  Result := FNode.OwnerDocument;
end;

function TProfXmlNode4.GetParentNode: IXMLNode;
begin
  Result := FNode.ParentNode;
end;

function TProfXmlNode4.GetPrefix: DOMString;
begin
  Result := FNode.Prefix;
end;

function TProfXmlNode4.GetReadOnly: Boolean;
begin
  Result := FNode.ReadOnly;
end;

function TProfXmlNode4.GetText: DOMString;
begin
  Result := FNode.Text;
end;

function TProfXmlNode4.GetXML: DOMString;
begin
  Result := FNode.XML;
end;

procedure TProfXmlNode4.SetAttribute(const AttrName: DOMString; const Value: OleVariant);
begin
  FNode.Attributes[AttrName] := Value;
end;

procedure TProfXmlNode4.SetChildValue(const IndexOrName: OleVariant; const Value: OleVariant);
begin
  FNode.ChildValues[IndexOrName] := Value;
end;

procedure TProfXmlNode4.SetNodeValue(const Value: OleVariant);
begin
  FNode.NodeValue := Value;
end;

procedure TProfXmlNode4.SetReadOnly(const Value: Boolean);
begin
  FNode.ReadOnly := Value;
end;

procedure TProfXmlNode4.SetText(const Value: DOMString);
begin
  FNode.Text := Value;
end;

function TProfXmlNode4.AddChild(const TagName: DOMString; Index: Integer = -1): IXMLNode;
begin
  Result := FNode.AddChild(TagName, Index);
end;

function TProfXmlNode4.AddChild(const TagName, NamespaceURI: DOMString;
  GenPrefix: Boolean = False; Index: Integer = -1): IXMLNode;
begin
  Result := FNode.AddChild(TagName, NamespaceURI, GenPrefix, Index);
end;

function TProfXmlNode4.CloneNode(Deep: Boolean): IXMLNode;
begin
  Result := FNode.CloneNode(Deep);
end;

procedure TProfXmlNode4.DeclareNamespace(const Prefix, URI: DOMString);
begin
  FNode.DeclareNamespace(Prefix, URI);
end;

function TProfXmlNode4.FindNamespaceURI(const TagOrPrefix: DOMString): DOMString;
begin
  Result := FNode.FindNamespaceURI(TagOrPrefix);
end;

function TProfXmlNode4.FindNamespaceDecl(const NamespaceURI: DOMString): IXMLNode;
begin
  Result := FNode.FindNamespaceDecl(NamespaceURI);
end;

function TProfXmlNode4.GetAttributeNS(const AttrName, NamespaceURI: DOMString): OleVariant;
begin
  Result := FNode.GetAttributeNS(AttrName, NamespaceURI);
end;

function TProfXmlNode4.HasAttribute(const Name: DOMString): Boolean;
begin
  Result := FNode.HasAttribute(Name);
end;

function TProfXmlNode4.HasAttribute(const Name, NamespaceURI: DOMString): Boolean;
begin
  Result := FNode.HasAttribute(Name, NamespaceURI);
end;

function TProfXmlNode4.NextSibling: IXMLNode;
begin
  Result := FNode.NextSibling();
end;

procedure TProfXmlNode4.Normalize;
begin
  FNode.Normalize();
end;

function TProfXmlNode4.PreviousSibling: IXMLNode;
begin
  Result := FNode.PreviousSibling();
end;

procedure TProfXmlNode4.Resync;
begin
  FNode.Resync();
end;

procedure TProfXmlNode4.SetAttributeNS(const AttrName, NamespaceURI: DOMString; const Value: OleVariant);
begin
  FNode.SetAttributeNS(AttrName, NamespaceURI, Value);
end;

procedure TProfXmlNode4.TransformNode(const stylesheet: IXMLNode; var output: WideString);
begin
  FNode.TransformNode(Stylesheet, Output);
end;

procedure TProfXmlNode4.TransformNode(const stylesheet: IXMLNode; const output: IXMLDocument);
begin
  FNode.TransformNode(Stylesheet, Output);
end;
*)

end.
