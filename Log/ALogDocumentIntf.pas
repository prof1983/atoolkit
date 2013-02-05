{**
@Author Prof1983 <prof1983@ya.ru>
@Created 25.02.2007
@LastMod 05.02.2013
}
unit ALogDocumentIntf;

interface

uses
  ADocumentIntf, ALogNodeIntf, ATypes;

type
  IALogDocument = interface
    function GetDocumentElement(): ALogNode;

    function AddToLog(AGroup: TLogGroupMessage; AType: TLogTypeMessage; const AStrMsg: WideString): Integer;

    property DocumentElement: ALogNode read GetDocumentElement;
  end;

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
