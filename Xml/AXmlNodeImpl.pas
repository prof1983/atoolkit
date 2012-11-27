{**
@Abstract Класс работы с XML нодами
@Author Prof1983 <prof1983@ya.ru>
@Created 07.03.2007
@LastMod 27.11.2012
}
unit AXmlNodeImpl;

// TODO: Разделить на AXmlNodeObj и AXmlNodeImpl.

interface

uses
  Classes, SysUtils, Variants, XmlDom, XmlIntf,
  AAttributesIntf, ABase, ABaseUtils2, AConsts2, AEntityImpl, ANodeImpl, ATypes,
  AXmlAttributesImpl, AXmlAttributesUtils, AXmlNodeCollectionUtils, AXmlDocumentImpl,
  AXmlNodeIntf, AXmlNodeListUtils, AXmlNodeUtils, AXmlUtils;

type //** Класс работы с XML нодами
  TProfXmlNode = class(TANode)
  protected
    //** Объект работы с атрибутами
    FAttributes: TProfXmlAttributes;
    FAttributes1: TAttributes;
    FNode: IXmlNode;
    FChildNodes: AXmlNodeList; //FNodes: array of TProfXmlNode;
  protected // --- from TProfXmlNode1 ---
    FCollection: AXmlNodeCollection;
    FDocument: TProfXmlDocument;
    FName: WideString;
    FValue: WideString;
  public
    function GetAsBool(): WordBool; safecall;
    function GetAsDateTime(): TDateTime; safecall;
    function GetAsFloat32(): AFloat32; safecall;
    function GetAsFloat64(): AFloat64; safecall;
    function GetAsInt32(): Integer; safecall;
    function GetAsInt64(): Int64; safecall;
    function GetAsString(): WideString; safecall;
  public
    function GetAttribute(const Name: WideString; UpperCase: Boolean = False): WideString;
    function GetName(): WideString; deprecated; // Use GetNodeName()
    //** Получить вложеный нод по индесу
    function GetNodeByIndex(Index: AInt): AXmlNode;
    //** Получить вложеный нод по имени (AXmlNode_GetChildNodeByName)
    function GetNodeByName(const AName: WideString): AProfXmlNode;
    //** Возвращает колличество вложенных нодов
    function GetNodeCount(): Integer; safecall;
    //** Получить имя нода
    function GetNodeName(): WideString; safecall;
    function GetXmlString(): WideString; safecall;
    procedure SetNode(Value: IXmlNode);
    procedure SetXmlString(const Value: WideString); safecall;
  public // IProfNode
      //** Возвращает объект работы с атрибутами
    function GetAttributes(): IProfAttributes; safecall;
    function GetChildNodes(): AXmlNodeList;
  public
    function GetValueAsBool(var Value: WordBool): WordBool; safecall;
    function GetValueAsDateTime(var Value: TDateTime): WordBool; safecall;
    function GetValueAsFloat32(var Value: AFloat32): WordBool; safecall;
    function GetValueAsFloat64(var Value: AFloat64): WordBool; safecall;
    function GetValueAsInt32(var Value: Integer): WordBool; safecall;
    function GetValueAsInt64(var AValue: Int64): WordBool; safecall;
    function GetValueAsString(var Value: WideString): WordBool; safecall;
  protected
    procedure SetAsString(const Value: WideString); safecall;
  protected
    function SetValueAsBool(Value: WordBool): WordBool; safecall;
    function SetValueAsFloat64(Value: AFloat64): WordBool; safecall;
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
    function WriteFloat64(const AName: WideString; Value: AFloat64): WordBool; safecall;
    function WriteInt32(const AName: WideString; Value: Int32): WordBool; safecall;
    function WriteInt64(const AName: WideString; Value: Int64): WordBool; safecall;
    function WriteString(const AName, Value: WideString): WordBool; safecall;
    //function WriteXml(const AName, Value: WideString): WordBool; safecall;
  public
    class function GetAsBoolA(Node: IXmlNode): WordBool; safecall;
    class function GetAsDateTimeA(Node: IXmlNode): TDateTime; safecall;
    class function GetAsFloat32A(Node: IXmlNode): AFloat32; safecall;
    class function GetAsFloat64A(Node: IXmlNode): AFloat64; safecall;
    class function GetAsInt32A(Node: IXmlNode): Int32; safecall;
    class function GetAsInt64A(Node: IXmlNode): Int64; safecall;
    class function GetAsStringA(Node: IXmlNode): WideString; safecall;
  public
    class function GetValueAsBoolA(ANode: IXmlNode; var Value: WordBool): WordBool; safecall;
    class function GetValueAsDateTimeA(ANode: IXmlNode; var Value: TDateTime): WordBool; safecall;
    class function GetValueAsFloat32A(ANode: IXmlNode; var Value: AFloat32): WordBool; safecall;
    class function GetValueAsFloat64A(ANode: IXmlNode; var Value: AFloat64): WordBool; safecall;
    class function GetValueAsInt32A(ANode: IXmlNode; var Value: Integer): WordBool; safecall;
    class function GetValueAsInt64A(ANode: IXmlNode; var Value: Int64): WordBool; safecall;
    class function GetValueAsStringA(ANode: IXmlNode; var Value: WideString): WordBool; safecall;
  public
    class function ReadBoolA(ANode: IXmlNode; const AName: WideString;
        var Value: WordBool): WordBool; safecall; deprecated; // Use ProfXmlNode_ReadBool()
    class function ReadDateTimeA(ANode: IXmlNode; const AName: WideString;
        var Value: TDateTime): WordBool; safecall; deprecated; // Use ProfXmlNode_ReadDateTime()
    class function ReadFloat32A(ANode: IXmlNode; const AName: WideString;
        var Value: AFloat32): WordBool; safecall; deprecated; // Use ProfXmlNode_ReadFloat32()
    class function ReadFloat64A(ANode: IXmlNode; const AName: WideString;
        var Value: AFloat64): WordBool; safecall; deprecated; // Use ProfXmlNode_ReadFloat64()
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
      //** Add message to log
    function AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
        const Msg: WideString): AInt; override;
      //** Add message to log
    function AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: string; AParams: array of const): Boolean;
  public
    constructor Create();
    procedure Free();
  public
    property AsString: WideString read GetAsString write SetAsString;
  public
    property Node: IXmlNode read FNode write SetNode;
    //** Вложеные ноды по индексу
    property NodeByIndex[Index: AInt]: AXmlNode read GetNodeByIndex;
    //** Вложеные ноды по имени
    property NodeByName[const Name: WideString]: AProfXmlNode read GetNodeByName;
    //** Колличество вложеных нодов
    property NodeCount: Integer read GetNodeCount;
    //** Имя нода
    property NodeName: WideString read GetNodeName;
  end;

  TProfXmlNode2 = class(TProfXmlNode, IProfXmlNode1, IProfXmlNode2{, IXmlNode})
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
    function GetValueAsUInt08(var Value: AUInt08): WordBool; safecall;
    function GetValueAsUInt64(var Value: UInt64): WordBool; safecall;
  public // IProfXmlNode2
    function SetValueAsBool(Value: WordBool): WordBool; safecall;
    function SetValueAsFloat64(Value: AFloat64): WordBool; safecall;
    function SetValueAsInt32(Value: Int32): WordBool; safecall;
    function SetValueAsString(const Value: WideString): WordBool; safecall;
    function SetValueAsUInt08(Value: AUInt08): WordBool; safecall;
    function SetValueAsUInt64(Value: UInt64): WordBool; safecall;
  public // IProfXmlNode2
    function ReadBool(const AName: WideString; var Value: WordBool): WordBool; virtual; safecall;
    function ReadDateTime(const AName: WideString; var Value: TDateTime): WordBool; virtual; safecall;
    function ReadFloat32(const AName: WideString; var Value: AFloat32): WordBool; virtual; safecall;
    function ReadFloat64(const AName: WideString; var Value: AFloat64): WordBool; virtual; safecall;
    function ReadInt08(const AName: WideString; var Value: AInt08): WordBool; virtual; safecall;
    function ReadInt16(const AName: WideString; var Value: Int16): WordBool; virtual; safecall;
    function ReadInt32(const AName: WideString; var Value: Int32): WordBool; virtual; safecall;
    function ReadInt64(const AName: WideString; var Value: Int64): WordBool; virtual; safecall;
    function ReadInteger(const AName: WideString; var Value: Integer): WordBool; virtual; safecall;
    function ReadString(const AName: WideString; var Value: WideString): WordBool; virtual; safecall;
    function ReadUInt08(const AName: WideString; var Value: AUInt08): WordBool; virtual; safecall;
    function ReadUInt16(const AName: WideString; var Value: UInt16): WordBool; virtual; safecall;
    function ReadUInt32(const AName: WideString; var Value: UInt32): WordBool; virtual; safecall;
    function ReadUInt64(const AName: WideString; var Value: AUInt64): WordBool; virtual; safecall;
    //function ReadWideString(const AName: WideString; var Value: WideString): WordBool; virtual; safecall;
  public // IProfXmlNode2
    function WriteBool(const AName: WideString; Value: WordBool): WordBool; virtual; safecall;
    function WriteDateTime(const AName: WideString; Value: TDateTime): WordBool; virtual; safecall;
    function WriteFloat32(const AName: WideString; Value: AFloat32): WordBool; virtual; safecall;
    function WriteFloat64(const AName: WideString; Value: AFloat64): WordBool; virtual; safecall;
    function WriteInt32(const AName: WideString; Value: Int32): WordBool; virtual; safecall;
    function WriteInt64(const AName: WideString; Value: Int64): WordBool; virtual; safecall;
    function WriteInteger(const AName: WideString; Value: Integer): WordBool; virtual; safecall;
    function WriteString(const AName, Value: WideString): WordBool; virtual; safecall;
    function WriteUInt08(const AName: WideString; Value: AUInt08): WordBool; virtual; safecall;
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
    function GetChildNodes(): AXmlNodeList;
    function GetCollection(): AXmlNodeCollection;
    function GetCountNodes(): Integer;
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
    function AddFromXml(Xml: TProfXmlNode2): AError;
    function Clear(): AError;
      {** @return TProfXmlNode1 }
    function FindNode(const Name: WideString): AProfXmlNode; deprecated; // Use GetNodeByName1()
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
        ADef: AFloat64 = 0): AFloat64; safecall; deprecated; // Use ProfXmlNode_ReadFloatDef()
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
    property Document: TProfXmlDocument read FDocument;
    property Node: IXmlNode read FNode; //implements IXmlNode;
    property NodeName: WideString read GetNodeName write SetNodeName;
    property NodeValue: OleVariant read GetNodeValue write SetNodeValue;
    property OwnerDocument: TProfXmlDocument read FDocument;
    property ValueStr: WideString read FValue write FValue;
    //property Xml: WideString read GetXml write SetXml;
    property XmlB: WideString read GetXmlB write SetXmlB;
  end;

  TProfXmlNode1 = TProfXmlNode2;
  TProfXmlNode4 = TProfXmlNode2;

