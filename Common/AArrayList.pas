{**
@Author Prof1983 <prof1983@ya.ru>
@Created 23.09.2007
@LastMod 04.02.2013

Prototype: java.lang.ArrayList
}
unit AArrayList;

interface

uses
  ABase, ACollectionIntf, AIteratorIntf, AListIntf;

type
  TArrayList = class(TInterfacedObject, IACollection, IAList)
  private
    FElements: array of AId;
  public // IAIterable
    function GetIterator(): IAIterator;
  public // IACollection
      {** Returns true if this collection contains the specified element. }
    function Contains(Id: AId): AError;
      {** Returns the number of elements in this collection. }
    function GetCount(): Integer;
      {** Returns true if this collection contains no elements. }
    function GetIsEmpty(): Boolean;
      {** Returns the number of elements in this collection. }
    function GetSize(): AInt;
  public // IACollection
      {** Ensures that this collection contains the specified element. }
    function Add(Id: AId): AError;
      {** Adds all of the elements in the specified collection to this collection. }
    function AddAll(Objects: IACollection): AError;
      {** Removes all of the elements from this collection. }
    function Clear(): AError;
      {** Returns true if this collection contains all of the elements in the specified collection. }
    function ContainsAll(Objects: IACollection): AError;
      {** Removes a single instance of the specified element from this collection, if it is present. }
    function Remove(Id: AId): AError;
      {** Removes all this collection's elements that are also contained in the specified collection. }
    function RemoveAll(Objects: IACollection): AError;
      {** Retains only the elements in this collection that are contained in the specified collection. }
    function RetainAll(Objects: IACollection): AError;
  public // IACollection
      {** Compares the specified object with this collection for equality. }
    function Equals(Id: AId): AError;
      {** Returns the hash code value for this collection. }
    function HashCode(): AInt;
  public
    function GetElementByIndex(Index: Integer): AId;
    procedure Insert(Index: Integer; Element: TObject);
    procedure RemoveByIndex(Index: Integer);
    function ToString(): APascalString;
  public
    property Count: Integer read GetCount;
    property ElementByIndex[Index: Integer]: AId read GetElementByIndex;
    property Iterator: IAIterator read GetIterator;
    property IsEmpty: Boolean read GetIsEmpty;
  end;

implementation

{ TList }

function TArrayList.Add(Id: AId): AError;
var
  i: Integer;
begin
  i := Length(FElements);
  SetLength(FElements, i + 1);
  FElements[i] := Id;
end;

function TArrayList.AddAll(Objects: IACollection): AError;
begin
  Result := -1;
end;

function TArrayList.Clear(): AError;
begin
  Result := -1;
end;

function TArrayList.Contains(Id: AId): AError;
begin
  Result := -1;
end;

function TArrayList.ContainsAll(Objects: IACollection): AError;
begin
  Result := -1;
end;

function TArrayList.Equals(Id: AId): AError;
begin
  Result := -1;
end;

function TArrayList.GetCount(): Integer;
begin
  Result := Length(FElements);
end;

function TArrayList.GetElementByIndex(Index: Integer): AId;
begin
  if (Index >= 0) and (Index < Length(FElements)) then
    Result := FElements[Index]
  else
    Result := 0;
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

function TArrayList.GetSize(): AInt;
begin
  Result := 0;
end;

function TArrayList.HashCode(): AInt;
begin
  Result := 0;
end;

procedure TArrayList.Insert(Index: Integer; Element: TObject);
begin
  // ...
end;

function TArrayList.Remove(Id: AId): AError;
begin
  Result := -1;
end;

function TArrayList.RemoveAll(Objects: IACollection): AError;
begin
  Result := -1;
end;

procedure TArrayList.RemoveByIndex(Index: Integer);
begin
  // ...
end;

function TArrayList.RetainAll(Objects: IACollection): AError;
begin
  Result := -1;
end;

function TArrayList.ToString: APascalString;
begin
  Result := '';
end;

end.
