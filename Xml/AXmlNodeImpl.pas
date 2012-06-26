{**
@Abstract(Класс работы с XML нодами)
@Author(Prof1983 prof1983@ya.ru)
@Created(07.03.2007)
@LastMod(26.06.2012)
@Version(0.5)
}
unit AXmlNodeImpl;

// TODO: Разделить на AXmlNodeObj и AXmlNodeImpl.

interface

uses
  SysUtils, Variants, XmlIntf,
  AAttributesIntf, AEntityImpl, ANodeIntf, ATypes, AXmlAttributesImpl;

type //** Класс работы с XML нодами
  TProfXmlNode = class(TANamedEntity, IProfNode)
  protected
    //** Объект работы с атрибутами
    FAttributes: TProfXmlAttributes;
    FNode: IXmlNode;
    FNodes: array of TProfXmlNode;
    procedure SetNode(Value: IXmlNode);
  protected
    function GetAsBool(): WordBool; safecall;
    function GetAsDateTime(): TDateTime; safecall;
    function GetAsFloat32(): Float32; safecall;
    function GetAsFloat64(): Float64; safecall;
    function GetAsInt32(): Integer; safecall;
    function GetAsInt64(): Int64; safecall;
    function GetAsString(): WideString; safecall;
  protected
    //** Возвращает объект работы с атрибутами