implementation

// --- Private ---

{**
  Выделить имя и атрибуты их строки "tag attr1="value1" attr2="value2""
}
procedure _GetNameAndAttributes(Value: WideString; var FAttributes: TAttributes; var FName: WideString);
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
    AXmlAttributes_SetAttribute(FAttributes, AName, AValue);
  until Length(Value) = 0;
end;

{ TProfXmlNode }

function TProfXmlNode.AddToLog(LogGroup: TLogGroupMessage; LogType: TLogTypeMessage;
  const Msg: WideString): AInt;
begin
  Result := inherited AddToLog(LogGroup, LogType, Msg);
  if Assigned(FDocument) then
    FDocument.AddToLog(LogGroup, LogType, Msg, []);
end;

function TProfXmlNode.AddToLog2(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
    const AStrMsg: String; AParams: array of const): Boolean;
begin
  Result := (AddToLog(AGroup, AType, Format(AStrMsg, AParams)) >= 0);
end;

constructor TProfXmlNode.Create();
begin
  inherited Create();
  FAttributes := TProfXmlAttributes.Create();
end;

procedure TProfXmlNode.Free();
begin
  AXmlNodeList_Clear(FChildNodes);
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

function TProfXmlNode.GetAsFloat32(): AFloat32;
begin
  Result := 0;
  GetValueAsFloat32(Result);
