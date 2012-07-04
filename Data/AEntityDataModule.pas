{**
@Abstract(Модуль данных сущностей)
@Author(Prof1983 prof1983@ya.ru)
@Created(19.03.2008)
@LastMod(04.07.2012)
@Version(0.5)

Элементарной (атомарной) единицей данных является сущность (Entity).
}
unit AEntityDataModule;

interface

uses
  ABase, AEntityObj, AIteratorIntf;

type
  //** @abstract(Модуль данных сущностей)
  TAEntityDataModule = class
  private
    FEntities: array of TAEntityObject;
  public
    function GetEntityByID(Id: AId): TAEntityObject;
    function GetEntityByIndex(Index: AInt): TAEntityObject;
    function GetEntityType(Id: AId): AId;
    // TODO: Реализовать
    //function GetEntityDataSize(ID: TADI): Integer;
    //function GetEntityData(ID: TAID; Size: Integer; P: Pointer): Integer;
  public
    // TODO: Удалить
    //** Добавляет сущьность в базу, присваевае уникальный идентификатор.
    //function AddEntity(Entity: TAEntity): TAID;
    //** Возвращяет True, если идентификатор не занят.
    function IsFree(Id: AId): ABoolean;
    //** Создает новую сущность
    function NewEntity(EntityType: AId): AId;
    //** Возвращяет итератор сущностей с помощью которого можно сделать выборку сущностей определенного типа.
    function Select(EntityType: AId): IAIterator;
  end;

implementation

type
  TAEntityIterator = class(TInterfacedObject, IAIterator)
  private
    FDataModule: TAEntityDataModule;
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
    property DataModule: TAEntityDataModule read FDataModule write FDataModule;
  end;

{ TARDataModule }

{function TADataModule.AddEntity(Entity: TAEntity): AId;
begin
  Result := Length(FEntities);
  SetLength(FEntities, Result + 1);
  FEntities[Result] := Entity;
  Result := Result + 65536;
  Entity.EntityID := Result;
end;}

function TAEntityDataModule.GetEntityByID(Id: AId): TAEntityObject;
begin
  Result := GetEntityByIndex(ID - 65536);
end;

function TAEntityDataModule.GetEntityByIndex(Index: Integer): TAEntityObject;
begin
  if (Index >= 0) and (Index < Length(FEntities)) then
    Result := FEntities[Index]
  else
    Result := nil;
end;

function TAEntityDataModule.GetEntityType(Id: AId): AId;
var
  e: TAEntityObject;
begin
  e := GetEntityById(Id);
  if Assigned(e) then
    Result := e.EntityType
  else
    Result := 0;
end;

function TAEntityDataModule.IsFree(Id: AId): Boolean;
begin
  // Идентификаторы 0..65535 зарезервированы под системные
  if (ID < 65536) then
  begin
    Result := False;
    Exit;
  end;
  Result := not(Assigned(GetEntityByID(Id)));
end;

function TAEntityDataModule.NewEntity(EntityType: AId): AId;
var
  index: Integer;
begin
  index := Length(FEntities);
  SetLength(FEntities, index + 1);
  Result := index + 65536;
  FEntities[index] := TAEntityObject.Create(Result, EntityType);
end;

function TAEntityDataModule.Select(EntityType: AId): IAIterator;
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
  FNextId := 1;
end;

function TAEntityIterator.HasNext(): ABoolean;
begin
  Result := False;
end;

function TAEntityIterator.Insert(Element: AId): ABoolean;
begin
  Result := False;
end;

function TAEntityIterator.IsEmpty(): ABoolean;
begin
  Result := True;
end;

function TAEntityIterator.Next(): AId;
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

function TAEntityIterator.Remove(): ABoolean;
begin
  Result := False;
end;

end.
