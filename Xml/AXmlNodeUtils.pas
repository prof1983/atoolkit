{**
@Abstract(AXmlNode functions)
@Author(Prof1983 prof1983@ya.ru)
@Created(28.06.2012)
@LastMod(09.07.2012)
@Version(0.5)
}
unit AXmlNodeUtils;

interface

uses
  SysUtils, XmlIntf,
  ABase;

// --- AXmlNode ---

function AXmlNode_AsString(Node: AXmlNode): APascalString;

function AXmlNode_GetAttributeCount(Node: AXmlNode): AInteger;

function AXmlNode_GetAttributeName(Node: AXmlNode; Index: AInt): APascalString;

function AXmlNode_GetAttributeValue(Node: AXmlNode; const Name: APascalString): APascalString;

function AXmlNode_GetAttributeValue2(Node: AXmlNode; const Name: APascalString;
    UpperCase: ABoolean): APascalString;

function AXmlNode_GetAttributeValueByIndex(Node: AXmlNode; Index: AInt): APascalString;

function AXmlNode_GetChildNodeByAttribute(Node: AXmlNode; const AttrName, AttrValue: APascalString): AXmlNode;

{** Return TProfXmlNode }
function AXmlNode_GetChildNodeByName(Node: AXmlNode; const Name: APascalString): AProfXmlNode;

function AXmlNode_GetChildNodeCount(Node: AXmlNode): AInt;

function AXmlNode_GetChildNodes(Node: AXmlNode): AXmlNodeList;

function AXmlNode_GetCollection(Node: AXmlNode): AXmlNodeCollection;

function AXmlNode_GetDocument(Node: AXmlNode): AXmlDocument;

function AXmlNode_GetName(Node: AXmlNode): APascalString;

function AXmlNode_GetNameAndAttributes(Node: AXmlNode; const Value: APascalString): AError;

function AXmlNode_GetValueAsBool(Node: AXmlNode; out Value: ABoolean): AError;

function AXmlNode_GetValueAsDateTime(Node: AXmlNode; out Value: TDateTime): AError;

function AXmlNode_GetValueAsInt(Node: AXmlNode; out Value: AInt): AError;

function AXmlNode_GetValueAsInt32(Node: AXmlNode; out Value: AInt32): AError;

function AXmlNode_GetValueAsInt64(Node: AXmlNode; out Value: AInt64): AError;

function AXmlNode_GetValueAsString(Node: AXmlNode; out Value: APascalString): AError;

function AXmlNode_GetValueAsUInt08(Node: AXmlNode; out Value: AUInt08): AError;

function AXmlNode_GetValueAsUInt64(Node: AXmlNode; out Value: AUInt64): AError;

function AXmlNode_GetXml(Node: AXmlNode): APascalString;

function AXmlNode_GetXmlA(Node: AXmlNode; const Prefix: APascalString): APascalString;

function AXmlNode_Free(Node: AXmlNode): AError;

function AXmlNode_ReadBool(Node: AXmlNode; const Name: APascalString;
    out Value: ABoolean): AError;

function AXmlNode_ReadBoolDef(Node: AXmlNode; const Name: APascalString;
    DefValue: ABoolean): ABoolean;

function AXmlNode_ReadDateTime(Node: AXmlNode; const Name: APascalString;
    out Value: TDateTime): AError;

function AXmlNode_ReadDateTimeDef(Node: AXmlNode; const Name: APascalString;
    DefValue: TDateTime): TDateTime;

function AXmlNode_ReadFloat32(Node: AXmlNode; const Name: APascalString;
    var Value: AFloat32): AError;

function AXmlNode_ReadFloat64(Node: AXmlNode; const Name: APascalString;
    out Value: AFloat64): AError;

function AXmlNode_ReadFloat64Def(Node: AXmlNode; const Name: APascalString;
    DefValue: AFloat64): AFloat64;

function AXmlNode_ReadInt(Node: AXmlNode; const Name: APascalString;
    var Value: AInt): AError;

function AXmlNode_ReadInt32(Node: AXmlNode; const Name: APascalString;
    out Value: AInt32): AError;

function AXmlNode_ReadInt32Def(Node: AXmlNode; const Name: APascalString;
    DefValue: AInt32): AInt32;