end;

class function TProfXmlNode.GetAsFloat32A(Node: IXmlNode): AFloat32;
var
  Res: AFloat32;
begin
  if ProfXmlNode_GetValueAsFloat32(Node, Res) then
    Result := Res
  else
    Result := 0;
end;

function TProfXmlNode.GetAsFloat64(): AFloat64;
begin
  Result := 0;
  GetValueAsFloat64(Result);
end;

class function TProfXmlNode.GetAsFloat64A(Node: IXmlNode): AFloat64;
var
  Res: AFloat64;
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

function TProfXmlNode.GetAttribute(const Name: WideString; UpperCase: Boolean = False): WideString;
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
    Result := AXmlAttribures_GetAttribute(FAttributes1, Name, UpperCase);
end;

function TProfXmlNode.GetAttributes(): IProfAttributes;
begin
  Result := FAttributes;
end;

function TProfXmlNode.GetChildNodes(): AXmlNodeList;
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

function TProfXmlNode.GetName(): WideString;
begin
  Result := GetNodeName();
end;

function TProfXmlNode.GetNodeByIndex(Index: AInt): AXmlNode;
begin
  Result := AXmlNode_GetChildNodeByIndex(AXmlNode(Self), Index);
end;

function TProfXmlNode.GetNodeByName(const AName: WideString): AProfXmlNode;
begin
  Result := AXmlNode_GetChildNodeByName(AXmlNode(Self), AName);
