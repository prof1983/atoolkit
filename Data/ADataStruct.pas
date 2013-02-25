{**
@Author Prof1983 <prof1983@ya.ru>
@Created 27.12.2012
@LastMod 25.02.2013
}
unit ADataStruct;

interface

uses
  ABase,
  ADataBase,
  ADatabaseStructure,
  ADataUtils;

// --- ADataStruct ---

function ADataStruct_AddTableP(Struct: ADataStructure; const TableName: APascalString): ATableStructure;

function ADataStruct_Clear(Struct: ADataStructure): AError; {$ifdef ADtdCall}stdcall;{$endif}

// --- Data_Struct ---

function Data_Struct_AddTableP(Struct: ADataStructure; const TableName: APascalString): ATableStructure; deprecated {$ifdef ADeprText}'Use ADataStruct_AddTableP()'{$endif};

function Data_Struct_Clear(Struct: ADataStructure): AError; {$ifdef AStdCall}stdcall;{$endif} deprecated {$ifdef ADeprText}'Use ADataStruct_Clear()'{$endif};

implementation

// --- ADataStruct ---

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

// --- Data_Struct ---

function Data_Struct_AddTableP(Struct: ADataStructure; const TableName: APascalString): ATableStructure;
begin
  Result := ADataStruct_AddTableP(Struct, TableName);
end;

function Data_Struct_Clear(Struct: ADataStructure): AError;
begin
  Result := ADataStruct_Clear(Struct);
end;

end.
 