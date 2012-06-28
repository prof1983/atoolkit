{**
@Abstract(AXmlNode functions)
@Author(Prof1983 prof1983@ya.ru)
@Created(28.06.2012)
@LastMod(28.06.2012)
@Version(0.5)
}
unit AXmlNodeUtils;

interface

uses
  XmlIntf,
  ABase;

// --- AXmlNode ---

function AXmlNode_GetAttributeValue(Node: AXmlNode; const Name: APascalString): APascalString;

function AXmlNode_GetAttributeValue2(Node: AXmlNode; const Name: APascalString;
    UpperCase: ABoolean): APascalString;

function AXmlNode_GetDocument(Node: AXmlNode): AXmlDocument;

function AXmlNode_GetName(Node: AXmlNode): APascalString;

function AXmlNode_GetXmlA(Node: AXmlNode; const Prefix: APascalString): APascalString;

function AXmlNode_Free(Node: AXmlNode): AError;

function AXmlNode_New(Document: AXmlDocument): AXmlNode;

function AXmlNode_SetDocument(Node: AXmlNode; Document: AXmlDocument): AError;

function AXmlNode_SetName(Node: AXmlNode; const Name: APascalString): AError;

function AXmlNode_SetXml(Node: AXmlNode; const S: APascalString): AError;

// --- AXmlNode2 ---

function AXmlNode2_New(Node: IXmlNode): AProfXmlNode2;

implementation

uses
  AXml2006, AXml2007;

function AXmlNode_GetAttributeValue(Node: AXmlNode; const Name: APascalString): APascalString;
begin
  Result := TProfXmlNode1(Node).Attributes[Name];
end;

function AXmlNode_GetAttributeValue2(Node: AXmlNode; const Name: APascalString;
    UpperCase: ABoolean): APascalString;
begin
  Result := TProfXmlNode1(Node).GetAttribute(Name, UpperCase);
end;

function AXmlNode_GetDocument(Node: AXmlNode): AXmlDocument;
begin
  Result := TProfXmlNode1(Node).Document.GetSelf();
end;

function AXmlNode_GetName(Node: AXmlNode): APascalString;
begin
  Result := TProfXmlNode1(Node).GetName();
end;

function AXmlNode_GetXmlA(Node: AXmlNode; const Prefix: APascalString): APascalString;
begin
  Result := TProfXmlNode1(Node).GetXmlA('');
end;

function AXmlNode_Free(Node: AXmlNode): AError;
begin
  TProfXmlNode1(Node).Free();
  Result := 0;
end;

function AXmlNode_New(Document: AXmlDocument): AXmlNode;
begin
  Result := AXmlNode(TProfXmlNode1.Create(Document));
end;

function AXmlNode_SetDocument(Node: AXmlNode; Document: AXmlDocument): AError;
begin
  TProfXmlNode1(Node).SetDocument_Priv(Document);
end;

function AXmlNode_SetName(Node: AXmlNode; const Name: APascalString): AError;
begin
  TProfXmlNode1(Node).SetName(Name);
  Result := 0;
end;

function AXmlNode_SetXml(Node: AXmlNode; const S: APascalString): AError;
begin
  if TProfXmlNode1(Node).SetXml(S) then
    Result := 0
  else
    Result := -1;
end;

// --- AXmlNode2 ---

function AXmlNode2_New(Node: IXmlNode): AProfXmlNode2;
begin
  try
    Result := AProfXmlNode2(TProfXmlNode2.Create(Node));
  except
    Result := 0;
  end;
end;

end.
