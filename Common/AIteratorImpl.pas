{**
@abstract AIterator implementation
@author Prof1983 <prof1983@ya.ru>
@created 19.07.2012
@lastmod 19.07.2012
}
unit AIteratorImpl;

interface

uses
  ABase, AIteratorIntf, AEntityDataModule;

type
  TAIterator = class(TInterfacedObject, IAIterator)
  private
    FDataModule: TAEntityList;
    FEntityType: AId;
    FNextId: AId;
  public // IAIterator
    function HasNext(): ABoolean;
    function Insert(Element: AId): ABoolean;
    function IsEmpty(): ABoolean;
    function Next(): AId;
    function Remove(): ABoolean;
  public
    constructor Create();
  public
    property EntityType: AId read FEntityType write FEntityType;
    property DataModule: TAEntityList read FDataModule write FDataModule;
  end;

  TAEntityIterator = TAIterator;

implementation

{ TAIterator }

constructor TAIterator.Create();
begin
  inherited;
  FNextId := 1;
end;

function TAIterator.HasNext(): ABoolean;
begin
  Result := False;
end;

function TAIterator.Insert(Element: AId): ABoolean;
begin
  Result := False;
end;

function TAIterator.IsEmpty(): ABoolean;
begin
  Result := True;
end;

function TAIterator.Next(): AId;
begin
  while True do
  begin
    if FDataModule.IsFree(FNextID) then
    begin
      Result := 0;
      Exit;
    end;
    if (FDataModule.GetEntityType(FNextID) = FEntityType) then
    begin
      Result := FNextID;
      Inc(FNextID);
      Exit;
    end;
    Inc(FNextID);
  end;
end;

function TAIterator.Remove(): ABoolean;
begin
  Result := False;
end;

end.
