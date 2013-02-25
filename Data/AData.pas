{**
@Author Prof1983 <prof1983@ya.ru>
@Created 13.10.2008
@LastMod 25.02.2013

Analog System.Data.*
}
unit AData;

interface

uses
  ABase,
  ABaseTypes,
  ADataBase,
  ADataConnections,
  ADataMain,
  ADataModelMain,
  ADataStruct,
  ADataTypes;

function Fin(): AError; stdcall;

function Init(): AError; stdcall;

function NewDatabaseW(const DriverName: AWideString): ADataConnection; stdcall;

function NewDatabaseStructure(): ADataStructure; stdcall;

function RegisterDriver(GetProc: ADataDriverGetProc_Proc): AInteger; stdcall;

// --- Database ---

procedure Database_Close(Database: ADataConnection); stdcall;

function Database_Connect(Database: ADataConnection): ABoolean; stdcall;

function Database_CreateDatabase(Database: ADataConnection): ABoolean; stdcall;

procedure Database_Disconnect(Database: ADataConnection); stdcall;

function Database_ExecuteSql(Database: ADataConnection; const Sql: AWideString): ABoolean; stdcall;

function Database_ChangeDataSet(Database: ADataConnection; DataSet: ADataSet; const SelectSql: AWideString): AError; stdcall;

function Database_CheckDatabaseStructure(Database: ADataConnection; Struct: ADataStructure; Logger: AAddToLogA_Proc): ABoolean; stdcall;

function Database_CheckTableStructure(Database: ADataConnection; TableStruct: ATableStructure; Logger: AAddToLogA_Proc): ABoolean; stdcall;

function Database_GetConnected(Database: ADataConnection): Boolean; stdcall;

function Database_GetConnectionString(Database: ADataConnection): AWideString; stdcall;

function Database_NewDataSet(Database: ADataConnection; const SelectSqlText: AWideString; ReadOnly: ABoolean): ADataSet; stdcall;

function Database_NewDataSetA(Database: ADataConnection; const SelectSqlText, UpdateSqlText, InsertSqlText, DeleteSqlText, RefreshSqlText: AWideString): ADataSet; stdcall;

procedure Database_SetConnectionString(Database: ADataConnection; const Value: AWideString); stdcall;

// --- DataSet ---

procedure DataSet_SetReadOnly(DataSet: ADataSet; ReadOnly: ABoolean); stdcall;

// --- Struct ---

function Struct_AddTableWS(Struct: ADataStructure; const TableName: WideString): ATableStructure;

function Struct_Clear(Struct: ADataStructure): AError; stdcall;

implementation

{ Public }

function Fin(): AError;
begin
  Result := AData_Fin();
end;

function Init(): AError;
begin
  Result := AData_Init();
end;

function NewDatabaseStructure(): ADataStructure;
begin
  Result := AData_NewDatabaseStructure();
end;

function NewDatabaseW(const DriverName: AWideString): ADataConnection;
begin
  Result := AData_NewConnectionP(DriverName);
end;

function RegisterDriver(GetProc: ADataDriverGetProc_Proc): AInt;
begin
  Result := AData_RegisterDriver(GetProc);
end;

// --- Database ---

function Database_ChangeDataSet(Database: ADataConnection; DataSet: ADataSet; const SelectSql: AWideString): AError;
begin
  Result := ADataConnection_ChangeDataSetP(Database, DataSet, SelectSql);
end;

function Database_CheckDatabaseStructure(Database: ADataConnection; Struct: ADataStructure; Logger: AAddToLogA_Proc): ABool;
begin
  Result := (ADataConnection_CheckDatabaseStructure(Database, Struct, Logger) >= 0);
end;

function Database_CheckTableStructure(Database: ADataConnection; TableStruct: ATableStructure; Logger: AAddToLogA_Proc): ABool;
begin
  Result := (ADataConnection_CheckTableStructure(Database, TableStruct, Logger) >= 0);
end;

procedure Database_Close(Database: ADataConnection);
begin
  ADataConnection_Close(Database);
end;

function Database_Connect(Database: ADataConnection): ABool;
begin
  Result := (ADataConnection_Connect(Database) >= 0);
end;

function Database_CreateDatabase(Database: ADataConnection): ABool;
begin
  Result := (ADataConnection_CreateDatabase(Database) >= 0);
end;

procedure Database_Disconnect(Database: ADataConnection);
begin
  ADataConnection_Disconnect(Database);
end;

function Database_ExecuteSql(Database: ADataConnection; const Sql: AWideString): ABool;
begin
  Result := (ADataConnection_ExecuteSqlP(Database, Sql) >= 0);
end;

function Database_GetConnected(Database: ADataConnection): ABool;
begin
  Result := ADataConnection_GetConnected(Database);
end;

function Database_GetConnectionString(Database: ADataConnection): AWideString;
begin
  Result := ADataConnection_GetConnectionStringP(Database);
end;

function Database_NewDataSet(Database: ADataConnection; const SelectSqlText: AWideString; ReadOnly: ABool): ADataSet;
begin
  Result := ADataConnection_NewDataSetP(Database, SelectSqlText, ReadOnly);
end;

function Database_NewDataSetA(Database: ADataConnection; const SelectSqlText, UpdateSqlText, InsertSqlText, DeleteSqlText, RefreshSqlText: AWideString): ADataSet;
begin
  Result := ADataConnection_NewDataSetExP(Database, SelectSqlText, UpdateSqlText, InsertSqlText, DeleteSqlText, RefreshSqlText);
end;

procedure Database_SetConnectionString(Database: ADataConnection; const Value: AWideString);
begin
  ADataConnection_SetConnectionStringP(Database, Value);
end;

// --- DataSet ---

procedure DataSet_SetReadOnly(DataSet: ADataSet; ReadOnly: ABool);
begin
  ADataModel_SetReadOnly(DataSet, ReadOnly);
end;

// --- Struct ---

function Struct_AddTableWS(Struct: ADataStructure; const TableName: WideString): ATableStructure;
begin
  Result := ADataStruct_AddTableP(Struct, TableName);
end;

function Struct_Clear(Struct: ADataStructure): AError;
begin
  Result := ADataStruct_Clear(Struct);
end;

end.
