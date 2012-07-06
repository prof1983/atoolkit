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
function ProfXmlNode_GetValueAsString(Node: IXmlNode; var Value: WideString): WordBool;
function ProfXmlNode_ReadBool(ANode: IXmlNode; const AName: WideString; var Value: WordBool): WordBool;
function ProfXmlNode_ReadBoolDef(ANode: IXmlNode; const AName: WideString; ADef: WordBool): WordBool;
function ProfXmlNode_ReadDateTime(ANode: IXmlNode; const AName: WideString; var Value: TDateTime): WordBool;
function ProfXmlNode_ReadDateTimeDef(ANode: IXmlNode; const AName: WideString; ADef: TDateTime): TDateTime;
function ProfXmlNode_ReadFloat32(Node: IXmlNode; const Name: WideString; var Value: Float32): WordBool;
function ProfXmlNode_ReadFloat64(Node: IXmlNode; const Name: WideString; var Value: Float64): WordBool;
function ProfXmlNode_ReadFloatDef(ANode: IXmlNode; const AName: WideString; ADef: Float64): Float64;
function ProfXmlNode_ReadInt(Node: IXmlNode; const Name: WideString; var Value: Integer): WordBool;
function ProfXmlNode_ReadInt32(Node: IXmlNode; const Name: WideString; var Value: Int32): WordBool;
function ProfXmlNode_ReadInt32Def(ANode: IXmlNode; const AName: WideString; ADef: Int32): Int32;
function ProfXmlNode_ReadInt64(Node: IXmlNode; const Name: APascalString; var Value: Int64): WordBool;
function ProfXmlNode_ReadInt64Def(Node: IXmlNode; const Name: APascalString; Def: AInt64): AInt64;
function ProfXmlNode_ReadString(Node: IXmlNode; const Name: WideString; var Value: WideString): WordBool;
function ProfXmlNode_ReadStringDef(Node: IXmlNode; const Name, Def: APascalString): APascalString;
function ProfXmlNode_WriteBool(Node: IXmlNode; const Name: APascalString; Value: ABool): ABool;
function ProfXmlNode_WriteDateTime(Node: IXmlNode; const Name: APascalString; Value: TDateTime): ABool;
function ProfXmlNode_WriteFloat32(Node: IXmlNode; const Name: APascalString; Value: AFloat32): ABool;
function ProfXmlNode_WriteFloat64(Node: IXmlNode; const Name: WideString; Value: Float64): WordBool;
function ProfXmlNode_WriteInt(Node: IXmlNode; const Name: APascalString; Value: AInt): WordBool;
function ProfXmlNode_WriteInt32(Node: IXmlNode; const Name: APascalString; Value: AInt): WordBool;
function ProfXmlNode_WriteInt64(Node: IXmlNode; const Name: APascalString; Value: AInt64): ABoolean;
function ProfXmlNode_WriteString(Node: IXmlNode; const Name, Value: APascalString): ABool;

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
  if not(Assigned(ANode)) then
  begin
    Result := False;
    Exit;
  end;
  try
    if (VarType(ANode.NodeValue) = varBoolean) then
      Value := ANode.NodeValue
    else
      Value := StrToBool(ANode.NodeValue);
    Result := True;
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
  if not(Assigned(ANode)) then
  begin
    Result := False;
    Exit;
  end;
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
  //Code: Integer;
  s: string;
begin
  if not(Assigned(ANode)) then
  begin
    Result := False;
    Exit;
  end;
  try
    if (VarType(ANode.NodeValue) = varDouble) then
    begin
      Value := ANode.NodeValue;
    end
    else if (VarType(ANode.NodeValue) = varString) or (VarType(ANode.NodeValue) = varOleStr) then
    begin
      s := ANode.NodeValue;
      Result := TryStrToFloat(s, Value);
      {Val(ANode.NodeValue, Value, Code);
      Result := (Code = 0);}
    end
    else
      Result := False;
  except
    Result := False;
  end;
end;

function ProfXmlNode_GetValueAsInt32(ANode: IXmlNode; var Value: Int32): WordBool;
var
  tmp: Int64;
begin
  tmp := Value;
  Result := ProfXmlNode_GetValueAsInt64(ANode, tmp);
  Value := tmp;
end;

function ProfXmlNode_GetValueAsInt64(ANode: IXmlNode; var Value: Int64): WordBool;
var
  Code: Integer;
