{**
@Abstract(AXmlCollection)
@Author(Prof1983 prof1983@ya.ru)
@Created(26.04.2012)
@LastMod(03.07.2012)
@Version(0.5)
}
unit AXmlNodeCollectionIntf;

interface

uses
  ABase, AXmlNodeIntf;

type
  IProfXmlCollection = interface
    function DeleteNode(Node: AProfXmlNode): WordBool;
    function GetCount(): Integer;
    function GetNode(Index: Integer): AProfXmlNode;

    property Count: Integer read GetCount;
    property Nodes[Index: Integer]: AProfXmlNode read GetNode;
  end;

implementation

end.
 