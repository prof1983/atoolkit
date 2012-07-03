{**
@Abstract(Interface XmlDocument)
@Author(Prof1983 prof1983@ya.ru)
@Created(26.03.2012)
@LastMod(03.07.2012)
@Version(0.5)
}
unit AXmlDocumentIntf;

interface

uses
  ABase, ADocumentIntf;

type //** Интерфейс работы с XML документом
  IProfXmlDocument = interface //(IProfDocument)
    function GetDocumentElement(): AProfXmlNode;
    //** Возвращает имя файла документа
    function GetFileName(): WideString;
    procedure SetFileName(const Value: WideString);

    function LoadFromFile(const FileName: WideString): WordBool;
    function SaveToFile(const FileName: WideString): WordBool;

    property DocumentElement: AProfXmlNode read GetDocumentElement;
    property FileName: WideString read GetFileName write SetFileName;
  end;

  {**
    Интерфейс работы с XML документом
    Не рекомендуется использовать.
  }
  IProfXmlDocumentA = interface
    function GetDocumentElement(): AProfXmlNodeA{IProfXmlNodeA}; safecall;
    function GetFileName(): WideString; safecall;
    procedure SetFileName(const Value: WideString); safecall;

    procedure Close(); safecall;
    function LoadFromFile(const FileName: WideString): WordBool; safecall;
    function SaveToFile(const FileName: WideString): WordBool; safecall;
    function Open(): Integer; safecall;

    property DocumentElement: AProfXmlNodeA{IProfXmlNodeA} read GetDocumentElement;
    property FileName: WideString read GetFileName write SetFileName;
  end;

implementation

end.
 