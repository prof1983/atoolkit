{**
@Author Prof1983 <prof1983@ya.ru>
@Created 27.12.2012
@LastMod 04.04.2013
}
unit ADataStruct;

interface

uses
  ABase,
  ADataBase,
  ADatabaseStructure,
  ADataUtils,
  AStringMain;

// --- ADataStruct ---

function ADataStruct_AddTable(Struct: ADataStructure;
    const TableName: AString_Type): ATableStructure; {$ifdef ADtdCall}stdcall;{$endif}

function ADataStruct_AddTableP(Struct: ADataStructure; const TableName: APascalString): ATableStructure;

function ADataStruct_Clear(Struct: ADataStructure): AError; {$ifdef ADtdCall}stdcall;{$endif}

implementation

// --- ADataStruct ---

function ADataStruct_AddTable(Struct: ADataStructure;
    const TableName: AString_Type): ATableStructure;
begin
  Result := ADataStruct_AddTableP(Struct, AString_ToP(TableName));
end;

function ADataStruct_AddTableP(Struct: ADataStructure; const TableName: APascalString): ATableStructure;
begin
  if (Struct = 0) then
  begin
    Result := 0;
    Exit;
  end;
  if (Length(TableName) <= 0) then
  begin
    Result := 0;
    Exit;
  end;
  try
    Result := ATableStructure(TADatabaseStructure(Struct).AddTable(TableName));
  except
    Result := 0;
  end;
end;

function ADataStruct_Clear(Struct: ADataStructure): AError;
begin
  if (Struct = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    TADatabaseStructure(Struct).Clear();
    Result := 0;
  except
    Result := -1;
  end;
end;

end.
 