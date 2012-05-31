{**
@Abstract(AArrayList)
@Author(Prof1983 prof1983@ya.ru)
@Created(23.09.2007)
@LastMod(27.03.2012)
@Version(0.5)

Прототип: java.lang.ArrayList
}
unit AArrayList;

interface

uses
  ABase, ACollection, AIteratorIntf, AListIntf;

type
  TArrayList = class(TInterfacedObject, IACollection2, IAList)
  private
    FElements: array of TObject;
  protected
    function GetCount(): Integer;
    function GetElementByIndex(Index: Integer): TObject;
    function GetIterator(): IAIterator;
    function GetIsEmpty(): Boolean;
  public
    {** Добавить элемент в конец списка }
    procedure Add(Element: TObject);
    {** Вставить элемент }
    procedure Insert(Index: Integer; Element: TObject);
    {** Удалить элемент из списка }
    procedure Remove(Element: TObject);
    {** Удалить элемент из списка по индексу }
    procedure RemoveByIndex(Index: Integer);
    function ToString(): APascalString;
  public
    {** Колличество элементов в списке }
    property Count: Integer read GetCount;
    {** Элемент по индексу }
    property ElementByIndex[Index: Integer]: TObject read GetElementByIndex;
    {** Итератор }
    property Iterator: IAIterator read GetIterator;
    {** Список пуст }
    property IsEmpty: Boolean read GetIsEmpty;
  end;

implementation

{ TList }

procedure TArrayList.Add(Element: TObject);
var
  i: Integer;
begin
  i := Length(FElements);
  SetLength(FElements, i + 1);
  FElements[i] := Element;
end;

function TArrayList.GetCount(): Integer;
begin
  Result := Length(FElements);
end;

function TArrayList.GetElementByIndex(Index: Integer): TObject;
begin
  if (Index >= 0) and (Index < Length(FElements)) then
    Result := FElements[Index]
  else
    Result := nil;
end;

function TArrayList.GetIsEmpty(): Boolean;
begin
  Result := (Length(FElements) = 0);
end;

function TArrayList.GetIterator(): IAIterator;
begin
  //Result := TListIterator.Create(Self);
  // ...
end;

procedure TArrayList.Insert(Index: Integer; Element: TObject);
begin
  // ...
end;

procedure TArrayList.Remove(Element: TObject);
begin
  // ...
end;

procedure TArrayList.RemoveByIndex(Index: Integer);
begin
  // ...
end;

function TArrayList.ToString: APascalString;
begin
  Result := '';
end;

end.
