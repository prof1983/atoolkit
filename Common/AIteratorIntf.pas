{**
@Abstract(Итератор)
@Author(Prof1983 prof1983@ya.ru)
@Created(10.05.2007)
@LastMod(25.06.2012)
@Version(0.5)

Prototype: java.util.Iterator.java 1.24 01/17/04
}
unit AIteratorIntf;

interface

uses
  ABase;

type
  {**
    Итератор для данных сущности, когда данные в виде коллекции.
    Удаляется автоматически, когда никто не ссылается на эту сущность.

    An iterator over a collection.
    Iterator takes the place of Enumeration in the Java collections framework.
    Iterators differ from enumerations in two ways: <ul>
    <li> Iterators allow the caller to remove elements from the underlying
    collection during the iteration with well-defined semantics.
    <li> Method names have been improved.
    </ul><p>

    This interface is a member of the
    <a href="{@docRoot/../guide/collections/index.html">Java Collections Framework</a>.
  }
  IAIterator = interface
    {**
      Returns true if the iteration has more elements.
      In other words, returns true if next would return an element
      rather than throwing an exception.

      @return(true if the iterator has more elements)
    }
    function HasNext(): Boolean;

      //** Вставить элемент в коллекцию
    function Insert(Element: TAId): Boolean;

      //** Пусто?
    function IsEmpty(): Boolean;

    {**
      Returns the next element in the iteration.
      Calling this method repeatedly until the {@link #hasNext() method returns false will
      return each element in the underlying collection exactly once.

      @return the next element in the iteration.
      @exception NoSuchElementException iteration has no more elements.
    }
    function Next(): AId;
    //function Next(): TObject;
    //function Next(): IUnknown;

    {**
      Удаляет текущий элемент из коллекции

      Removes from the underlying collection the last element returned by the
      iterator (optional operation).  This method can be called only once per
      call to <tt>next</tt>.  The behavior of an iterator is unspecified if
      the underlying collection is modified while the iteration is in
      progress in any way other than by calling this method.

      @exception UnsupportedOperationException if the <tt>remove</tt>
     		  operation is not supported by this Iterator.

      @exception IllegalStateException if the <tt>next</tt> method has not
     		  yet been called, or the <tt>remove</tt> method has already
     		  been called after the last call to the <tt>next</tt> method.
    }
    function Remove(): Boolean;
  end;

  //IJavaIterator = IAIterator;

implementation

end.
