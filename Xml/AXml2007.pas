{**
@Abstract(Работа с XML)
@Author(Prof1983 prof1983@ya.ru)
@Created(09.10.2005)
@LastMod(19.06.2012)
@Version(0.5)
}
unit AXml2007;

// TODO: Build TProfXmlNodeList

{$I A.inc}

interface

uses
  {$ifdef Delphi_XE_UP}XmlDom,{$endif}
  Classes, ComCtrls, ComObj, SysUtils, Variants, XmlIntf,
  ABase, AConsts2, ATypes, AXmlCollectionIntf, AXmlDocumentIntf, AXmlIntf1, AXmlNodeIntf;

type
  Int32 = AInt32;
  Float32 = AFloat32;
  Float64 = AFloat64;
  UInt08 = Byte;

type
  {** Опции удаления пробелов в функции strDeleteStace }
  TDeleteSpaceOptions = (
    dsFirst,  //**< Первые
    dsLast,   //**< Последние
    dsRep     //**< Повторяющиеся
    );
  TDeleteSpaceOptionsSet = set of TDeleteSpaceOptions;

type // Атрибут (Name="Value") -------------------------------------------------
  TAttribute = record
    Name: WideString;
    Value: WideString;
  end;

type // Атрибуты (Name1="Value1" Name2="Value2") -------------------------------
  TAttributes = array of TAttribute;

type
  IXmlDomNode = IXmlNode;

{type // Интерфейсы -------------------------------------------------------------
  //IProfXmlCollection = AXmlCollectionIntf.IProfXmlCollection2006;
  //IProfXmlNode = AXmlNodeIntf.IProfXmlNode2006;}

type
  // Коллекция нодов
  TProfXmlCollection = class(TInterfacedObject, IProfXmlCollection)
  protected
    FNodes: array of AProfXmlNode1;
    FOwner: AProfXmlNode1;
  public // IProfXmlCollection2006
    function DeleteNode(Node: IProfXmlNode2006): WordBool;
    function GetCount(): Integer;
    function GetNode(Index: Integer): AProfXmlNode1;
    function Get_Node(Index: Integer): IProfXmlNode2006;
  public
    function AddChild(const AName: WideString): AProfXmlNode1;
    procedure AddNode(ANode: AProfXmlNode1);
    procedure Clear();
    function FindNode(Name: WideString): AProfXmlNode1;
    procedure Free();
    function GetNodeByAttribute(AName, AValue: WideString): AProfXmlNode1;
    function GetNodeByName(Name: WideString): AProfXmlNode1;
    function NewNode(const AName: WideString): AProfXmlNode1;
  public
    constructor Create(AOwner: AProfXmlNode1);
  public
    //property Count: Integer read GetCount;
    property Nodes[Index: Integer]: AProfXmlNode1 read GetNode;
    property NodesByName[Name: WideString]: AProfXmlNode1 read GetNodeByName;
  end;

  TProfXmlCollection2006 = TProfXmlCollection;

  // TODO: Use unXml3.TProfXmlDocument
  // XML документ
  TProfXmlDocument1 = class(TInterfacedObject, IProfXmlDocument2006)
  protected
    FDocumentElement: AProfXmlNode1;
    FEncoding: WideString;   // Набор символов = 'Windows-1251'
    FFileName: WideString;   // Имя файла
    FOnAddToLog: TAddToLog;
    FStandAlone: WideString; // Указывает на внешнее описание = ''
    FVersion: WideString;    // Версия XML = '1.0'
  protected
    function DoDocumentTag(Node: AProfXmlNode1): Boolean; virtual;
  public
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: String; AParams: array of const): Boolean;
    procedure Free(); virtual;
    function LoadFromFile(const AFileName: WideString = ''): WordBool;
    function LoadFromString(Value: WideString): Boolean;
    function SaveToFile(const AFileName: WideString = ''): WordBool;
    function SaveToString(var S: WideString): WordBool;
  public
    constructor Create(const AFileName: WideString = ''; AAddToLog: TAddToLog = nil);
  public
    property DocumentElement: AProfXmlNode1 read FDocumentElement write FDocumentElement;
    property Encoding: WideString read FEncoding write FEncoding;
    property OnAddToLog: TAddToLog read FOnAddToLog write FOnAddToLog;
    property StandAlone: WideString read FStandAlone write FStandAlone;
    property Version: WideString read FVersion write FVersion;
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
  private // IProfXmlNodeNew
    function Attributes_Count(): Integer;
    function Get_Attribute(const Name: WideString): WideString;
    function Get_Attribute_Name(Index: Integer): WideString;
    function Get_Attribute_Value(Index: Integer): WideString;
    function Get_Collection(): AXmlCollection;
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
    function GetAttribute(const AName: WideString; AUpperCase: Boolean = False): WideString;
    function GetCountNodes(): Integer;
    function GetName(): WideString;
    function GetNode(Index: Integer): TProfXmlNode1;
    function GetNodeByName(Name: WideString): TProfXmlNode1;
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
    function SetXml(const AValue: WideString): WordBool;
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
    constructor Create(ADocument: TProfXmlDocument1 = nil);
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

  // XML элемент
  TProfXmlNode1_2006 = class(TProfXmlNode1)
  protected
    function Get_Attribute(Name: WideString): WideString;
    function Get_Attribute_Name(Index: Integer): WideString;
    function Get_Attribute_Value(Index: Integer): WideString;
    function Get_Collection: IProfXmlCollection;
    function Get_NodeName: WideString;
    function Get_NodeValue: WideString;
    function Get_Xml: WideString;
    procedure Set_Attribute(Name, Value: WideString);
    procedure Set_NodeName(Value: WideString);
    procedure Set_NodeValue(Value: WideString);
    procedure Set_Xml(const Value: WideString);
  public
    function GetAttribute(const AName: WideString; AUpperCase: Boolean = False): WideString;
    function GetName: WideString;
    function GetValueAsBool(var Value: WordBool): Boolean;
    function GetValueAsDateTime(var Value: TDateTime): Boolean;
    function GetValueAsInt32(var Value: Int32): Boolean;
    function GetValueAsInt64(var AValue: Int64): Boolean;
    function GetValueAsInteger(var AValue: Integer): Boolean;
    function GetValueAsString(var Value: WideString): Boolean;
    function GetValueAsUInt08(var Value: UInt08): Boolean;
    function GetValueAsUInt64(var Value: UInt64): Boolean;
    function GetXml: WideString;
    function Load: Boolean; virtual;
    function LoadFromXml(AXml: TProfXmlNode1): Boolean;
    function NodeExist(AName: WideString): Boolean;
    function ReadBool(const AName: WideString; var Value: WordBool): WordBool; virtual;
    function ReadDateTime(const AName: WideString; var Value: TDateTime): WordBool; virtual;
    function ReadFloat64(const AName: WideString; var Value: Float64): WordBool; virtual;
    function ReadInt32(const AName: WideString; var Value: Int32): WordBool; virtual;
    function ReadInt64(const AName: WideString; AValue: Int64): WordBool; virtual;
    function ReadInteger(const AName: WideString; var AValue: Integer): WordBool; virtual;
    function ReadString(const AName: WideString; var Value: WideString): WordBool; virtual;
    function ReadUInt08(const AName: WideString; var Value: UInt08): WordBool; virtual;
    function ReadUInt64(const AName: WideString; var Value: UInt64): WordBool; virtual;
    function ReadWideString(const AName: WideString; var Value: WideString): WordBool; virtual;
    procedure SetName(Value: WideString);
    function SetValueAsBool(Value: Boolean): Boolean;
    function SetValueAsFloat64(Value: Float64): Boolean;
    function SetValueAsInt32(AValue: Int32): Boolean;
    function SetValueAsString(AValue: WideString): Boolean;
    function SetValueAsUInt08(AValue: UInt08): Boolean;
    function SetValueAsUInt64(AValue: UInt64): Boolean;
    function SetXml(Value: WideString): Boolean;
    function WriteBool(const AName: WideString; Value: WordBool): WordBool; virtual;
    function WriteFloat64(const AName: WideString; Value: Float64): WordBool; virtual;
    function WriteInt32(const AName: WideString; Value: Int32): WordBool; virtual;
    function WriteInt64(const AName: WideString; Value: Int64): WordBool; virtual;
    function WriteInteger(const AName: WideString; Value: Integer): WordBool; virtual;
    function WriteString(const AName, Value: WideString): WordBool; virtual;
    function WriteUInt08(const AName: WideString; AValue: UInt08): WordBool; virtual;
    function WriteUInt64(const AName: WideString; AValue: UInt64): WordBool; virtual;
    function WriteXml(const AName, Value: WideString): WordBool;
    function SetXmlA(var Value: WideString; CloseTag: WideString = ''): WordBool;
  public
    property Attributes[Name: WideString]: WideString read Get_Attribute write Set_Attribute;
    property Attribute_Name[Index: Integer]: WideString read Get_Attribute_Name;
    property Attribute_Value[Index: Integer]: WideString read Get_Attribute_Value;
  end;

