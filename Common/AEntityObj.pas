{**
@Abstract(Сущность)
@Author(Prof1983 prof1983@ya.ru)
@Created(11.05.2007)
@LastMod(08.06.2012)
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

// Базовые типы сущностей [0..1024]

const
  AINone           = 0; // нет записи
  AIType           = 1; // тип
const
  AIEmptyType      = 2; // Пусто
  AINullType       = 3; // Null
  AIBoolType       = 4; // Boolean
  AIIntType        = 5; // Целое
  AIFloatType      = 6; // Значение с плавающей точкой
  AIStringType     = 7; // строка
  AIDateTimeType   = 8; // дата/время
  AICollectionType = 9; // коллекция

implementation

{ TAEntity }

constructor TAEntityObject.Create(EntityId, EntityType: TAId);
begin
  inherited Create();
  FEntityId := EntityId;
  FEntityType := EntityType;
end;

end.
