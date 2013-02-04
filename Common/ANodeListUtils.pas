{**
@Abstract ANodeList functions
@Author Prof1983 <prof1983@ya.ru>
@Created 18.07.2012
@LastMod 18.07.2012
}
unit ANodeListUtils;

interface

uses
  ABase;

// --- ANodeList ---

function ANodeList_Add(NodeList: ANodeList; Node: ANode): AInt;

implementation

uses
  AXmlNodeListUtils;

// --- ANodeList ---

function ANodeList_Add(NodeList: ANodeList; Node: ANode): AInt;
begin
  Result := AXmlNodeList_Add(NodeList, Node);
end;

end.
