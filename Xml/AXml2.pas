{**
@Abstract(Работа с XML)
@Author(Prof1983 prof1983@ya.ru)
@Created(09.10.2005)
@LastMod(09.07.2012)
@Version(0.5)
}
unit AXml2;

TODO: Use AXmlDocumentImpl.pas

interface

uses
  SysUtils, Variants, XmlDoc, XmlDom, XmlIntf,
  ATypes, AXmlNodeImpl, AXmlNodeIntf;

type
  TProfXmlDocument = AXmlDocumentImpl.TProfXmlDocument1;
  TProfXmlNode = AXmlNodeImpl.TProfXmlNode2;

  {TProfXmlNodeCollection = class(TXmlNodeCollection)
  private
    function GetNode(Index: Integer): TProfXmlNode;
  public
    property Nodes[Index: Integer]: TProfXmlNode read GetNode;
  end;}

implementation

{ TProfXmlNodeCollection }

{function TProfXmlNodeCollection.GetNode(Index: Integer): TProfXmlNode;
begin
  Result := TProfXmlNode(inherited GetNode(Index));
end;}

end.
