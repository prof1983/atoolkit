{**
@Author Prof1983 <prof1983@ya.ru>
@Created 25.02.2007
@LastMod 04.02.2013
}
unit ANodeIntf;

interface

uses
  AAttributesIntf, ABase, AEntityIntf;

type
  IProfNodes = interface;

  IProfNode = interface(IANamedEntity)
    function GetAttributes(): IProfAttributes; safecall;
    function GetChildNodes(): AXmlNodeList;

    property Attributes: IProfAttributes read GetAttributes;
    property ChildNodes: AXmlNodeList read GetChildNodes;
  end;

  IProfNodes = interface
    function GetNodeById(Id: Int64): IProfNode; safecall;
    function GetNodeByIndex(Index: Integer): IProfNode; safecall;
    function GetNodeByName(const Name: WideString): IProfNode; safecall;
    function GetNodeCount(): Integer; safecall;

    function Add(Node: IProfNode): Integer; safecall;
    function Delete(Index: Integer): Integer; safecall;
    function Insert(Index: Integer; Node: IProfNode): Integer; safecall;
    function New(const Name: WideString): IProfNode; safecall;

    property Count: Integer read GetNodeCount;
    property NodeById[Id: Int64]: IProfNode read GetNodeById;
    property NodeByIndex[Index: Integer]: IProfNode read GetNodeByIndex;
    property NodeByName[const Name: WideString]: IProfNode read GetNodeByName;
    property NodeCount: Integer read GetNodeCount;
  end;

implementation

end.