//    function GetAttributes(): IProfXmlAttributes; safecall;
    //** Получить вложеный нод по индесу
    function GetNodeByIndex(AIndex: Integer): IProfNode; safecall;
    //** Получить вложеный нод по имени
    function GetNodeByName(const AName: WideString): IProfNode; safecall;
    //** Возвращает колличество вложенных нодов
    function GetNodeCount(): Integer; safecall;
    //** Получить имя нода
    function GetNodeName(): WideString; safecall;
    function GetXmlString(): WideString; safecall;
    procedure SetXmlString(const Value: WideString); safecall;
  protected
    function GetAttributes(): IProfAttributes; safecall;
    function GetChildNodes(): IProfNodes; safecall;
  public
    class function GetValueAsBoolA(ANode: IXmlNode; var Value: WordBool): WordBool; safecall;
    class function GetValueAsDateTimeA(ANode: IXmlNode; var Value: TDateTime): WordBool; safecall;
    class function GetValueAsFloat32A(ANode: IXmlNode; var Value: Float32): WordBool; safecall;
    class function GetValueAsFloat64A(ANode: IXmlNode; var Value: Float64): WordBool; safecall;
    class function GetValueAsInt32A(ANode: IXmlNode; var Value: Integer): WordBool; safecall;
    class function GetValueAsInt64A(ANode: IXmlNode; var Value: Int64): WordBool; safecall;
    class function GetValueAsStringA(ANode: IXmlNode; var Value: WideString): WordBool; safecall;
  protected
    function GetValueAsBool(var Value: WordBool): WordBool; safecall;
    function GetValueAsDateTime(var Value: TDateTime): WordBool; safecall;
    function GetValueAsFloat32(var Value: Float32): WordBool; safecall;
    function GetValueAsFloat64(var Value: Float64): WordBool; safecall;
    function GetValueAsInt32(var Value: Integer): WordBool; safecall;
    function GetValueAsInt64(var AValue: Int64): WordBool; safecall;
    function GetValueAsString(var Value: WideString): WordBool; safecall;
  protected
    procedure SetAsString(const Value: WideString); safecall;
  protected
    function SetValueAsBool(Value: WordBool): WordBool; safecall;
    function SetValueAsFloat64(Value: Float64): WordBool; safecall;
    function SetValueAsInt32(AValue: Integer): WordBool; safecall;
    function SetValueAsString(const AValue: WideString): WordBool; safecall;
    function SetValueAsUInt08(AValue: Byte): WordBool; safecall;
  public
    class function ReadBoolA(ANode: IXmlNode; const AName: WideString; var Value: WordBool): WordBool; safecall;
    class function ReadDateTimeA(ANode: IXmlNode; const AName: WideString; var Value: TDateTime): WordBool; safecall;
    class function ReadFloat32A(ANode: IXmlNode; const AName: WideString; var Value: Float32): WordBool; safecall;
    class function ReadFloat64A(ANode: IXmlNode; const AName: WideString; var Value: Float64): WordBool; safecall;
    class function ReadInt32A(ANode: IXmlNode; const AName: WideString; var Value: Integer): WordBool; safecall;
    class function ReadInt64A(ANode: IXmlNode; const AName: WideString; var Value: Int64): WordBool; safecall;
    class function ReadStringA(ANode: IXmlNode; const AName: WideString; var Value: WideString): WordBool; safecall;
  public
    function ReadBool(const Name: WideString; var Value: WordBool): WordBool; safecall;
    function ReadBoolDef(const Name: WideString; DefValue: WordBool): WordBool; safecall;
    function ReadDateTime(const Name: WideString; var Value: TDateTime): WordBool; safecall;
    function ReadDateTimeDef(const Name: WideString; DefValue: TDateTime): TDateTime; safecall;
    function ReadFloat64(const Name: WideString; var Value: Double): WordBool; safecall;
    function ReadFloat64Def(const Name: WideString; DefValue: Double): Double; safecall;
    function ReadInt32(const Name: WideString; var Value: Integer): WordBool; safecall;
    function ReadInt32Def(const Name: WideString; DefValue: Integer): Integer; safecall;
    function ReadInt64(const Name: WideString; var Value: Int64): WordBool; safecall;
    function ReadInt64Def(const Name: WideString; DefValue: Int64): Int64; safecall;
    function ReadString(const Name: WideString; var Value: WideString): WordBool; safecall;
    function ReadStringDef(const Name: WideString; const DefValue: WideString): WideString; safecall;
  public
    class function WriteBoolA(ANode: IXmlNode; const AName: WideString; Value: WordBool): WordBool; safecall;
    class function WriteDateTimeA(ANode: IXmlNode; const AName: WideString; Value: TDateTime): WordBool; safecall;
    class function WriteFloat32A(ANode: IXmlNode; const AName: WideString; Value: Real): WordBool; safecall;
    class function WriteFloat64A(ANode: IXmlNode; const AName: WideString; Value: Double): WordBool; safecall;
    class function WriteInt32A(ANode: IXmlNode; const AName: WideString; Value: Integer): WordBool; safecall;
    class function WriteInt64A(ANode: IXmlNode; const AName: WideString; Value: Int64): WordBool; safecall;
    class function WriteStringA(ANode: IXmlNode; const AName, Value: WideString): WordBool; safecall;
  public
    function WriteBool(const AName: WideString; Value: WordBool): WordBool; safecall;
    function WriteDateTime(const AName: WideString; AValue: TDateTime): WordBool; safecall;
    function WriteFloat64(const AName: WideString; Value: Float64): WordBool; safecall;
    function WriteInt32(const AName: WideString; Value: Int32): WordBool; safecall;
    function WriteInt64(const AName: WideString; Value: Int64): WordBool; safecall;
    function WriteString(const AName, Value: WideString): WordBool; safecall;
    //function WriteXml(const AName, Value: WideString): WordBool; safecall;
  public
    constructor Create();
    procedure Free();
  public
    property AsString: WideString read GetAsString write SetAsString;
  public
    property Node: IXmlNode read FNode write SetNode;
    //** Вложеные ноды по индексу
    property NodeByIndex[Index: Integer]: IProfNode read GetNodeByIndex;
    //** Вложеные ноды по имени
    property NodeByName[const Name: WideString]: IProfNode read GetNodeByName;
    //** Колличество вложеных нодов
    property NodeCount: Integer read GetNodeCount;
    //** Имя нода
    property NodeName: WideString read GetNodeName;
  end;

implementation

{ TProfXmlNode }

constructor TProfXmlNode.Create();
begin
  inherited Create();
  FAttributes := TProfXmlAttributes.Create();
end;

procedure TProfXmlNode.Free();
var
  i: Integer;
begin
  for i := 0 to High(FNodes) do
    FNodes := nil;
  SetLength(FNodes, 0);
  FNode := nil;
end;

function TProfXmlNode.GetAsBool(): WordBool;
begin
  Result := False;
  GetValueAsBool(Result);
end;

function TProfXmlNode.GetAsDateTime(): TDateTime;
begin
  Result := 0;
  GetValueAsDateTime(Result);
end;

function TProfXmlNode.GetAsFloat32(): Float32;
begin
  Result := 0;
  GetValueAsFloat32(Result);
end;

function TProfXmlNode.GetAsFloat64(): Float64;
begin
  Result := 0;
  GetValueAsFloat64(Result);
end;

