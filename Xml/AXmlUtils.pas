{**
@abstract(ProfXml)
@author(Prof1983 prof1983@ya.ru)
@created(15.02.2012)
@lastmod(06.07.2012)
@version(0.5)
}
unit AXmlUtils;

interface

uses
  ComObj, SysUtils, Variants, XmlDoc, XmlDom, XmlIntf,
  ABase, ATypes;

function ProfXmlNode_GetAttribute(Node: IXmlNode; const AttrName: DOMString): OleVariant;
function ProfXmlNode_GetNodeByName(ANode: IXmlNode; const AName: WideString): IXmlNode;
function ProfXmlNode_GetValueAsBool(ANode: IXmlNode; var Value: WordBool): WordBool;
function ProfXmlNode_GetValueAsDateTime(ANode: IXmlNode; var Value: TDateTime): WordBool;
function ProfXmlNode_GetValueAsFloat32(ANode: IXmlNode; var Value: Float32): WordBool;
function ProfXmlNode_GetValueAsFloat64(ANode: IXmlNode; var Value: Float64): WordBool;
function ProfXmlNode_GetValueAsInt32(ANode: IXmlNode; var Value: Int32): WordBool;
function ProfXmlNode_GetValueAsInt64(ANode: IXmlNode; var Value: Int64): WordBool;
function ProfXmlNode_GetValueAsString(ANode: IXmlNode; var Value: WideString): WordBool;
function ProfXmlNode_ReadBool(ANode: IXmlNode; const AName: WideString; var Value: WordBool): WordBool;
function ProfXmlNode_ReadBoolDef(ANode: IXmlNode; const AName: WideString; ADef: WordBool): WordBool;
function ProfXmlNode_ReadDateTime(ANode: IXmlNode; const AName: WideString; var Value: TDateTime): WordBool;
function ProfXmlNode_ReadDateTimeDef(ANode: IXmlNode; const AName: WideString; ADef: TDateTime): TDateTime;
function ProfXmlNode_ReadFloat32(Node: IXmlNode; const Name: WideString; var Value: Float32): WordBool;
function ProfXmlNode_ReadFloat64(Node: IXmlNode; const Name: WideString; var Value: Float64): WordBool;
function ProfXmlNode_ReadFloatDef(ANode: IXmlNode; const AName: WideString; ADef: Float64): Float64;
function ProfXmlNode_ReadInt(Node: IXmlNode; const Name: WideString; var Value: Integer): WordBool;
function ProfXmlNode_ReadInt32(ANode: IXmlNode; const AName: WideString; var Value: Int32): WordBool;
function ProfXmlNode_ReadInt32Def(ANode: IXmlNode; const AName: WideString; ADef: Int32): Int32;
function ProfXmlNode_ReadInt64(Node: IXmlNode; const Name: APascalString; var Value: Int64): WordBool;
function ProfXmlNode_ReadString(ANode: IXmlNode; const AName: WideString; var Value: WideString): WordBool;
function ProfXmlNode_WriteBool(ANode: IXmlNode; const AName: WideString; Value: WordBool): WordBool;
function ProfXmlNode_WriteDateTime(ANode: IXmlNode; const AName: APascalString; Value: TDateTime): ABoolean;
function ProfXmlNode_WriteFloat64(ANode: IXmlNode; const AName: WideString; Value: Float64): WordBool;
function ProfXmlNode_WriteInt(ANode: IXmlNode; const AName: WideString; Value: Integer): WordBool;
function ProfXmlNode_WriteInt32(ANode: IXmlNode; const AName: WideString; Value: Integer): WordBool;
function ProfXmlNode_WriteInt64(ANode: IXmlNode; const AName: APascalString; Value: AInt64): ABoolean;
function ProfXmlNode_WriteString(ANode: IXmlNode; const AName, Value: WideString): WordBool;

implementation

{ Public }

function ProfXmlNode_GetAttribute(Node: IXmlNode; const AttrName: DOMString): OleVariant;
begin
  if not(Assigned(Node)) then
  begin
    Result := NULL;
    Exit;
  end;
  Result := Node.Attributes[AttrName];
