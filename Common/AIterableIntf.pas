{**
@Abstract(AToolkit Iterable interface)
@Author(Prof1983 prof1983@ya.ru)
@Created(07.05.2007)
@LastMod(25.06.2012)
@Version(0.5)

Prototype: java.lang.Iterable
}
unit AIterableIntf;

interface

uses
  ABase, AIteratorIntf;

type
  {**
    Implementing this interface allows an object to be the target of
    the "foreach" statement.
  }
  IAIterable = interface
    {**
      Returns an iterator over a set of elements.
      There are no guarantees concerning the order in which the elements are returned
      (unless this collection is an instance of some class that provides a
      guarantee).

      @return an Iterator
    }
    function GetIterator(): IAIterator;

      //** Convert to string
    function ToString(): APascalString;

    {** Returns an iterator over a set of elements }
    property Iterator: IAIterator read GetIterator;
  end;

  //IJavaIterable = IAIterable;

implementation

end.
