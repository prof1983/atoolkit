{**
@Abstract(Работа с XML)
@Author(Prof1983 prof1983@ya.ru)
@Created(09.10.2005)
@LastMod(06.07.2012)
@Version(0.5)
}
unit AXml2;

TODO: Use AXmlDocumentImpl.pas

interface

uses
  SysUtils, Variants, XmlDoc, XmlDom, XmlIntf,
  ATypes, AXmlNodeImpl, AXmlNodeIntf;

type
  TProfXmlNode = AXmlNodeImpl.TProfXmlNode2;

type
  {TProfXmlNodeCollection = class(TXmlNodeCollection)
  private
    function GetNode(Index: Integer): TProfXmlNode;
  public
    property Nodes[Index: Integer]: TProfXmlNode read GetNode;
  end;}

  TProfXmlDocument = AXmlDocumentImpl.TProfXmlDocument2;

implementation

{ TProfXmlNodeCollection }

{function TProfXmlNodeCollection.GetNode(Index: Integer): TProfXmlNode;
begin
  Result := TProfXmlNode(inherited GetNode(Index));
end;}

end.
