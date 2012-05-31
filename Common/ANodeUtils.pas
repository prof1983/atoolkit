{**
@Abstract(Общие интерфейсы для всех проектов)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.02.2007)
@LastMod(26.04.2012)
@Version(0.5)

История версий
0.0.2.0 - 03.06.2007 - Сделал IProfNodes наследником от IProfCollection
}
unit ANodeUtils;

interface

uses
  AAttributesIntf, AEntityIntf, ANodeIntf;

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
  TmpNode: IProfNode;
begin
  Result := False;
  if not(Assigned(Node)) then Exit;
  try
    TmpNode := Node.ChildNodes.GetNodeByName(Name);
    if not(Assigned(TmpNode)) then Exit;
    Result := Node_AsInt(TmpNode, Value);
  except
  end;
end;

function Node_ReadInt32Def(Node: IProfNode; const Name: WideString; DefValue: Integer): Integer;
var
  TmpNode: IProfNode;
begin
  Result := DefValue;
  if not(Assigned(Node)) then Exit;
  try
    TmpNode := Node.ChildNodes.GetNodeByName(Name);
    if not(Assigned(TmpNode)) then Exit;
    Result := Node_AsInt32Def(TmpNode, DefValue);
  except
  end;
end;

end.