function AXmlNode_ReadInt64(Node: AXmlNode; const Name: APascalString;
    out Value: AInt64): AError;

function AXmlNode_ReadInt64Def(Node: AXmlNode; const Name: APascalString;
    DefValue: AInt64): AInt64;

function AXmlNode_ReadString(Node: AXmlNode; const Name: APascalString;
    out Value: APascalString): AError;

function AXmlNode_ReadStringDef(Node: AXmlNode; const Name,
    DefValue: APascalString): APascalString;

function AXmlNode_SetDocument(Node: AXmlNode; Document: AXmlDocument): AError;

function AXmlNode_SetName(Node: AXmlNode; const Name: APascalString): AError;

function AXmlNode_SetValueAsBool(Node: AXmlNode; Value: ABoolean): AError;

function AXmlNode_SetValueAsFloat64(Node: AXmlNode; Value: AFloat64): AError;

function AXmlNode_SetValueAsInt32(Node: AXmlNode; Value: AInt32): AError;

function AXmlNode_SetValueAsString(Node: AXmlNode; const Value: APascalString): AError;

function AXmlNode_SetXml(Node: AXmlNode; const S: APascalString): AError;

function AXmlNode_SetXmlA(Node: AXmlNode; var Value: APascalString; const CloseTag: APascalString): AError;

function AXmlNode_WriteBool(Node: AXmlNode; const Name: APascalString; Value: ABool): AError;

function AXmlNode_WriteInt(Node: AXmlNode; const Name: APascalString; Value: AInt): AError;

function AXmlNode_WriteString(Node: AXmlNode; const Name, Value: APascalString): AError;

// --- AXmlNode0 ---

function AXmlNode0_New(): AXmlNode;

// --- AXmlNode1 ---

function AXmlNode1_New(Document: AXmlDocument): AXmlNode;

// --- AXmlNode2 ---

function AXmlNode2_New(Node: IXmlNode): AProfXmlNode2;

implementation

uses
  AXml2007, AXmlNodeCollectionUtils, AXmlNodeImpl, AXmlNodeListUtils, AXmlUtils;

// --- AXmlNode ---

function AXmlNode_AsString(Node: AXmlNode): APascalString;
begin
  if (TObject(Node) is TProfXmlNode) then
    Result := TProfXmlNode(Node).AsString
  else if (TObject(Node) is TProfXmlNode1) then
    Result := TProfXmlNode1(Node).AsString
  else if (TObject(Node) is TProfXmlNode2) then
    Result := TProfXmlNode2(Node).AsString
  else
    Result := '';
end;

function AXmlNode_CreateCollection(Node: AXmlNode): AXmlNodeCollection;
begin
  if (TObject(Node) is TProfXmlNode1) then
    Result := AXmlNodeCollection_New1(Node)
  else if (TObject(Node) is TProfXmlNode2) then
    Result := AXmlNodeCollection_New2(TProfXmlNode2(Node).Node.Collection)
  else
    Result := 0;
end;

function AXmlNode_GetAttributeCount(Node: AXmlNode): AInteger;
begin
  if (TObject(Node) is TProfXmlNode1) then
    Result := TProfXmlNode1(Node).Attributes_Count()
  else
    Result := -1;
end;

function AXmlNode_GetAttributeName(Node: AXmlNode; Index: AInt): APascalString;
begin
  Result := TProfXmlNode1(Node).Attribute_Name[Index];
end;

function AXmlNode_GetAttributeValue(Node: AXmlNode; const Name: APascalString): APascalString;
begin
  if (TObject(Node) is TProfXmlNode1) then
    Result := TProfXmlNode1(Node).GetAttribute(Name)
  else if (TObject(Node) is TProfXmlNode2) then
    Result := TProfXmlNode2(Node).GetAttribute(Name)
  else
    Result := '';
end;

function AXmlNode_GetAttributeValue2(Node: AXmlNode; const Name: APascalString;
    UpperCase: ABoolean): APascalString;
begin
  if (TObject(Node) is TProfXmlNode1) then
    Result := TProfXmlNode1(Node).GetAttribute(Name, UpperCase)
  else
    Result := '';
end;

