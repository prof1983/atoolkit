{**
@Abstract(Реализация интерфейса IProfNode)
@Author(Prof1983 prof1983@ya.ru)
@Created(11.04.2007)
@LastMod(26.06.2012)
@Version(0.5)
}
unit ANodeImpl;

interface

uses
  AAttributesIntf, AAttributesImpl, AEntityImpl, ANodeIntf;

type //** Реализация интерфейса IProfNode
  TProfNode = class(TANamedEntity, IProfNode)
  protected
    FAttributes: IProfAttributes;
    FChildNodes: IProfNodes;
  protected
    function GetAttributes(): IProfAttributes; safecall;
    function GetChildNodes(): IProfNodes; safecall;
  public
    procedure AfterConstruction(); override;
  public
    property Attributes: IProfAttributes read GetAttributes;
    property ChildNodes: IProfNodes read GetChildNodes;
  end;
  TProfNode3 = TProfNode;

implementation

uses
  ANodesImpl;

{ TProfNode }

procedure TProfNode.AfterConstruction();
begin
  inherited;
  FAttributes := nil;
  FChildNodes := nil;
end;

function TProfNode.GetAttributes(): IProfAttributes;
begin
  if not(Assigned(FAttributes)) then
    FAttributes := TProfAttributes3.Create();
  Result := FAttributes;
end;

function TProfNode.GetChildNodes(): IProfNodes;
begin
  if not(Assigned(FChildNodes)) then
    FChildNodes := TProfNodes3.Create();
  Result := FChildNodes;
end;

end.
