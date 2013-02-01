{**
@Abstract Модуль работы с базами и структурами данных
@Author Prof1983 <prof1983@ya.ru>
@Created 13.10.2008
@LastMod 30.01.2013
}
unit ADataUtils;

interface

uses
  ABase, ABaseTypes, ADataBase, ADataTypes,
  ADatabaseStructure;

function Data_NewDatabase(const DriverName: AWideString): ADataConnection; stdcall;
function Data_NewDatabaseStructure: ADataStructure; stdcall;
function Data_RegisterDriver(DataDriver: ADataDriver): AInteger; stdcall;

function Data_Struct_AddTable(Struct: ADataStructure; const TableName: WideString): ATableStructure;
function Data_Struct_Clear(Struct: ADataStructure): AError;

procedure Database_Close(Database: ADataConnection); stdcall;
function Database_Connect(Database: ADataConnection): ABoolean; stdcall;
function Database_CreateDatabase(Database: ADataConnection): ABoolean; stdcall;
procedure Database_Disconnect(Database: ADataConnection); stdcall;
function Database_ExecuteSql(Database: ADataConnection; const Sql: AWideString): ABoolean; stdcall;

procedure Database_ChangeDataSet(Database: ADataConnection; DataSet: ADataSet; const SelectSql: AWideString);
function Database_CheckDatabaseStructure(Database: ADataConnection; Struct: ADataStructure; Logger: TAddToLogWSProc): ABoolean;
function Database_CheckTableStructure(Database: ADataConnection; TableStruct: ATableStructure; Logger: TAddToLogWSProc): ABoolean; stdcall;
function Database_GetConnected(Database: ADataConnection): Boolean; stdcall;
function Database_GetConnectionString(Database: ADataConnection): AWideString; stdcall;
function Database_NewDataSet(Database: ADataConnection; const SelectSqlText: AWideString; ReadOnly: ABoolean): ADataSet; stdcall;
function Database_NewDataSetA(Database: ADataConnection; const SelectSqlText, UpdateSqlText, InsertSqlText, DeleteSqlText, RefreshSqlText: AWideString): ADataSet; stdcall;
procedure Database_SetConnectionString(Database: ADataConnection; const Value: AWideString); stdcall;

var // TODO: to Private
  FDrivers: array of ADataDriver;
  FInitialized: ABoolean;

implementation

{type
  IADatabaseStructureSignal = interface(IASignal)
    // Подписаться на получение события
    procedure Connect(CallBack: TADatabaseStructureSignalProc);
    // Отписаться от события
    procedure Disconnect(CallBack: TADatabaseStructureSignalProc);
    // Выполнить при возникновении события
    procedure Invoke(Struct: IADatabaseStructure; DatabaseVersion: TADatabaseVersion);
  end;}

var
  FConnections: array of record
    Connection: ADataConnection;
    Driver: ADataDriver;
  end;

{ Private }

function _GetConnectionDriver(Connection: ADataConnection): ADataDriver;
var
  I: Integer;
begin
  for I := 0 to High(FConnections) do
  begin
    if (FConnections[I].Connection = Connection) then
    begin
      Result := FConnections[I].Driver;
      Exit;
    end;
  end;
  Result := 0;
end;

{ Data }

function Data_NewDatabase(const DriverName: AWideString): ADataConnection; stdcall;
var
  I: Integer;
  J: Integer;
  Connection: ADataConnection;
begin
  for I := 0 to High(FDrivers) do
  begin
    if (PDataDriver(FDrivers[I])^.GetName = DriverName) then
    begin
      Connection := PDataDriver(FDrivers[I])^.NewDatabase;
      if (Connection <> 0) then
      begin
        J := Length(FConnections);
        SetLength(FConnections, J+1);
        FConnections[J].Connection := Connection;
        FConnections[J].Driver := FDrivers[I];
      end;
      Result := Connection;
      Exit;
    end;
  end;
  Result := 0;
end;

function Data_NewDatabaseStructure: ADataStructure; stdcall;
begin
  Result := ADataStructure(TADatabaseStructure.Create());
end;

function Data_RegisterDriver(DataDriver: ADataDriver): AInteger; stdcall;
begin
  Result := Length(FDrivers);
  SetLength(FDrivers, Result + 1);
  FDrivers[Result] := DataDriver;
end;

{ Data_Struct }

function Data_Struct_AddTable(Struct: ADataStructure; const TableName: WideString): ATableStructure;
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
  Result := ATableStructure(TADatabaseStructure(Struct).AddTable(TableName));
end;

function Data_Struct_Clear(Struct: ADataStructure): AError;
begin
  if (Struct = 0) then
  begin
    Result := -2;
    Exit;
  end;
  TADatabaseStructure(Struct).Clear();
  Result := 0;
end;

{ Database }

procedure Database_ChangeDataSet(Database: ADataConnection; DataSet: ADataSet; const SelectSql: AWideString);
var
  I: IADatabase;
begin
  I := IADatabase(Database);
  if Assigned(I) then
    I.ChangeDataSet(DataSet, SelectSql);
end;

function Database_CheckDatabaseStructure(Database: ADataConnection; Struct: ADataStructure; Logger: TAddToLogWSProc): ABoolean;
{var
  Driver: ADataDriver;
  //I: IADatabase;}
begin
  Result := True;
  {Driver := _GetConnectionDriver(Database);
  if (Driver = 0) then
  begin
    Result := False;
    Exit;
  end;
  PDataDriver(Driver).Database_CheckDatabaseStructure}
  {I := IADatabase(Database);
  if Assigned(I) then
    Result := I.ChechDatabaseStructure(Struct, Logger)
  else
    Result := False;}
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

end.
 