function AXmlNode_GetAttributeValueByIndex(Node: AXmlNode; Index: AInt): APascalString;
begin
  if (TObject(Node) is TProfXmlNode1) then
    Result := TProfXmlNode1(Node).Attribute_Value[Index]
  else
    Result := '';
end;

function AXmlNode_GetChildNodeByAttribute(Node: AXmlNode; const AttrName, AttrValue: APascalString): AXmlNode;
var
  I: Integer;
  Nodes: AXmlNodeList;
  Count: AInt;
  ChildNode: AXmlNode;
begin
  Nodes := AXmlNode_GetChildNodes(Node);
  Count := AXmlNodeList_GetCount(Nodes);
  for I := 0 to Count - 1 do
  begin
    ChildNode := AXmlNodeList_GetNodeByIndex(Nodes, I);
    if (AXmlNode_GetAttributeValue(ChildNode, AttrName) = AttrValue) then
    begin
      Result := ChildNode;
      Exit;
    end;
  end;
  Result := 0;
end;

function AXmlNode_GetChildNodeByName(Node: AXmlNode; const Name: APascalString): AProfXmlNode;
var
  N: IXmlNode;
  Child: IXmlNode;
  Nodes: AXmlNodeList;
begin
  if (TObject(Node) is TProfXmlNode) then
    Result := TProfXmlNode(Node).GetNodeByName(Name)
  else if (TObject(Node) is TProfXmlNode2) then
  begin
    N := TProfXmlNode2(Node).Node;
    if Assigned(N) then
    begin
      // Поиск XML нода
      Child := N.ChildNodes.FindNode(Name);
      // Если нету - создание XML нода
      if not(Assigned(Child)) then
        Child := N.AddChild(Name);
      if not(Assigned(Child)) then
      begin
        Result := 0;
        Exit;
      end;
      // Создание оболочки нода
      Result := AXmlNode2_New(Child);
    end
    else
    begin
      Nodes := AXmlNode_GetChildNodes(Node);
      Result := AXmlNodeList_GetNodeByName1(Nodes, Name);
    end;
  end
  else
    Result := 0;
end;

function AXmlNode_GetChildNodeCount(Node: AXmlNode): AInt;
var
  Nodes: AXmlNodeList;
begin
  if (TObject(Node) is TProfXmlNode) then
  begin
    if not(Assigned(TProfXmlNode(Node).Node)) then
    begin
      Result := -1;
      Exit;
    end;
    try
      Result := TProfXmlNode(Node).Node.ChildNodes.Count;
    except
      Result := -1;
    end;
  end
  else if (TObject(Node) is TProfXmlNode2) then
  begin
    if Assigned(TProfXmlNode2(Node).Node) then
    try
      Result := TProfXmlNode2(Node).Node.ChildNodes.Count;
    except
      Result := -1;
    end
    else
    begin
      Nodes := TProfXmlNode2(Node).GetChildNodes();
      Result := AXmlNodeList_GetCount(Nodes);
      Exit;
    end;
  end
  else
    Result := -1;
end;

function AXmlNode_GetChildNodes(Node: AXmlNode): AXmlNodeList;
begin
  if (TObject(Node) is TProfXmlNode1) then
    Result := TProfXmlNode1(Node).GetChildNodes()
  else if (TObject(Node) is TProfXmlNode) then
    Result := 0 //TProfXmlNode(Node).GetChildNodes()
  else
    Result := 0;
end;

function AXmlNode_GetCollection(Node: AXmlNode): AXmlNodeCollection;
begin
  if (TObject(Node) is TProfXmlNode1) then
    Result := TProfXmlNode1(Node).Get_Collection()
  else
    Result := 0;
end;

function AXmlNode_GetDocument(Node: AXmlNode): AXmlDocument;
begin
  if (TObject(Node) is TProfXmlNode1) then
    Result := TProfXmlNode1(Node).Document.GetSelf()
  else
    Result := 0;
end;

function AXmlNode_GetName(Node: AXmlNode): APascalString;
begin
  if (TObject(Node) is TProfXmlNode1) then
    Result := TProfXmlNode1(Node).GetName()
  else if (TObject(Node) is TProfXmlNode2) then
    Result := TProfXmlNode2(Node).GetName()
  else
    Result := '';
end;