end;

function TProfXmlNode.GetNodeCount(): Integer;
begin
  Result := AXmlNode_GetChildNodeCount(AXmlNode(Self));
end;

function TProfXmlNode.GetNodeName(): WideString;
begin
  if Assigned(FNode) then
  try
    Result := FNode.NodeName;
  except
    Result := '';
  end
  else
    Result := FName;
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

function TProfXmlNode.GetValueAsFloat32(var Value: AFloat32): WordBool;
begin
  Result := GetValueAsFloat32A(FNode, Value);
end;

class function TProfXmlNode.GetValueAsFloat32A(ANode: IXmlNode; var Value: AFloat32): WordBool;
begin
  Result := ProfXmlNode_GetValueAsFloat32(ANode, Value);
end;

function TProfXmlNode.GetValueAsFloat64(var Value: AFloat64): WordBool;
begin
  Result := GetValueAsFloat64A(FNode, Value);
end;

class function TProfXmlNode.GetValueAsFloat64A(ANode: IXmlNode; var Value: AFloat64): WordBool;
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
var
  V: ABoolean;
begin
  V := Value;
  Result := (AXmlNode_ReadBool(AXmlNode(Self), Name, V) >= 0);
  Value := V;
end;

class function TProfXmlNode.ReadBoolA(ANode: IXmlNode; const AName: WideString;
    var Value: WordBool): WordBool;
begin
  Result := ProfXmlNode_ReadBool(ANode, AName, Value);
end;

function TProfXmlNode.ReadBoolDef(const Name: WideString; DefValue: WordBool): WordBool;
begin
  Result := AXmlNode_ReadBoolDef(AXmlNode(Self), Name, DefValue);
end;

function TProfXmlNode.ReadDateTime(const Name: WideString; var Value: TDateTime): WordBool;
begin
  Result := (AXmlNode_ReadDateTime(AXmlNode(Self), Name, Value) >= 0);
