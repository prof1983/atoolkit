{**
@Abstract Интерфейс для любых документов
@Author Prof1983 <prof1983@ya.ru>
@Created 11.04.2007
@LastMod 23.11.2012
}
unit ADocumentIntf;

interface

uses
  ABase, AEntityIntf;

type
  //** Интерфейс для любых документов
  IADocument = interface(IANamedEntity)
    {**
      Открыт ли документ?
      Реализация метода IsOpened должна проверить соответствующие свойства
      Объекта для определения состояния документа.
    }
    function GetIsOpened(): WordBool; safecall;

    {**
      Закрыть документ
      Реализация метода Close() должна содержать действия по нейтрализации
      результатов работы метода Open().
    }
    procedure CloseDocument(); safecall;

    {**
      Открыть документ
      Реализация метода Open() должна содержать все необходимые действия для
      обеспечения корректной и безошибочной работы других методов документа.
      Этот метод запускается первым после создания экземпляра класса.
      @returns(Возврашает 0 в случае успешного выполнения;
        положительное число, если есть замечания;
        отрицательное число, если есть ошибки (открыть документ не удалось))
    }
    function OpenDocument(): AError; safecall;

    {**
      Открыт ли документ?
      Реализация IsOpened должна проверить соответствующие свойства Объекта
      для определения состояния документа.
    }
    property IsOpened: WordBool read GetIsOpened;
  end;

  IProfDocument = IADocument;

implementation

end.