function AXmlNode_GetNameAndAttributes(Node: AXmlNode; const Value: APascalString): AError;
begin
  if (TObject(Node) is TProfXmlNode2) then
  begin
    TProfXmlNode2(Node).GetNameAndAttributes(Value);
    Result := 0;
  end
  else
    Result := -1;
end;

function AXmlNode_GetValueAsBool(Node: AXmlNode; out Value: ABoolean): AError;
var
  V: WordBool;
begin
  if (Node = 0) then
  begin
    Result := -2;
    Exit;
  end;
  if (TObject(Node) is TProfXmlNode1) then
  begin
    if Assigned(TProfXmlNode1(Node).Node) then
    begin
      V := Value;
      if ProfXmlNode_GetValueAsBool(TProfXmlNode1(Node).Node, V) then
      begin
        Value := V;
        Result := 0;
      end
      else
        Result := -4;
    end
    else
    begin
      Value := (TProfXmlNode1(Node).ValueStr = 'True');
      Result := 0;
    end;
  end
  else if (TObject(Node) is TProfXmlNode) then
  begin
    V := Value;
    if ProfXmlNode_GetValueAsBool(TProfXmlNode(Node).Node, V) then
    begin
      Value := V;
      Result := 0;
    end
    else
      Result := -3;
  end
  else
    Result := -3;
end;

function AXmlNode_GetValueAsDateTime(Node: AXmlNode; out Value: TDateTime): AError;
begin
  if (Node = 0) then
  begin
    Result := -2;
    Exit;
  end;
  if (TObject(Node) is TProfXmlNode1) then
  begin
    if TProfXmlNode1(Node).GetValueAsDateTime(Value) then
      Result := 0
    else
      Result := -4;
  end
  else
    Result := -3;
end;

function AXmlNode_GetValueAsInt(Node: AXmlNode; out Value: AInt): AError;
begin
  if (Node = 0) then
  begin
    Result := -2;
    Exit;
  end;
  if (TObject(Node) is TProfXmlNode1) then
  begin
    if TProfXmlNode1(Node).GetValueAsInteger(Value) then
      Result := 0
    else
      Result := -4;
  end
  else
    Result := -3;
end;

function AXmlNode_GetValueAsInt32(Node: AXmlNode; out Value: AInt32): AError;
begin
  if (Node = 0) then
  begin
    Result := -2;
    Exit;
  end;
  if (TObject(Node) is TProfXmlNode1) then
  begin
    if TProfXmlNode1(Node).GetValueAsInt32(Value) then
      Result := 0
    else
      Result := -4;
  end
  else
    Result := -3;
end;

function AXmlNode_GetValueAsInt64(Node: AXmlNode; out Value: AInt64): AError;
begin
  if (Node = 0) then
  begin
    Result := -2;
    Exit;
  end;
  if (TObject(Node) is TProfXmlNode1) then
  begin
    if TProfXmlNode1(Node).GetValueAsInt64(Value) then
      Result := 0
    else
      Result := -4;
  end
  else
    Result := -3;
end;

function AXmlNode_GetValueAsString(Node: AXmlNode; out Value: APascalString): AError;
var
  V: WideString;
begin
  if (Node = 0) then
  begin
    Result := -2;
    Exit;
  end;
  if (TObject(Node) is TProfXmlNode1) then
  begin
    if Assigned(TProfXmlNode1(Node).Node) then
    begin
      V := Value;
      if ProfXmlNode_GetValueAsString(TProfXmlNode1(Node).Node, V) then
      begin
        Value := V;
        Result := 0;
      end
      else
        Result := -4;
    end
    else
    begin
      Value := TProfXmlNode1(Node).ValueStr;
      Result := 0;
    end;
  end
  else
    Result := -3;
end;

function AXmlNode_GetValueAsUInt08(Node: AXmlNode; out Value: AUInt08): AError;
begin
  if (Node = 0) then
  begin
    Result := -2;
    Exit;
  end;
  if (TObject(Node) is TProfXmlNode1) then
  begin
    if TProfXmlNode1(Node).GetValueAsUInt08(Value) then
      Result := 0
    else
      Result := -4;
  end
  else
    Result := -3;
end;

