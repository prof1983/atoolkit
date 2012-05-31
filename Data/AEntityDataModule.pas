{**
@Abstract(Модуль данных сущностей)
@Author(Prof1983 prof1983@ya.ru)
@Created(19.03.2008)
@LastMod(23.04.2012)
@Version(0.5)

Элементарной (атомарной) единицей данных является сущность (Entity).
}
unit AEntityDataModule;

interface

uses
  ABase, AEntitiesBase, AEntity, AEntityIterator;

type
  //** @abstract(Модуль данных сущностей)
  TAEntityDataModule = class
  private
    FEntities: array of TAEntity;
  public
    function GetEntityByID(ID: TAID): TAEntity;
    function GetEntityByIndex(Index: Integer): TAEntity;
    function GetEntityType(ID: TAID): TAID;
    // TODO: Реализовать
    //function GetEntityDataSize(ID: TADI): Integer;
    //function GetEntityData(ID: TAID; Size: Integer; P: Pointer): Integer;
  public
    // TODO: Удалить
    //** Добавляет сущьность в базу, присваевае уникальный идентификатор.
    //function AddEntity(Entity: TAEntity): TAID;
    //** Возвращяет True, если идентификатор не занят.
    function IsFree(ID: TAID): Boolean;
    //** Создает новую сущность
    function NewEntity(EntityType: TAID): TAID;
    //** Возвращяет итератор сущностей с помощью которого можно сделать выборку сущностей определенного типа.
    function Select(EntityType: TAID): IAEntityIterator;
  end;

implementation

type
  TAEntityIterator = class(TInterfacedObject, IAEntityIterator)
  private
    FDataModule: TAEntityDataModule;
    FEntityType: TAID;
    FNextID: TAID;
  public
    constructor Create();
    function Next(): TAID;
  public
    property EntityType: TAID read FEntityType write FEntityType;
    property DataModule: TAEntityDataModule read FDataModule write FDataModule;
  end;

{ TARDataModule }

{function TADataModule.AddEntity(Entity: TAEntity): TAID;
begin
  Result := Length(FEntities);
  SetLength(FEntities, Result + 1);
  FEntities[Result] := Entity;
  Result := Result + 65536;
  Entity.EntityID := Result;
end;}

function TAEntityDataModule.GetEntityByID(ID: TAID): TAEntity;
begin
  Result := GetEntityByIndex(ID - 65536);
end;

function TAEntityDataModule.GetEntityByIndex(Index: Integer): TAEntity;
begin
  if (Index >= 0) and (Index < Length(FEntities)) then
    Result := FEntities[Index]
  else
    Result := nil;
end;

function TAEntityDataModule.GetEntityType(ID: TAID): TAID;
var
  e: TAEntity;
begin
  e := GetEntityByID(ID);
  if Assigned(e) then
    Result := e.EntityType
  else
    Result := 0;
end;

function TAEntityDataModule.IsFree(ID: TAID): Boolean;
begin
  // Идентификаторы 0..65535 зарезервированы под системные
  if (ID < 65536) then
  begin
    Result := False;
    Exit;
  end;
  Result := not(Assigned(GetEntityByID(ID)));
end;

function TAEntityDataModule.NewEntity(EntityType: TAID): TAID;
var
  index: Integer;
begin
  index := Length(FEntities);
  SetLength(FEntities, index + 1);
  Result := index + 65536;
  FEntities[index] := TAEntity.Create(Result, EntityType);
end;

function TAEntityDataModule.Select(EntityType: TAID): IAEntityIterator;
var
  iterator: TAEntityIterator;
begin
  iterator := TAEntityIterator.Create();
  iterator.EntityType := EntityType;
  iterator.DataModule := Self;
  Result := iterator;
end;

{ TAEntityIterator }

constructor TAEntityIterator.Create();
begin
  inherited;
  FNextID := 1;
end;

function TAEntityIterator.Next(): TAID;
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

end.
