{**
@Abstract(Общие интерфейсы для всех проектов)
@Author(Prof1983 prof1983@ya.ru)
@Created(25.02.2007)
@LastMod(06.07.2012)
@Version(0.5)
}
unit ALogDocumentIntf;

interface

uses
  ADocumentIntf, ALogNodeIntf, ATypes;

type
    //** Интерфейс документа логирования
  IALogDocument = interface //(IProfDocument)
    function GetDocumentElement(): ALogNode;
    function GetDocumentElement2(): IALogNode2;

    {**
      Добавить лог-сообщение
      @returns(Возвращает номер добавленого лог-сообщения или 0)
    }
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;

    property DocumentElement: IALogNode2 read GetDocumentElement2;
  end;

    //** Интерфейс документов логирования
  IALogDocuments = interface(IALogDocument)
    function GetDocumentByID(ID: Int64): ALogDocument;
    function GetDocumentByIndex(Index: Integer): ALogDocument;
    function GetDocumentCount(): Integer;

    function Add(Document: ALogDocument): Integer;
    //function AddLogDocument(ADocument: ALogDocument): Integer;
    function Delete(Index: Integer): Integer;
    function Insert(Index: Integer; Document: ALogDocument): Integer;
    //function New(const Name: WideString): IALogDocument; safecall;

    property DocumentById[Id: Int64]: ALogDocument read GetDocumentById;
    property DocumentByIndex[Index: Integer]: ALogDocument read GetDocumentByIndex;
    property DocumentCount: Integer read GetDocumentCount;
  end;

  //ILogDocument = IALogNode2;
  //ILogDocuments = IALogDocuments;
  //ILogDocument2 = IALogDocument;
  //ILogDocuments2 = ILogDocuments;
  //IProfLogDocument = IALogDocument;
  //IProfLogDocuments = IALogDocuments;

implementation

end.