function AXmlNode_GetValueAsUInt64(Node: AXmlNode; out Value: AUInt64): AError;
var
  Code: Integer;
begin
  if (Node = 0) then
  begin
    Result := -2;
    Exit;
  end;
  if (TObject(Node) is TProfXmlNode1) then
  begin
    if Assigned(TProfXmlNode1(Node).Node) then
    try
      Value := TProfXmlNode1(Node).Node.NodeValue;
      Result := 0;
    except
      Result := -4;
    end
    else
    begin
      Val(TProfXmlNode1(Node).ValueStr, Value, Code);
      if (Code = 0) then
        Result := 0
      else
        Result := -4;
    end;
  end
  else
    Result := -3;
end;

function AXmlNode_GetXml(Node: AXmlNode): APascalString;
begin
  if (TObject(Node) is TProfXmlNode1) then
    Result := TProfXmlNode1(Node).GetXml()
  else
    Result := '';
end;

function AXmlNode_GetXmlA(Node: AXmlNode; const Prefix: APascalString): APascalString;
begin
  if (TObject(Node) is TProfXmlNode1) then
    Result := TProfXmlNode1(Node).GetXmlA('')
  else
    Result := '';
end;

function AXmlNode_Free(Node: AXmlNode): AError;
begin
  if (TObject(Node) is TProfXmlNode1) then
  begin
    TProfXmlNode1(Node).Free();
    Result := 0;
  end
  else
    Result := -1;
end;

function AXmlNode_ReadBool(Node: AXmlNode; const Name: APascalString;
    out Value: ABoolean): AError;
var
  Node1: AProfXmlNode;
  V: WordBool;
  Res: ABoolean;
  Nodes: AXmlNodeList;
begin
  if (TObject(Node) is TProfXmlNode1) then
  begin
    if Assigned(TProfXmlNode1(Node).Node) then
    begin
      V := Value;
      Res := ProfXmlNode_ReadBool(TProfXmlNode1(Node).Node, Name, V);
      Value := V;
      if Res then
        Result := 0
      else
        Result := -3;
    end
    else
    begin
      Nodes := AXmlNode_GetChildNodes(Node);
      if (Nodes = 0) then
      begin
        Result := -2;
        Exit;
      end;
      Node1 := AXmlNodeList_FindNode(Nodes, Name);
      if (Node1 = 0) then
      begin
        Result := -3;
        Exit;
      end;
      Result := AXmlNode_GetValueAsBool(Node1, Value);
    end;
  end
  else if (TObject(Node) is TProfXmlNode) then
  begin
    V := Value;
    Res := ProfXmlNode_ReadBool(TProfXmlNode(Node).Node, Name, V);
    Value := V;
    if Res then
      Result := 0
    else
      Result := -3;
  end
  else
    Result := -2;
end;

function AXmlNode_ReadBoolDef(Node: AXmlNode; const Name: APascalString;
    DefValue: ABoolean): ABoolean;
begin
  Result := DefValue;
  AXmlNode_ReadBool(Node, Name, Result);
end;

function AXmlNode_ReadDateTime(Node: AXmlNode; const Name: APascalString;
    out Value: TDateTime): AError;
var
  S: APascalString;
  Node1: AProfXmlNode;
  Nodes: AXmlNodeList;
begin
  if (TObject(Node) is TProfXmlNode1) then
  begin
    if Assigned(TProfXmlNode(Node).Node) then
    begin
      if ProfXmlNode_ReadDateTime(TProfXmlNode(Node).Node, Name, Value) then
        Result := 0
      else
        Result := -3;
    end
    else
    begin
      Nodes := AXmlNode_GetChildNodes(Node);
      if (Nodes <> 0) then
      begin
        Node1 := AXmlNodeList_FindNode(Nodes, Name);
        if (Node1 = 0) then
        begin
          Result := -3;
          Exit;
        end;
        Result := AXmlNode_GetValueAsDateTime(Node1, Value);
      end
      else
      begin
        if (AXmlNode_ReadString(Node, Name, S) < 0) then
        begin
          Result := -3;
          Exit;
        end;
        try
          Value := StrToDateTime(S);
          Result := 0;
        except
          Result := -4;
        end;
      end;
    end;
  end
  else if (TObject(Node) is TProfXmlNode) then
  begin
    if ProfXmlNode_ReadDateTime(TProfXmlNode(Node).Node, Name, Value) then
      Result := 0
    else
      Result := -3;
  end
  else
    Result := -2;
