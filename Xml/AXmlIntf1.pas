{**
@Abstract(Интерфейсы XML)
@Author(Prof1983 prof1983@ya.ru)
@Created(09.10.2005)
@LastMod(19.06.2012)
@Version(0.5)
}
unit AXmlIntf1;

interface

uses
  AXmlCollectionIntf, AXmlDocumentIntf, AXmlNodeIntf;

type
  IProfXmlDocument = AXmlDocumentIntf.IProfXmlDocument2006;
  IProfXmlNode = AXmlNodeIntf.IProfXmlNodeNew;

implementation

end.
