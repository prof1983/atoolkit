﻿{**
@Abstract(Interface XmlDocument)
@Author(Prof1983 prof1983@ya.ru)
@Created(26.03.2012)
@LastMod(28.06.2012)
@Version(0.5)
}
unit AXmlDocumentIntf;

interface

uses
  ABase, ADocumentIntf;

type //** Интерфейс работы с XML документом
  IProfXmlDocument = interface(IProfDocument)
    function GetDocumentElement(): AProfXmlNode2;
    //** Возвращает имя файла документа
    function GetFileName(): WideString;
    procedure SetFileName(const Value: WideString);

    function LoadFromFile(const FileName: WideString): WordBool;
    function SaveToFile(const FileName: WideString): WordBool;

    property DocumentElement: AProfXmlNode2 read GetDocumentElement;
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
 