end;

function AXmlNode_ReadDateTimeDef(Node: AXmlNode; const Name: APascalString;
    DefValue: TDateTime): TDateTime;
begin
  Result := DefValue;
  AXmlNode_ReadDateTime(Node, Name, Result);
end;

function AXmlNode_ReadFloat32(Node: AXmlNode; const Name: APascalString;
    var Value: AFloat32): AError;
var
  F64: AFloat64;
begin
  if (TObject(Node) is TProfXmlNode1) then
  begin
    if Assigned(TProfXmlNode1(Node).Node) then
    begin
      if ProfXmlNode_ReadFloat32(TProfXmlNode1(Node).Node, Name, Value) then
        Result := 0
      else
        Result := -3;
    end
    else
    begin
      F64 := Value;
      Result := AXmlNode_ReadFloat64(Node, Name, F64);
      Value := F64;
    end;
  end
  else if (TObject(Node) is TProfXmlNode) then
  begin
    if ProfXmlNode_ReadFloat32(TProfXmlNode(Node).Node, Name, Value) then
      Result := 0
    else
      Result := -3;
  end
  else
    Result := -2;
end;

function AXmlNode_ReadFloat64(Node: AXmlNode; const Name: APascalString;
    out Value: AFloat64): AError;
var
  Code: Integer;
  S: APascalString;
begin
  if (TObject(Node) is TProfXmlNode1) then
  begin
    if Assigned(TProfXmlNode(Node).Node) then
    begin
      if ProfXmlNode_ReadFloat64(TProfXmlNode(Node).Node, Name, Value) then
        Result := 0
      else
        Result := -3;
    end
    else
    begin
      if (AXmlNode_ReadString(Node, Name, S) < 0) then
      begin
        Result := -2;
        Exit;
      end;
      Val(S, Value, Code);
      if (Code = 0) then
        Result := 0
      else
        Result := -3;
    end;
  end
  else if (TObject(Node) is TProfXmlNode) then
  begin
    if ProfXmlNode_ReadFloat64(TProfXmlNode(Node).Node, Name, Value) then
      Result := 0
    else
      Result := -3;
  end
  else
    Result := -2;
end;

function AXmlNode_ReadFloat64Def(Node: AXmlNode; const Name: APascalString;
    DefValue: AFloat64): AFloat64;
begin
  Result := DefValue;
  AXmlNode_ReadFloat64(Node, Name, Result);
end;

function AXmlNode_ReadInt(Node: AXmlNode; const Name: APascalString;
    var Value: AInt): AError;
var
  Node1: AProfXmlNode;
  Nodes: AXmlNodeList;
begin
  if (TObject(Node) is TProfXmlNode1) then
  begin
    if Assigned(TProfXmlNode1(Node).Node) then
    begin
      if ProfXmlNode_ReadInt(TProfXmlNode1(Node).Node, Name, Value) then
        Result := 0
      else
        Result := -3;
    end
    else
    begin
      Nodes := AXmlNode_GetChildNodes(Node);
      Node1 := AXmlNodeList_FindNode(Nodes, Name);
      if (Node1 = 0) then
      begin
        Result := -4;
        Exit;
      end;
      Result := AXmlNode_GetValueAsInt(Node1, Value);
    end;
  end
  else if (TObject(Node) is TProfXmlNode) then
  begin
    if ProfXmlNode_ReadInt(TProfXmlNode(Node).Node, Name, Value) then
      Result := 0
    else
      Result := -3;
  end
  else
    Result := -2;
end;

function AXmlNode_ReadInt32(Node: AXmlNode; const Name: APascalString;
    out Value: AInt32): AError;
begin
  if (TObject(Node) is TProfXmlNode1) then
    Result := AXmlNode_ReadInt(Node, Name, Value)
  else if (TObject(Node) is TProfXmlNode) then
  begin
    if ProfXmlNode_ReadInt32(TProfXmlNode(Node).Node, Name, Value) then
      Result := 0
    else
      Result := -3;
  end
  else
    Result := -2;
end;

