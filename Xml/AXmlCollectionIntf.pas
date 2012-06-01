{**
@Abstract(AXmlCollection)
@Author(Prof1983 prof1983@ya.ru)
@Created(26.04.2012)
@LastMod(02.05.2012)
@Version(0.5)
}
unit AXmlCollectionIntf;

interface

uses
  AXmlNodeIntf;

//IProfXmlCollection = ProfXmlIntf.IProfXmlCollection2006;

// TODO: Remove safecall

type
  IProfXmlCollection2006 = interface
    function GetCount(): Integer; safecall;
    function DeleteNode(Node: IProfXmlNode2006): WordBool; safecall;
    function Get_Node(Index: Integer): IProfXmlNode2006; safecall;

    property Count: Integer read GetCount;
    property Nodes[Index: Integer]: IProfXmlNode2006 read Get_Node;
  end;

implementation

end.
 