function TProfXmlNode.GetAsInt32(): Integer;
begin
  Result := 0;
  GetValueAsInt32(Result);
end;

function TProfXmlNode.GetAsInt64(): Int64;
begin
  Result := 0;
  GetValueAsInt64(Result);
end;

function TProfXmlNode.GetAsString(): WideString;
begin
  Result := '';
  GetValueAsString(Result);
end;

function TProfXmlNode.GetAttributes(): IProfAttributes;
begin
  Result := FAttributes;
end;

function TProfXmlNode.GetChildNodes(): IProfNodes;
begin
  Result := nil;
  // ...
end;

function TProfXmlNode.GetNodeByIndex(AIndex: Integer): IProfNode;
var
  i: Integer;
begin
  Result := nil;
  if Assigned(FNode) then
  try
    if (Length(FNodes) = 0) and (FNode.ChildNodes.Count > 0) then
    try
      // Заполнение FNodes
      SetLength(FNodes, FNode.ChildNodes.Count);
      for i := 0 to High(FNodes) do
      begin
        FNodes[i] := TProfXmlNode.Create();
        FNodes[i].SetNode(FNode.ChildNodes.Nodes[i]);
      end;
    except
      SetLength(FNodes, 0);
      Exit;
    end;
    if (AIndex >= 0) and (AIndex < Length(FNodes)) then
      Result := FNodes[AIndex];
  except
  end;
end;

function TProfXmlNode.GetNodeByName(const AName: WideString): IProfNode;
var
  i: Integer;
begin
  Result := nil;
  if Assigned(FNode) then
  try
    if (Length(FNodes) = 0) and (FNode.ChildNodes.Count > 0) then
    try
      // Заполнение FNodes
      SetLength(FNodes, FNode.ChildNodes.Count);
      for i := 0 to High(FNodes) do
      begin
        FNodes[i] := TProfXmlNode.Create();
        FNodes[i].SetNode(FNode.ChildNodes.Nodes[i]);
      end;
    except
      SetLength(FNodes, 0);
      Exit;
    end;
    for i := 0 to High(FNodes) do
      if FNodes[i].NodeName = AName then
      begin
        Result := FNodes[i];
        Exit;
      end;
  except
  end;
end;

function TProfXmlNode.GetNodeCount(): Integer;
begin
  Result := -1;
  if Assigned(FNode) then
  try
    Result := FNode.ChildNodes.Count;
  except
  end;
end;

function TProfXmlNode.GetNodeName(): WideString;
begin
  Result := '';
  if Assigned(FNode) then
  try
    Result := FNode.NodeName;
  except
  end;
end;

function TProfXmlNode.GetValueAsBool(var Value: WordBool): WordBool;
begin
  Result := GetValueAsBoolA(FNode, Value);
end;

class function TProfXmlNode.GetValueAsBoolA(ANode: IXmlNode; var Value: WordBool): WordBool;
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

function TProfXmlNode.GetValueAsDateTime(var Value: TDateTime): WordBool;
begin
  Result := GetValueAsDateTimeA(FNode, Value);
end;

class function TProfXmlNode.GetValueAsDateTimeA(ANode: IXmlNode; var Value: TDateTime): WordBool;
begin
  try
    Value := ANode.NodeValue;
  except
  end;
end;

function TProfXmlNode.GetValueAsFloat32(var Value: Float32): WordBool;
begin
  Result := GetValueAsFloat32A(FNode, Value);
end;

class function TProfXmlNode.GetValueAsFloat32A(ANode: IXmlNode; var Value: Float32): WordBool;
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

function TProfXmlNode.GetValueAsFloat64(var Value: Float64): WordBool;
begin
  Result := GetValueAsFloat64A(FNode, Value);
end;

class function TProfXmlNode.GetValueAsFloat64A(ANode: IXmlNode; var Value: Float64): WordBool;
var
  s: string;
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
      s := ANode.NodeValue;
      Result := TryStrToFloat(s, Value);
    end
    else
      Result := False;
  except
    Result := False;
  end;
end;

function TProfXmlNode.GetValueAsInt32(var Value: Integer): WordBool;
begin
  Result := GetValueAsInt32A(FNode, Value);
end;

class function TProfXmlNode.GetValueAsInt32A(ANode: IXmlNode; var Value: Integer): WordBool;
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

function TProfXmlNode.GetValueAsInt64(var AValue: Int64): WordBool;
begin
  Result := GetValueAsInt64A(FNode, AValue);
