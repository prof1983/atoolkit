{**
@Author Prof1983 <prof1983@ya.ru>
@Created 01.10.2009
@LastMod 20.02.2013
}
unit AStringLists;

{define AStdCall}

interface

uses
  Classes,
  ABase,
  ABaseTypes,
  AStringMain;

// --- AStringList ---

function AStringList_Add(StringList: AStringList; const Value: AString_Type): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AStringList_AddA(StringList: AStringList; Value: AStr): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AStringList_AddP(StringList: AStringList; const Value: APascalString): AInt;

function AStringList_Clear(StringList: AStringList): AError; {$ifdef AStdCall}stdcall;{$endif}

function AStringList_Delete(StringList: AStringList; Index: AInt): AError; {$ifdef AStdCall}stdcall;{$endif}

function AStringList_GetCount(StringList: AStringList): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AStringList_GetStringP(StringList: AStringList; Index: AInt): APascalString;

function AStringList_Free(StringList: AStringList): AError; {$ifdef AStdCall}stdcall;{$endif}

function AStringList_Insert(StringList: AStringList; Index: AInt;
    Value: AString_Type): AInt; {$ifdef AStdCall}stdcall;{$endif}

function AStringList_InsertP(StringList: AStringList; Index: AInt; const Value: APascalString): AError;

function AStringList_New(): AStringList; {$ifdef AStdCall}stdcall;{$endif}

implementation

// --- AStringList ---

function AStringList_Add(StringList: AStringList; const Value: AString_Type): AInt;
begin
  try
    Result := AStringList_AddP(StringList, AString_ToPascalString(Value));
  except
    Result := -1;
  end;
end;

function AStringList_AddA(StringList: AStringList; Value: AStr): AInt;
begin
  Result := AStringList_AddP(StringList, Value);
end;

function AStringList_AddP(StringList: AStringList; const Value: APascalString): AInt;
begin
  if (StringList = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    Result := TStringList(StringList).Add(Value);
  except
    Result := -1;
  end;
end;

function AStringList_Clear(StringList: AStringList): AError;
begin
  if (StringList = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    TStringList(StringList).Clear();
    Result := 0;
  except
    Result := -1;
  end;
end;

function AStringList_Delete(StringList: AStringList; Index: AInt): AError;
begin
  if (StringList = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    TStringList(StringList).Delete(Index);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AStringList_GetCount(StringList: AStringList): AInt;
begin
  if (StringList = 0) then
  begin
    Result := 0;
    Exit;
  end;
  try
    Result := TStringList(StringList).Count;
  except
    Result := 0;
  end;
end;

function AStringList_GetStringP(StringList: AStringList; Index: AInt): APascalString;
begin
  if (StringList = 0) then
  begin
    Result := '';
    Exit;
  end;
  try
    Result := TStringList(StringList).Strings[Index];
  except
    Result := '';
  end;
end;

function AStringList_Free(StringList: AStringList): AError;
begin
  if (StringList = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    TStringList(StringList).Free();
    Result := 0;
  except
    Result := -1;
  end;
end;

function AStringList_Insert(StringList: AStringList; Index: AInt;
    Value: AString_Type): AInt;
begin
  try
    Result := AStringList_InsertP(StringList, Index, AString_ToPascalString(Value));
  except
    Result := -1;
  end;
end;

function AStringList_InsertP(StringList: AStringList; Index: AInt; const Value: APascalString): AError;
begin
  if (StringList = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    TStringList(StringList).Insert(Index, Value);
    Result := 0;
  except
    Result := -1;
  end;
end;

function AStringList_New(): AStringList;
begin
  try
    Result := AStringList(TStringList.Create());
  except
    Result := 0;
  end;
end;

end.