function AXmlNode_ReadInt32Def(Node: AXmlNode; const Name: APascalString;
    DefValue: AInt32): AInt32;
begin
  Result := DefValue;
  AXmlNode_ReadInt32(Node, Name, Result);
  {if (TObject(Node) is TProfXmlNode1) then
    Result := ProfXmlNode_ReadInt32Def(TProfXmlNode1(Node).Node, Name, DefValue)
  else if (TObject(Node) is TProfXmlNode) then
  begin
    Result := DefValue;
    AXmlNode_ReadInt32(Node, Name, Result);
  end
  else
    Result := DefValue;}
end;

function AXmlNode_ReadInt64(Node: AXmlNode; const Name: APascalString;
    out Value: AInt64): AError;
begin
  if (TObject(Node) is TProfXmlNode) then
  begin
    if ProfXmlNode_ReadInt64(TProfXmlNode(Node).Node, Name, Value) then
      Result := 0
    else
      Result := -3;
  end
  else
    Result := -2;
end;

function AXmlNode_ReadInt64Def(Node: AXmlNode; const Name: APascalString;
    DefValue: AInt64): AInt64;
begin
  Result := DefValue;
  AXmlNode_ReadInt64(Node, Name, Result);
end;

function AXmlNode_ReadString(Node: AXmlNode; const Name: APascalString;
    out Value: APascalString): AError;
var
  Node1: AProfXmlNode;
  Nodes: AXmlNodeList;
  Res: WordBool;
  V: WideString;
begin
  if (TObject(Node) is TProfXmlNode1) then
  begin
    if Assigned(TProfXmlNode1(Node).Node) then
    begin
      V := Value;
      Res := ProfXmlNode_ReadString(TProfXmlNode1(Node).Node, Name, V);
      Value := V;
      if Res then
        Result := 0
      else
        Result := -3;
    end
    else
    begin
      Nodes := AXmlNode_GetChildNodes(Node);
      Node1 := AXmlNodeList_FindNode(Nodes, Name);
      Result := AXmlNode_GetValueAsString(Node1, Value);
    end;
  end
  else if (TObject(Node) is TProfXmlNode) then
  begin
    V := Value;
    Res := ProfXmlNode_ReadString(TProfXmlNode(Node).Node, Name, V);
    Value := V;
    if Res then
      Result := 0
    else
      Result := -3;
  end
  else
    Result := -2;
end;

function AXmlNode_ReadStringDef(Node: AXmlNode; const Name,
    DefValue: APascalString): APascalString;
begin
  Result := DefValue;
  AXmlNode_ReadString(Node, Name, Result);
end;

function AXmlNode_SetDocument(Node: AXmlNode; Document: AXmlDocument): AError;
begin
  if (TObject(Node) is TProfXmlNode1) then
  begin
    TProfXmlNode1(Node).SetDocument_Priv(Document);
    Result := 0;
  end
  else
    Result := -1;
end;

function AXmlNode_SetName(Node: AXmlNode; const Name: APascalString): AError;
begin
  if (TObject(Node) is TProfXmlNode1) then
  begin
    TProfXmlNode1(Node).SetName(Name);
    Result := 0;
  end
  else
    Result := -1;
end;

function AXmlNode_SetValueAsBool(Node: AXmlNode; Value: ABoolean): AError;
begin
  if (TObject(Node) is TProfXmlNode2) then
  begin
    if TProfXmlNode2(Node).SetValueAsBool(Value) then
      Result := 0
    else
      Result := -1;
  end
  else
    Result := -2;
end;

function AXmlNode_SetValueAsFloat64(Node: AXmlNode; Value: AFloat64): AError;
begin
  if (TObject(Node) is TProfXmlNode2) then
  begin
    if TProfXmlNode2(Node).SetValueAsFloat64(Value) then
      Result := 0
    else
      Result := -1;
  end
  else
    Result := -2;
end;

function AXmlNode_SetValueAsInt32(Node: AXmlNode; Value: AInt32): AError;
begin
  if (TObject(Node) is TProfXmlNode2) then
  begin
    if TProfXmlNode2(Node).SetValueAsInt32(Value) then
      Result := 0
    else
      Result := -1;
  end
  else
    Result := -2;
end;

