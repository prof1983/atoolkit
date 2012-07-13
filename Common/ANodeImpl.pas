{**
@Abstract(Interface IProfNode implementation)
@Author(Prof1983 <prof1983@ya.ru>)
@Created(11.04.2007)
@LastMod(13.07.2012)

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
  {** Реализация интерфейса IProfNode }
  TANode = class(TANamedEntity, IProfNode)
  protected
    FAttributes: IProfAttributes;
    FChildNodes: AXmlNodeList{IProfNodes};
  protected
    function GetAttributes(): IProfAttributes; safecall;
    function GetChildNodes(): AXmlNodeList;
  public
    procedure AfterConstruction(); override;
  public
    property Attributes: IProfAttributes read GetAttributes;
    property ChildNodes: AXmlNodeList read GetChildNodes;
  end;
  TProfNode = TANode;

implementation

uses
  ANodesImpl;

{ TProfNode }

procedure TANode.AfterConstruction();
begin
  inherited;
  FAttributes := nil;
  FChildNodes := 0;
end;

function TANode.GetAttributes(): IProfAttributes;
begin
  if not(Assigned(FAttributes)) then
    FAttributes := TProfAttributes3.Create();
  Result := FAttributes;
end;

function TANode.GetChildNodes(): AXmlNodeList;
begin
  if (FChildNodes = 0) then
    FChildNodes := AXmlNodeList(TProfNodes3.Create());
  Result := FChildNodes;
end;

end.
