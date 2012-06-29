{**
@Abstract(AXmlNodeList functions)
@Author(Prof1983 prof1983@ya.ru)
@Created(29.06.2012)
@LastMod(29.06.2012)
@Version(0.5)
}
unit AXmlNodeListUtils;

interface

uses
  XmlIntf,
  ABase;

type
  AXmlNodeList_Type = record
    Nodes: IXmlNodeList{IInterfaceList};
    //NotificationProc: TNodeListNotification;
    //Owner: TXmlNode;
    UpdateCount: Integer;
    //DefaultNamespaceURI: DOMString;
  end;
  AXmlNodeList_P = ^AXmlNodeList_Type;

// --- AXmlNodeList ---

function AXmlNodeList_New(Nodes: IXmlNodeList): AXmlNodeList;

function AXmlNodeList_GetNodeByName(XmlNodeList: AXmlNodeList; const Name: APascalString): IXmlNode;

implementation

var
  FItems: array of AXmlNodeList_P;

// --- Private ---

function _FindByNodes(Nodes: IXmlNodeList): AXmlNodeList;
var
  I: Integer;
begin
  for I := 0 to High(FItems) do
  begin
    if (FItems[I]^.Nodes = Nodes) then
    begin
      Result := AXmlNodeList(FItems[I]);
      Exit;
    end;
  end;
  Result := 0;
end;

// --- AXmlNodeList ---

function AXmlNodeList_New(Nodes: IXmlNodeList): AXmlNodeList;
var
  Item: AXmlNodeList;
  I: Integer;
  P: Pointer;
begin
  Item := _FindByNodes(Nodes);
  if (Item >= 0) then
  begin
    Result := Item;
    Exit;
  end;

  P := AllocMem(SizeOf(AXmlNodeList_Type));

  I := Length(FItems);
  SetLength(FItems, I + 1);
  FItems[I] := P;
  Result := AXmlNodeList(P);
end;

function AXmlNodeList_GetNodeByName(XmlNodeList: AXmlNodeList; const Name: APascalString): IXmlNode;
begin
  Result := AXmlNodeList_P(XmlNodeList)^.Nodes.Nodes[Name];
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

end.
