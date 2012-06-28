{**
@Abstract(AXmlCollection)
@Author(Prof1983 prof1983@ya.ru)
@Created(26.04.2012)
@LastMod(28.06.2012)
@Version(0.5)
}
unit AXmlCollectionIntf;

interface

uses
  ABase, AXmlNodeIntf;

type
  IProfXmlCollection = interface
    function DeleteNode(Node: IProfXmlNode2006): WordBool;
    function GetCount(): Integer;
    function GetNode(Index: Integer): AProfXmlNode1;
    //function Get_Node(Index: Integer): IProfXmlNode2006; deprecated; // Use GetNode()

    property Count: Integer read GetCount;
    property Nodes[Index: Integer]: AProfXmlNode1 read GetNode;
  end;

implementation

end.
 