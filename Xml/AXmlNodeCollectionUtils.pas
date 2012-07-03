{**
@Abstract(AXmlCollection functions)
@Author(Prof1983 prof1983@ya.ru)
@Created(29.06.2012)
@LastMod(03.07.2012)
@Version(0.5)
}
unit AXmlNodeCollectionUtils;

interface

uses
  XmlIntf,
  ABase;

function AXmlNodeCollection_Clear(Collection: AXmlNodeCollection): AError;

function AXmlNodeCollection_Free(Collection: AXmlNodeCollection): AError;

function AXmlNodeCollection_GetCount(Collection: AXmlNodeCollection): AInt;

function AXmlNodeCollection_GetNode(Collection: AXmlNodeCollection; Index: AInt): AXmlNode;

function AXmlNodeCollection_New1(Node: AProfXmlNode): AXmlNodeCollection;

function AXmlNodeCollection_New2(Collection: IXmlNodeCollection): AXmlNodeCollection;

implementation

uses
  AXmlNodeCollectionImpl;

function AXmlNodeCollection_Clear(Collection: AXmlNodeCollection): AError;
begin
  if not(TObject(Collection) is TProfXmlCollection) then
  begin
    Result := -2;
    Exit;
  end;
  TProfXmlCollection(Collection).Clear();
  Result := 0;
end;

function AXmlNodeCollection_Free(Collection: AXmlNodeCollection): AError;
begin
  if not(TObject(Collection) is TProfXmlCollection) then
  begin
    Result := -2;
    Exit;
  end;
  TProfXmlCollection(Collection).Free();
  Result := 0;
end;

function AXmlNodeCollection_GetCount(Collection: AXmlNodeCollection): AInt;
begin
  if not(TObject(Collection) is TProfXmlCollection) then
  begin
    Result := -2;
    Exit;
  end;
  Result := TProfXmlCollection(Collection).GetCount();
end;

function AXmlNodeCollection_GetNode(Collection: AXmlNodeCollection; Index: AInt): AXmlNode;
begin
  if not(TObject(Collection) is TProfXmlCollection) then
  begin
    Result := 0;
    Exit;
  end;
  Result := TProfXmlCollection(Collection).GetNode(Index);
end;

function AXmlNodeCollection_New1(Node: AProfXmlNode): AXmlNodeCollection;
begin
  Result := AXmlNodeCollection(TProfXmlCollection.Create(Node));
end;

function AXmlNodeCollection_New2(Collection: IXmlNodeCollection): AXmlNodeCollection;
begin
  Result := AXmlNodeCollection(TProfXmlCollection.Create2(Collection));
end;

end.
