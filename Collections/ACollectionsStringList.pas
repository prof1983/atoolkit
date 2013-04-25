{**
@Author(Prof1983 prof1983@ya.ru)
@Created(01.10.2009)
@LastMod(30.08.2011)
}
unit ACollectionsStringList;

interface

uses
  Classes, ABase, ACollectionsBase;

function Collections_StringList_AddP(StringList: AStringList; const Value: APascalString): AInteger;
procedure Collections_StringList_Clear(StringList: AStringList);
function Collections_StringList_Count(StringList: AStringList): AInteger;
procedure Collections_StringList_Delete(StringList: AStringList; Index: AInteger);
procedure Collections_StringList_InsertP(StringList: AStringList; Index: AInteger; const Value: APascalString);
function Collections_StringList_New(): AStringList;

implementation

{ Collections_StringList }

function Collections_StringList_AddP(StringList: AStringList; const Value: APascalString): AInteger;
begin
  Result := TStringList(StringList).Add(Value);
end;

procedure Collections_StringList_Clear(StringList: AStringList);
begin
  TStringList(StringList).Clear;
end;

function Collections_StringList_Count(StringList: AStringList): AInteger;
begin
  Result := TStringList(StringList).Count;
end;

procedure Collections_StringList_Delete(StringList: AStringList; Index: AInteger);
begin
  TStringList(StringList).Delete(Index);
end;

procedure Collections_StringList_InsertP(StringList: AStringList; Index: AInteger; const Value: APascalString);
begin
  TStringList(StringList).Insert(Index, Value);
end;

function Collections_StringList_New(): AStringList;
begin
  Result := AStringList(TStringList.Create);
end;

end.
