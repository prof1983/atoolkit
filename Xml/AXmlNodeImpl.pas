{**
@Abstract(Класс работы с XML нодами)
@Author(Prof1983 prof1983@ya.ru)
@Created(07.03.2007)
@LastMod(26.06.2012)
@Version(0.5)
}
unit AXmlNodeImpl;

// TODO: Разделить на AXmlNodeObj и AXmlNodeImpl.

interface

uses
  SysUtils, Variants, XmlIntf,
  AAttributesIntf, ABase, AEntityImpl, ANodeIntf, ATypes, AXmlAttributesImpl, AXmlNodeIntf,
  // --- for TProfXmlNode2 ---
  //Classes, ComCtrls, ComObj, MSXmlDom, XmlDoc,
  XmlDom;
  //AConsts2, AXmlCollectionIntf, AXmlDocumentIntf, AXmlNodeUtils,

type //** Класс работы с XML нодами
  TProfXmlNode = class(TANamedEntity, IProfNode)
  protected
    //** Объект работы с атрибутами
    FAttributes: TProfXmlAttributes;
    FNode: IXmlNode;
    FNodes: array of TProfXmlNode;
    procedure SetNode(Value: IXmlNode);
  protected
    function GetAsBool(): WordBool; safecall;
    function GetAsDateTime(): TDateTime; safecall;
    function GetAsFloat32(): Float32; safecall;
    function GetAsFloat64(): Float64; safecall;
    function GetAsInt32(): Integer; safecall;
    function GetAsInt64(): Int64; safecall;
    function GetAsString(): WideString; safecall;
  protected
    //** Возвращает объект работы с атрибутами
//    function GetAttributes(): IProfXmlAttributes; safecall;
    //** Получить вложеный нод по индесу
    function GetNodeByIndex(AIndex: Integer): IProfNode; safecall;
    //** Получить вложеный нод по имени
    function GetNodeByName(const AName: WideString): IProfNode; safecall;
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
    property NodeByName[const Name: WideString]: IProfNode read GetNodeByName;
    //** Колличество вложеных нодов
    property NodeCount: Integer read GetNodeCount;
    //** Имя нода
    property NodeName: WideString read GetNodeName;
  end;

  TProfXmlNode2 = class(TInterfacedObject{TXmlNode}, IProfXmlNode2, IXmlNode)
  protected
    FNode: IXmlNode{TXmlNode};
  protected
    function Get_Attribute(Name: WideString): WideString;
    function Get_Collection: IXmlNodeCollection; safecall;
    function Get_Xml(): WideString;
    procedure Set_Attribute(Name, Value: WideString);
    procedure Set_Xml(const Value: WideString);
  public
    function GetAsString(): WideString;
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

implementation

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

function TProfXmlNode.GetNodeByName(const AName: WideString): IProfNode;
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
    for i := 0 to High(FNodes) do
      if FNodes[i].NodeName = AName then
      begin
        Result := FNodes[i];
        Exit;
      end;
  except
  end;
end;

function TProfXmlNode.GetNodeCount(): Integer;
begin
  Result := -1;
  if Assigned(FNode) then
  try
    Result := FNode.ChildNodes.Count;
  except
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
  // Поиск XML нода
  Node := Self.ChildNodes.FindNode(AName);
  // Если нету - создание XML нода
  if not(Assigned(Node)) then
    Node := Self.AddChild(AName);
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
  Result := Assigned(FNode);
  if not(Result) then Exit;
  Node := FNode.ChildNodes.FindNode(AName);
  Result := Assigned(Node);
  if not(Result) then Exit;
  Result := (VarType(Node.NodeValue) = varBoolean);
  if not(Result) then Exit;
  Value := Node.NodeValue;
  {//Result := Assigned(FNode);
  //if not(Result) then Exit;
  Node := ChildNodes.FindNode(AName);
  Result := Assigned(Node);
  if not(Result) then Exit;
  Result := (VarType(Node.NodeValue) = varBoolean);
  if not(Result) then Exit;
  Value := Node.NodeValue;}
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
  Result := Assigned(FNode);
  if not(Result) then Exit;
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
  {//Result := Assigned(FNode);
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
  end;}
end;

function TProfXmlNode2.ReadString(const AName: WideString; var Value: WideString): WordBool;
var
  Node: IXmlNode;
begin
  Result := Assigned(FNode);
  if not(Result) then Exit;
  Node := FNode.ChildNodes.FindNode(AName);
  Result := Assigned(Node);
  if not(Result) then Exit;
  if (VarType(Node.NodeValue) = varString) or (VarType(Node.NodeValue) = varOleStr) then begin
    Value := Node.NodeValue;
    Result := True;
  end else Result := False;
  {//Result := Assigned(FNode);
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
    Result := False;}
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

procedure TProfXmlNode2.SetXml(const Value: DOMString{WideString});
begin
  SetText(Value);
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
  Result := Assigned(FNode);
  if not(Assigned(FNode)) then Exit;
  Node := FNode.ChildNodes.FindNode(AName);
  if Assigned(Node) then
    Node.NodeValue := Value
  else
    FNode.AddChild(AName).NodeValue := Value;
  Result := True;
  {Node := ChildNodes.FindNode(AName);
  if Assigned(Node) then
    Node.NodeValue := Value
  else
    AddChild(AName).NodeValue := Value;
  Result := True;}
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
  Result := Assigned(FNode);
  if not(Result) then Exit;
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
  {try
    Node := ChildNodes.FindNode(AName);
    if Assigned(Node) then
      Node.NodeValue := Value
    else
      AddChild(AName).NodeValue := Value;
    Result := True;
  except
    Result := False;
  end;}
end;

function TProfXmlNode2.WriteString(const AName, Value: WideString): WordBool;
var
  Node: IXmlNode;
begin
  Result := Assigned(FNode);
  if not(Result) then Exit;
  Node := FNode.ChildNodes.FindNode(AName);
  if Assigned(Node) then
    Node.NodeValue := Value
  else
    FNode.AddChild(AName).NodeValue := Value;
  {Node := ChildNodes.FindNode(AName);
  if Assigned(Node) then
    Node.NodeValue := Value
  else
    AddChild(AName).NodeValue := Value;}
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

end.
