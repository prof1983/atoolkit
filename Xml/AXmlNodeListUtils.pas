{**
@Abstract(AXmlNodeList functions)
@Author(Prof1983 prof1983@ya.ru)
@Created(29.06.2012)
@LastMod(02.07.2012)
@Version(0.5)
}
unit AXmlNodeListUtils;

interface

uses
  XmlIntf,
  ABase;

type
  AXmlNodeList_Type = record
    Nodes1: IXmlNodeList{IInterfaceList};
    Nodes2: array of AProfXmlNode;
    //NotificationProc: TNodeListNotification;
    //Owner: TXmlNode;
    UpdateCount: Integer;
    //DefaultNamespaceURI: DOMString;
  end;
  AXmlNodeList_P = ^AXmlNodeList_Type;

// --- AXmlNodeList ---

function AXmlNodeList_Add(XmlNodeList: AXmlNodeList; Node: AProfXmlNode): AInt;

function AXmlNodeList_Clear(XmlNodeList: AXmlNodeList): AError;

function AXmlNodeList_FindNode(XmlNodeList: AXmlNodeList; const Name: APascalString): AXmlNode;

function AXmlNodeList_GetCount(XmlNodeList: AXmlNodeList): AInt;

function AXmlNodeList_GetNodeByIndex(XmlNodeList: AXmlNodeList; Index: AInt): AXmlNode;

function AXmlNodeList_GetNodeByName1(XmlNodeList: AXmlNodeList; const Name: APascalString): AXmlNode;

function AXmlNodeList_GetNodeByName2(XmlNodeList: AXmlNodeList; const Name: APascalString): IXmlNode;

function AXmlNodeList_New(Nodes: IXmlNodeList): AXmlNodeList;

function AXmlNodeList_Remove(Nodes: AXmlNodeList; Node: AProfXmlNode): AInt;

implementation

uses
  AXmlNodeUtils;

var
  FItems: array of AXmlNodeList_P;

// --- Private ---

function _FindByNodes(Nodes: IXmlNodeList): AXmlNodeList;
var
  I: Integer;
begin
  for I := 0 to High(FItems) do
  begin
    if (FItems[I]^.Nodes1 = Nodes) then
    begin
      Result := AXmlNodeList(FItems[I]);
      Exit;
    end;
  end;
  Result := 0;
end;

function _FindNodeByName2(XmlNodeList: AXmlNodeList_P; const Name: WideString): AInt;
var
  I: Integer;
begin
  for I := 0 to High(XmlNodeList^.Nodes2) do
  begin
    if (AXmlNode_GetName(XmlNodeList^.Nodes2[I]) = Name) then
    begin
      Result := I;
      Exit;
    end;
  end;
end;

// --- AXmlNodeList ---

function AXmlNodeList_Add(XmlNodeList: AXmlNodeList; Node: AProfXmlNode): AInt;
var
  NL: AXmlNodeList_P;
  I: Int32;
  //Document: AXmlDocument;
begin
  NL := AXmlNodeList_P(XmlNodeList);
  I := Length(NL^.Nodes2);
  SetLength(NL^.Nodes2, I + 1);
  NL^.Nodes2[I] := Node;

  // Only if (TObject(Node) is TProfXmlNode1) then
  //Document := AXmlNode_GetDocument(FOwner);
  //AXmlNode_SetDocument(FNodes[I], Document);

  Result := I;
end;

function AXmlNodeList_Clear(XmlNodeList: AXmlNodeList): AError;
var
  NL: AXmlNodeList_P;
  I: Integer;
begin
  NL := AXmlNodeList_P(XmlNodeList);
  for I := 0 to High(NL^.Nodes2) do
    AXmlNode_Free(NL^.Nodes2[I]);
  SetLength(NL^.Nodes2, 0);
end;

function AXmlNodeList_FindNode(XmlNodeList: AXmlNodeList; const Name: APascalString): AXmlNode;
var
  NL: AXmlNodeList_P;
  I: Int32;
begin
  NL := AXmlNodeList_P(XmlNodeList);
  if (Name = '') then
  begin
    Result := 0;
    Exit;
  end;
  for I := 0 to High(NL^.Nodes2) do
  begin
    if (AXmlNode_GetName(NL^.Nodes2[I]) = Name) then
    begin
      Result := NL^.Nodes2[I];
      Exit;
    end;
  end;
  Result := 0;
end;

function AXmlNodeList_GetCount(XmlNodeList: AXmlNodeList): AInt;
begin
  Result := Length(AXmlNodeList_P(XmlNodeList)^.Nodes2);
end;

function AXmlNodeList_GetNodeByIndex(XmlNodeList: AXmlNodeList; Index: AInt): AXmlNode;
var
  NL: AXmlNodeList_P;
begin
  NL := AXmlNodeList_P(XmlNodeList);
  if (Index < 0) or (Index > Length(NL^.Nodes2)) then
  begin
    Result := 0;
    Exit;
  end;
  Result := NL^.Nodes2[Index];
end;

function AXmlNodeList_GetNodeByName1(XmlNodeList: AXmlNodeList; const Name: APascalString): AXmlNode;
var
  Node: IXmlNode;
  Index: Integer;
begin
  Index := _FindNodeByName2(AXmlNodeList_P(XmlNodeList), Name);
  if (Index >= 0) then
  begin
    Result := AXmlNodeList_P(XmlNodeList)^.Nodes2[Index];
    Exit;
  end;

  Node := AXmlNodeList_GetNodeByName2(XmlNodeList, Name);
  if Assigned(Node) then
    Result := AXmlNode2_New(Node)
  else
    Result := 0;
end;

function AXmlNodeList_GetNodeByName2(XmlNodeList: AXmlNodeList; const Name: APascalString): IXmlNode;
var
  Nodes: IXmlNodeList;
begin
  Nodes := AXmlNodeList_P(XmlNodeList)^.Nodes1;
  if not(Assigned(Nodes)) then
  begin
    Result := nil;
    Exit;
  end;
  Result := Nodes.Nodes[Name];
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

function AXmlNodeList_New(Nodes: IXmlNodeList): AXmlNodeList;
var
  Item: AXmlNodeList;
  I: Integer;
  P: Pointer;
begin
  if Assigned(Nodes) then
  begin
    Item := _FindByNodes(Nodes);
    if (Item >= 0) then
    begin
      Result := Item;
      Exit;
    end;
  end;

  P := AllocMem(SizeOf(AXmlNodeList_Type));

  I := Length(FItems);
  SetLength(FItems, I + 1);
  FItems[I] := P;
  FItems[I]^.Nodes1 := Nodes;
  Result := AXmlNodeList(P);
end;

function AXmlNodeList_Remove(Nodes: AXmlNodeList; Node: AProfXmlNode): AInt;
var
  NL: AXmlNodeList_P;
  I: Integer;
  I2: Integer;
begin
  NL := AXmlNodeList_P(Nodes);
  for I := 0 to High(NL^.Nodes2) do
  begin
    if (NL^.Nodes2[I] = Node) then
    begin
      for I2 := I to High(NL^.Nodes2) - 1 do
        NL^.Nodes2[I2] := NL^.Nodes2[I2 + 1];
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

end.
