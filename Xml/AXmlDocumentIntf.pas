{**
@Abstract(Interface XmlDocument)
@Author(Prof1983 prof1983@ya.ru)
@Created(26.03.2012)
@LastMod(02.05.2012)
@Version(0.5)
}
unit AXmlDocumentIntf;

interface

uses
  ADocumentIntf, ANodeIntf;

type //** Интерфейс работы с XML документом
  IProfXmlDocument = interface(IProfDocument)
    function GetDocumentElement(): IProfNode; safecall;
    //** Возвращает имя файла документа
    function GetFileName(): WideString; safecall;
    procedure SetFileName(const Value: WideString); safecall;

    function LoadFromFile(const FileName: WideString): WordBool; safecall;
    function SaveToFile(const FileName: WideString): WordBool; safecall;

    property DocumentElement: IProfNode read GetDocumentElement;
    property FileName: WideString read GetFileName write SetFileName;
  end;

{type //** @abstract(Интерфейс работы с XML документом. Не рекомендуется использовать.)
  IProfXmlDocumentA = interface
    function GetDocumentElement(): IProfXmlNodeA; safecall;
    function GetFileName(): WideString; safecall;
    procedure SetFileName(const Value: WideString); safecall;

    procedure Close(); safecall;
    function LoadFromFile(const FileName: WideString): WordBool; safecall;
    function SaveToFile(const FileName: WideString): WordBool; safecall;
    function Open(): Integer; safecall;

    property DocumentElement: IProfXmlNodeA read GetDocumentElement;
    property FileName: WideString read GetFileName write SetFileName;
  end;}

{type //** @abstract(Интерфейс работы с XML документом. Не рекомендуется использовать.)
  IProfXmlDocumentB = interface
    function GetDocumentElement(): IProfXmlNodeB; safecall;
    function GetFileName(): WideString; safecall;
    procedure SetFileName(const Value: WideString); safecall;

    procedure Close(); safecall;
    function Open(): WordBool; safecall;

    property DocumentElement: IProfXmlNodeB read GetDocumentElement;
    property FileName: WideString read GetFileName write SetFileName;
  end;}

// --- from ProfXmlIntf.pas ---

type
  IProfXmlDocument2006 = interface
  end;

implementation

end.
 