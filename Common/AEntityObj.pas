{**
@Abstract(Сущность)
@Author(Prof1983 prof1983@ya.ru)
@Created(11.05.2007)
@LastMod(21.06.2012)
@Version(0.5)
}
unit AEntityObj;

interface

uses
  ABase;

type
  TAEntityObject = class
  protected
    FEntityId: TAId;
    FEntityType: TAId;
  public
    constructor Create(EntityId, EntityType: TAId);
  public
    // TODO: Убрать "write FEntityId"
    property EntityId: TAId read FEntityId write FEntityId;
    property EntityType: TAId read FEntityType;
  end;
  //TAEntity = TAEntityObject;

implementation

{ TAEntity }

constructor TAEntityObject.Create(EntityId, EntityType: TAId);
begin
  inherited Create();
  FEntityId := EntityId;
  FEntityType := EntityType;
end;

end.
