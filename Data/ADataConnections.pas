{**
@Author Prof1983 <prof1983@ya.ru>
@Created 26.12.2012
@LastMod 25.02.2013
}
unit ADataConnections;

interface

uses
  ABase,
  ABaseTypes,
  ADataBase,
  ADataPrivData,
  ADataTypes,
  ADataUtils,
  AStringMain;

// --- ADataConnection ---

function ADataConnection_ChangeDataSetP(Connection: ADataConnection; DataSet: ADataSet;
    const SelectSql: APascalString): AError;

function ADataConnection_CheckDatabaseStructure(Connection: ADataConnection;
    Struct: ADataStructure; Logger: AAddToLogA_Proc): AError; {$ifdef AStdCall}stdcall;{$endif}

function ADataConnection_CheckTableStructure(Connection: ADataConnection;
    TableStruct: ATableStructure; Logger: AAddToLogA_Proc): AError; {$ifdef AStdCall}stdcall;{$endif}

function ADataConnection_Close(Connection: ADataConnection): AError; {$ifdef AStdCall}stdcall;{$endif}

function ADataConnection_Connect(Connection: ADataConnection): AError; {$ifdef AStdCall}stdcall;{$endif}

function ADataConnection_CreateDatabase(Connection: ADataConnection): AError; {$ifdef AStdCall}stdcall;{$endif}

function ADataConnection_Disconnect(Connection: ADataConnection): AError; {$ifdef AStdCall}stdcall;{$endif}

function ADataConnection_ExecuteSqlP(Connection: ADataConnection;
    const Sql: APascalString): AError;

function ADataConnection_GetConnected(Connection: ADataConnection): ABool; {$ifdef AStdCall}stdcall;{$endif}

function ADataConnection_GetConnectionStringP(Connection: ADataConnection): APascalString;

function ADataConnection_NewDataSetExP(Connection: ADataConnection;
    const SelectSqlText, UpdateSqlText, InsertSqlText, DeleteSqlText,
    RefreshSqlText: AWideString): ADataSet;

function ADataConnection_NewDataSetP(Connection: ADataConnection;
    const SelectSqlText: APascalString; ReadOnly: ABool): ADataSet;

function ADataConnection_SetConnectionStringP(Connection: ADataConnection;
    const Value: AWideString): AError;

// --- Database ---

function Database_ChangeDataSetP(Connection: ADataConnection; DataSet: ADataSet;
    const SelectSql: APascalString): AError;

function Database_CheckDatabaseStructure(Connection: ADataConnection; Struct: ADataStructure;
    Logger: AAddToLogA_Proc): AError; {$ifdef AStdCall}stdcall;{$endif}

function Database_CheckTableStructure(Connection: ADataConnection; TableStruct: ATableStructure;
    Logger: AAddToLogA_Proc): AError; {$ifdef AStdCall}stdcall;{$endif}

function Database_Close(Connection: ADataConnection): AError; {$ifdef AStdCall}stdcall;{$endif}

function Database_Connect(Connection: ADataConnection): AError; {$ifdef AStdCall}stdcall;{$endif}

function Database_CreateDatabase(Connection: ADataConnection): AError; {$ifdef AStdCall}stdcall;{$endif}

function Database_Disconnect(Connection: ADataConnection): AError; {$ifdef AStdCall}stdcall;{$endif}

function Database_ExecuteSqlP(Connection: ADataConnection; const Sql: APascalString): AError;

function Database_GetConnected(Connection: ADataConnection): ABool; {$ifdef AStdCall}stdcall;{$endif}

function Database_GetConnectionStringP(Connection: ADataConnection): APascalString;

function Database_NewDataSet2P(Connection: ADataConnection; const SelectSqlText, UpdateSqlText,
    InsertSqlText, DeleteSqlText, RefreshSqlText: APascalString): ADataSet;

function Database_NewDataSetP(Connection: ADataConnection; const SelectSqlText: APascalString;
    ReadOnly: ABool): ADataSet;

function Database_SetConnectionStringP(Connection: ADataConnection; const Value: APascalString): AError;

implementation

// --- Private ---

function _Connection_ChangeDataSet(Index: AInt; DataSet: ADataSet;
    const SelectSql: APascalString): AError;
var
  IDriver: AInt;
  S: AString_Type;
begin
  IDriver := _FindDriver(FConnections[Index].Driver);
  if (IDriver < 0) then
  begin
    Result := -10;
    Exit;
  end;
  AString_SetP(S, SelectSql);
  Result := FDrivers[IDriver].Procs.Connection_ChangeDataSet(FConnections[Index].Id, DataSet, S);
end;

function _Connection_CheckDatabaseStructure(Index: AInt; Struct: ADataStructure;
    Logger: AAddToLogA_Proc): AError;
