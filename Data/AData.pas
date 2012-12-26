{**
@Abstract ћодуль работы с базами и структурами данных
@Author Prof1983 <prof1983@ya.ru>)
@Created 13.10.2008
@LastMod 26.12.2012

Analog System.Data.*
}
unit AData;

interface

uses
  ABase,
  ABaseTypes,
  ADataBase,
  ADataConnections,
  ADataMain;

function Init(): AError; stdcall;
function Done(): AError; stdcall;

function NewDatabaseW(const DriverName: AWideString): ADataConnection; stdcall;
function NewDatabaseStructure(): ADataStructure; stdcall;
function Drivers_RegisterDriver(DataDriver: ADataDriver): AInteger; stdcall;

procedure Database_Close(Database: ADataConnection); stdcall;
function Database_Connect(Database: ADataConnection): ABoolean; stdcall;
function Database_CreateDatabase(Database: ADataConnection): ABoolean; stdcall;
procedure Database_Disconnect(Database: ADataConnection); stdcall;
function Database_ExecuteSql(Database: ADataConnection; const Sql: AWideString): ABoolean; stdcall;

function Database_ChangeDataSet(Database: ADataConnection; DataSet: ADataSet; const SelectSql: AWideString): AError; stdcall;
function Database_CheckDatabaseStructure(Database: ADataConnection; Struct: ADataStructure; Logger: TAddToLogWSProc): ABoolean; stdcall;
function Database_CheckTableStructure(Database: ADataConnection; TableStruct: ATableStructure; Logger: TAddToLogWSProc): ABoolean; stdcall;
function Database_GetConnected(Database: ADataConnection): Boolean; stdcall;
function Database_GetConnectionString(Database: ADataConnection): AWideString; stdcall;
function Database_NewDataSet(Database: ADataConnection; const SelectSqlText: AWideString; ReadOnly: ABoolean): ADataSet; stdcall;
function Database_NewDataSetA(Database: ADataConnection; const SelectSqlText, UpdateSqlText, InsertSqlText, DeleteSqlText, RefreshSqlText: AWideString): ADataSet; stdcall;
procedure Database_SetConnectionString(Database: ADataConnection; const Value: AWideString); stdcall;

procedure DataSet_SetReadOnly(DataSet: ADataSet; ReadOnly: ABoolean); stdcall;

// --- Struct ---

function Struct_AddTableWS(Struct: ADataStructure; const TableName: WideString): ATableStructure;
function Struct_Clear(Struct: ADataStructure): AError; stdcall;

{function Driver_GetName: AWideString;
function Driver_NewDatabase: PADatabase;}

implementation

uses
  ADataUtils, ADataTypes;

{ Public }

function NewDatabaseW(const DriverName: AWideString): ADataConnection; stdcall;
begin
  try
    Result := ADataUtils.Data_NewDatabase(DriverName);
  except
    Result := 0;
  end;
end;

function NewDatabaseStructure(): ADataStructure; stdcall;
begin
  try
    Result := ADataUtils.Data_NewDatabaseStructure();
  except
    Result := 0;
  end;
end;

{ Database }

function Database_ChangeDataSet(Database: ADataConnection; DataSet: ADataSet; const SelectSql: AWideString): AError; stdcall;
begin
  Result := ADataConnection_ChangeDataSetWS(Database, DataSet, SelectSql);
end;

function Database_CheckDatabaseStructure(Database: ADataConnection; Struct: ADataStructure; Logger: TAddToLogWSProc): ABoolean; stdcall;
begin
  Result := ADataConnection_CheckDatabaseStructure(Database, Struct, Logger);
end;

function Database_CheckTableStructure(Database: ADataConnection; TableStruct: ATableStructure; Logger: TAddToLogWSProc): ABoolean; stdcall;
begin
  Result := ADataConnection_CheckTableStructure(Database, TableStruct, Logger);
end;

procedure Database_Close(Database: ADataConnection); stdcall;
begin
  ADataConnection_Close(Database);
end;

function Database_Connect(Database: ADataConnection): ABoolean; stdcall;
begin
  Result := ADataConnection_Connect(Database);
end;

function Database_CreateDatabase(Database: ADataConnection): ABoolean; stdcall;
begin
  Result := ADataConnection_CreateDatabase(Database);
end;

procedure Database_Disconnect(Database: ADataConnection); stdcall;
begin
  ADataConnection_Disconnect(Database);
end;

function Database_ExecuteSql(Database: ADataConnection; const Sql: AWideString): ABoolean; stdcall;
begin
  Result := ADataConnection_ExecuteSqlWS(Database, Sql);
end;

function Database_GetConnected(Database: ADataConnection): ABoolean; stdcall;
begin
  Result := ADataConnection_GetConnected(Database);
end;

function Database_GetConnectionString(Database: ADataConnection): AWideString; stdcall;
begin
  Result := ADataConnection_GetConnectionStringWS(Database);
end;

function Database_NewDataSet(Database: ADataConnection; const SelectSqlText: AWideString; ReadOnly: ABoolean): ADataSet; stdcall;
begin
  Result := ADataConnection_NewDataSetWS(Database, SelectSqlText, ReadOnly);
end;

function Database_NewDataSetA(Database: ADataConnection; const SelectSqlText, UpdateSqlText, InsertSqlText, DeleteSqlText, RefreshSqlText: AWideString): ADataSet; stdcall;
begin
  Result := ADataConnection_NewDataSet2WS(Database, SelectSqlText, UpdateSqlText, InsertSqlText, DeleteSqlText, RefreshSqlText);
end;

procedure Database_SetConnectionString(Database: ADataConnection; const Value: AWideString); stdcall;
begin
  ADataConnection_SetConnectionStringWS(Database, Value);
end;

{ DataSet }

procedure DataSet_SetReadOnly(DataSet: ADataSet; ReadOnly: ABoolean); stdcall;
begin
  // ...
end;

{ Drivers }

function Drivers_RegisterDriver(DataDriver: ADataDriver): AInteger; stdcall;
begin
  Result := AData_RegisterDriver(DataDriver);
end;

{ Struct }

function Struct_AddTableWS(Struct: ADataStructure; const TableName: WideString): ATableStructure;
begin
  try
    Result := Data_Struct_AddTable(Struct, TableName);
  except
    Result := 0;
  end;
end;

function Struct_Clear(Struct: ADataStructure): AError; stdcall;
begin
  try
    Result := Data_Struct_Clear(Struct);
  except
    Result := -1;
  end;
end;

{ Module }

function Done(): AError; stdcall;
begin
  Result := Data_Done();
end;

function Init(): AError; stdcall;
begin
  Result := Data_Init();
end;

end.
