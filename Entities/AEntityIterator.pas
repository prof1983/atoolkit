{**
@Abstract(Итератор сущностей)
@Author(Prof1983 prof1983@ya.ru)
@Created(19.03.2008)
@LastMod(23.04.2011)
@Version(0.5)
}
unit AEntityIterator;

interface

uses
  ABase, AEntitiesBase;

type
  IAEntityIterator = interface
    function Next(): TAID;
  end;

{type
  TAEntityIterator = class // TODO: Добавить? (TInterfacedObject, IAEntityIterator)
    function Next(): TAID; virtual; abstract;
  end;}

implementation

end.
 