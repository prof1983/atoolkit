{**
@Abstract(ANode functions)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.02.2007)
@LastMod(12.07.2012)
@Version(0.5)
}
unit ANodeUtils;

interface

uses
  ABase, ANodeIntf, AXmlNodeListUtils, AXmlNodeUtils;

function Node_AsString(Node: IProfNode): WideString;
function Node_ReadInt(Node: IProfNode; const Name: WideString; var Value: Integer): Boolean;
function Node_ReadInt32Def(Node: IProfNode; const Name: WideString; DefValue: Integer): Integer;

implementation

function Node_AsInt(Node: IProfNode; var Value: Integer): Boolean;
var
  Code: Integer;
begin
  Result := False;
  if not(Assigned(Node)) then Exit;
  try
    {if (VarType(Node.NodeValue) = varInteger) then
    begin
      Value := Node.NodeValue;
    end
    else if (VarType(ANode.NodeValue) = varString) or (VarType(ANode.NodeValue) = varOleStr) then
    begin
      Val(ANode.NodeValue, Value, Code);
      Result := (Code = 0);
    end
    else
      Result := False;}
  except
  end;
end;

function Node_AsInt32Def(Node: IProfNode; DefValue: Integer): Integer;
var
  Code: Integer;
begin
  Result := DefValue;
  if not(Assigned(Node)) then Exit;
  try
    {if (VarType(Node.NodeValue) = varInteger) then
    begin
      Value := Node.NodeValue;
    end
    else if (VarType(ANode.NodeValue) = varString) or (VarType(ANode.NodeValue) = varOleStr) then
    begin
      Val(ANode.NodeValue, Value, Code);
      Result := (Code = 0);
    end
    else
      Result := False;}
  except
  end;
end;

function Node_AsString(Node: IProfNode): WideString;
begin
  Result := '';
end;

function Node_ReadInt(Node: IProfNode; const Name: WideString; var Value: Integer): Boolean;
var
  Nodes: AXmlNodeList;
  TmpNode: AXmlNode;
begin
  Result := False;
  if not(Assigned(Node)) then Exit;
  try
    Nodes := Node.GetChildNodes();
    TmpNode := AXmlNodeList_GetNodeByName1(Nodes, Name);
    Result := (AXmlNode_GetValueAsInt(TmpNode, Value) >= 0);
  except
  end;
end;

function Node_ReadInt32Def(Node: IProfNode; const Name: WideString; DefValue: Integer): Integer;
var
  Nodes: AXmlNodeList;
  TmpNode: AXmlNode;
  V: AInt;
begin
  if not(Assigned(Node)) then
  begin
    Result := DefValue;
    Exit;
  end;
  try
    Nodes := Node.GetChildNodes();
    TmpNode := AXmlNodeList_GetNodeByName1(Nodes, Name);
    if (AXmlNode_GetValueAsInt(TmpNode, V) >= 0) then
      Result := V
    else
      Result := DefValue;
  except
    Result := DefValue;
  end;
end;

end.