begin
  if not(Assigned(ANode)) then
  begin
    Result := False;
    Exit;
  end;
  try
    if (VarType(ANode.NodeValue) = varInteger) or (VarType(ANode.NodeValue) = varInt64) then
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
  {try
    Value := ANode.NodeValue;
    Result := True;
  except
    Result := False;
  end;}
end;

function ProfXmlNode_GetValueAsString(Node: IXmlNode; var Value: WideString): WordBool;
var
  NodeValue: OleVariant;
begin
  if not(Assigned(Node)) then
  begin
    Result := False;
    Exit;
  end;
  try
    if not(Node.IsTextElement) then
    begin
      Result := False;
      Exit;
    end;
    NodeValue := Node.NodeValue;
    if (VarType(NodeValue) = varString) or (VarType(NodeValue) = varOleStr) then
    begin
      Value := NodeValue;
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

function ProfXmlNode_ReadInt32(Node: IXmlNode; const Name: WideString; var Value: Int32): WordBool;
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
    Result := ProfXmlNode_GetValueAsInt32(Node1, Value);
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

function ProfXmlNode_ReadInt64Def(Node: IXmlNode; const Name: APascalString; Def: AInt64): AInt64;
begin
  Result := Def;
  ProfXmlNode_ReadInt64(Node, Name, Result);
end;

function ProfXmlNode_ReadString(Node: IXmlNode; const Name: WideString; var Value: WideString): WordBool;
var
  Node1: IXmlNode;
begin
  if not(Assigned(Node)) then
  begin
    Result := False;
    Exit;
  end;
  Node1 := Node.ChildNodes.FindNode(Name);
  if not(Assigned(Node1)) then
  begin
    Result := False;
    Exit;
  end;
  Result := ProfXmlNode_GetValueAsString(Node1, Value);
end;

function ProfXmlNode_ReadStringDef(Node: IXmlNode; const Name, Def: APascalString): APascalString;
var
  V: WideString;
begin
  Result := Def;
  V := '';
  ProfXmlNode_ReadString(Node, Name, V);
  Result := V;
end;

function ProfXmlNode_WriteBool(Node: IXmlNode; const Name: APascalString; Value: ABool): ABool;
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
    if Assigned(Node1) then
      Node1.NodeValue := Value
    else
      Node.AddChild(Name).NodeValue := Value;
    Result := True;
  except
    Result := False;
  end;
end;

function ProfXmlNode_WriteDateTime(Node: IXmlNode; const Name: APascalString; Value: TDateTime): ABool;
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
    if Assigned(Node1) then
      Node1.NodeValue := Value
    else
      Node.AddChild(Name).NodeValue := Value;
    Result := True;
  except
    Result := False;
  end;
end;

function ProfXmlNode_WriteFloat32(Node: IXmlNode; const Name: APascalString; Value: AFloat32): ABool;
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
    if Assigned(Node1) then
      Node1.NodeValue := Value
    else
      Node.AddChild(Name).NodeValue := Value;
    Result := True;
  except
    Result := False;
  end;
end;

function ProfXmlNode_WriteFloat64(Node: IXmlNode; const Name: WideString; Value: Float64): WordBool;
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
    if Assigned(Node1) then
      Node1.NodeValue := Value
    else
      Node.AddChild(Name).NodeValue := Value;
    Result := True;
  except
    Result := False;
  end;
end;

function ProfXmlNode_WriteInt(Node: IXmlNode; const Name: APascalString; Value: AInt): WordBool;
begin
  Result := ProfXmlNode_WriteInt32(Node, Name, Value);
end;

function ProfXmlNode_WriteInt32(Node: IXmlNode; const Name: APascalString; Value: AInt): WordBool;
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
    if Assigned(Node1) then
      Node1.NodeValue := Value
    else
      Node.AddChild(Name).NodeValue := Value;
    Result := True;
  except
    Result := False;
  end;
end;

function ProfXmlNode_WriteInt64(Node: IXmlNode; const Name: APascalString; Value: AInt64): ABoolean;
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
    if Assigned(Node1) then
      Node1.NodeValue := Value
    else
      Node.AddChild(Name).NodeValue := Value;
    Result := True;
  except
    Result := False;
  end;
end;

function ProfXmlNode_WriteString(Node: IXmlNode; const Name, Value: APascalString): ABool;
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
    if not(Node.IsTextElement) then
    begin
      Result := False;
      Exit;
    end;
    if not(Assigned(Node1)) then
      Node1 := Node.AddChild(Name);
    Node1.NodeValue := Value;
    Result := True;
  except
    Result := False;
  end;
end;

end.