type                   // TInterfacedObject
  TProfXmlNodeList = class(TAutoIntfObject, IXmlNodeList) //IXmlDomNodeList)
  private
    FList: IInterfaceList;
    //FNotificationProc: TNodeListNotification;
    //FOwner: TXMLNode;
    FUpdateCount: Integer;
    //FDefaultNamespaceURI: DOMString;
  protected // IXmlDomNodeList
    function Get_item(index: Integer): IXmlNode{IXmlDomNode}; safecall;
    function Get_length(): Integer; safecall;
    function nextNode(): IXmlNode{IXmlDomNode}; safecall;
    procedure Reset(); safecall;
    function Get__newEnum(): IUnknown; safecall;
  protected
    // IXMLNodeList
    function Add(const Node: IXmlDomNode): Integer;
    procedure BeginUpdate();
    procedure Clear();
    function Delete(const Index: Integer): Integer; overload;
    {$ifdef Delphi_XE_Up}
    function Delete(const Name: DOMString): Integer; overload;
    function Delete(const Name, NamespaceURI: DOMString): Integer; overload;
    {$else}
    function Delete(const Name: WideString): Integer; overload;
    function Delete(const Name, NamespaceURI: WideString): Integer; overload;
    {$endif Delphi_XE_Up}
    procedure EndUpdate();
    function First: IXmlDomNode;
    {$ifdef Delphi_XE_Up}
    function FindNode(NodeName: DOMString): IXMLNode; overload;
    function FindNode(NodeName, NamespaceURI: DOMString): IXMLNode; overload;
    function FindNode(ChildNodeType: TGuid): IXMLNode; overload;
    {$else}
    function FindNode(NodeName: WideString): IXmlDomNode; overload;
    function FindNode(NodeName, NamespaceURI: WideString): IXmlDomNode; overload;
    function FindNode(ChildNodeType: TGuid): IXmlDomNode; overload;
    {$endif Delphi_XE_Up}
    function FindSibling(const Node: IXmlDomNode; Delta: Integer): IXmlDomNode;
    function Get(Index: Integer): IXmlDomNode;
    function GetCount(): Integer;
    function GetNode(const IndexOrName: OleVariant): IXmlDomNode;
    function GetUpdateCount(): Integer;
    {$ifdef Delphi_XE_Up}
    function IndexOf(const Node: IXMLNode): Integer; overload;
    function IndexOf(const Name: DOMString): Integer; overload;
    function IndexOf(const Name, NamespaceURI: DOMString): Integer; overload;
    {$else}
    function IndexOf(const Node: IXmlDomNode): Integer; overload;
    function IndexOf(const Name: WideString): Integer; overload;
    function IndexOf(const Name, NamespaceURI: WideString): Integer; overload;
    {$endif Delphi_XE_Up}
    procedure Insert(Index: Integer; const Node: IXmlDomNode);
    function Last(): IXmlDomNode;
    function Remove(const Node: IXmlDomNode): Integer;
    function ReplaceNode(const OldNode, NewNode: IXmlDomNode): IXmlDomNode;
  protected
    {function DoNotify(Operation: TNodeListOperation; const Node: IXmlDomNode;
      const IndexOrName: OleVariant; BeforeOperation: Boolean): IXmlDomNode;}
    //property DefaultNamespaceURI: DOMString read FDefaultNamespaceURI;
    function InternalInsert(Index: Integer; const Node: IXmlDomNode): Integer;
    property List: IInterfaceList read FList;
    //property NotificationProc: TNodeListNotification read FNotificationProc;
    //property Owner: TXMLNode read FOwner;
  public
    {constructor Create(Owner: TXMLNode; const DefaultNamespaceURI: DOMString;
      NotificationProc: TNodeListNotification);}
    destructor Destroy(); override;
  public
    property Count: Integer read GetCount;
    property UpdateCount: Integer read GetUpdateCount;
  public
    property item[index: Integer]: IXmlDomNode read Get_item; default;
    property length: Integer read Get_length;
    property _newEnum: IUnknown read Get__newEnum;
  end;

type // Используемые классы для работы с XML -----------------------------------
  TProfXmlDocument = TProfXmlDocument1;
  TProfXmlNode     = TProfXmlNode1;

// -----------------------------------------------------------------------------
// Возвращает значение атрибута
// AUpperCase - различать большие и маленькие символы?
function GetAttribute(var FAttributes: TAttributes; const AName: WideString; AUpperCase: Boolean = False): WideString;

