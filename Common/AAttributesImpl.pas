{**
@Abstract(Аттрибуты)
@Author(Prof1983 prof1983@ya.ru)
@Created(15.04.2007)
@LastMod(26.04.2012)
@Version(0.5)
}
unit AAttributesImpl;

interface

uses
  AAttributeIntf, AAttributesIntf, AEntityImpl;

type //** Аттрибуты
  TProfAttributes3 = class(TProfEntity3, IProfAttributes)
  private
      //** Возвращает значение атрибута по индексу
    function GetAttributeById(Id: Int64): IProfAttribute; safecall;
      //** Возвращает имя атрибута по индексу
    function GetAttributeByIndex(Index: Integer): IProfAttribute; safecall;
      //** Вернуть значение атрибута по имени атрибута
    function GetAttributeByName(const Name: WideString): IProfAttribute; safecall;
  public
    function Add(Attribute: IProfAttribute): Integer; safecall;
    function Delete(Index: Integer): Integer; safecall;
    function Insert(Index: Integer; Attribute: IProfAttribute): Integer; safecall;
    function New(const Name: WideString; Value: OleVariant): IProfAttribute; safecall;
  public
      //** Атрибут по ID
    property AttributeByID[Id: Int64]: IProfAttribute read GetAttributeById;
      //** Атрибут по индексу
    property AttributeByIndex[Index: Integer]: IProfAttribute read GetAttributeByIndex;
      //** Атрибут по имени
    property AttributeByName[const Name: WideString]: IProfAttribute read GetAttributeByName;
  end;

implementation

{ TProfAttributes3 }

function TProfAttributes3.Add(Attribute: IProfAttribute): Integer;
begin
  Result := 0;
  // ...
end;

function TProfAttributes3.Delete(Index: Integer): Integer;
begin
  Result := 0;
  // ...
end;

function TProfAttributes3.GetAttributeById(Id: Int64): IProfAttribute;
begin
  Result := nil;
  // ...
end;

function TProfAttributes3.GetAttributeByIndex(Index: Integer): IProfAttribute;
begin
  Result := nil;
  // ...
end;

function TProfAttributes3.GetAttributeByName(const Name: WideString): IProfAttribute;
begin
  Result := nil;
  // ...
end;

function TProfAttributes3.Insert(Index: Integer; Attribute: IProfAttribute): Integer;
begin
  Result := 0;
  // ...
end;

function TProfAttributes3.New(const Name: WideString; Value: OleVariant): IProfAttribute;
begin
  Result := nil;
  // ...
end;

end.
