{**
@Abstract(AXmlCollection functions)
@Author(Prof1983 prof1983@ya.ru)
@Created(29.06.2012)
@LastMod(29.06.2012)
@Version(0.5)
}
unit AXmlCollectionUtils;

interface

uses
  ABase;

function AXmlCollection_GetCount(Collection: AXmlCollection): AInt;

function AXmlCollection_GetNode(Collection: AXmlCollection; Index: AInt): AXmlNode;

implementation

uses
  AXmlCollectionImpl;

function AXmlCollection_GetCount(Collection: AXmlCollection): AInt;
begin
  Result := TProfXmlCollection(Collection).GetCount();
end;

function AXmlCollection_GetNode(Collection: AXmlCollection; Index: AInt): AXmlNode;
begin
  Result := TProfXmlCollection(Collection).GetNode(Index);
end;

end.
