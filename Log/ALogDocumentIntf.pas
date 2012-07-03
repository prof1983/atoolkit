{**
@Abstract(Общие интерфейсы для всех проектов)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.02.2007)
@LastMod(03.07.2012)
@Version(0.5)
}
unit ALogDocumentIntf;

interface

uses
  ADocumentIntf, ALogNodeIntf, ANodeIntf, ATypes;

type
    //** Интерфейс документа логирования
  ILogDocument = IALogNode2;

    //** Интерфейс документов логирования
  ILogDocuments = interface(ILogDocument)
    function AddLogDocument(ADocument: ILogDocument): Integer;
  end;

  ILogDocument2 = ILogDocument;
  ILogDocuments2 = ILogDocuments;

type //** Интерфейс документа логирования
  IProfLogDocument = interface //(IProfDocument)
    function GetDocumentElement(): IALogNode2; safecall;

    {**
      Добавить лог-сообщение
      @returns(Возвращает номер добавленого лог-сообщения или 0)
    }
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;

    property DocumentElement: IALogNode2 read GetDocumentElement;
  end;

type //** Интерфейс документов логирования
  IProfLogDocuments = interface(IProfLogDocument)
    function GetDocumentByID(ID: Int64): IProfLogDocument; safecall;
    function GetDocumentByIndex(Index: Integer): IProfLogDocument; safecall;
    function GetDocumentCount(): Integer; safecall;

    function Add(Document: IProfLogDocument): Integer; safecall;
    function Delete(Index: Integer): Integer; safecall;
    function Insert(Index: Integer; Document: IProfLogDocument): Integer; safecall;
    //function New(const Name: WideString): IProfLogDocument; safecall;

    property DocumentByID[ID: Int64]: IProfLogDocument read GetDocumentByID;
    property DocumentByIndex[Index: Integer]: IProfLogDocument read GetDocumentByIndex;
    property DocumentCount: Integer read GetDocumentCount;
  end;

implementation

end.
