{**
@Abstract(Интерфейсы для хранилиша настроек)
@Author(Prof1983 prof1983@ya.ru)
@Created(22.02.2007)
@LastMod(25.05.2012)
@Version(0.5)
}
unit AStorageIntf;

interface

uses
  AReaderIntf, AWriterIntf;

type
  //** @abstract(Интервейс чтения из хранилища)
  IStorageReader = interface(IProfReader2)
    procedure Close(); safecall;
    function Open(): WordBool; safecall;
  end;

  //** @abstract(Интерфейс записи в хранилище)
  IStorageWriter = interface(IProfWriter2)
    procedure Close(); safecall;
    function Open(): WordBool; safecall;
  end;

implementation

end.
