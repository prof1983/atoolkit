{**
@Abstract Entity list
@Author Prof1983 <prof1983@ya.ru>
@Created 19.03.2008
@LastMod 05.02.2013
}
unit AEntityDataModule;

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
  public
    //** Return True, if identifier is free
    function IsFree(Id: AId): ABoolean;
    function NewEntity(EntityType: AId): AId;
    function Select(EntityType: AId): AIterator;
  end;

implementation

uses
  AIteratorUtils;

{ TAEntityList }

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
  // Id 0..65535 reserved for system
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
