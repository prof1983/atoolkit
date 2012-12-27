{**
@Author Prof1983 <prof1983@ya.ru>
@Created 27.12.2012
@LastMod 27.12.2012
}
unit ADataStruct;

interface

uses
  ABase,
  ADataBase,
  ADataUtils;

function ADataStruct_AddTableP(Struct: ADataStructure; const TableName: APascalString): ATableStructure; {$ifdef ADtdCall}stdcall;{$endif}

function ADataStruct_Clear(Struct: ADataStructure): AError; {$ifdef ADtdCall}stdcall;{$endif}

implementation

// --- ADataStruct ---

function ADataStruct_AddTableP(Struct: ADataStructure; const TableName: APascalString): ATableStructure;
begin
  try
    Result := Data_Struct_AddTable(Struct, TableName);
  except
    Result := 0;
  end;
end;

function ADataStruct_Clear(Struct: ADataStructure): AError;
begin
  try
    Result := Data_Struct_Clear(Struct);
  except
    Result := -1;
  end;
end;

end.
 