end;

class function TProfXmlNode.ReadDateTimeA(ANode: IXmlNode; const AName: WideString;
    var Value: TDateTime): WordBool;
begin
  Result := ProfXmlNode_ReadDateTime(ANode, AName, Value);
end;

function TProfXmlNode.ReadDateTimeDef(const Name: WideString; DefValue: TDateTime): TDateTime;
begin
  Result := AXmlNode_ReadDateTimeDef(AXmlNode(Self), Name, DefValue);
end;

class function TProfXmlNode.ReadFloat32A(ANode: IXmlNode; const AName: WideString;
    var Value: AFloat32): WordBool;
begin
  Result := ProfXmlNode_ReadFloat32(ANode, AName, Value);
end;

function TProfXmlNode.ReadFloat64(const Name: WideString; var Value: Double): WordBool;
begin
  Result := (AXmlNode_ReadFloat64(AXmlNode(Self), Name, Value) >= 0);
end;

class function TProfXmlNode.ReadFloat64A(ANode: IXmlNode; const AName: WideString;
    var Value: AFloat64): WordBool;
begin
  Result := ProfXmlNode_ReadFloat64(ANode, AName, Value);
end;

function TProfXmlNode.ReadFloat64Def(const Name: WideString; DefValue: Double): Double;
begin
  Result := AXmlNode_ReadFloat64Def(AXmlNode(Self), Name, DefValue);
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
  Result := AXmlNode_ReadInt32Def(AXmlNode(Self), Name, DefValue);
end;

function TProfXmlNode.ReadInt64(const Name: WideString; var Value: Int64): WordBool;
begin
  Result := (AXmlNode_ReadInt64(AXmlNode(Self), Name, Value) >= 0);
end;

class function TProfXmlNode.ReadInt64A(ANode: IXmlNode; const AName: WideString;
    var Value: Int64): WordBool;
begin
  Result := ProfXmlNode_ReadInt64(ANode, AName, Value);
end;

function TProfXmlNode.ReadInt64Def(const Name: WideString; DefValue: Int64): Int64;
begin
  Result := AXmlNode_ReadInt64Def(AXmlNode(Self), Name, DefValue);
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
  Result := AXmlNode_ReadStringDef(AXmlNode(Self), Name, DefValue);
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
  Result := (AXmlNode_SetValueAsBool(AXmlNode(Self), Value) >= 0);
end;

function TProfXmlNode.SetValueAsFloat64(Value: AFloat64): WordBool;
begin
  Result := (AXmlNode_SetValueAsFloat64(AXmlNode(Self), Value) >= 0);
end;

function TProfXmlNode.SetValueAsInt32(AValue: Integer): WordBool;
begin
  Result := (AXmlNode_SetValueAsInt32(AXmlNode(Self), AValue) >= 0);
end;

function TProfXmlNode.SetValueAsString(const AValue: WideString): WordBool;
begin
  Result := (AXmlNode_SetValueAsString(AXmlNode(Self), AValue) >= 0);
end;

function TProfXmlNode.SetValueAsUInt08(AValue: Byte): WordBool;
begin
  Result := (AXmlNode_SetValueAsUInt08(AXmlNode(Self), AValue) >= 0);
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
  Result := (AXmlNode_WriteDateTime(AXmlNode(Self), AName, AValue) >= 0);
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
  Result := (AXmlNode_WriteFloat64(AXmlNode(Self), AName, Value) >= 0);
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
  Result := (AXmlNode_WriteInt64(AXmlNode(Self), AName, Value) >= 0);
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
  Result := (AXmlNode_WriteString(AXmlNode(Self), AName, Value) >= 0);
end;

class function TProfXmlNode.WriteStringA(Node: IXmlNode; const Name,
    Value: APascalString): ABool;
begin
  Result := ProfXmlNode_WriteString(Node, Name, Value);
end;

{ TProfXmlNode2 }

