{**
@Abstract ACollections
@Author Prof1983 <prof1983@ya.ru>
@Created 29.06.2011
}
unit ACollections;

{$ifndef A0}
  {$define ALocal}
{$endif}

interface

uses
  ABase,
  ACollectionsBase,
  ACollectionsStringList,
  {$ifdef ALocal}AStrings{$else}AStrings0{$endif};

function Init(): AError; stdcall;

function Done(): AError; stdcall;

//** ƒобавл€ет строку в список. ¬озвращает индекс, по которому эта строка сохранена.
function StringList_Add(StringList: AStringList; const Value: AString_Type): AInteger; stdcall;

//** ƒобавл€ет строку в список. ¬озвращает индекс, по которому эта строка сохранена.
function StringList_AddA(StringList: AStringList; Value: PAnsiChar): AInteger; stdcall;

//** ƒобавл€ет строку в список. ¬озвращает индекс, по которому эта строка сохранена.
function StringList_AddP(StringList: AStringList; const Value: APascalString): AInteger; stdcall;

//** ƒобавл€ет строку в список. ¬озвращает индекс, по которому эта строка сохранена.
// Use StringList_AddP()
function StringList_AddPS(StringList: AStringList; const Value: APascalString): AInteger; stdcall; deprecated;

//** ƒобавл€ет строку в список. ¬озвращает индекс, по которому эта строка сохранена.
function StringList_AddWS(StringList: AStringList; const Value: AWideString): AInteger; stdcall;

//** ”дал€ет все элементы.
function StringList_Clear(StringList: AStringList): AError; stdcall;

function StringList_Count(StringList: AStringList): AInteger; stdcall;

function StringList_Delete(StringList: AStringList; Index: AInteger): AError; stdcall;

{**
  ¬ставл€ет в список строку по указанному индексу.
  Ёлементы, находившиес€ до этого по индексу Index и далее, смещаютс€ вперед, чтобы освободить
  место дл€ вставл€емого объекта.
}
function StringList_Insert(StringList: AStringList; Index: AInteger;
    Value: AString_Type): AInteger; stdcall;

{**
  ¬ставл€ет в список строку по указанному индексу.
  Ёлементы, находившиес€ до этого по индексу Index и далее, смещаютс€ вперед, чтобы освободить
  место дл€ вставл€емого объекта.
}
function StringList_InsertP(StringList: AStringList; Index: AInteger;
    const Value: APascalString): AError; stdcall;

//** —оздает коллекцию-список строк.
function StringList_New(): AStringList; stdcall;

{**
  ”дал€ет из списка строку, расположенную по указанному индексу.
  Ёлементы, наход€щиес€ за удал€емым смещаютс€ назад, чтобы ликвидировать образовавшуюс€ брешь.
}
function StringList_RemoveAt(StringList: AStringList; Index: AInteger): AInteger; stdcall;

implementation

function Done(): AError; stdcall;
begin
  Result := 0;
end;

function Init(): AError; stdcall;
begin
  Result := 0;
end;

function StringList_Add(StringList: AStringList; const Value: AString_Type): AInteger; stdcall;
begin
  try
    Result := Collections_StringList_AddP(StringList, AStrings.String_ToWideString(Value));
  except
    Result := -1;
  end;
end;

function StringList_AddA(StringList: AStringList; Value: PAnsiChar): AInteger; stdcall;
begin
  try
    Result := Collections_StringList_AddP(StringList, Value);
  except
    Result := -1;
  end;
end;

function StringList_AddP(StringList: AStringList; const Value: APascalString): AInteger; stdcall;
begin
  try
    Result := Collections_StringList_AddP(StringList, Value);
  except
    Result := -1;
  end;
end;

function StringList_AddPS(StringList: AStringList; const Value: APascalString): AInteger; stdcall;
begin
  try
    Result := Collections_StringList_AddP(StringList, Value);
  except
    Result := -1;
  end;
end;

function StringList_AddWS(StringList: AStringList; const Value: AWideString): AInteger; stdcall;
begin
  try
    Result := Collections_StringList_AddP(StringList, Value);
  except
    Result := -1;
  end;
end;

function StringList_Clear(StringList: AStringList): AError; stdcall;
begin
  try
    Collections_StringList_Clear(StringList);
    Result := 0;
  except
    Result := -1;
  end;
end;

function StringList_Count(StringList: AStringList): AInteger; stdcall;
begin
  try
    Result := Collections_StringList_Count(StringList);
  except
    Result := -1;
  end;
end;

function StringList_Delete(StringList: AStringList; Index: AInteger): AError; stdcall;
begin
  try
    Collections_StringList_Delete(StringList, Index);
    Result := 0;
  except
    Result := -1;
  end;
end;

function StringList_Insert(StringList: AStringList; Index: AInteger;
    Value: AString_Type): AInteger; stdcall;
begin
  try
    Collections_StringList_InsertP(StringList, Index, AStrings.String_ToWideString(Value));
    Result := 0;
  except
    Result := -1;
  end;
end;

function StringList_InsertP(StringList: AStringList; Index: AInteger;
    const Value: APascalString): AError; stdcall;
begin
  try
    Collections_StringList_InsertP(StringList, Index, Value);
    Result := 0;
  except
    Result := -1;
  end;
end;

function StringList_New(): AStringList; stdcall;
begin
  try
    Result := Collections_StringList_New();
  except
    Result := 0;
  end;
end;

function StringList_RemoveAt(StringList: AStringList; Index: AInteger): AInteger; stdcall;
begin
  try
    Collections_StringList_Delete(StringList, Index);
    Result := 0;
  except
    Result := -1;
  end;
end;

end.
