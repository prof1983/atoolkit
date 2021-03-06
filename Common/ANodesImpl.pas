{**
@Author Prof1983 <prof1983@ya.ru>
@Created 15.04.2007
@LastMod 04.02.2013
}
unit ANodesImpl;

interface

uses
  ABase, AEntityImpl, ANodeIntf, ANodeImpl;

type
  TANodeList = class(TANamedEntity, IProfNodes)
  private
    FNodes: array of IProfNode;
  private
    function GetNodeById(Id: Int64): IProfNode; safecall;
    function GetNodeByIndex(Index: Integer): IProfNode; safecall;
    function GetNodeByName(const Name: WideString): IProfNode; safecall;
    function GetNodeCount(): Integer; safecall;
  public
    function Add(Node: IProfNode): Integer; virtual; safecall;
    function Delete(Index: Integer): Integer; virtual; safecall;
    function Insert(Index: Integer; Node: IProfNode): Integer; virtual; safecall;
    function LoadFromXml(const FileName: WideString): AError; deprecated;
    function New(const Name: WideString): IProfNode; virtual; safecall;
    function SaveToXml(const FileName: WideString): AError; deprecated;
  public
    property NodeById[Id: Int64]: IProfNode read GetNodeById;
    property NodeByIndex[Index: Integer]: IProfNode read GetNodeByIndex;
    property NodeByName[const Name: WideString]: IProfNode read GetNodeByName;
    property NodeCount: Integer read GetNodeCount;
  end;

implementation

{ TANodeList }

function TANodeList.Add(Node: IProfNode): Integer;
begin
  Result := Length(FNodes);
  SetLength(FNodes, Result + 1);
  FNodes[Result] := Node;
end;

function TANodeList.Delete(Index: Integer): Integer;
var
  i: Integer;
begin
  if (Index < 0) or (Index >= Length(FNodes)) then
  begin
    Result := -1;
    Exit;
  end;
  Result := 0;
  for i := Index to High(FNodes) - 1 do
    FNodes[i] := FNodes[i + 1];
  SetLength(FNodes, High(FNodes));
end;

function TANodeList.GetNodeById(Id: Int64): IProfNode;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to High(FNodes) do
    if FNodes[i].ID = ID then
    begin
      Result := FNodes[i];
      Exit;
    end;
end;

function TANodeList.GetNodeByIndex(Index: Integer): IProfNode;
begin
  Result := nil;
  if (Index >= 0) and (Index < Length(FNodes)) then
    Result := FNodes[Index];
end;

function TANodeList.GetNodeByName(const Name: WideString): IProfNode;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to High(FNodes) do
    if FNodes[i].Name = Name then
    begin
      Result := FNodes[i];
      Exit;
    end;
end;

function TANodeList.GetNodeCount(): Integer;
begin
  Result := Length(FNodes);
end;

function TANodeList.Insert(Index: Integer; Node: IProfNode): Integer;
var
  i: Integer;
begin
  Result := 0;
  SetLength(FNodes, Length(FNodes) + 1);
  for i := High(FNodes) - 1 downto Index do
    FNodes[i + 1] := FNodes[i];
  FNodes[Index] := Node;
end;

function TANodeList.LoadFromXml(const FileName: WideString): AError;
begin
  Result := -1;
  // ...
end;

function TANodeList.New(const Name: WideString): IProfNode;
begin
  Result := TANode.Create();
  Result.Name := Name;
  Self.Add(Result);
end;

function TANodeList.SaveToXml(const FileName: WideString): AError;
begin
  Result := -1;
  // ...
end;

end.