var
  IDriver: AInt;
begin
  IDriver := _FindDriver(FConnections[Index].Driver);
  if (IDriver < 0) then
  begin
    Result := -10;
    Exit;
  end;
  Result := FDrivers[IDriver].Procs.Connection_CheckDatabaseStructure(FConnections[Index].Id, Struct, Logger);
end;

function _Connection_CheckTableStructure(Index: AInt; TableStruct: ATableStructure;
    Logger: AAddToLogA_Proc): AError;
var
  IDriver: AInt;
begin
  IDriver := _FindDriver(FConnections[Index].Driver);
  if (IDriver < 0) then
  begin
    Result := -10;
    Exit;
  end;
  Result := FDrivers[IDriver].Procs.Connection_CheckTableStructure(FConnections[Index].Id, TableStruct, Logger);
end;

function _Connection_Close(Index: AInt): AError;
var
  IDriver: AInt;
begin
  IDriver := _FindDriver(FConnections[Index].Driver);
  if (IDriver < 0) then
  begin
    Result := -10;
    Exit;
  end;
  Result := FDrivers[IDriver].Procs.Connection_Close(FConnections[Index].Id);
end;

function _Connection_Connect(Index: AInt): AError;
var
  IDriver: AInt;
begin
  IDriver := _FindDriver(FConnections[Index].Id);
  if (IDriver < 0) then
  begin
    Result := -10;
    Exit;
  end;
  Result := FDrivers[IDriver].Procs.Connection_Connect(FConnections[Index].Id);
end;

function _Connection_CreateDatabase(Index: AInt): AError;
var
  IDriver: AInt;
begin
  IDriver := _FindDriver(FConnections[Index].Id);
  if (IDriver < 0) then
  begin
    Result := -10;
    Exit;
  end;
  Result := FDrivers[IDriver].Procs.Connection_CreateDatabase(FConnections[Index].Id);
end;

function _Connection_Disconnect(Index: AInt): AError;
var
  IDriver: AInt;
begin
  IDriver := _FindDriver(FConnections[Index].Id);
  if (IDriver < 0) then
  begin
    Result := -10;
    Exit;
  end;
  Result := FDrivers[IDriver].Procs.Connection_Disconnect(FConnections[Index].Id);
end;

function _Connection_ExecuteSql(Index: AInt; const Sql: APascalString): AError;
var
  IDriver: AInt;
  S: AString_Type;
begin
  IDriver := _FindDriver(FConnections[Index].Id);
  if (IDriver < 0) then
  begin
    Result := -10;
    Exit;
  end;
  AString_SetP(S, Sql);
  Result := FDrivers[IDriver].Procs.Connection_ExecuteSql(FConnections[Index].Id, S);
end;

function _Connection_GetConnected(Index: AInt): ABool;
var
  IDriver: AInt;
begin
  IDriver := _FindDriver(FConnections[Index].Id);
  if (IDriver < 0) then
  begin
    Result := False;
    Exit;
  end;
  Result := FDrivers[IDriver].Procs.Connection_GetConnected(FConnections[Index].Id);
end;

function _Connection_GetConnectionString(Index: AInt): APascalString;
var
  IDriver: AInt;
  S: AString_Type;
begin
  IDriver := _FindDriver(FConnections[Index].Id);
  if (IDriver < 0) then
  begin
    Result := '';
    Exit;
  end;
  AString_Clear(S);
  if (FDrivers[IDriver].Procs.Connection_GetConnectionString(FConnections[Index].Id, S) < 0) then
  begin
    Result := '';
    Exit;
  end;
  Result := AString_ToPascalString(S);
end;

function _Connection_NewDataSet(Index: AInt; const SelectSqlText: APascalString; ReadOnly: ABool): ADataSet;
var
  IDriver: AInt;
  S: AString_Type;
begin
  IDriver := _FindDriver(FConnections[Index].Id);
  if (IDriver < 0) then
  begin
    Result := -10;
    Exit;
  end;
  AString_SetP(S, SelectSqlText);
  Result := FDrivers[IDriver].Procs.Connection_NewDataSet(FConnections[Index].Id, S, ReadOnly);
end;

function _Connection_NewDataSetEx(Index: AInt; const SelectSqlText, UpdateSqlText, InsertSqlText,
    DeleteSqlText, RefreshSqlText: APascalString): ADataSet;
var
  IDriver: AInt;
  SSelectSqlText: AString_Type;
  SUpdateSqlText: AString_Type;
  SInsertSqlText: AString_Type;
  SDeleteSqlText: AString_Type;
  SRefreshSqlText: AString_Type;
