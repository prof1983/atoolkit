{**
@Abstract Общие интерфейсы для всех проектов
@Author Prof1983 <prof1983@ya.ru>
@Created 25.02.2007
@LastMod 28.11.2012
}
unit ALogDocumentIntf;

interface

uses
  ADocumentIntf, ALogNodeIntf, ATypes;

type
    //** Интерфейс документа логирования
  IALogDocument = interface
    function GetDocumentElement(): ALogNode;

    {**
      Добавить лог-сообщение
      @returns(Возвращает номер добавленого лог-сообщения или 0)
    }
    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;

    property DocumentElement: ALogNode read GetDocumentElement;
  end;

    //** Интерфейс документов логирования
  IALogDocuments = interface(IALogDocument)
    function GetDocumentByID(ID: Int64): ALogDocument;
    function GetDocumentByIndex(Index: Integer): ALogDocument;
    function GetDocumentCount(): Integer;

    function Add(Document: ALogDocument): Integer;
    function Delete(Index: Integer): Integer;
    function Insert(Index: Integer; Document: ALogDocument): Integer;

    property DocumentById[Id: Int64]: ALogDocument read GetDocumentById;
    property DocumentByIndex[Index: Integer]: ALogDocument read GetDocumentByIndex;
    property DocumentCount: Integer read GetDocumentCount;
  end;

implementation

end.
