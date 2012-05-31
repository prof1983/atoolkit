{**
@Abstract(Общие интерфейсы для всех проектов)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.02.2007)
@LastMod(24.04.2012)
@Version(0.5)
}
unit AAttributesIntf;

interface

uses
  AAttributeIntf, AEntityIntf;

type //** Интерфейс работы с атрибутами XML. Пока не рекомендуется использовать.
  IProfAttributes = interface(IProfEntity)
      //** Возвращает значение атрибута по индексу
    function GetAttributeById(Id: Int64): IProfAttribute; safecall;
      //** Возвращает имя атрибута по индексу
    function GetAttributeByIndex(Index: Integer): IProfAttribute; safecall;
      //** Вернуть значение атрибута по имени атрибута
    function GetAttributeByName(const Name: WideString): IProfAttribute; safecall;

    function Add(Attribute: IProfAttribute): Integer; safecall;
    function Delete(Index: Integer): Integer; safecall;
    function Insert(Index: Integer; Attribute: IProfAttribute): Integer; safecall;
    function New(const Name: WideString; Value: OleVariant): IProfAttribute; safecall;

      //** Атрибут по Id
    property AttributeByID[Id: Int64]: IProfAttribute read GetAttributeById;
      //** Атрибут по индексу
    property AttributeByIndex[Index: Integer]: IProfAttribute read GetAttributeByIndex;
      //** Атрибут по имени
    property AttributeByName[const Name: WideString]: IProfAttribute read GetAttributeByName;
  end;

implementation

end.
