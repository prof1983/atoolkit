{**
@Abstract ћодуль работы с базами и структурами данных
@Author Prof1983 <prof1983@ya.ru>)
@Created 13.10.2008
@LastMod 19.07.2012

Analog System.Data.*
}
unit AData;

interface

uses
  ABase, ABaseTypes, ADataBase;

function Init(): AError; stdcall;
function Done(): AError; stdcall;

function Data_Init(): AError;
function Data_Done(): AError;

function NewDatabaseW(const DriverName: AWideString): ADataConnection; stdcall;
function NewDatabaseStructure(): ADataStructure; stdcall;
function Drivers_RegisterDriver(DataDriver: ADataDriver): AInteger; stdcall;

// Use NewDatabaseW()
function Data_NewDatabase(const DriverName: AWideString): ADataConnection; stdcall; deprecated;
// Use NewDatabaseStructure()
function Data_NewDatabaseStructure: ADataStructure; stdcall; deprecated;
// Use Drivers_RegisterDriver()
function Data_RegisterDriver(DataDriver: ADataDriver): AInteger; stdcall; deprecated;

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

{ Data }

function Data_Done(): AError;
{var
  I: Integer;}
begin
  {for I := 0 to High(FDrivers) do
    FDrivers[I]._Release();
  SetLength(FDrivers, 0);}

  FInitialized := False;
  Result := 0;
end;

function Data_Init(): AError;
begin
  if FInitialized then
  begin
    Result := 0;
    Exit;
  end;

  FInitialized := True;
  Result := 0;
end;

function Data_NewDatabase(const DriverName: AWideString): ADataConnection;
begin
  Result := ADataUtils.Data_NewDatabase(DriverName);
end;

function Data_NewDatabaseStructure: ADataStructure;
begin
  Result := ADataUtils.Data_NewDatabaseStructure();
end;

function Data_RegisterDriver(DataDriver: ADataDriver): Integer;
begin
  Result := ADataUtils.Data_RegisterDriver(DataDriver);
end;

{ Database }

function Database_ChangeDataSet(Database: ADataConnection; DataSet: ADataSet; const SelectSql: AWideString): AError; stdcall;
begin
  try
    ADataUtils.Database_ChangeDataSet(Database, DataSet, SelectSql);
    Result := 0;
  except
    Result := -1;
  end;
end;

function Database_CheckDatabaseStructure(Database: ADataConnection; Struct: ADataStructure; Logger: TAddToLogWSProc): ABoolean; stdcall;
begin
  try
    Result := ADataUtils.Database_CheckDatabaseStructure(Database, Struct, Logger);
  except
    Result := False;
  end;
end;

function Database_CheckTableStructure(Database: ADataConnection; TableStruct: ATableStructure; Logger: TAddToLogWSProc): ABoolean; stdcall;
var
  I: IADatabase;
begin
  I := IADatabase(Database);
  if Assigned(I) then
    Result := I.CheckTableStructure(IATableStructure(TableStruct), Logger)
  else
    Result := False;
end;

procedure Database_Close(Database: ADataConnection); stdcall;
var
  I: IADatabase;
begin
  I := IADatabase(Database);
  if Assigned(I) then
    I.Close;
end;

function Database_Connect(Database: ADataConnection): ABoolean; stdcall;
var
  I: IADatabase;
begin
  I := IADatabase(Database);
  if Assigned(I) then
    Result := I.Connect
  else
    Result := False;
end;

function Database_CreateDatabase(Database: ADataConnection): ABoolean; stdcall;
var
  I: IADatabase;
begin
  I := IADatabase(Database);
  if Assigned(I) then
    Result := I.CreateDatabase
  else
    Result := False;
end;

procedure Database_Disconnect(Database: ADataConnection); stdcall;
var
  I: IADatabase;
begin
  I := IADatabase(Database);
  if Assigned(I) then
    I.Disconnect;
end;

function Database_ExecuteSql(Database: ADataConnection; const Sql: AWideString): ABoolean; stdcall;
var
  I: IADatabase;
begin
  I := IADatabase(Database);
  if Assigned(I) then
    Result := I.ExecuteSql(Sql)
  else
    Result := False;
end;

function Database_GetConnected(Database: ADataConnection): ABoolean; stdcall;
var
  I: IADatabase;
begin
  I := IADatabase(Database);
  if Assigned(I) then
    Result := I.GetConnected
  else
    Result := False;
end;

function Database_GetConnectionString(Database: ADataConnection): AWideString; stdcall;
var
  I: IADatabase;
begin
  I := IADatabase(Database);
  if Assigned(I) then
    Result := I.GetConnectionString
  else
    Result := '';
end;

function Database_NewDataSet(Database: ADataConnection; const SelectSqlText: AWideString; ReadOnly: ABoolean): ADataSet; stdcall;
var
  FDatabase: IADatabase;
begin
  FDatabase := IADatabase(Database);
  FDatabase._AddRef();
  Result := FDatabase.NewDataSet(SelectSqlText, ReadOnly);
  FDatabase._Release();
end;

function Database_NewDataSetA(Database: ADataConnection; const SelectSqlText, UpdateSqlText, InsertSqlText, DeleteSqlText, RefreshSqlText: AWideString): ADataSet; stdcall;
var
  FDatabase: IADatabase;
begin
  FDatabase := IADatabase(Database);
  FDatabase._AddRef();
  Result := FDatabase.NewDataSetA(SelectSqlText, UpdateSqlText, InsertSqlText, DeleteSqlText, RefreshSqlText);
  FDatabase._Release();
end;

procedure Database_SetConnectionString(Database: ADataConnection; const Value: AWideString); stdcall;
begin
  if (Database <> 0) then
  try
    IADatabase(Database).SetConnectionString(Value);
  except
  end;
end;

{ DataSet }

procedure DataSet_SetReadOnly(DataSet: ADataSet; ReadOnly: ABoolean); stdcall;
begin
  // ...
end;

{ Drivers }

function Drivers_RegisterDriver(DataDriver: ADataDriver): AInteger; stdcall;
begin
  try
    Result := ADataUtils.Data_RegisterDriver(DataDriver);
  except
    Result := -1;
  end;
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
