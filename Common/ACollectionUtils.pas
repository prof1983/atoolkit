{**
@Abstract(ACollection util functions)
@Author(Prof1983 prof1983@ya.ru)
@Created(08.06.2012)
@LastMod(08.06.2012)
@Version(0.5)
}
unit ACollectionUtils;

interface

uses
  ABaseTypes, ACollectionImpl;

function ACollection_New(): ACollection;

implementation

function ACollection_New(): ACollection;
begin
  Result := ACollection(TACollection.Create());
end;

end.
