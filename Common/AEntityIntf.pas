{**
@Abstract Сушность. Общий интерфейс для все элементов
@Author Prof1983 <prof1983@ya.ru>
@Created 25.02.2007
@LastMod 04.02.2013
}
unit AEntityIntf;

interface

uses
  ABase, ATypes;

type //** Сущность - базовый интерфейс для представления знаний
  IAEntity = interface
      {** Возвращает идентификатор сущности }
    function GetId(): TAId;
      {** Возвращает идентификатор сущности }
    function GetEntityId(): TAId;
      {** Возвращает тип сущности (TProfEntityType) }
    function GetEntityType(): TAId;
      {** Задает тип сущности }
    procedure SetEntityType(Value: TAId);

      {** Идентификатор. Только для чтения.
          Идентификатор залается при создании сущности и не меняется.
          Аналоги:
            org.framerd.OID.OID }
    property Id: TAId read GetId;
      {** Идентификатор. Только для чтения.
          Идентификатор залается при создании сущности и не меняется.
          Аналоги:
            org.framerd.OID.OID }
    property EntityId: TAId read GetEntityId;
      {** Тип сущности. Номера от 0 до 1023 заререзвированы. (TProfEntityType)
          Аналоги:
            aterm.ATermAppl.AFun
            org.framerd.FDType.TypeName }
    property EntityType: TAId read GetEntityType write SetEntityType;
  end;

  {** Именованая сущность }
  IANamedEntity = interface(IAEntity)
    {** Возвращает имя }
    function GetName(): WideString;
    {** Задает имя }
    procedure SetName(const Value: WideString);

    {** Имя сущности
        Имя. Имя используется как идентификатор для OWL объектов.
        Аналоги:
          aterm.ATerm.Name }
    property Name: WideString read GetName write SetName;
  end;

type
  IProfEntities = interface(IANamedEntity)
    //** Возвращает элемент по ID
    function GetByID(ID: Int64): IANamedEntity; safecall;
    //** Возвращает элемент по индексу
    function GetByIndex(Index: Integer): IANamedEntity; safecall;
    //** Элемент по имени
    function GetByName(const Name: WideString): IANamedEntity; safecall;

    function Add(Entity: IANamedEntity): Integer; safecall;
    function Delete(Index: Integer): Integer; safecall;
    function Insert(Index: Integer; Entity: IANamedEntity): Integer; safecall;

    //** Элемент по ID
    property ById[ID: Int64]: IANamedEntity read GetByID;
    //** Элемент по индексу
    property ByIndex[Index: Integer]: IANamedEntity read GetByIndex;
    //** Элемент по имени
    property ByName[const Name: WideString]: IANamedEntity read GetByName;
  end;

implementation

end.