// -----------------------------------------------------------------------------
// Выделить имя и атрибуты их строки "tag attr1="value1" attr2="value2""
procedure GetNameAndAttributes(Value: WideString; var FAttributes: TAttributes; var FName: WideString);

// -----------------------------------------------------------------------------
// Формировать документы в формате XML достаточно просто. Следует лишь познакомится с
// конкретным DTD и образцами корректных документов. А вот загрузка может быть достаточно
// трудна, если не прибегать к помощи готовых решений в виде XML парсеров. Их довольно
// много для разных платформ и при желании можно найти их описания в WWW. Одним из
// наиболее распространенным на платформе Windows является Microsoft XML Parser. Дело в том,
// что он входит в состав Microsoft Explorer 5.0 и более позние версии. Он доступен в виде
// объекта ActiveX. Данный парсер является верифицирующим, то есть проверяет не только
// синтаксическую проверку документа, но и семантическую корректность в соответствии с заданным DTD.
// http://www.codenet.ru/progr/delphi/stat/delphi_xml.php
procedure LoadOnixDoc(TV: TTreeView; const FileName: string);

// -----------------------------------------------------------------------------
// Установить значение атрибута. Если атрибута нет - создает.
procedure SetAttribute(var FAttributes: TAttributes; const Name, Value: WideString);

implementation

// Functions Forward -----------------------------------------------------------
// -----------------------------------------------------------------------------
function strDeleteSpace(const SIn: WideString; Options: TDeleteSpaceOptionsSet): WideString; forward;
function _strDeleteSpace(var S: WideString; Options: TDeleteSpaceOptionsSet): Boolean; forward;

// Functions -------------------------------------------------------------------
// -----------------------------------------------------------------------------
function GetAttribute(var FAttributes: TAttributes; const AName: WideString; AUpperCase: Boolean = False): WideString;
var
  I: Integer;
begin
  Result := '';
  if AUpperCase then
  begin
    for I := 0 to High(FAttributes) do if FAttributes[I].Name = AName then
    begin
      Result := FAttributes[I].Value;
      Exit;
    end;
  end
  else
  begin
    for I := 0 to High(FAttributes) do if AnsiUpperCase(FAttributes[I].Name) = AnsiUpperCase(AName) then
    begin
      Result := FAttributes[I].Value;
      Exit;
    end;
  end;
end;

// -----------------------------------------------------------------------------
procedure GetNameAndAttributes(Value: WideString; var FAttributes: TAttributes; var FName: WideString);
// Выделить имя и атрибуты их строки "tag attr1="value1" attr2="value2""
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
        Value := strDeleteSpace(Value, [dsFirst, dsLast, dsRep]);
      end
      else
      begin // Если нет открывающей кавычки
        I := Pos(' ', Value);
        AValue := Copy(Value, 1, I - 1);
        Value := Copy(Value, I + 1, Length(Value));
        Value := strDeleteSpace(Value, [dsFirst, dsLast, dsRep]);
      end;
    end
    else
      AValue := ''; // Пустое значение
    // Создание атрибута
    SetAttribute(FAttributes, AName, AValue);
  until Length(Value) = 0;
end;

// -----------------------------------------------------------------------------
procedure LoadOnixDoc(TV: TTreeView; const FileName: string);
var
  XML: variant;
  //Node,
  mainNode, childNodes: variant;
  TreeNode: TTreeNode;

  procedure LoadItems(TreeNode: TTreeNode; Node: variant);
  var i: integer;
  begin
    TreeNode := TV.Items.AddChild(TreeNode, Node.nodeName);
    TreeNode.ImageIndex := TreeNode.Level;
    TreeNode.SelectedIndex := TreeNode.ImageIndex;
    if Node.nodeName = '#text' then
    begin
      TreeNode.Text := Node.nodeValue;
      //TV.SetNodeBoldState(TreeNode, true);
    end;
    for i:=0 to Node.childNodes.length-1 do
      LoadItems(TreeNode, Node.childNodes.item[i]);
  end;

begin
  XML := CreateOleObject('Microsoft.XMLDOM');
  XML.load(FileName);

  if XML.parseError.reason <> '' then
  begin
    //ShowMessage( XML.parseError.reason );
  end
  else
  begin
    mainNode := XML.documentElement;
    childNodes := mainNode.childNodes;
    LoadItems(nil, mainNode);
    TreeNode := TV.Items[1];
    while Assigned(TreeNode) do
    begin
      TreeNode.Expand(false);
      TreeNode := TreeNode.GetNextSibling;
    end;
    if Assigned(TV.Items[0]) then TV.Items[0].Expand(false);
  end;
end;

// -----------------------------------------------------------------------------
procedure SetAttribute(var FAttributes: TAttributes; const Name, Value: WideString);
var
  I: Integer;
begin
  if Name = '' then Exit;
  // Поиск атрибута
  for I := 0 to High(FAttributes) do if FAttributes[I].Name = Name then
  begin
    FAttributes[I].Value := Value;
    Exit;
  end;
  // Создание атрибута
  I := Length(FAttributes);
  SetLength(FAttributes, I + 1);
  FAttributes[I].Name := Name;
  FAttributes[I].Value := Value;
end;

// -----------------------------------------------------------------------------
function strDeleteSpace(const SIn: WideString; Options: TDeleteSpaceOptionsSet): WideString;
begin
  Result := ''; if (Length(SIn) = 0) then Exit;
  Result := SIn;
  _strDeleteSpace(Result, Options);
end;

// -----------------------------------------------------------------------------
function _strDeleteSpace(var S: WideString; Options: TDeleteSpaceOptionsSet): Boolean;
// Удаление префиксных, постфиксных, повторяющихся пробелов и префиксных и поствиксных #13#10
var
  B: Boolean;
  I: LongWord;