function TProfXmlNode2.AddFromXml(Xml: TProfXmlNode2): AError;
begin
  if Self.LoadFromXml(AProfXmlNode(Xml)) then
    Result := 0
  else
    Result := -1;
end;

function TProfXmlNode2.Attributes_Count: Integer;
begin
  Result := Length(FAttributes1);
end;

function TProfXmlNode2.Clear(): AError;
begin
  SetLength(FAttributes1, 0);
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
  FDocument := TProfXmlDocument(Document);
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
end;

function TProfXmlNode2.GetAsString(): WideString;
begin
  if Assigned(FNode) and ((VarType(FNode.NodeValue) = varOleStr) or (VarType(FNode.NodeValue) = varStrArg) or (VarType(FNode.NodeValue) = varString)) then
    Result := FNode.NodeValue
  else
    Result := '';
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

procedure TProfXmlNode2.GetNameAndAttributes(Value: WideString);
begin
  _GetNameAndAttributes(Value, FAttributes1, FName);
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

function TProfXmlNode2.GetValueAsUInt08(var Value: AUInt08): WordBool;
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
    for I := 0 to High(FAttributes1) do
      Attr := Attr + ' ' + FAttributes1[I].Name+'="'+FAttributes1[I].Value+'"';

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
  for I := 0 to High(FAttributes1) do
    Attr := Attr + ' ' + FAttributes1[I].Name+'="'+FAttributes1[I].Value+'"';

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
  if (Index >= 0) and (Index < Length(FAttributes1)) then
    Result := FAttributes1[Index].Name
  else
    Result := '';
end;

function TProfXmlNode2.Get_Attribute_Value(Index: Integer): WideString;
begin
  if (Index >= 0) and (Index < Length(FAttributes1)) then
    Result := FAttributes1[Index].Value
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
    TProfXmlNode2(GetNodeByName(ANode.GetNodeName())).LoadFromXml(AProfXmlNode(ANode));
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
    Node := AXmlNode_New1(AXmlDocument(Self.FDocument));
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
  Result := (GetNodeByName1(AName) <> nil);
end;

function TProfXmlNode2.ReadBool(const AName: WideString; var Value: WordBool): WordBool;
var
  V: ABoolean;
begin
  V := Value;
  Result := (AXmlNode_ReadBool(AXmlNode(Self), AName, V) >= 0);
  Value := V;
end;

class function TProfXmlNode2.ReadBoolDef(ANode: IXmlNode; const AName: WideString;
    ADef: WordBool): WordBool;
begin
  Result := AXmlNode_ReadBoolDef(AXmlNode(Self), AName, ADef);
end;

function TProfXmlNode2.ReadDateTime(const AName: WideString; var Value: TDateTime): WordBool;
begin
  Result := (AXmlNode_ReadDateTime(AXmlNode(Self), AName, Value) >= 0);
end;

class function TProfXmlNode2.ReadDateTimeDef(ANode: IXmlNode; const AName: WideString;
    ADef: TDateTime): TDateTime;
begin
  Result := ProfXmlNode_ReadDateTimeDef(ANode, AName, ADef);
end;

function TProfXmlNode2.ReadFloat32(const AName: WideString; var Value: AFloat32): WordBool;
begin
  Result := (AXmlNode_ReadFloat32(AXmlNode(Self), AName, Value) >= 0);
end;

function TProfXmlNode2.ReadFloat64(const AName: WideString; var Value: AFloat64): WordBool;
begin
  Result := (AXmlNode_ReadFloat64(AXmlNode(Self), AName, Value) >= 0);
end;

class function TProfXmlNode2.ReadFloatDef(ANode: IXmlNode; const AName: WideString; ADef: AFloat64): AFloat64;
begin
  Result := ProfXmlNode_ReadFloatDef(ANode, AName, ADef);
end;

function TProfXmlNode2.ReadInt08(const AName: WideString; var Value: AInt08): WordBool;
begin
  Result := (AXmlNode_ReadInt08(AXmlNode(Self), AName, Value) >= 0);
