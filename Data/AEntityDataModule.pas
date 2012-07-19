{**
@abstract Entity list
@author Prof1983 <prof1983@ya.ru>
@created 19.03.2008
@lastmod 19.07.2012

Элементарной (атомарной) единицей данных является сущность (Entity).
}
unit AEntityDataModule;

// TODO: Rename to AEntityList.pas
// TODO: Move to At/Common

interface

uses
  ABase, AEntityObj, AIteratorIntf;

type
    //** @abstract Entity list
  TAEntityList = class
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
    function Select(EntityType: AId): AIterator;
  end;

  TAEntityDataModule = TAEntityList;

implementation

uses
  AIteratorUtils;

{ TAEntityList }

{function TAEntityList.AddEntity(Entity: TAEntity): AId;
begin
  Result := Length(FEntities);
  SetLength(FEntities, Result + 1);
  FEntities[Result] := Entity;
  Result := Result + 65536;
  Entity.EntityID := Result;
end;}

function TAEntityList.GetEntityByID(Id: AId): TAEntityObject;
begin
  Result := GetEntityByIndex(ID - 65536);
end;

function TAEntityList.GetEntityByIndex(Index: Integer): TAEntityObject;
begin
  if (Index >= 0) and (Index < Length(FEntities)) then
    Result := FEntities[Index]
  else
    Result := nil;
end;

function TAEntityList.GetEntityType(Id: AId): AId;
var
  e: TAEntityObject;
begin
  e := GetEntityById(Id);
  if Assigned(e) then
    Result := e.EntityType
  else
    Result := 0;
end;

function TAEntityList.IsFree(Id: AId): Boolean;
begin
  // Идентификаторы 0..65535 зарезервированы под системные
  if (ID < 65536) then
  begin
    Result := False;
    Exit;
  end;
  Result := not(Assigned(GetEntityByID(Id)));
end;

function TAEntityList.NewEntity(EntityType: AId): AId;
var
  index: Integer;
begin
  index := Length(FEntities);
  SetLength(FEntities, index + 1);
  Result := index + 65536;
  FEntities[index] := TAEntityObject.Create(Result, EntityType);
end;

function TAEntityList.Select(EntityType: AId): AIterator;
begin
  Result := AIterator_New(Self, EntityType);
end;

end.
