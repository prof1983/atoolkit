{**
@abstract AIterator functions
@author Prof1983 <prof1983@ya.ru>
@created 19.07.2012
@lastmod 19.07.2012
}
unit AIteratorUtils;

interface

uses
  ABase, AEntityDataModule;

function AIterator_New(List: TAEntityList; EntityType: AId): AIterator;

implementation

uses
  AIteratorImpl;

function AIterator_New(List: TAEntityList; EntityType: AId): AIterator;
var
  Iterator: TAIterator;
begin
  Iterator := TAIterator.Create();
  Iterator.EntityType := EntityType;
  Iterator.DataModule := List;
  Result := AIterator(Iterator);
end;

end.