end;

class function TProfXmlNode.GetValueAsInt64A(ANode: IXmlNode; var Value: Int64): WordBool;
var
  tmp: Integer;
begin
  tmp := Value;
  Result := GetValueAsInt32A(ANode, tmp);
  Value := tmp;
end;

function TProfXmlNode.GetValueAsString(var Value: WideString): WordBool;
begin
  Result := GetValueAsStringA(FNode, Value);
end;

class function TProfXmlNode.GetValueAsStringA(ANode: IXmlNode; var Value: WideString): WordBool;
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

function TProfXmlNode.GetXmlString(): WideString;
begin
  if Assigned(FNode) then
  try
    Result := FNode.XML;
  except
  end;
end;

function TProfXmlNode.ReadBool(const Name: WideString; var Value: WordBool): WordBool;
begin
  Result := ReadBoolA(FNode, Name, Value);
end;

class function TProfXmlNode.ReadBoolA(ANode: IXmlNode; const AName: WideString; var Value: WordBool): WordBool;
var
  Node: IXmlNode;
begin
  Result := Assigned(ANode);
  if not(Result) then Exit;
  Node := ANode.ChildNodes.FindNode(AName);
  Result := Assigned(Node);
  if not(Result) then Exit;
  Result := GetValueAsBoolA(Node, Value);
end;

function TProfXmlNode.ReadBoolDef(const Name: WideString; DefValue: WordBool): WordBool;
begin
  Result := DefValue;
  ReadBool(Name, Result)
end;

function TProfXmlNode.ReadDateTime(const Name: WideString; var Value: TDateTime): WordBool;
begin
  Result := ReadDateTimeA(FNode, Name, Value);
end;

class function TProfXmlNode.ReadDateTimeA(ANode: IXmlNode; const AName: WideString; var Value: TDateTime): WordBool;
var
  S: WideString;
begin
  Result := ReadStringA(ANode, AName, S);
  if not(Result) then Exit;
  try
    Value := StrToDateTime(S);
    Result := True;
  except
    Result := False;
  end;
end;

function TProfXmlNode.ReadDateTimeDef(const Name: WideString; DefValue: TDateTime): TDateTime;
begin
  Result := DefValue;
  ReadDateTime(Name, Result);
end;

class function TProfXmlNode.ReadFloat32A(ANode: IXmlNode; const AName: WideString; var Value: Float32): WordBool;
var
  Node: IXmlNode;
begin
  Result := Assigned(ANode);
  if not(Result) then Exit;
  try
    Node := ANode.ChildNodes.FindNode(AName);
    Result := Assigned(Node);
    if not(Result) then Exit;
    Result := GetValueAsFloat32A(Node, Value);
  except
    Result := False;
  end;
end;

function TProfXmlNode.ReadFloat64(const Name: WideString; var Value: Double): WordBool;
begin
  Result := ReadFloat64A(FNode, Name, Value);
end;

class function TProfXmlNode.ReadFloat64A(ANode: IXmlNode; const AName: WideString; var Value: Float64): WordBool;
var
  Node: IXmlNode;
begin
  Result := Assigned(ANode);
  if not(Result) then Exit;
  try
    Node := ANode.ChildNodes.FindNode(AName);
    Result := Assigned(Node);
    if not(Result) then Exit;
    Result := GetValueAsFloat64A(Node, Value);
  except
    Result := False;
  end;
end;

function TProfXmlNode.ReadFloat64Def(const Name: WideString; DefValue: Double): Double;
begin
  Result := DefValue;
  ReadFloat64(Name, Result);
end;

function TProfXmlNode.ReadInt32(const Name: WideString; var Value: Integer): WordBool;
begin
  Result := ReadInt32A(FNode, Name, Value);
end;

class function TProfXmlNode.ReadInt32A(ANode: IXmlNode; const AName: WideString; var Value: Integer): WordBool;
var
  Node: IXmlNode;
begin
  Result := Assigned(ANode);
  if not(Result) then Exit;
  try
    Node := ANode.ChildNodes.FindNode(AName);
    Result := Assigned(Node);
    if not(Result) then Exit;
    Result := GetValueAsInt32A(Node, Value);
  except
    Result := False;
  end;
end;

function TProfXmlNode.ReadInt32Def(const Name: WideString; DefValue: Integer): Integer;
begin
  Result := DefValue;
  ReadInt32(Name, Result);