end;

function ProfXmlNode_GetNodeByName(ANode: IXmlNode; const AName: WideString): IXmlNode;
var
  Node: IXmlNode;
begin
  Result := nil;
  if not(Assigned(ANode)) then Exit;
  // Поиск XML нода
  Node := ANode.ChildNodes.FindNode(AName);
  // Если нету - создание XML нода
  if not(Assigned(Node)) then
    Node := ANode.AddChild(AName);
  Result := Node as IXmlNode;
end;

function ProfXmlNode_GetValueAsBool(ANode: IXmlNode; var Value: WordBool): WordBool;
begin
  Result := Assigned(ANode);
  if not(Result) then Exit;
  Result := False;
  try
    case VarType(ANode.NodeValue) of
      varBoolean:
        Value := ANode.NodeValue;
    else
      Value := StrToBool(ANode.NodeValue);
    end;
  except
    Result := False;
  end;
end;

function ProfXmlNode_GetValueAsDateTime(ANode: IXmlNode; var Value: TDateTime): WordBool;
begin
  try
    Value := ANode.NodeValue;
    Result := True;
  except
    Result := False;
  end;
end;

function ProfXmlNode_GetValueAsFloat32(ANode: IXmlNode; var Value: Float32): WordBool;
var
  Code: Integer;
begin
  Result := Assigned(ANode);
  if not(Result) then Exit;
  try
    if (VarType(ANode.NodeValue) = varSingle) then
    begin
      Value := ANode.NodeValue;
    end
    else if (VarType(ANode.NodeValue) = varString) or (VarType(ANode.NodeValue) = varOleStr) then
    begin
      Val(ANode.NodeValue, Value, Code);
      Result := (Code = 0);
    end
    else
      Result := False;
  except
    Result := False;
  end;
end;

function ProfXmlNode_GetValueAsFloat64(ANode: IXmlNode; var Value: Float64): WordBool;
var
  Code: Integer;
begin
  Result := Assigned(ANode);
  if not(Result) then Exit;
  try
    if (VarType(ANode.NodeValue) = varDouble) then
    begin
      Value := ANode.NodeValue;
    end
    else if (VarType(ANode.NodeValue) = varString) or (VarType(ANode.NodeValue) = varOleStr) then
    begin
      Val(ANode.NodeValue, Value, Code);
      Result := (Code = 0);
    end
    else
      Result := False;
  except
    Result := False;
  end;
end;

function ProfXmlNode_GetValueAsInt32(ANode: IXmlNode; var Value: Int32): WordBool;
var
  Code: Integer;
begin
  Result := Assigned(ANode);
  if not(Result) then Exit;
  try
    if (VarType(ANode.NodeValue) = varInteger) then
    begin
      Value := ANode.NodeValue;
    end
    else if (VarType(ANode.NodeValue) = varString) or (VarType(ANode.NodeValue) = varOleStr) then
    begin
      Val(ANode.NodeValue, Value, Code);
      Result := (Code = 0);
    end
    else
      Result := False;
  except
    Result := False;
  end;
end;

function ProfXmlNode_GetValueAsInt64(ANode: IXmlNode; var Value: Int64): WordBool;
begin
  try
    Value := ANode.NodeValue;
    Result := True;
  except
    Result := False;
  end;
end;

function ProfXmlNode_GetValueAsString(ANode: IXmlNode; var Value: WideString): WordBool;
begin
  Result := Assigned(ANode);
  if not(Result) then Exit;
  try
    if (VarType(ANode.NodeValue) = varString) or (VarType(ANode.NodeValue) = varOleStr) then
    begin
      Value := ANode.NodeValue;
      Result := True;
    end
    else
      Result := False;
  except
    Result := False;
  end;
end;

function ProfXmlNode_ReadBool(ANode: IXmlNode; const AName: WideString; var Value: WordBool): WordBool;
var
  Node: IXmlNode;