begin
  IDriver := _FindDriver(FConnections[Index].Id);
  if (IDriver < 0) then
  begin
    Result := -10;
    Exit;
  end;
  AString_SetP(SSelectSqlText, SelectSqlText);
  AString_SetP(SUpdateSqlText, UpdateSqlText);
  AString_SetP(SInsertSqlText, InsertSqlText);
  AString_SetP(SDeleteSqlText, DeleteSqlText);
  AString_SetP(SRefreshSqlText, RefreshSqlText);
  Result := FDrivers[IDriver].Procs.Connection_NewDataSetEx(FConnections[Index].Id,
      SSelectSqlText, SUpdateSqlText, SInsertSqlText, SDeleteSqlText, SRefreshSqlText);
end;

function _Connection_SetConnectionString(Index: AInt; const Value: APascalString): AError;
var
  IDriver: AInt;
  S: AString_Type;
begin
  IDriver := _FindDriver(FConnections[Index].Id);
  if (IDriver < 0) then
  begin
    Result := -10;
    Exit;
  end;
  AString_SetP(S, Value);
  Result := FDrivers[IDriver].Procs.Connection_SetConnectionString(FConnections[Index].Id, S);
end;

// --- ADataConnection ---

function ADataConnection_ChangeDataSetP(Connection: ADataConnection; DataSet: ADataSet;
    const SelectSql: APascalString): AError;
var
  I: AInt;
