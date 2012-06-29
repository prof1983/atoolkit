{**
@Abstract(XML)
@Author(Prof1983 prof1983@ya.ru)
@Created(09.10.2005)
@LastMod(29.06.2012)
@Version(0.5)
}
unit AXmlCollectionImpl;

interface

uses
  ABase, AXmlCollectionIntf, AXmlNodeIntf, AXmlNodeUtils;

type
  // Коллекция нодов
  TProfXmlCollection = class(TInterfacedObject, IProfXmlCollection)
  protected
    FNodes: array of AProfXmlNode;
    FOwner: AProfXmlNode;
  public // IProfXmlCollection
    function DeleteNode(Node: IProfXmlNode2006): WordBool;
    function GetCount(): Integer;
    function GetNode(Index: Integer): AProfXmlNode;
    //function Get_Node(Index: Integer): IProfXmlNode2006;
  public
    function AddChild(const AName: WideString): AProfXmlNode;
    procedure AddNode(ANode: AProfXmlNode);
    procedure Clear();
    function FindNode(Name: WideString): AProfXmlNode;
    procedure Free();
    function GetNodeByAttribute(AName, AValue: WideString): AProfXmlNode;
    function GetNodeByName(Name: WideString): AProfXmlNode;
    function NewNode(const Name: WideString): AProfXmlNode;
  public
    constructor Create(AOwner: AProfXmlNode);
  public
    //property Count: Integer read GetCount;
    property Nodes[Index: Integer]: AProfXmlNode read GetNode;
    property NodesByName[Name: WideString]: AProfXmlNode read GetNodeByName;
  end;

implementation

{ TProfXmlCollection }

function TProfXmlCollection.AddChild(const AName: WideString): AProfXmlNode;
begin
  Result := NewNode(AName);
end;

procedure TProfXmlCollection.AddNode(ANode: AProfXmlNode);
var
  I: Int32;
  Document: AXmlDocument;
begin
  I := Length(FNodes);
  SetLength(FNodes, I + 1);
  FNodes[I] := ANode;
  Document := AXmlNode_GetDocument(FOwner);
  AXmlNode_SetDocument(FNodes[I], Document);
end;

procedure TProfXmlCollection.Clear();
var
  I: Integer;
begin
  for I := 0 to High(FNodes) do
    AXmlNode_Free(FNodes[I]);
  SetLength(FNodes, 0);
end;

constructor TProfXmlCollection.Create(AOwner: AProfXmlNode);
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

function TProfXmlCollection.FindNode(Name: WideString): AProfXmlNode;
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
    if (AXmlNode_GetName(FNodes[I]) = Name) then
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

function TProfXmlCollection.GetNode(Index: Integer): AProfXmlNode;
begin
  Result := 0;
  if (Index < 0) or (Index > Length(FNodes)) then Exit;
  Result := FNodes[Index];
end;

function TProfXmlCollection.GetNodeByAttribute(AName, AValue: WideString): AProfXmlNode;
var
  i: Integer;
begin
  for i := 0 to High(FNodes) do
  begin
    if (AXmlNode_GetAttributeValue(FNodes[i], AName) = AValue) then
    begin
      Result := FNodes[i];
      Exit;
    end;
  end;
  Result := 0;
end;

function TProfXmlCollection.GetNodeByName(Name: WideString): AProfXmlNode;
var
  Res: AProfXmlNode1;
  Document: AXmlDocument;
begin
  if (Name = '') then
  begin
    Result := 0;
    Exit;
  end;
  Result := FindNode(Name);
  if (Result <> 0) then Exit;
  Document := AXmlNode_GetDocument(FOwner);
  Res := AXmlNode_New(Document);
  AXmlNode_SetName(Res, Name);
  AddNode(AProfXmlNode1(Res));
  Result := AProfXmlNode1(Res);
end;

{function TProfXmlCollection.Get_Node(Index: Integer): IProfXmlNode2006;
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
end;}

function TProfXmlCollection.NewNode(const Name: WideString): AProfXmlNode;
var
  Res: AProfXmlNode1;
  Document: AXmlDocument;
begin
  Document := AXmlNode_GetDocument(FOwner);
  Res := AXmlNode_New(Document);
  AXmlNode_SetName(Res, Name);
  AddNode(AProfXmlNode1(Res));
  Result := AProfXmlNode1(Res);
end;

end.
