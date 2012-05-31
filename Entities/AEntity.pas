{**
@Abstract(Сущность)
@Author(Prof1983 prof1983@ya.ru)
@Created(11.05.2007)
@LastMod(23.04.2012)
@Version(0.5)
}
unit AEntity;

interface

uses
  ABase, AEntitiesBase;

type
  TAEntity = class
  protected
    FEntityID: TAID;
    FEntityType: TAID;
  public
    constructor Create(EntityID, EntityType: TAID);
  public
    // TODO: Убрать "write FEntityID"
    property EntityID: TAID read FEntityID write FEntityID;
    property EntityType: TAID read FEntityType;
  end;

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

{ TEntity }

constructor TAEntity.Create(EntityID, EntityType: TAID);
begin
  inherited Create();
  FEntityID := EntityID;
  FEntityType := EntityType;
end;

end.