begin
  if not(Assigned(ANode)) then
  begin
    Result := False;
    Exit;
  end;
  Node := ANode.ChildNodes.FindNode(AName);
  if not(Assigned(Node)) then
  begin
    Result := False;
    Exit;
  end;
  Result := ProfXmlNode_GetValueAsBool(Node, Value);
end;

function ProfXmlNode_ReadBoolDef(ANode: IXmlNode; const AName: WideString; ADef: WordBool): WordBool;
begin
  Result := ADef;
  ProfXmlNode_ReadBool(ANode, AName, Result);
end;

function ProfXmlNode_ReadDateTime(ANode: IXmlNode; const AName: WideString; var Value: TDateTime): WordBool;
var
  S: WideString;
begin
  Result := ProfXmlNode_ReadString(ANode, AName, S);
  if not(Result) then Exit;
  try
    Value := StrToDateTime(S);
    Result := True;
  except
    Result := False;
  end;
end;

function ProfXmlNode_ReadDateTimeDef(ANode: IXmlNode; const AName: WideString; ADef: TDateTime): TDateTime;
begin
  Result := ADef;
  ProfXmlNode_ReadDateTime(ANode, AName, Result);
end;

function ProfXmlNode_ReadFloat32(Node: IXmlNode; const Name: WideString; var Value: Float32): WordBool;
var
  Node1: IXmlNode;
begin
  if not(Assigned(Node)) then
  begin
    Result := False;
    Exit;
  end;
  try
    Node1 := Node.ChildNodes.FindNode(Name);
    if not(Assigned(Node1)) then
    begin
      Result := False;
      Exit;
    end;
    Result := ProfXmlNode_GetValueAsFloat32(Node1, Value);
  except
    Result := False;
  end;
end;

function ProfXmlNode_ReadFloat64(Node: IXmlNode; const Name: WideString; var Value: Float64): WordBool;
var
  Node1: IXmlNode;
begin
  if not(Assigned(Node)) then
  begin
    Result := False;
    Exit;
  end;
  try
    Node1 := Node.ChildNodes.FindNode(Name);
    if not(Assigned(Node1)) then
    begin
      Result := False;
      Exit;
    end;
    Result := ProfXmlNode_GetValueAsFloat64(Node1, Value);
  except
    Result := False;
  end;
end;

function ProfXmlNode_ReadFloatDef(ANode: IXmlNode; const AName: WideString; ADef: Float64): Float64;
begin
  Result := ADef;
  ProfXmlNode_ReadFloat64(ANode, AName, Result);
end;

function ProfXmlNode_ReadInt(Node: IXmlNode; const Name: WideString; var Value: Integer): WordBool;
var
  Node1: IXmlNode;
  Code: Integer;
begin
  try
    Node1 := Node.ChildNodes.FindNode(Name);
    if not(Assigned(Node1)) then
    begin
      Result := False;
      Exit;
    end;
    if (VarType(Node1.NodeValue) = varInteger) then
    begin
      Value := Node1.NodeValue;
    end
    else if (VarType(Node1.NodeValue) = varString) or (VarType(Node1.NodeValue) = varOleStr) then
    begin
      Val(Node1.NodeValue, Value, Code);
      Result := (Code = 0);
    end
    else
      Result := False;
  except
    Result := False;
  end
end;

function ProfXmlNode_ReadInt32(ANode: IXmlNode; const AName: WideString; var Value: Int32): WordBool;
var
  Node: IXmlNode;
begin
  Result := Assigned(ANode);
  if not(Result) then Exit;
  try
    Node := ANode.ChildNodes.FindNode(AName);
    Result := Assigned(Node);
    if not(Result) then Exit;
    Result := ProfXmlNode_GetValueAsInt32(Node, Value);
  except
    Result := False;
  end;
end;

function ProfXmlNode_ReadInt32Def(ANode: IXmlNode; const AName: WideString; ADef: Int32): Int32;
var
  Value: Int32;
begin
  if ProfXmlNode_ReadInt32(ANode, AName, Value) then
    Result := Value
  else
    Result := ADef;
end;

function ProfXmlNode_ReadInt64(Node: IXmlNode; const Name: APascalString; var Value: Int64): WordBool;
var
  Node1: IXmlNode;
