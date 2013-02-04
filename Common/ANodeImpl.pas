{**
@Abstract Interface IProfNode implementation
@Author Prof1983 <prof1983@ya.ru>
@Created 11.04.2007
@LastMod 04.02.2013

Uses
  @link AAttributesIntf
  @link AAttributesImpl
  @link ABase
  @link AEntityImpl
  @link ANodeIntf
}
unit ANodeImpl;

interface

uses
  AAttributesIntf, AAttributesImpl, ABase, AEntityImpl, ANodeIntf;

type
  TANode = class(TANamedEntity, IProfNode)
  protected
    FAttributes: IProfAttributes;
    FChildNodes: ANodeList;
  public
    function GetAttributes(): IProfAttributes; safecall;
    function GetChildNodes(): ANodeList;
    function Initialize(): AError; virtual;
  public
    constructor Create();
  public
    property Attributes: IProfAttributes read GetAttributes;
    property ChildNodes: ANodeList read GetChildNodes;
  end;
  //TProfNode = TANode;

implementation

uses
  ANodesImpl;

{ TANode }

constructor TANode.Create();
begin
  inherited Create();
  FAttributes := nil;
  FChildNodes := 0;
end;

function TANode.GetAttributes(): IProfAttributes;
begin
  if not(Assigned(FAttributes)) then
    FAttributes := TProfAttributes3.Create();
  Result := FAttributes;
end;

function TANode.GetChildNodes(): ANodeList;
begin
  if (FChildNodes = 0) then
    FChildNodes := AXmlNodeList(TANodeList.Create());
  Result := FChildNodes;
end;

function TANode.Initialize(): AError;
begin
  GetChildNodes();
  GetAttributes();
  Result := 0;
end;

end.