begin
  repeat
  B := False;

  Result := True;
  if (Length(S) = 0) then Exit;
  // Удаление префиксных пробелов
  if (dsFirst in Options) then while (S[1] = ' ') do
  begin
    Delete(S, 1, 1);
    if Length(S) = 0 then Exit;
    B := True;
  end;
  // Удаление постфиксных пробелов
  if (dsLast in Options) then while (S[Length(S)] = ' ') do
  begin
    Delete(S, Length(S), 1);
    if Length(S) = 0 then Exit;
    B := True
  end;
  // Удаление повторяющихся промежуточных пробелов
  if (dsRep in Options) then
  repeat
    I := Pos(S, WideString('  '));
    if I = 0 then Break;
    Delete(S, I, 1);
  until False;

  // Удаление префиксных #13#10
  if (Length(S) >= 2) and (S[1]=#13) and (S[2]=#10) then
  begin
    Delete(S, 1, 2);
    B := True;
  end;
  // Удаление постфиксных #13#10
  if (Length(S) >= 2) and (S[Length(S)-1]=#13) and (S[Length(S)]=#10) then
  begin
    Delete(S, Length(S)-1, 2);
    B := True;
  end;

  // Повтор удаления
  until (B = False);
end;

// -----------------------------------------------------------------------------
function StrHtmlFromStr(const Value: WideString): WideString;
// Переводит строку со спец символими в строку Html формата со спецсимволами
var
  I: Int32;
begin
  Result := '';
  for I := 1 to Length(Value) do case Value[I] of
    '<': Result := Result + '&lt;';
    '>': Result := Result + '&gt;';
  else
    Result := Result + Value[I];
  end;
end;

// -----------------------------------------------------------------------------
function StrHtmlToStr(Value: WideString): WideString;
// Переводит строку Html формата с тегами в простую строку с символами
// Обратная процедура StrHtmlFromStr
var
  Igt: Int32;
  Ilt: Int32;
begin
  Result := '';
  repeat
    Igt := Pos(WideString('&gt;'), Value);
    Ilt := Pos(WideString('&lt;'), Value);
    if (Igt > 0) and (Ilt > 0) and (Igt < Ilt) then
    begin
      Result := Result + Copy(Value, 1, Igt - 1) + '>';
      Delete(Value, 1, Igt + 3);
    end else if (Igt > 0) and (Ilt > 0) and (Ilt < Igt) then
    begin
      Result := Result + Copy(Value, 1, Ilt - 1) + '<';
      Delete(Value, 1, Ilt + 3);
    end else if (Igt > 0) then
    begin
      Result := Result + Copy(Value, 1, Igt - 1) + '>';
      Delete(Value, 1, Igt + 3);
    end else if (Ilt > 0) then
    begin
      Result := Result + Copy(Value, 1, Ilt - 1) + '<';
      Delete(Value, 1, Ilt + 3);
    end else Result := Result + Value;
  until (Igt = 0) and (Ilt = 0);
end;

{ TProfXmlCollection }

function TProfXmlCollection.AddChild(const AName: WideString): AProfXmlNode1;
begin
  Result := NewNode(AName);
end;

procedure TProfXmlCollection.AddNode(ANode: AProfXmlNode1);
var
  I: Int32;
begin
  I := Length(FNodes);
  SetLength(FNodes, I + 1);
  FNodes[I] := ANode;
  TProfXmlNode1(FNodes[I]).FDocument := TProfXmlNode1(FOwner).Document;
end;

procedure TProfXmlCollection.Clear();
var
  I: Integer;
begin
  for I := 0 to High(FNodes) do
    TProfXmlNode1(FNodes[I]).Free();
  SetLength(FNodes, 0);
end;

constructor TProfXmlCollection.Create(AOwner: AProfXmlNode1);
begin
  inherited Create;
  FOwner := AOwner;
end;

function TProfXmlCollection.DeleteNode(Node: IProfXmlNode2006): WordBool;
var
  I: Integer;
  I2: Integer;
begin
  Result := False;
  for I := 0 to High(FNodes) do
    if (IProfXmlNode2006(FNodes[I]) = Node) then
    begin
      for I2 := I to High(FNodes) - 1 do
        FNodes[I2] := FNodes[I2 + 1];
      Result := True;
      Exit;
    end;
end;

function TProfXmlCollection.FindNode(Name: WideString): AProfXmlNode1;
var
  I: Int32;
begin
  if (Name = '') then
  begin
    Result := 0;
    Exit;
  end;
  for I := 0 to High(FNodes) do
  begin
    if (TProfXmlNode1(FNodes[I]).GetName() = Name) then
    begin
      Result := FNodes[I];
      Exit;
    end;
  end;
  Result := 0;
end;

procedure TProfXmlCollection.Free();
begin
  Clear();
  inherited Free();
end;

function TProfXmlCollection.GetCount(): Integer;
begin
  Result := Length(FNodes)
end;

function TProfXmlCollection.GetNode(Index: Integer): AProfXmlNode1;
begin
  Result := 0;
  if (Index < 0) or (Index > Length(FNodes)) then Exit;
  Result := FNodes[Index];
end;

function TProfXmlCollection.GetNodeByAttribute(AName, AValue: WideString): AProfXmlNode1;
var
  i: Integer;
begin
  for i := 0 to High(FNodes) do
  begin
    if (TProfXmlNode1(FNodes[i]).Attributes[AName] = AValue) then
    begin
      Result := FNodes[i];
      Exit;
    end;
  end;
  Result := 0;
end;

function TProfXmlCollection.GetNodeByName(Name: WideString): AProfXmlNode1;
var
  Res: TProfXmlNode1;
begin
  if (Name = '') then
  begin
    Result := 0;
    Exit;
  end;
  Result := FindNode(Name);
  if (Result <> 0) then Exit;
  Res := TProfXmlNode1.Create(TProfXmlNode1(FOwner).Document);
  Res.SetName(Name);
  AddNode(AProfXmlNode1(Res));
  Result := AProfXmlNode1(Res);
end;

function TProfXmlCollection.Get_Node(Index: Integer): IProfXmlNode2006;
var
  Node: TProfXmlNode1;
begin
  Node := TProfXmlNode1(GetNode(Index));
  if not(Assigned(Node)) then
  begin
    Result := nil;
    Exit;
  end;
  Result := Node;
end;

function TProfXmlCollection.NewNode(const AName: WideString): AProfXmlNode1;
var
  Res: TProfXmlNode1;
begin
  Res := TProfXmlNode1.Create(TProfXmlNode1(FOwner).Document);
  Res.FName := AName;
  AddNode(AProfXmlNode1(Res));
  Result := AProfXmlNode1(Res);
end;

{ TProfXmlDocument1 }

function TProfXmlDocument1.AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: String; AParams: array of const): Boolean;
begin
  if Assigned(FOnAddToLog) then
    Result := FOnAddToLog(AGroup, AType, AStrMsg, AParams)
  else
    Result := False;
end;

constructor TProfXmlDocument1.Create(const AFileName: WideString = ''; AAddToLog: TAddToLog = nil);
var
  DocumentElement: TProfXmlNode1;
begin
  inherited Create;
  FOnAddToLog := AAddToLog;
  FEncoding := 'Windows-1251';
  FStandAlone := '';
  FVersion := '1.0';
  FFileName := AFileName;

  DocumentElement := TProfXmlNode1.Create(Self);
  DocumentElement.SetName('Config');

  FDocumentElement := AProfXmlNode1(DocumentElement);

  // Если указано имя файла - загружаем
  if (FFileName <> '') then
    LoadFromFile(FFileName);
end;

function TProfXmlDocument1.DoDocumentTag(Node: AProfXmlNode1): Boolean;
// Чтение тега <?...?>
begin
  Result := False;
end;

procedure TProfXmlDocument1.Free();
begin
  TProfXmlNode1(FDocumentElement).Free();
  FDocumentElement := 0;
  inherited Free;
end;

function TProfXmlDocument1.LoadFromFile(const AFileName: WideString = ''): WordBool;
var
  F: TextFile;
  S: string;
  Str: string;
  FileName: WideString;
begin
  //Result := False;

  if AFileName = '' then
    FileName := FFileName
  else
    FileName := AFileName;

  if FFileName = '' then
    FFileName := FileName;

  AddToLog(lgGeneral, ltInformation, 'Загрузка XML файла "%s"', [FileName]);
  // if not(FileExists(FileName)) then Exit;
  AssignFile(F, FileName);
  {$I-}Reset(F);{$I+}
  Result := (IOResult = 0);
  if not(Result) then
  begin
    {$I-}CloseFile(F);{$I+}
    Exit;
  end;
  // Перевод файла в одну строку
  Str := '';
  while not(Eof(F)) do
  begin
    ReadLn(F, S);
    S := StrDeleteSpace(S, [dsFirst, dsLast, dsRep]);
    Str := Str + S;
  end;
  {$I-}CloseFile(F);{$I+}
  Result := LoadFromString(Str);
end;

function TProfXmlDocument1.LoadFromString(Value: WideString): Boolean;
var
  I: Integer;
  IEnd: Integer;
  S: string;
  Line: Integer;
  Node: TProfXmlNode1;
begin
  Result := False;
  Line := 0;
  // Чтение <?...?> тегов
  repeat
    Inc(Line);
    I := Pos(WideString('<?'), Value);
    if I > 0 then
    begin
      IEnd := Pos(WideString('?>'), Value);
      if IEnd = 0 then
      begin
        AddToLog(lgGeneral, ltError, err_Xml_Load1, [Line]);
        Exit;
      end;
      S := Copy(Value, 3, IEnd - 3);
      Delete(Value, 1, IEnd+1);
      //
      I := Pos('<', Value);
      if I = 0 then
      begin
        AddToLog(lgGeneral, ltError, err_Xml_Load2, [Line]);
      end;
      // #13#10
      IEnd := Pos(WideString(#13#10), Value);
      if IEnd < I then Inc(Line);
      Value := Copy(Value, I, Length(Value));
      //S := strDeleteSpace(S);

      Node := TProfXmlNode1.Create;
      Node.SetXml('<' + S + '/>');
      if AnsiUpperCase(Node.NodeName) = 'XML' then
      begin
        FEncoding := Node.GetAttribute('encoding', False);
        FVersion := Node.GetAttribute('version', False)
      end
      else
        DoDocumentTag(AProfXmlNode1(Node));
      Node.Free;
      //Node := nil;
    end;
  until I = 0;
  // Чтение DocumentElement
  Result := TProfXmlNode1(FDocumentElement).SetXml(Value);
end;

function TProfXmlDocument1.SaveToFile(const AFileName: WideString = ''): WordBool;
var
  F: TextFile;
  FileName: WideString;
  S: WideString;
begin
  SaveToString(S);

  if AFileName = '' then
    FileName := FFileName
  else
    FileName := AFileName;

  AssignFile(F, FileName);
  {$I-}
  Rewrite(F);
  WriteLn(F, String(S));
  CloseFile(F);
  {$I+}
  Result := (IOResult = 0);
end;

function TProfXmlDocument1.SaveToString(var S: WideString): WordBool;
begin
  // Сохранение тегов <?...?>
  if FVersion <> '' then begin
    if FEncoding = '' then
      S := '<? xml version="' + FVersion + '" ?>'+#13#10
    else
      S := '<? xml version="' + FVersion + '" encoding="' + FEncoding + '" ?>'+#13#10;
  end else S := '';
  S := S + TProfXmlNode1(FDocumentElement).GetXmlA('');
  Result := True;
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

constructor TProfXmlNode1.Create(ADocument: TProfXmlDocument1 = nil);
begin
  inherited Create;
  Self._AddRef();
  FCollection := TProfXmlCollection.Create(AProfXmlNode1(Self));
  FDocument := ADocument;
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

function TProfXmlNode1.GetAttribute(const AName: WideString; AUpperCase: Boolean = False): WideString;
begin
  Result := AXml2007.GetAttribute(FAttributes, AName, AUpperCase)
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
  AXml2007.GetNameAndAttributes(Value, FAttributes, FName);
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

function TProfXmlNode1.Get_Collection(): AXmlCollection2006;
begin
  Result := AXmlCollection2006(FCollection);
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
// Создает новую дочернюю структуру, разбирая строку
// Value - элемент
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
// Создает новую дочернюю структуру, разбирая строку
// Value - дочерние элементы
begin
  Result := ReadNodes(Value, CloseTag);
end;

procedure TProfXmlNode1.Set_Attribute(const Name, Value: WideString);
begin
  AXml2007.SetAttribute(FAttributes, Name, Value);
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

{ TProfXmlNode1_2006 }

function TProfXmlNode1_2006.GetAttribute(const AName: WideString; AUpperCase: Boolean = False): WideString;
// Возвращает значение атрибута
// AUpperCase - различать большие и маленькие символы?
var
  I: Integer;
begin
  if AUpperCase then begin
    for I := 0 to High(FAttributes) do if FAttributes[I].Name = AName then begin
      Result := FAttributes[I].Value;
      Exit;
    end;
  end else begin
    for I := 0 to High(FAttributes) do if AnsiUpperCase(FAttributes[I].Name) = AnsiUpperCase(AName) then begin
      Result := FAttributes[I].Value;
      Exit;
    end;
  end;
end;

function TProfXmlNode1_2006.GetName: WideString;
begin
  Result := FName;
end;

function TProfXmlNode1_2006.GetValueAsBool(var Value: WordBool): Boolean;
begin
  Value := (FValue = 'True');
  Result := True;
end;

function TProfXmlNode1_2006.GetValueAsDateTime(var Value: TDateTime): Boolean;
begin
  try
    Value := StrToDateTime(FValue);
    Result := True;
  except
    Result := False;
  end;
end;

function TProfXmlNode1_2006.GetValueAsInt32(var Value: Int32): Boolean;
var
  Code: Integer;
begin
  Val(FValue, Value, Code);
  Result := (Code = 0);
end;

function TProfXmlNode1_2006.GetValueAsInt64(var AValue: Int64): Boolean;
var
  Code: Integer;
begin
  Val(FValue, AValue, Code);
  Result := (Code = 0);
end;

function TProfXmlNode1_2006.GetValueAsInteger(var AValue: Integer): Boolean;
var
  Code: Integer;
begin
  Val(FValue, AValue, Code);
  Result := (Code = 0);
end;

function TProfXmlNode1_2006.GetValueAsString(var Value: WideString): Boolean;
begin
  Value := FValue;
  Result := True;
end;

function TProfXmlNode1_2006.GetValueAsUInt08(var Value: UInt08): Boolean;
var
  Code: Integer;
begin
  Val(FValue, Value, Code);
  Result := (Code = 0);
end;

function TProfXmlNode1_2006.GetValueAsUInt64(var Value: UInt64): Boolean;
var
  Code: Integer;
begin
  Val(FValue, Value, Code);
  Result := (Code = 0);
end;

function TProfXmlNode1_2006.GetXml: WideString;
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

function TProfXmlNode1_2006.Get_Attribute(Name: WideString): WideString;
begin
  Result := GetAttribute(Name);
end;

function TProfXmlNode1_2006.Get_Attribute_Name(Index: Integer): WideString;
begin
  if (Index >= 0) and (Index < Length(FAttributes)) then
    Result := FAttributes[Index].Name
  else
    Result := '';
end;

function TProfXmlNode1_2006.Get_Attribute_Value(Index: Integer): WideString;
begin
  if (Index >= 0) and (Index < Length(FAttributes)) then
    Result := FAttributes[Index].Value
  else
    Result := '';
end;

function TProfXmlNode1_2006.Get_Collection: IProfXmlCollection;
begin
  Result := FCollection;
end;

function TProfXmlNode1_2006.Get_NodeName: WideString;
begin
  Result := FName;
end;

function TProfXmlNode1_2006.Get_NodeValue: WideString;
begin
  Result := FValue;
end;

function TProfXmlNode1_2006.Get_Xml: WideString;
begin
  Result := GetXml;
end;

function TProfXmlNode1_2006.Load: Boolean;
begin
  Result := False;
end;

function TProfXmlNode1_2006.LoadFromXml(AXml: TProfXmlNode1): Boolean;
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

function TProfXmlNode1_2006.NodeExist(AName: WideString): Boolean;
begin
  Result := Assigned(FindNode(AName));
end;

function TProfXmlNode1_2006.ReadBool(const AName: WideString; var Value: WordBool): WordBool;
var
  Node: TProfXmlNode1;
begin
  Result := False;
  Node := FindNode(AName);
  if not(Assigned(Node)) then Exit;
  Result := Node.GetValueAsBool(Value);
end;

function TProfXmlNode1_2006.ReadDateTime(const AName: WideString; var Value: TDateTime): WordBool;
var
  Node: TProfXmlNode1;
begin
  Result := False;
  Node := FindNode(AName);
  if not(Assigned(Node)) then Exit;
  Result := Node.GetValueAsDateTime(Value);
end;

function TProfXmlNode1_2006.ReadFloat64(const AName: WideString; var Value: Float64): WordBool;
var
  Code: Cardinal;
  S: WideString;
begin
  Result := ReadString(AName, S);
  if not(Result) then Exit;
  Val(S, Value, Code);
  Result := (Code = 0);
end;

function TProfXmlNode1_2006.ReadInt32(const AName: WideString; var Value: Int32): WordBool;
var
  Node: TProfXmlNode1;
begin
  Result := False;
  Node := FindNode(AName);
  if not(Assigned(Node)) then Exit;
  Result := Node.GetValueAsInt32(Value);
end;

function TProfXmlNode1_2006.ReadInt64(const AName: WideString; AValue: Int64): WordBool;
begin
  Result := NodeExist(AName);
  if not(Result) then Exit;
  Result := FindNode(AName).GetValueAsInt64(AValue);
end;

function TProfXmlNode1_2006.ReadInteger(const AName: WideString; var AValue: Integer): WordBool;
begin
  Result := NodeExist(AName);
  if not(Result) then Exit;
  Result := FindNode(AName).GetValueAsInteger(AValue);
end;

function TProfXmlNode1_2006.ReadString(const AName: WideString; var Value: WideString): WordBool;
begin
  if NodeExist(AName) then Result := FindNode(AName).GetValueAsString(Value) else Result := False;
end;

function TProfXmlNode1_2006.ReadUInt08(const AName: WideString; var Value: UInt08): WordBool;
var
  Node: TProfXmlNode1;
begin
  Result := False;
  Node := FindNode(AName);
  if not(Assigned(Node)) then Exit;
  Result := Node.GetValueAsUInt08(Value);
end;

function TProfXmlNode1_2006.ReadUInt64(const AName: WideString; var Value: UInt64): WordBool;
var
  Node: TProfXmlNode1;
begin
  Result := False;
  Node := FindNode(AName);
  if not(Assigned(Node)) then Exit;
  Result := Node.GetValueAsUInt64(Value);
end;

function TProfXmlNode1_2006.ReadWideString(const AName: WideString; var Value: WideString): WordBool;
var
  Node: TProfXmlNode1;
begin
  Result := False;
  Node := FindNode(AName);
  if not(Assigned(Node)) then Exit;
  Result := Node.GetValueAsString(Value);
end;

procedure TProfXmlNode1_2006.SetName(Value: WideString);
begin
  FName := Value;
end;

function TProfXmlNode1_2006.SetValueAsBool(Value: Boolean): Boolean;
begin
  {$IFDEF VER150}
  FValue := BoolToStr(Value, True);
  {$ELSE}
  if Value then FValue := 'True' else FValue := 'False';
  {$ENDIF}
  Result := True;
end;

function TProfXmlNode1_2006.SetValueAsFloat64(Value: Float64): Boolean;
begin
  FValue := FloatToStr(Value);
  Result := True;
end;

function TProfXmlNode1_2006.SetValueAsInt32(AValue: Int32): Boolean;
begin
  FValue := IntToStr(AValue);
  Result := True;
end;

function TProfXmlNode1_2006.SetValueAsString(AValue: WideString): Boolean;
begin
  FValue := AValue;
  Result := True;
end;

function TProfXmlNode1_2006.SetValueAsUInt08(AValue: UInt08): Boolean;
begin
  FValue := IntToStr(AValue);
  Result := True;
end;

function TProfXmlNode1_2006.SetValueAsUInt64(AValue: UInt64): Boolean;
begin
  FValue := IntToStr(AValue);
  Result := True;
end;

function TProfXmlNode1_2006.SetXml(Value: WideString): Boolean;
// Создает новую дочернюю структуру, разбирая строку
// Value - элемент
var
  I: Integer;
  I2: Integer;
  Tag: String;
begin
  Result := False;
  FValue := '';
  //repeat
    I := Pos('<', Value);
    // Запись значения
    if (I = 0) then begin
      FValue := FValue + Value;
    end else begin
      FValue := FValue + Copy(Value, 1, I - 1);
    end;
    FValue := StrHtmlToStr(FValue);  // Преобразование символов
    if I = 0 then begin
      Result := True;
      Exit;
    end;
    FValue := Copy(Value, 1, I - 1);
    Delete(Value, 1, I);
    I := Pos('>', Value);
    I2 := Pos(WideString('/>'), Value);
    if (I = 0) then begin
      AddToLog(lgGeneral, ltError, 'Не найден закрывающий символ ">"', []);
      Exit;
    end;
    if I2 <> I - 1 then I2 := 0; // I2 должен отставать от I на 1 символ
    if I2 = 0 then begin
      Tag := Copy(Value, 1, I - 1);
    end else begin
      Tag := Copy(Value, 1, I2 - 1);
    end;
    Delete(Value, 1, I); // Удаление начала описания нода
    // ..........

    GetNameAndAttributes(Tag); // Выделить имя и атрибуты их строки "tag attr1="value1" attr2="value2""
    Value := strDeleteSpace(Value, [dsFirst, dsLast]);
    Result := ReadNodes(Value, FName); // Читать ноды из строки до закрывающего тега
  //until False;
end;

function TProfXmlNode1_2006.SetXmlA(var Value: WideString; CloseTag: WideString = ''): WordBool;
// Создает новую дочернюю структуру, разбирая строку
// Value - дочерние элементы
begin
  Result := ReadNodes(Value, CloseTag);
end;

procedure TProfXmlNode1_2006.Set_Attribute(Name, Value: WideString);
var
  I: Integer;
begin
  if Name = '' then Exit;
  // Поиск атрибута
  for I := 0 to High(FAttributes) do if FAttributes[I].Name = Name then begin
    FAttributes[I].Value := Value;
    Exit;
  end;
  // Создание атрибута
  I := Length(FAttributes);
  SetLength(FAttributes, I + 1);
  FAttributes[I].Name := Name;
  FAttributes[I].Value := Value;
end;

procedure TProfXmlNode1_2006.Set_NodeName(Value: WideString);
begin
  FName := Value;
end;

procedure TProfXmlNode1_2006.Set_NodeValue(Value: WideString);
begin
  FValue := Value;
end;

procedure TProfXmlNode1_2006.Set_Xml(const Value: WideString);
begin
  SetXml(Value);
end;

function TProfXmlNode1_2006.WriteBool(const AName: WideString; Value: WordBool): WordBool;
begin
  Result := GetNodeByName(AName).SetValueAsBool(Value);
end;

function TProfXmlNode1_2006.WriteFloat64(const AName: WideString; Value: Float64): WordBool;
begin
  Result := GetNodeByName(AName).SetValueAsFloat64(Value);
end;

function TProfXmlNode1_2006.WriteInt32(const AName: WideString; Value: Int32): WordBool;
begin
  Result := GetNodeByName(AName).SetValueAsInt32(Value);
end;

function TProfXmlNode1_2006.WriteInt64(const AName: WideString; Value: Int64): WordBool;
begin
  Result := WriteInt32(AName, Value);
end;

function TProfXmlNode1_2006.WriteInteger(const AName: WideString; Value: Integer): WordBool;
begin
  Result := WriteInt32(AName, Value);
end;

function TProfXmlNode1_2006.WriteString(const AName, Value: WideString): WordBool;
begin
  Result := GetNodeByName(AName).SetValueAsString(Value);
end;

function TProfXmlNode1_2006.WriteUInt08(const AName: WideString; AValue: UInt08): WordBool;
begin
  Result := GetNodeByName(AName).SetValueAsUInt08(AValue);
end;

function TProfXmlNode1_2006.WriteUInt64(const AName: WideString; AValue: UInt64): WordBool;
begin
  Result := GetNodeByName(AName).SetValueAsUInt64(AValue);
end;

function TProfXmlNode1_2006.WriteXml(const AName, Value: WideString): WordBool;
begin
  Result := GetNodeByName(AName).SetXml(Value);
end;

{ TProxXmlNodeList }

{constructor TProfXmlNodeList.Create(Owner: TXMLNode;
  const DefaultNamespaceURI: DOMString; NotificationProc: TNodeListNotification);
begin
  FList := TInterfaceList.Create;
  FOwner := Owner;
  FNotificationProc := NotificationProc;
  FDefaultNamespaceURI := DefaultNamespaceURI;
  inherited Create;
end;}

destructor TProfXmlNodeList.Destroy;
begin
  inherited;
end;

procedure TProfXmlNodeList.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TProfXmlNodeList.EndUpdate;
begin
  Dec(FUpdateCount);
end;

{function TProfXmlNodeList.DoNotify(Operation: TNodeListOperation; const Node: IXMLNode;
  const IndexOrName: OleVariant; BeforeOperation: Boolean): IXMLNode;
begin
  Result := Node;
  if Assigned(NotificationProc) then
    NotificationProc(Operation, Result, IndexOrName, BeforeOperation);
end;}

function TProfXmlNodeList.GetCount: Integer;
begin
  Result := List.Count;
end;

function TProfXmlNodeList.IndexOf(const Node: IXMLNode): Integer;
begin
  Result := List.IndexOf(Node as IXMLNode)
end;

{$ifdef Delphi_XE_Up}
function TProfXmlNodeList.IndexOf(const Name: DOMString): Integer;
begin
  //Result := IndexOf(Name, DefaultNamespaceURI);
end;
{$else}
function TProfXmlNodeList.IndexOf(const Name: WideString): Integer;
begin
  //Result := IndexOf(Name, DefaultNamespaceURI);
end;
{$endif Delphi_XE_Up}

{$ifdef Delphi_XE_Up}
function TProfXmlNodeList.IndexOf(const Name, NamespaceURI: DOMString): Integer;
begin
  {for Result := 0 to Count - 1 do
    if NodeMatches(Get(Result).DOMNode, Name, NamespaceURI) then Exit;}
  Result := -1;
end;
{$else}
function TProfXmlNodeList.IndexOf(const Name, NamespaceURI: WideString): Integer;
begin
  {for Result := 0 to Count - 1 do
    if NodeMatches(Get(Result).DOMNode, Name, NamespaceURI) then Exit;}
  Result := -1;
end;
{$endif Delphi_XE_Up}

{function TProfXmlNodeList.IndexOf(const Node: IXmlDomNode): Integer;
begin
  // ...
end;}

{$ifdef Delphi_XE_Up}
function TProfXmlNodeList.FindNode(NodeName: DOMString): IXMLNode;
begin
  //Result := FindNode(NodeName, DefaultNamespaceURI);
end;
{$else}
function TProfXmlNodeList.FindNode(NodeName: WideString): IXMLNode;
begin
  //Result := FindNode(NodeName, DefaultNamespaceURI);
end;
{$endif Delphi_XE_Up}

{$ifdef Delphi_XE_Up}
function TProfXmlNodeList.FindNode(NodeName, NamespaceURI: DOMString): IXMLNode;
var
  Index: Integer;
begin
  Index := IndexOf(NodeName, NamespaceURI);
  if Index >= 0 then
    Result := Get(Index)
  else
    Result := nil;
end;
{$else}
function TProfXmlNodeList.FindNode(NodeName, NamespaceURI: WideString): IXMLNode;
var
  Index: Integer;
begin
  Index := IndexOf(NodeName, NamespaceURI);
  if Index >= 0 then
    Result := Get(Index)
  else
    Result := nil;
end;
{$endif Delphi_XE_Up}

function TProfXmlNodeList.FindNode(ChildNodeType: TGuid): IXMLNode;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    if Supports(Get(I), ChildNodeType, Result) then Exit;
  Result := nil;
end;

function TProfXmlNodeList.First(): IXMLNode;
begin
  if List.Count > 0 then
    Result := List.First as IXMLNode
  else
    Result := nil;
end;

function TProfXmlNodeList.Last: IXMLNode;
begin
  if List.Count > 0 then
    Result := List.Last as IXMLNode else
    Result := nil;
end;

function TProfXmlNodeList.nextNode: IXmlDomNode;
begin

end;

function TProfXmlNodeList.FindSibling(const Node: IXMLNode; Delta: Integer): IXMLNode;
var
  Index: Integer;
begin
  Index := IndexOf(Node);
  Index := Index + Delta;
  if (Index >= 0) and (Index < list.Count) then
    Result := Get(Index) else
    Result := nil;
end;

function TProfXmlNodeList.Get(Index: Integer): IXMLNode;
begin
  Result := List.Get(Index) as IXMLNode;
end;

function TProfXmlNodeList.GetNode(const IndexOrName: OleVariant): IXMLNode;
begin
  {if VarIsOrdinal(IndexOrName) then
    Result := List.Get(IndexOrName) as IXMLNode
  else
  begin
    Result := FindNode(WideString(IndexOrName));
    if not Assigned(Result) and
      (doNodeAutoCreate in Owner.OwnerDocument.Options) then
      Result := DoNotify(nlCreateNode, nil, IndexOrName, True);
    if not Assigned(Result) then
      XMLDocError(SNodeNotFound, [IndexOrName]);
  end;}
end;

function TProfXmlNodeList.Add(const Node: IXMLNode): Integer;
begin
  Insert(-1, Node);
  Result := Count - 1;
end;

function TProfXmlNodeList.InternalInsert(Index: Integer;
  const Node: IXMLNode): Integer;
begin
  {DoNotify(nlInsert, Node, Index, True);
  if Index <> -1 then
  begin
     List.Insert(Index, Node as IXMLNode);
     Result := Index;
  end
  else
    Result := List.Add(Node as IXMLNode);
  DoNotify(nlInsert, Node, Index, False);}
end;

procedure TProfXmlNodeList.Insert(Index: Integer; const Node: IXMLNode);

  {procedure InsertFormattingNode(const Len, Index: Integer;
    Break: Boolean = True);
  var
    I: Integer;
    IndentNode: IXMLNode;
    IndentStr: WideString;
  begin
    for I := 1 to Len do
      IndentStr := IndentStr + Owner.OwnerDocument.NodeIndentStr;
    if Break then
      IndentStr := SLineBreak + IndentStr;
    with Owner do
      IndentNode := TXMLNode.Create(CreateDOMNode(OwnerDocument.DOMDocument,
        IndentStr, ntText), nil, OwnerDocument);
    InternalInsert(Index, IndentNode);
  end;}

var
  TrailIndent, NewIndex: Integer;
begin
  (*
  { Determine if we should add do formatting here }
  if Assigned(Owner.ParentNode) and (Owner.HostNode = nil) and
     (doNodeAutoIndent in Owner.OwnerDocument.Options) and
     not (Node.NodeType in [ntText, ntAttribute]) then
  begin
    { Insert formatting before the node }
    if Count = 0 then
      InsertFormattingNode(Owner.ParentNode.NestingLevel, -1);
    if Index = -1 then
      InsertFormattingNode(1, -1, False);
    { Insert the actual node }
    NewIndex := InternalInsert(Index, Node);
    { Insert formatting after the node }
    if Index = -1 then
      TrailIndent := Owner.ParentNode.NestingLevel else
      TrailIndent := Owner.NestingLevel;
    if (NewIndex >= Count-1) or (Get(NewIndex+1).NodeType <> ntText) then
      InsertFormattingNode(TrailIndent, NewIndex + 1)
  end else
    InternalInsert(Index, Node);
  *)
end;

function TProfXmlNodeList.Delete(const Index: Integer): Integer;
begin
  Result := Remove(Get(Index));
end;

{$ifdef Delphi_XE_Up}
function TProfXmlNodeList.Delete(const Name: DOMString): Integer;
begin
  //Result := Delete(Name, DefaultNamespaceURI);
end;
{$else}
function TProfXmlNodeList.Delete(const Name: WideString): Integer;
begin
  //Result := Delete(Name, DefaultNamespaceURI);
end;
{$endif Delphi_XE_Up}

{$ifdef Delphi_XE_Up}
function TProfXmlNodeList.Delete(const Name, NamespaceURI: DOMString): Integer;
var
  Node: IXMLNode;
begin
  Node := FindNode(Name, NamespaceURI);
  if Assigned(Node) then
    Result := Remove(Node)
  else
   { No error when named nodes doesn't exist }
    Result := -1;
end;
{$else}
function TProfXmlNodeList.Delete(const Name, NamespaceURI: WideString): Integer;
var
  Node: IXMLNode;
begin
  Node := FindNode(Name, NamespaceURI);
  if Assigned(Node) then
    Result := Remove(Node)
  else
   { No error when named nodes doesn't exist }
    Result := -1;
end;
{$endif Delphi_XE_Up}

function TProfXmlNodeList.Remove(const Node: IXMLNode): Integer;
begin
  {DoNotify(nlRemove, Node, -1, True);
  Result := List.Remove(Node as IXMLNode);
  DoNotify(nlRemove, Node, -1, False);}
end;

function TProfXmlNodeList.ReplaceNode(const OldNode, NewNode: IXMLNode): IXMLNode;
var
  Index: Integer;
begin
  Index := Remove(OldNode);
  Insert(Index, NewNode);
  Result := OldNode;
end;

procedure TProfXmlNodeList.Reset();
begin
end;

procedure TProfXmlNodeList.Clear;
begin
  List.Lock;
  try
    while Count > 0 do
      Remove(Get(0));
  finally
    List.Unlock;
  end;
end;

function TProfXmlNodeList.GetUpdateCount: Integer;
begin
  Result := FUpdateCount;
end;

function TProfXmlNodeList.Get_item(index: Integer): IXmlDomNode;
begin

end;

function TProfXmlNodeList.Get_length: Integer;
begin

end;

function TProfXmlNodeList.Get__newEnum: IUnknown;
begin

end;

end.