end;

function TProfXmlNode2.ReadInt16(const AName: WideString; var Value: Int16): WordBool;
begin
  Result := (AXmlNode_ReadInt16(AXmlNode(Self), AName, Value) >= 0);
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
begin
  Result := (AXmlNode_ReadInt64(AXmlNode(Self), AName, Value) >= 0);
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
      AddToLog(lgGeneral, ltError, err_Xml_ReadNodes_1);
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

function TProfXmlNode2.ReadUInt08(const AName: WideString; var Value: AUInt08): WordBool;
begin
  Result := (AXmlNode_ReadUInt08(AXmlNode(Self), AName, Value) >= 0);
end;

function TProfXmlNode2.ReadUInt16(const AName: WideString; var Value: UInt16): WordBool;
begin
  Result := (AXmlNode_ReadUInt16(AXmlNode(Self), AName, Value) >= 0);
end;

function TProfXmlNode2.ReadUInt32(const AName: WideString; var Value: UInt32): WordBool;
begin
  Result := (AXmlNode_ReadUInt32(AXmlNode(Self), AName, Value) >= 0);
end;

function TProfXmlNode2.ReadUInt64(const AName: WideString; var Value: AUInt64): WordBool;
begin
  Result := (AXmlNode_ReadUInt64(AXmlNode(Self), AName, Value) >= 0);
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
  FDocument := TProfXmlDocument(Document);
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
  Result := (AXmlNode_SetValueAsBool(AXmlNode(Self), Value) >= 0);
end;

function TProfXmlNode2.SetValueAsFloat64(Value: AFloat64): WordBool;
begin
  Result := (AXmlNode_SetValueAsFloat64(AXmlNode(Self), Value) >= 0);
end;

function TProfXmlNode2.SetValueAsInt32(Value: Int32): WordBool;
begin
  Result := (AXmlNode_SetValueAsInt32(AXmlNode(Self), Value) >= 0);
end;

function TProfXmlNode2.SetValueAsString(const Value: WideString): WordBool;
begin
  Result := (AXmlNode_SetValueAsString(AXmlNode(Self), Value) >= 0);
end;

function TProfXmlNode2.SetValueAsUInt08(Value: AUInt08): WordBool;
begin
  Result := (AXmlNode_SetValueAsUInt08(AXmlNode(Self), Value) >= 0);
end;

function TProfXmlNode2.SetValueAsUInt64(Value: UInt64): WordBool;
begin
  Result := (AXmlNode_SetValueAsUInt64(AXmlNode(Self), Value) >= 0);
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
      AddToLog(lgGeneral, ltError, 'Не найден закрывающий символ ">"');
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
  AXmlAttributes_SetAttribute(FAttributes1, Name, Value); //FNode.SetAttribute(Name, Value);
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
begin
  Result := (AXmlNode_WriteDateTime(AXmlNode(Self), AName, Value) >= 0);
end;

function TProfXmlNode2.WriteFloat32(const AName: WideString; Value: AFloat32): WordBool;
begin
  Result := (AXmlNode_WriteFloat32(AXmlNode(Self), AName, Value) >= 0);
end;

function TProfXmlNode2.WriteFloat64(const AName: WideString; Value: AFloat64): WordBool;
begin
  Result := (AXmlNode_WriteFloat64(AXmlNode(Self), AName, Value) >= 0);
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
begin
  Result := (AXmlNode_WriteString(AXmlNode(Self), AName, Value) >= 0);
end;

function TProfXmlNode2.WriteUInt08(const AName: WideString; Value: AUInt08): WordBool;
begin
  Result := (AXmlNode_WriteUInt08(AXmlNode(Self), AName, Value) >= 0);
end;

function TProfXmlNode2.WriteUInt64(const AName: WideString; Value: UInt64): WordBool;
begin
  Result := (AXmlNode_WriteUInt64(AXmlNode(Self), AName, Value) >= 0);
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

end.