begin
  if not(Assigned(Node)) then
  begin
    Result := False;
    Exit;
  end;
  try
    Node1 := Node.ChildNodes.FindNode(Name);
    if not(Assigned(Node1)) then
    begin
      Result := False;
      Exit;
    end;
    Result := ProfXmlNode_GetValueAsInt64(Node1, Value);
  except
    Result := False;
  end;
end;

function ProfXmlNode_ReadString(ANode: IXmlNode; const AName: WideString; var Value: WideString): WordBool;
var
  Node: IXmlNode;
begin
  Result := Assigned(ANode);
  if not(Result) then Exit;
  Node := ANode.ChildNodes.FindNode(AName);
  Result := Assigned(Node);
  if not(Result) then Exit;
  Result := ProfXmlNode_GetValueAsString(Node, Value);
end;

function ProfXmlNode_WriteBool(ANode: IXmlNode; const AName: WideString; Value: WordBool): WordBool;
var
  Node: IXmlNode;
begin
  Result := Assigned(ANode);
  if not(Result) then Exit;
  try
    Node := ANode.ChildNodes.FindNode(AName);
    if Assigned(Node) then
      Node.NodeValue := Value
    else
      ANode.AddChild(AName).NodeValue := Value;
    Result := True;
  except
    Result := False;
  end;
end;

function ProfXmlNode_WriteDateTime(ANode: IXmlNode; const AName: APascalString; Value: TDateTime): ABoolean;
var
  Node: IXmlNode;
begin
  Result := Assigned(ANode);
  if not(Result) then Exit;
  try
    Node := ANode.ChildNodes.FindNode(AName);
    if Assigned(Node) then
      Node.NodeValue := Value
    else
      ANode.AddChild(AName).NodeValue := Value;
    Result := True;
  except
    Result := False;
  end;
end;

function ProfXmlNode_WriteFloat64(ANode: IXmlNode; const AName: WideString; Value: Float64): WordBool;
var
  Node: IXmlNode;
begin
  Result := Assigned(ANode);
  if not(Result) then Exit;
  try
    Node := ANode.ChildNodes.FindNode(AName);
    if Assigned(Node) then
      Node.NodeValue := Value
    else
      ANode.AddChild(AName).NodeValue := Value;
    Result := True;
  except
    Result := False;
  end;
end;

function ProfXmlNode_WriteInt(ANode: IXmlNode; const AName: WideString; Value: Integer): WordBool;
begin
  Result := ProfXmlNode_WriteInt32(ANode, AName, Value);
end;

function ProfXmlNode_WriteInt32(ANode: IXmlNode; const AName: WideString; Value: Integer): WordBool;
var
  Node: IXmlNode;
begin
  Result := Assigned(ANode);
  if not(Result) then Exit;
  try
    Node := ANode.ChildNodes.FindNode(AName);
    if Assigned(Node) then
      Node.NodeValue := Value
    else
      ANode.AddChild(AName).NodeValue := Value;
    Result := True;
  except
    Result := False;
  end;
end;

function ProfXmlNode_WriteInt64(ANode: IXmlNode; const AName: APascalString; Value: AInt64): ABoolean;
var
  Node: IXmlNode;
begin
  Result := Assigned(ANode);
  if not(Result) then Exit;
  try
    Node := ANode.ChildNodes.FindNode(AName);
    if Assigned(Node) then
      Node.NodeValue := Value
    else
      ANode.AddChild(AName).NodeValue := Value;
    Result := True;
  except
    Result := False;
  end;
end;

function ProfXmlNode_WriteString(ANode: IXmlNode; const AName, Value: WideString): WordBool;
var
  Node: IXmlNode;
begin
  Result := Assigned(ANode);
  if not(Result) then Exit;
  try
    Node := ANode.ChildNodes.FindNode(AName);
    if Assigned(Node) then
      Node.NodeValue := Value
    else
      ANode.AddChild(AName).NodeValue := Value;
    Result := True;
  except
    Result := False;
  end;
end;

end.
