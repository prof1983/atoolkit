{**
@Author Prof1983 <prof1983@ya.ru>
@Created 01.10.2009
@LastMod 18.12.2012
}
unit ACollectionsStringList;

interface

uses
  ABase,
  ABaseTypes,
  AStringLists;

function Collections_StringList_AddP(StringList: AStringList; const Value: APascalString): AInteger; deprecated; // Use AStringList_AddP()
procedure Collections_StringList_Clear(StringList: AStringList); deprecated; // Use AStringList_Clear()
function Collections_StringList_Count(StringList: AStringList): AInteger; deprecated; // Use AStringList_GetCount()
procedure Collections_StringList_Delete(StringList: AStringList; Index: AInteger); deprecated; // Use AStringList_Delete()
procedure Collections_StringList_InsertP(StringList: AStringList; Index: AInteger; const Value: APascalString); deprecated; // Use AStringList_InsertP()
function Collections_StringList_New(): AStringList; deprecated; // Use AStringList_New()

implementation

{ Collections_StringList }

function Collections_StringList_AddP(StringList: AStringList; const Value: APascalString): AInteger;
begin
  Result := AStringList_AddP(StringList, Value);
end;

procedure Collections_StringList_Clear(StringList: AStringList);
begin
  AStringList_Clear(StringList);
end;

function Collections_StringList_Count(StringList: AStringList): AInteger;
begin
  Result := AStringList_GetCount(StringList);
end;

procedure Collections_StringList_Delete(StringList: AStringList; Index: AInteger);
begin
  AStringList_Delete(StringList, Index);
end;

procedure Collections_StringList_InsertP(StringList: AStringList; Index: AInteger; const Value: APascalString);
begin
  AStringList_InsertP(StringList, Index, Value);
end;

function Collections_StringList_New(): AStringList;
begin
  Result := AStringList_New();
end;

end.
