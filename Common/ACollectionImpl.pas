{**
@Abstract(ACollection interface implementation)
@Author(Prof1983 prof1983@ya.ru)
@Created(08.06.2012)
@LastMod(08.06.2012)
@Version(0.5)
}
unit ACollectionImpl;

interface

uses
  ACollectionIntf, AIteratorIntf;

type //** @abstract(Коллекция)
  TACollection = class(TInterfacedObject, IACollection)
  public
      //** Создает и возвращает итератор
    function GetIterator(): IAIterator;
  end;

implementation

{ TACollection }

function TACollection.GetIterator(): IAIterator;
begin
  Result := nil;
  // ...
end;

end.
