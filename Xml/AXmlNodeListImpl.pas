{**
@Abstract(AXmlNodeList)
@Author(Prof1983 prof1983@ya.ru)
@Created(29.06.2012)
@LastMod(29.06.2012)
@Version(0.5)
}
unit AXmlNodeListImpl;

interface

uses
  //{$ifdef Delphi_XE_UP}XmlDom,{$endif}
  //Classes, ComCtrls, ComObj, SysUtils, Variants,
  XmlIntf,
  //ABase, AConsts2, ATypes, AXmlCollectionImpl, AXmlCollectionIntf, AXmlDocumentImpl, AXmlNodeIntf,
  //AXml2007;
  AXmlNodeListUtils;

type
  AXmlString = {$ifdef Delphi_XE_Up}DOMString{$else}WideString{$endif};
  IXmlNode = {$ifdef Delphi_XE_Up}XmlIntf.IXmlNode{$else}XmlIntf.IXmlDomNode{$endif};

  TProfXmlNodeList = class //(TInterfacedObject{TAutoIntfObject}, IXmlNodeList)
  private
    FList: AXmlNodeList_Type;
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
    function Delete(const Name: AXmlString): Integer; overload;
    function Delete(const Name, NamespaceUri: AXmlString): Integer; overload;
    procedure EndUpdate();
    function First: IXmlDomNode;
    function FindNode(NodeName: AXmlString): IXmlNode; overload;
    function FindNode(NodeName, NamespaceUri: AXmlString): IXmlNode; overload;
    function FindNode(ChildNodeType: TGuid): IXmlNode; overload;
    function FindSibling(const Node: IXmlDomNode; Delta: Integer): IXmlDomNode;
    function Get(Index: Integer): IXmlDomNode;
    function GetCount(): Integer;
    function GetNode(const IndexOrName: OleVariant): IXmlDomNode;
    function GetUpdateCount(): Integer;
    function IndexOf(const Node: IXmlNode): Integer; overload;
    function IndexOf(const Name: AXmlString): Integer; overload;
    function IndexOf(const Name, NamespaceUri: AXmlString): Integer; overload;
    procedure Insert(Index: Integer; const Node: IXmlDomNode);
    function Last(): IXmlDomNode;
    function Remove(const Node: IXmlDomNode): Integer;
    function ReplaceNode(const OldNode, NewNode: IXmlDomNode): IXmlDomNode;
  protected
    {function DoNotify(Operation: TNodeListOperation; const Node: IXmlDomNode;
      const IndexOrName: OleVariant; BeforeOperation: Boolean): IXmlDomNode;}
    //property DefaultNamespaceURI: DOMString read FDefaultNamespaceURI;
    function InternalInsert(Index: Integer; const Node: IXmlDomNode): Integer;
    //property NotificationProc: TNodeListNotification read FNotificationProc;
    //property Owner: TXMLNode read FOwner;
  public
    constructor Create(XmlNodeList: IXmlNodeList);
    {constructor Create(Owner: TXMLNode; const DefaultNamespaceURI: DOMString;
      NotificationProc: TNodeListNotification);}
  public
    property Count: Integer read GetCount;
    property Item[index: Integer]: IXmlDomNode read Get_item; default;
    property Length: Integer read Get_length;
    //property List: IInterfaceList read FList;
    //property _NewEnum: IUnknown read Get__newEnum;
    property UpdateCount: Integer read GetUpdateCount;
  end;

implementation

{ TProfXmlNodeList }

procedure TProfXmlNodeList.Clear();
begin
  List.Lock();
  try
    while (Count > 0) do
      Remove(Get(0));
  finally
    List.Unlock();
  end;
end;

procedure TProfXmlNodeList.BeginUpdate();
begin
  Inc(FUpdateCount);
end;

{constructor TProfXmlNodeList.Create(Owner: TXMLNode;
  const DefaultNamespaceURI: DOMString; NotificationProc: TNodeListNotification);
begin
  FList := TInterfaceList.Create;
  FOwner := Owner;
  FNotificationProc := NotificationProc;
  FDefaultNamespaceURI := DefaultNamespaceURI;
  inherited Create;
end;}

constructor TProfXmlNodeList.Create(XmlNodeList: IXmlNodeList);
begin
  inherited Create();
  FList := XmlNodeList;
end;

{function TProfXmlNodeList.DoNotify(Operation: TNodeListOperation; const Node: IXMLNode;
  const IndexOrName: OleVariant; BeforeOperation: Boolean): IXMLNode;
begin
  Result := Node;
  if Assigned(NotificationProc) then
    NotificationProc(Operation, Result, IndexOrName, BeforeOperation);
end;}

procedure TProfXmlNodeList.EndUpdate();
begin
  Dec(FUpdateCount);
end;

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
  if VarIsOrdinal(IndexOrName) then
    Result := AXmlNodeList_GetNodeByIndex(IndexOrName)
  else
    Result := AXmlNodeList_GetNodeByName(IndexOrName);
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
