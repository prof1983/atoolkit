{**
@Author Prof1983 <prof1983@ya.ru>
@Created 26.12.2012
@LastMod 17.04.2013
}
unit ADataConnections;

{$define AStdCall}

interface

uses
  ABase,
  ABaseTypes,
  ADataBase,
  ADataTypes,
  ADataUtils,
  AStringMain;

// --- ADataConnection ---

function ADataConnection_ChangeDataSet(Connection: ADataConnection; DataSet: ADataSet;
    const SelectSql: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function ADataConnection_ChangeDataSetP(Database: ADataConnection; DataSet: ADataSet;
    const SelectSql: APascalString): AError;

function ADataConnection_ChangeDataSetWS(Database: ADataConnection; DataSet: ADataSet;
    const SelectSql: AWideString): AError;

function ADataConnection_CheckDatabaseStructure(Database: ADataConnection;
    Struct: ADataStructure; Logger: TAddToLogWSProc): ABoolean;

function ADataConnection_CheckTableStructure(Database: ADataConnection;
    TableStruct: ATableStructure; Logger: TAddToLogWSProc): ABoolean;

function ADataConnection_Close(Database: ADataConnection): AError; {$ifdef AStdCall}stdcall;{$endif}

function ADataConnection_Connect(Database: ADataConnection): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function ADataConnection_CreateDatabase(Database: ADataConnection): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function ADataConnection_Disconnect(Database: ADataConnection): AError; {$ifdef AStdCall}stdcall;{$endif}

function ADataConnection_ExecuteSql(Connection: ADataConnection;
    const Sql: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function ADataConnection_ExecuteSqlP(Database: ADataConnection;
    const Sql: APascalString): ABoolean;

function ADataConnection_ExecuteSqlWS(Database: ADataConnection;
    const Sql: AWideString): ABoolean;

function ADataConnection_GetConnected(Database: ADataConnection): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function ADataConnection_GetConnectionString(Connection: ADataConnection;
    out ConnectionString: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function ADataConnection_GetConnectionStringP(Database: ADataConnection): APascalString;

function ADataConnection_GetConnectionStringWS(Database: ADataConnection): AWideString;

function ADataConnection_NewDataSet(Connection: ADataConnection;
    const SelectSqlText: AString_Type; ReadOnly: ABool): ADataSet; {$ifdef AStdCall}stdcall;{$endif}

function ADataConnection_NewDataSet2P(Database: ADataConnection;
    const SelectSqlText, UpdateSqlText, InsertSqlText, DeleteSqlText,
    RefreshSqlText: AWideString): ADataSet;

function ADataConnection_NewDataSet2WS(Database: ADataConnection;
    const SelectSqlText, UpdateSqlText, InsertSqlText, DeleteSqlText,
    RefreshSqlText: AWideString): ADataSet;

function ADataConnection_NewDataSetEx(Connection: ADataConnection;
    const SelectSqlText, UpdateSqlText, InsertSqlText, DeleteSqlText,
    RefreshSqlText: AString_Type): ADataSet; {$ifdef AStdCall}stdcall;{$endif}

function ADataConnection_NewDataSetExP(Connection: ADataConnection;
    const SelectSqlText, UpdateSqlText, InsertSqlText, DeleteSqlText,
    RefreshSqlText: APascalString): ADataSet;

function ADataConnection_NewDataSetP(Database: ADataConnection;
    const SelectSqlText: APascalString; ReadOnly: ABoolean): ADataSet;

function ADataConnection_NewDataSetWS(Database: ADataConnection;
    const SelectSqlText: AWideString; ReadOnly: ABoolean): ADataSet;

function ADataConnection_SetConnectionString(Connection: ADataConnection;
    const Value: AString_Type): AError; {$ifdef AStdCall}stdcall;{$endif}

function ADataConnection_SetConnectionStringP(Connection: ADataConnection;
    const Value: APascalString): AError;

function ADataConnection_SetConnectionStringWS(Database: ADataConnection;
    const Value: AWideString): AError;

implementation

// --- ADataConnection ---

function ADataConnection_ChangeDataSet(Connection: ADataConnection; DataSet: ADataSet;
    const SelectSql: AString_Type): AError;
begin
  Result := ADataConnection_ChangeDataSetP(Connection, DataSet, AString_ToP(SelectSql));
end;

function ADataConnection_ChangeDataSetP(Database: ADataConnection; DataSet: ADataSet;
    const SelectSql: APascalString): AError;
begin
  try
    ADataUtils.Database_ChangeDataSet(Database, DataSet, SelectSql);
    Result := 0;
  except
    Result := -1;
  end;
end;

function ADataConnection_ChangeDataSetWS(Database: ADataConnection; DataSet: ADataSet;
    const SelectSql: AWideString): AError;
begin
  try
    ADataUtils.Database_ChangeDataSet(Database, DataSet, SelectSql);
    Result := 0;
  except
    Result := -1;
  end;
end;

function ADataConnection_CheckDatabaseStructure(Database: ADataConnection;
    Struct: ADataStructure; Logger: TAddToLogWSProc): ABoolean;
begin
  try
    Result := ADataUtils.Database_CheckDatabaseStructure(Database, Struct, Logger);
  except
    Result := False;
  end;
end;

function ADataConnection_CheckTableStructure(Database: ADataConnection;
    TableStruct: ATableStructure; Logger: TAddToLogWSProc): ABoolean;
var
  I: IADatabase;
begin
  try
    I := IADatabase(Database);
    if Assigned(I) then
      Result := I.CheckTableStructure(IATableStructure(TableStruct), Logger)
    else
      Result := False;
  except
    Result := False;
  end;
end;

function ADataConnection_Close(Database: ADataConnection): AError;
var
  I: IADatabase;
begin
  try
    I := IADatabase(Database);
    if not(Assigned(I)) then
    begin
      Result := -2;
      Exit;
    end;
    I.Close();
    Result := 0;
  except
    Result := -1;
  end;
end;

function ADataConnection_Connect(Database: ADataConnection): ABoolean;
var
  I: IADatabase;
begin
  try
    I := IADatabase(Database);
    if Assigned(I) then
      Result := I.Connect
    else
      Result := False;
  except
    Result := False;
  end;
end;

function ADataConnection_CreateDatabase(Database: ADataConnection): ABoolean;
var
  I: IADatabase;
begin
  try
    I := IADatabase(Database);
    if Assigned(I) then
      Result := I.CreateDatabase
    else
      Result := False;
  except
    Result := False;
  end;
end;

function ADataConnection_Disconnect(Database: ADataConnection): AError;
var
  I: IADatabase;
begin
  try
    I := IADatabase(Database);
    if not(Assigned(I)) then
    begin
      Result := -2;
      Exit;
    end;
    I.Disconnect();
    Result := 0;
  except
    Result := -1;
  end;
end;

function ADataConnection_ExecuteSql(Connection: ADataConnection;
    const Sql: AString_Type): AError;
begin
  if ADataConnection_ExecuteSqlP(Connection, AString_ToP(Sql)) then
    Result := 0
  else
    Result := -1;
end;

function ADataConnection_ExecuteSqlP(Database: ADataConnection;
    const Sql: APascalString): ABoolean;
var
  I: IADatabase;
begin
  try
    I := IADatabase(Database);
    if Assigned(I) then
      Result := I.ExecuteSql(Sql)
    else
      Result := False;
  except
    Result := False;
  end;
end;

function ADataConnection_ExecuteSqlWS(Database: ADataConnection;
    const Sql: AWideString): ABoolean;
var
  I: IADatabase;
begin
  try
    I := IADatabase(Database);
    if Assigned(I) then
      Result := I.ExecuteSql(Sql)
    else
      Result := False;
  except
    Result := False;
  end;
end;

function ADataConnection_GetConnected(Database: ADataConnection): ABoolean;
var
  I: IADatabase;
begin
  try
    I := IADatabase(Database);
    if Assigned(I) then
      Result := I.GetConnected
    else
      Result := False;
  except
    Result := False;
  end;
end;

function ADataConnection_GetConnectionString(Connection: ADataConnection;
    out ConnectionString: AString_Type): AError;
begin
  Result := AString_AssignP(
      ConnectionString,
      ADataConnection_GetConnectionStringP(Connection));
end;

function ADataConnection_GetConnectionStringP(Database: ADataConnection): APascalString;
begin
  Result := ADataConnection_GetConnectionStringWS(Database);
end;

function ADataConnection_GetConnectionStringWS(Database: ADataConnection): AWideString;
var
  I: IADatabase;
begin
  try
    I := IADatabase(Database);
    if Assigned(I) then
      Result := I.GetConnectionString
    else
      Result := '';
  except
    Result := '';
  end;
end;

function ADataConnection_NewDataSet(Connection: ADataConnection;
    const SelectSqlText: AString_Type; ReadOnly: ABool): ADataSet;
begin
  Result := ADataConnection_NewDataSetP(Connection, AString_ToP(SelectSqlText), ReadOnly);
end;

function ADataConnection_NewDataSet2P(Database: ADataConnection;
    const SelectSqlText, UpdateSqlText, InsertSqlText, DeleteSqlText,
    RefreshSqlText: AWideString): ADataSet;
var
  FDatabase: IADatabase;
begin
  try
    FDatabase := IADatabase(Database);
    FDatabase._AddRef();
    Result := FDatabase.NewDataSetA(SelectSqlText, UpdateSqlText, InsertSqlText, DeleteSqlText, RefreshSqlText);
    FDatabase._Release();
  except
    Result := 0;
  end;
end;

function ADataConnection_NewDataSet2WS(Database: ADataConnection;
    const SelectSqlText, UpdateSqlText, InsertSqlText, DeleteSqlText,
    RefreshSqlText: AWideString): ADataSet;
var
  FDatabase: IADatabase;
begin
  try
    FDatabase := IADatabase(Database);
    FDatabase._AddRef();
    Result := FDatabase.NewDataSetA(SelectSqlText, UpdateSqlText, InsertSqlText, DeleteSqlText, RefreshSqlText);
    FDatabase._Release();
  except
    Result := 0;
  end;
end;

function ADataConnection_NewDataSetEx(Connection: ADataConnection;
    const SelectSqlText, UpdateSqlText, InsertSqlText, DeleteSqlText,
    RefreshSqlText: AString_Type): ADataSet;
begin
  Result := ADataConnection_NewDataSetExP(
      Connection,
      AString_ToP(SelectSqlText),
      AString_ToP(UpdateSqlText),
      AString_ToP(InsertSqlText),
      AString_ToP(DeleteSqlText),
      AString_ToP(RefreshSqlText));
end;

function ADataConnection_NewDataSetExP(Connection: ADataConnection;
    const SelectSqlText, UpdateSqlText, InsertSqlText, DeleteSqlText,
    RefreshSqlText: APascalString): ADataSet;
begin
  Result := ADataConnection_NewDataSet2WS(Connection, SelectSqlText, UpdateSqlText,
      InsertSqlText, DeleteSqlText, RefreshSqlText);
end;

function ADataConnection_NewDataSetP(Database: ADataConnection;
    const SelectSqlText: APascalString; ReadOnly: ABoolean): ADataSet;
var
  FDatabase: IADatabase;
begin
  try
    FDatabase := IADatabase(Database);
    FDatabase._AddRef();
    Result := FDatabase.NewDataSet(SelectSqlText, ReadOnly);
    FDatabase._Release();
  except
    Result := 0;
  end;
end;

function ADataConnection_NewDataSetWS(Database: ADataConnection;
    const SelectSqlText: AWideString; ReadOnly: ABoolean): ADataSet;
var
  FDatabase: IADatabase;
begin
  try
    FDatabase := IADatabase(Database);
    FDatabase._AddRef();
    Result := FDatabase.NewDataSet(SelectSqlText, ReadOnly);
    FDatabase._Release();
  except
    Result := 0;
  end;
end;

function ADataConnection_SetConnectionString(Connection: ADataConnection;
    const Value: AString_Type): AError;
begin
  Result := ADataConnection_SetConnectionStringP(Connection, AString_ToP(Value));
end;

function ADataConnection_SetConnectionStringP(Connection: ADataConnection;
    const Value: APascalString): AError;
begin
  Result := ADataConnection_SetConnectionStringWS(Connection, Value);
end;

function ADataConnection_SetConnectionStringWS(Database: ADataConnection;
    const Value: AWideString): AError;
begin
  if (Database = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    IADatabase(Database).SetConnectionString(Value);
    Result := 0;
  except
    Result := -1;
  end;
end;

end.
