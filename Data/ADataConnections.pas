{**
@Author Prof1983 <prof1983@ya.ru>
@Created 26.12.2012
@LastMod 05.02.2013
}
unit ADataConnections;

interface

uses
  ABase,
  ABaseTypes,
  ADataBase,
  ADataTypes,
  ADataUtils;

function ADataConnection_ChangeDataSetP(Database: ADataConnection; DataSet: ADataSet;
    const SelectSql: APascalString): AError;

function ADataConnection_CheckDatabaseStructure(Database: ADataConnection;
    Struct: ADataStructure; Logger: TAddToLogWSProc): ABoolean;

function ADataConnection_CheckTableStructure(Database: ADataConnection;
    TableStruct: ATableStructure; Logger: TAddToLogWSProc): ABoolean;

function ADataConnection_Close(Database: ADataConnection): AError; {$ifdef AStdCall}stdcall;{$endif}

function ADataConnection_Connect(Database: ADataConnection): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function ADataConnection_CreateDatabase(Database: ADataConnection): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function ADataConnection_Disconnect(Database: ADataConnection): AError; {$ifdef AStdCall}stdcall;{$endif}

function ADataConnection_ExecuteSqlP(Database: ADataConnection;
    const Sql: APascalString): ABoolean;

function ADataConnection_GetConnected(Database: ADataConnection): ABoolean; {$ifdef AStdCall}stdcall;{$endif}

function ADataConnection_GetConnectionStringP(Database: ADataConnection): AWideString;

function ADataConnection_NewDataSet2P(Database: ADataConnection;
    const SelectSqlText, UpdateSqlText, InsertSqlText, DeleteSqlText,
    RefreshSqlText: AWideString): ADataSet;

function ADataConnection_NewDataSetP(Database: ADataConnection;
    const SelectSqlText: APascalString; ReadOnly: ABoolean): ADataSet;

function ADataConnection_SetConnectionStringP(Database: ADataConnection;
    const Value: AWideString): AError;

implementation

{ Database }

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

function ADataConnection_GetConnectionStringP(Database: ADataConnection): AWideString;
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

function ADataConnection_SetConnectionStringP(Database: ADataConnection;
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