function AXmlNode_SetValueAsString(Node: AXmlNode; const Value: APascalString): AError;
var
  N1: TProfXmlNode1;
begin
  if (TObject(Node) is TProfXmlNode1) then
  begin
    N1 := TProfXmlNode1(Node);
    if Assigned(N1.Node) then
      N1.Node.NodeValue := Value
    else
      N1.ValueStr := Value;
    Result := 0;
  end
  else
    Result := -2;
end;

function AXmlNode_SetXml(Node: AXmlNode; const S: APascalString): AError;
begin
  if TProfXmlNode1(Node).SetXml(S) then
    Result := 0
  else
    Result := -1;
end;

function AXmlNode_SetXmlA(Node: AXmlNode; var Value: APascalString; const CloseTag: APascalString): AError;
var
  V: WideString;
  Res: WordBool;
begin
  V := Value;
  Res := TProfXmlNode2(Node).ReadNodes(V, CloseTag);
  Value := V;
  if Res then
    Result := 0
  else
    Result := -1;
end;

function AXmlNode_WriteBool(Node: AXmlNode; const Name: APascalString; Value: ABool): AError;
var
  Nodes: AXmlNodeList;
  N: AXmlNode;
begin
  if (TObject(Node) is TProfXmlNode) then
  begin
    if ProfXmlNode_WriteBool(TProfXmlNode(Node).Node, Name, Value) then
      Result := 0
    else
      Result := -3;
  end
  else if (TObject(Node) is TProfXmlNode1) then
  begin
    if Assigned(TProfXmlNode1(Node).Node) then
    begin
      if ProfXmlNode_WriteBool(TProfXmlNode1(Node).Node, Name, Value) then
        Result := 0
      else
        Result := -3;
    end
    else
    begin
      Nodes := AXmlNode_GetChildNodes(Node);
      N := AXmlNodeList_GetNodeByName1(Nodes, Name);
      Result := AXmlNode_SetValueAsBool(N, Value);
    end;
  end
  else
    Result := -2;
end;

function AXmlNode_WriteInt(Node: AXmlNode; const Name: APascalString; Value: AInt): AError;
var
  Nodes: AXmlNodeList;
  N: AXmlNode;
begin
  if (TObject(Node) is TProfXmlNode) then
  begin
    if ProfXmlNode_WriteInt(TProfXmlNode(Node).Node, Name, Value) then
      Result := 0
    else
      Result := -3;
  end
  else if (TObject(Node) is TProfXmlNode1) then
  begin
    if Assigned(TProfXmlNode1(Node).Node) then
    begin
      if ProfXmlNode_WriteInt(TProfXmlNode1(Node).Node, Name, Value) then
        Result := 0
      else
        Result := -3;
    end
    else
    begin
      Nodes := AXmlNode_GetChildNodes(Node);
      N := AXmlNodeList_GetNodeByName1(Nodes, Name);
      Result := AXmlNode_SetValueAsInt32(N, Value);
    end;
  end
  else
    Result := -2;
end;

function AXmlNode_WriteString(Node: AXmlNode; const Name, Value: APascalString): AError;
var
  N1: TProfXmlNode1;
  Child: AXmlNode;
begin
  if (TObject(Node) is TProfXmlNode1) then
  begin
    N1 := TProfXmlNode1(Node);
    if Assigned(N1.Node) then
    begin
      if ProfXmlNode_WriteString(N1.Node, Name, Value) then
        Result := 0
      else
        Result := -3;
    end
    else
    begin
      if (Name = '') then
      begin
        Result := -4;
        Exit;
      end;
      Child := AXmlNode_GetChildNodeByName(Node, Name);
      Result := AXmlNode_SetValueAsString(Child, Value);
    end;
  end
  else
    Result := -2;
end;

// --- AXmlNode0 ---

function AXmlNode0_New(): AXmlNode;
begin
  Result := AXmlNode(AXmlNodeImpl.TProfXmlNode.Create());
end;

// --- AXmlNode1 ---

function AXmlNode1_New(Document: AXmlDocument): AXmlNode;
//function AXmlNode_New(Document: AXmlDocument): AXmlNode;
begin
  Result := AXmlNode(TProfXmlNode1.Create1(Document));
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
