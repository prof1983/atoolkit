{**
@Abstract(Класс работы с XML атрибутами)
@Author(Prof1983 prof1983@ya.ru)
@Created(11.03.2007)
@LastMod(26.06.2012)
@Version(0.5)
}
unit AXmlAttributesImpl;

interface

uses
  XmlIntf,
  AAttributeIntf, AAttributesIntf, AEntityImpl;

type //** @abstract(Класс работы с XML атрибутами)
  TProfXmlAttributes = class(TANamedEntity, IProfAttributes)
  private
    FNode: IXmlNode;
  protected
    function GetAttributeByID(ID: Int64): IProfAttribute; safecall;
    function GetAttributeByIndex(Index: Integer): IProfAttribute; safecall;
    function GetAttributeByName(const Name: WideString): IProfAttribute; safecall;

    //** Вернуть значение атрибута по имени атрибута
    function GetAttribute(const Name: WideString): WideString; safecall;
    //** Возвращает имя атрибута по индексу
    function GetAttributeName(Index: Integer): WideString; safecall;
    //** Возвращает значение атрибута по индексу
    function GetAttributeValue(Index: Integer): WideString; safecall;
    //** Установить/Создать атрибут
    procedure SetAttribute(const Name, Value: WideString); safecall;
  public
    function Add(Attribute: IProfAttribute): Integer; safecall;
    function Delete(Index: Integer): Integer; safecall;
    function Insert(Index: Integer; Attribute: IProfAttribute): Integer; safecall;
    function New(const Name: WideString; Value: OleVariant): IProfAttribute; safecall;
  public
    //** Значение атрибута по имени атрибута
    property Attributes[const Name: WideString]: WideString read GetAttribute write SetAttribute;
    //** Имя атрибута по индексу
    property AttributeName[Index: Integer]: WideString read GetAttributeName;
    //** Значение атрибута по индексу
    property AttributeValue[Index: Integer]: WideString read GetAttributeValue;
  public
    property Node: IXmlNode read FNode write FNode;
  end;

implementation

{ TProfXmlAttributes }

function TProfXmlAttributes.Add(Attribute: IProfAttribute): Integer;
begin
  Result := -1;
  // ...
end;

function TProfXmlAttributes.Delete(Index: Integer): Integer;
begin
  Result := -1;
  // ...
end;

function TProfXmlAttributes.GetAttribute(const Name: WideString): WideString;
begin
  Result := '';
  if Assigned(FNode) then
  try
    Result := FNode.Attributes[Name];
  except
  end;
end;

function TProfXmlAttributes.GetAttributeByID(ID: Int64): IProfAttribute;
begin
  Result := nil;
  // ...
end;

function TProfXmlAttributes.GetAttributeByIndex(Index: Integer): IProfAttribute;
begin
  Result := nil;
  // ...
end;

function TProfXmlAttributes.GetAttributeByName(const Name: WideString): IProfAttribute;
begin
  Result := nil;
  // ...
end;

function TProfXmlAttributes.GetAttributeName(Index: Integer): WideString;
begin
  Result := '';
  if Assigned(FNode) then
  try
    Result := FNode.AttributeNodes.Nodes[Index].NodeName;
  except
  end;
end;

function TProfXmlAttributes.GetAttributeValue(Index: Integer): WideString;
begin
  Result := '';
  if Assigned(FNode) then
  try
    Result := FNode.AttributeNodes.Nodes[Index].NodeValue;
  except
  end;
end;

function TProfXmlAttributes.Insert(Index: Integer; Attribute: IProfAttribute): Integer;
begin
  Result := -1;
  // ...
end;

function TProfXmlAttributes.New(const Name: WideString; Value: OleVariant): IProfAttribute;
begin
  Result := nil;
  // ...
end;

procedure TProfXmlAttributes.SetAttribute(const Name, Value: WideString);
begin
  if Assigned(FNode) then
  try
    FNode.Attributes[Name] := Value;
  except
  end;
end;

end.
