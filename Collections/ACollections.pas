{**
Abstract()
@Author(Prof1983 prof1983@ya.ru)
@Created(29.06.2011)
@LastMod(18.11.2011)
@Version(0.5)
}
unit ACollections;

{$IFNDEF A0}
  {$DEFINE ALOCAL}
{$ENDIF}

interface

uses
  ABase, ACollectionsBase, ACollectionsStringList,
  {$IFDEF ALOCAL}AStrings{$ELSE}AStrings0{$ENDIF};

// Добавляет строку в список. Возвращает индекс, по которому эта строка сохранена.
function StringList_Add(StringList: AStringList; const Value: AString_Type): AInteger; stdcall;

// Добавляет строку в список. Возвращает индекс, по которому эта строка сохранена.
function StringList_AddP(StringList: AStringList; const Value: APascalString): AInteger; stdcall;

// Добавляет строку в список. Возвращает индекс, по которому эта строка сохранена.
function StringList_AddPS(StringList: AStringList; const Value: APascalString): AInteger; stdcall;

// Добавляет строку в список. Возвращает индекс, по которому эта строка сохранена.
function StringList_AddWS(StringList: AStringList; const Value: AWideString): AInteger; stdcall;

// Удаляет все элементы.
function StringList_Clear(StringList: AStringList): AError; stdcall;

function StringList_Count(StringList: AStringList): AInteger; stdcall;

function StringList_Delete(StringList: AStringList; Index: AInteger): AError; stdcall;

{ Вставляет в список строку по указанному индексу.
  Элементы, находившиеся до этого по индексу Index и далее, смещаются вперед, чтобы освободить
  место для вставляемого объекта. }
function StringList_Insert(StringList: AStringList; Index: AInteger;
    Value: AString_Type): AInteger; stdcall;

function StringList_InsertP(StringList: AStringList; Index: AInteger;
    const Value: APascalString): AError; stdcall;

// Создает коллекцию-список строк.
function StringList_New(): AStringList; stdcall;

{ Удаляет из списка строку, расположенную по указанному индексу.
  Элементы, находящиеся за удаляемым смещаются назад, чтобы ликвидировать образовавшуюся брешь. }
function StringList_RemoveAt(StringList: AStringList; Index: AInteger): AInteger; stdcall;

implementation

function StringList_Add(StringList: AStringList; const Value: AString_Type): AInteger; stdcall;
begin
  try
    Result := Collections_StringList_AddP(StringList, AStrings.String_ToWideString(Value));
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
