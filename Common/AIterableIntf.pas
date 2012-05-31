{**
@Abstract(AIterable)
@Author(Prof1983 prof1983@ya.ru)
@Created(07.05.2007)
@LastMod(23.03.2012)
@Version(0.5)

Прототип: java.lang.Iterable
}
unit AIterableIntf;

interface

uses
  AIteratorIntf;

type
  {**
    Implementing this interface allows an object to be the target of
    the "foreach" statement.
  }
  IAIterable = interface
    {**
      Returns an iterator over a set of elements of type T.
      @return an Iterator.
    }
    function GetIterator(): IAIterator;

    // [Prof]
    //function ToString(): WideString;

    property Iterator: IAIterator read GetIterator;
  end;

type
  {**
    Implementing this interface allows an object to be the target of
    the "foreach" statement.
  }
  IJavaIterable = interface
    {**
      Returns an iterator over a set of elements of type T.
      @return an Iterator.
    }
    //Iterator<T> iterator();

    // [Prof]
    function ToString(): WideString;
  end;

type
  IIterable = interface
    function GetIterator(): IAIterator;

    property Iterator: IAIterator read GetIterator;
  end;

implementation

end.
