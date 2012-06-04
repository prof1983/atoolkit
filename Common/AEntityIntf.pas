{**
@Abstract(Сушность. Общий интерфейс для все элементов)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.02.2007)
@LastMod(04.06.2012)
@Version(0.5)
}
unit AEntityIntf;

interface

uses
  ABase, ATypes;

type //** Сущность - базовый интерфейс для представления знаний
  IAEntity = interface
    //** Возвращает идентификатор сущности
    function GetId(): TAId;
    //** Возвращает идентификатор сущности
    function GetEntityId(): TAId;
    //** Возвращает тип сущности
    function GetEntityType(): TAId;
    //** Задает тип сущности
    procedure SetEntityType(Value: TAId);

    {**
      Идентификатор. Только для чтения.
      Идентификатор залается при создании сущности и не меняется.
      Агалоги:
        org.framerd.OID.OID
    }
    property Id: TAId read GetId;
    {**
      Идентификатор. Только для чтения.
      Идентификатор залается при создании сущности и не меняется.
      Агалоги:
        org.framerd.OID.OID
    }
    property EntityId: TAId read GetEntityId;
    {**
      Тип сущности. Номера от 0 до 1023 заререзвированы.
      Аналоги:
        aterm.ATermAppl.AFun
        org.framerd.FDType.TypeName
    }
    property EntityType: TAId read GetEntityType write SetEntityType;
  end;

type //** Сушность. Общий интерфейс для все элементов.
  IProfEntity = interface
      //** Возвращает тип сущности
    function GetEntityType(): TProfEntityType; safecall;
      //** Возвращает идентификатор сущности
    function GetId(): Int64; safecall;
      //** Возвращает имя
    function GetName(): WideString; safecall;
      //** Задать имя
    procedure SetName(const Value: WideString); safecall;

      {**
        Добавляет лог-сообщение.
        @returns(Возвращает номер добавленого лог-сообщения или 0)
      }
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage;
        const AStrMsg: WideString): Integer;

      //** Тип сущности
    property EntityType: TProfEntityType read GetEntityType;
      //** Идентификатор
    property Id: Int64 read GetId;
      //** Имя
    property Name: WideString read GetName write SetName;
  end;

type // Именованая сушность
  IProfNamedEntity = IProfEntity;

type
  IProfEntities = interface(IProfEntity)
    //** Возвращает элемент по ID
    function GetByID(ID: Int64): IProfEntity; safecall;
    //** Возвращает элемент по индексу
    function GetByIndex(Index: Integer): IProfEntity; safecall;
    //** Элемент по имени
    function GetByName(const Name: WideString): IProfEntity; safecall;

    function Add(Entity: IProfEntity): Integer; safecall;
    function Delete(Index: Integer): Integer; safecall;
    function Insert(Index: Integer; Entity: IProfEntity): Integer; safecall;
    //function New(const Name: WideString): IProfEntity; safecall;

    //** Элемент по ID
    property ByID[ID: Int64]: IProfEntity read GetByID;
    //** Элемент по индексу
    property ByIndex[Index: Integer]: IProfEntity read GetByIndex;
    //** Элемент по имени
    property ByName[const Name: WideString]: IProfEntity read GetByName;
  end;

implementation

end.