end;

function TProfXmlNode.ReadInt64(const Name: WideString; var Value: Int64): WordBool;
begin
  Result := ReadInt64A(FNode, Name, Value);
end;

class function TProfXmlNode.ReadInt64A(ANode: IXmlNode; const AName: WideString; var Value: Int64): WordBool;
var
  tmp: Integer;
begin
  tmp := Value;
  Result := ReadInt32A(ANode, AName, tmp);
  Value := tmp;
end;

function TProfXmlNode.ReadInt64Def(const Name: WideString; DefValue: Int64): Int64;
begin
  Result := DefValue;
  ReadInt64(Name, Result);
end;

function TProfXmlNode.ReadString(const Name: WideString; var Value: WideString): WordBool;
begin
  Result := ReadStringA(FNode, Name, Value);
end;

class function TProfXmlNode.ReadStringA(ANode: IXmlNode; const AName: WideString; var Value: WideString): WordBool;
var
  Node: IXmlNode;
begin
  Result := Assigned(ANode);
  if not(Result) then Exit;
  Node := ANode.ChildNodes.FindNode(AName);
  Result := Assigned(Node);
  if not(Result) then Exit;
  Result := GetValueAsStringA(Node, Value);
end;

function TProfXmlNode.ReadStringDef(const Name, DefValue: WideString): WideString;
begin
  Result := DefValue;
  ReadString(Name, Result);
end;

procedure TProfXmlNode.SetAsString(const Value: WideString);
begin
  // TODO: ...
end;

procedure TProfXmlNode.SetNode(Value: IXmlNode);
begin
  FNode := Value;
  FAttributes.Node := Value;
end;

function TProfXmlNode.SetValueAsBool(Value: WordBool): WordBool;
begin
  // TODO: ...
end;

function TProfXmlNode.SetValueAsFloat64(Value: Float64): WordBool;
begin
  // TODO: ...
end;

function TProfXmlNode.SetValueAsInt32(AValue: Integer): WordBool;
begin
  // TODO: ...
end;

function TProfXmlNode.SetValueAsString(const AValue: WideString): WordBool;
begin
  // TODO: ...
end;

function TProfXmlNode.SetValueAsUInt08(AValue: Byte): WordBool;
begin
  // TODO: ...
end;

procedure TProfXmlNode.SetXmlString(const Value: WideString);
begin
//  if Assigned(FNode) then
//  try
//    FNode.XML := Value;
//  except
//  end;
end;

function TProfXmlNode.WriteBool(const AName: WideString; Value: WordBool): WordBool;
begin
  Result := WriteBoolA(FNode, AName, Value);
end;

class function TProfXmlNode.WriteBoolA(ANode: IXmlNode; const AName: WideString; Value: WordBool): WordBool;
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

function TProfXmlNode.WriteDateTime(const AName: WideString; AValue: TDateTime): WordBool;
begin
  Result := WriteDateTimeA(FNode, AName, AValue);
end;

class function TProfXmlNode.WriteDateTimeA(ANode: IXmlNode; const AName: WideString; Value: TDateTime): WordBool;
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

class function TProfXmlNode.WriteFloat32A(ANode: IXmlNode; const AName: WideString; Value: Real): WordBool;
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

function TProfXmlNode.WriteFloat64(const AName: WideString; Value: Double): WordBool;
begin
  Result := WriteFloat64A(FNode, AName, Value);
end;

class function TProfXmlNode.WriteFloat64A(ANode: IXmlNode; const AName: WideString; Value: Double): WordBool;
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

function TProfXmlNode.WriteInt32(const AName: WideString; Value: Integer): WordBool;
begin
  Result := WriteInt32A(FNode, AName, Value);
end;

class function TProfXmlNode.WriteInt32A(ANode: IXmlNode; const AName: WideString; Value: Integer): WordBool;
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

function TProfXmlNode.WriteInt64(const AName: WideString; Value: Int64): WordBool;
begin
  Result := WriteInt64A(FNode, AName, Value);
end;

class function TProfXmlNode.WriteInt64A(ANode: IXmlNode; const AName: WideString; Value: Int64): WordBool;
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

function TProfXmlNode.WriteString(const AName, Value: WideString): WordBool;
begin
  Result := WriteStringA(FNode, AName, Value);
end;

class function TProfXmlNode.WriteStringA(ANode: IXmlNode; const AName, Value: WideString): WordBool;
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