begin
  if (Connection = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    I := _FindConnection(Connection);
    if (I < 0) then
    begin
      Result := -3;
      Exit;
    end;
    Result := _Connection_ChangeDataSet(I, DataSet, SelectSql);
  except
    Result := -1;
  end;
end;

function ADataConnection_CheckDatabaseStructure(Connection: ADataConnection;
    Struct: ADataStructure; Logger: AAddToLogA_Proc): AError;
var
  I: AInt;
begin
  if (Connection = 0) then
  begin
    Result := -2;
    Exit;
  end;
  I := _FindConnection(Connection);
  if (I < 0) then
  begin
    Result := -3;
    Exit;
  end;
  Result := _Connection_CheckDatabaseStructure(I, Struct, Logger);
end;

function ADataConnection_CheckTableStructure(Connection: ADataConnection;
    TableStruct: ATableStructure; Logger: AAddToLogA_Proc): AError;
var
  I: AInt;
begin
  if (Connection = 0) then
  begin
    Result := -2;
    Exit;
  end;
  I := _FindConnection(Connection);
  if (I < 0) then
  begin
    Result := -3;
    Exit;
  end;
  Result := _Connection_CheckTableStructure(I, TableStruct, Logger);
end;

function ADataConnection_Close(Connection: ADataConnection): AError;
var
  I: AInt;
begin
  if (Connection = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    I := _FindConnection(Connection);
    if (I < 0) then
    begin
      Result := -3;
      Exit;
    end;
    Result := _Connection_Close(I);
  except
    Result := -1;
  end;
end;

function ADataConnection_Connect(Connection: ADataConnection): AError;
var
  I: AInt;
begin
  if (Connection = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    I := _FindConnection(Connection);
    if (I < 0) then
    begin
      Result := -3;
      Exit;
    end;
    Result := _Connection_Connect(I);
  except
    Result := -1;
  end;
end;

function ADataConnection_CreateDatabase(Connection: ADataConnection): AError;
var
  I: AInt;
begin
  if (Connection = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    I := _FindConnection(Connection);
    if (I < 0) then
    begin
      Result := -3;
      Exit;
    end;
    Result := _Connection_CreateDatabase(I);
  except
    Result := -1;
  end;
end;

function ADataConnection_Disconnect(Connection: ADataConnection): AError;
var
  I: AInt;
begin
  if (Connection = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    I := _FindConnection(Connection);
    if (I < 0) then
    begin
      Result := -3;
      Exit;
    end;
    Result := _Connection_Disconnect(I);
  except
    Result := -1;
  end;
end;

function ADataConnection_ExecuteSqlP(Connection: ADataConnection;
    const Sql: APascalString): AError;
var
  I: AInt;
begin
  if (Connection < 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    I := _FindConnection(Connection);
    if (I < 0) then
    begin
      Result := -3;
      Exit;
    end;
    Result := _Connection_ExecuteSql(I, Sql)
  except
    Result := -1;
  end;
end;

function ADataConnection_GetConnected(Connection: ADataConnection): ABool;
var
  I: AInt;
begin
  if (Connection < 0) then
  begin
    Result := False;
    Exit;
  end;
  try
    I := _FindConnection(Connection);
    if (I < 0) then
    begin
      Result := False;
      Exit;
    end;
    Result := _Connection_GetConnected(I);
  except
    Result := False;
  end;
end;

function ADataConnection_GetConnectionStringP(Connection: ADataConnection): APascalString;
var
  I: AInt;
begin
  if (Connection < 0) then
  begin
    Result := '';
    Exit;
  end;
  try
    I := _FindConnection(Connection);
    if (I < 0) then
    begin
      Result := '';
      Exit;
    end;
    Result := _Connection_GetConnectionString(I);
  except
    Result := '';
  end;
end;

function ADataConnection_NewDataSetExP(Connection: ADataConnection;
    const SelectSqlText, UpdateSqlText, InsertSqlText, DeleteSqlText,
    RefreshSqlText: APascalString): ADataSet;
var
  I: AInt;
begin
  if (Connection = 0) then
  begin
    Result := 0;
    Exit;
  end;
  try
    I := _FindConnection(Connection);
    if (I < 0) then
    begin
      Result := 0;
      Exit;
    end;
    Result := _Connection_NewDataSetEx(I, SelectSqlText, UpdateSqlText, InsertSqlText, DeleteSqlText, RefreshSqlText);
  except
    Result := 0;
  end;
end;

function ADataConnection_NewDataSetP(Connection: ADataConnection;
    const SelectSqlText: APascalString; ReadOnly: ABool): ADataSet;
var
  I: AInt;
begin
  if (Connection = 0) then
  begin
    Result := 0;
    Exit;
  end;
  try
    I := _FindConnection(Connection);
    if (I < 0) then
    begin
      Result := 0;
      Exit;
    end;
    Result := _Connection_NewDataSet(I, SelectSqlText, ReadOnly);
  except
    Result := 0;
  end;
end;

function ADataConnection_SetConnectionStringP(Connection: ADataConnection;
    const Value: APascalString): AError;
var
  I: AInt;
begin
  if (Connection = 0) then
  begin
    Result := -2;
    Exit;
  end;
  try
    I := _FindConnection(Connection);
    if (I < 0) then
    begin
      Result := -3;
      Exit;
    end;
    Result := _Connection_SetConnectionString(I, Value);
  except
    Result := -1;
  end;
end;

// --- Database ---

function Database_ChangeDataSetP(Connection: ADataConnection; DataSet: ADataSet;
    const SelectSql: APascalString): AError;
begin
  Result := ADataConnection_ChangeDataSetP(Connection, DataSet, SelectSql);
end;

function Database_CheckDatabaseStructure(Connection: ADataConnection; Struct: ADataStructure;
    Logger: AAddToLogA_Proc): AError;
begin
  Result := ADataConnection_CheckDatabaseStructure(Connection, Struct, Logger);
end;

function Database_CheckTableStructure(Connection: ADataConnection; TableStruct: ATableStructure;
    Logger: AAddToLogA_Proc): AError;
begin
  Result := ADataConnection_CheckTableStructure(Connection, TableStruct, Logger);
end;

function Database_Close(Connection: ADataConnection): AError;
begin
  Result := ADataConnection_Close(Connection);
end;

function Database_Connect(Connection: ADataConnection): AError;
begin
  Result := ADataConnection_Connect(Connection);
end;

function Database_CreateDatabase(Connection: ADataConnection): AError;
begin
  Result := ADataConnection_CreateDatabase(Connection);
end;

function Database_Disconnect(Connection: ADataConnection): AError;
begin
  Result := ADataConnection_Disconnect(Connection);
end;

function Database_ExecuteSqlP(Connection: ADataConnection; const Sql: APascalString): AError;
begin
  Result := ADataConnection_ExecuteSqlP(Connection, Sql);
end;

function Database_GetConnected(Connection: ADataConnection): ABool;
begin
  Result := ADataConnection_GetConnected(Connection);
end;

function Database_GetConnectionStringP(Connection: ADataConnection): APascalString;
begin
  Result := ADataConnection_GetConnectionStringP(Connection);
end;

function Database_NewDataSet2P(Connection: ADataConnection; const SelectSqlText, UpdateSqlText,
    InsertSqlText, DeleteSqlText, RefreshSqlText: APascalString): ADataSet;
begin
  Result := ADataConnection_NewDataSetExP(Connection, SelectSqlText, UpdateSqlText, InsertSqlText,
      DeleteSqlText, RefreshSqlText);
end;

function Database_NewDataSetP(Connection: ADataConnection; const SelectSqlText: APascalString;
    ReadOnly: ABool): ADataSet;
begin
  Result := ADataConnection_NewDataSetP(Connection, SelectSqlText, ReadOnly);
end;

function Database_SetConnectionStringP(Connection: ADataConnection; const Value: APascalString): AError;
begin
  Result := ADataConnection_SetConnectionStringP(Connection, Value);
end;

end.
