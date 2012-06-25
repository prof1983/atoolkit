{**
@Abstract(ACollection interface implementation)
@Author(Prof1983 prof1983@ya.ru)
@Created(08.06.2012)
@LastMod(25.06.2012)
@Version(0.5)
}
unit ACollectionImpl;

interface

uses
  ABase, ACollectionIntf, AIteratorIntf;

type
  {**
    Implementation IACollection interface.
  }
  TACollection = class(TInterfacedObject, IACollection)
  public
    {**
      Ensures that this collection contains the specified element (optional operation).
    }
    function Add(Id: AId): AError;
    {**
      Adds all of the elements in the specified collection to this collection (optional operation).
    }
    function AddAll(Objects: IACollection): AError;
    {**
      Removes all of the elements from this collection (optional operation).
    }
    function Clear(): AError;
    {**
      Returns true if this collection contains the specified element.
    }
    function Contains(Id: AId): AError;
    {**
      Returns <tt>true</tt> if this collection contains all of the elements
      in the specified collection.
    }
    function ContainsAll(Objects: IACollection): AError;
    {**
      Compares the specified object with this collection for equality.
    }
    function Equals(Id: AId): AError;
    {**
      Returns the number of elements in this collection.
    }
    function GetCount(): AInt;
    {**
      Returns the hash code value for this collection.
    }
    function HashCode(): AInt;
    {**
      Returns true if this collection contains no elements.
    }
    function GetIsEmpty(): ABoolean;
    {**
      Создает и возвращает итератор.
    }
    function GetIterator(): IAIterator;
    {**
      Returns the number of elements in this collection.
    }
    function GetSize(): AInt;
    {**
      Removes a single instance of the specified element from this
      collection, if it is present (optional operation).
    }
    function Remove(Id: AId): AError;
    {
      Removes all this collection's elements that are also contained in the
      specified collection (optional operation).
    }
    function RemoveAll(Objects: IACollection): AError;
    {**
      Retains only the elements in this collection that are contained in the
      specified collection (optional operation).
    }
    function RetainAll(Objects: IACollection): AError;
  end;

implementation

{ TACollection }

function TACollection.Add(Id: AId): AError;
begin
  Result := -1;
end;

function TACollection.AddAll(Objects: IACollection): AError;
begin
  Result := -1;
end;

function TACollection.Clear(): AError;
begin
  Result := -1;
end;

function TACollection.Contains(Id: AId): AError;
begin
  Result := -1;
end;

function TACollection.ContainsAll(Objects: IACollection): AError;
begin
  Result := -1;
end;

function TACollection.Equals(Id: AId): AError;
begin
  Result := -1;
end;

function TACollection.GetCount(): AInt;
begin
  Result := -1;
end;

function TACollection.GetIsEmpty(): ABoolean;
begin
  Result := True;
end;

function TACollection.GetIterator(): IAIterator;
begin
  Result := nil;
  // ...
end;

function TACollection.GetSize(): AInt;
begin
  Result := 0;
end;

function TACollection.HashCode(): AInt;
begin
  Result := 0;
end;

function TACollection.Remove(Id: AId): AError;
begin
  Result := -1;
end;

function TACollection.RemoveAll(Objects: IACollection): AError;
begin
  Result := -1;
end;

function TACollection.RetainAll(Objects: IACollection): AError;
begin
  Result := -1;
end;

end.
