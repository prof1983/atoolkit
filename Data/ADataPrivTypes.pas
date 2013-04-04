{**
@Author Prof1983 <prof1983@ya.ru>
@Created 25.02.2013
@LastMod 04.04.2013
}
unit ADataPrivTypes;

interface

uses
  ABase,
  ABaseTypes,
  ADataBase;

type
  ADataConnection_ChangeDataSet_Proc = function(Connection: ADataConnection;
      DataSet: ADataSet; const SelectSql: AString_Type): AError; stdcall;
  ADataConnection_CheckDatabaseStructure_Proc = function(Connection: ADataConnection;
      Struct: ADataStructure; Logger: AAddToLogA_Proc): AError; stdcall;
  ADataConnection_CheckTableStructure_Proc = function(Connection: ADataConnection;
      TableStruct: ATableStructure; Logger: AAddToLogA_Proc): AError; stdcall;
  ADataConnection_Close_Proc = function(Connection: ADataConnection): AError; stdcall;
  ADataConnection_Connect_Proc = function(Connection: ADataConnection): AError; stdcall;
  ADataConnection_CreateDatabase_Proc = function(Connection: ADataConnection): AError; stdcall;
  ADataConnection_Disconnect_Proc = function(Connection: ADataConnection): AError; stdcall;
  ADataConnection_ExecuteSql_Proc = function(Connection: ADataConnection;
      const Sql: AString_Type): AError; stdcall;
  ADataConnection_GetConnected_Proc = function(Connection: ADataConnection): ABool;
  ADataConnection_GetConnectionString_Proc = function(Connection: ADataConnection;
      var Value: AString_Type): AError; stdcall;
  ADataConnection_NewDataSet_Proc = function(Connection: ADataConnection;
      const SelectSqlText: AString_Type; ReadOnly: ABool): ADataSet;
  ADataConnection_NewDataSetEx_Proc = function(Connection: ADataConnection;
      const SelectSqlText, UpdateSqlText, InsertSqlText,
      DeleteSqlText, RefreshSqlText: AString_Type): ADataSet; stdcall;
  ADataConnection_SetConnectionString_Proc = function(Connection: ADataConnection;
      const Value: AString_Type): AError; stdcall;
  ADataConnection_SetReadOnly_Proc = function(Connection: ADataConnection;
      DataSet: ADataSet; ReadOnly: ABool): AError; stdcall;

type
  ADataDriver_Close_Proc = function(): AError; stdcall;
  ADataDriver_ChangeDataSet_Proc = function(DataSet: ADataSet; const SelectSql: AString_Type): AError; stdcall;
  ADataDriver_Connect_Proc = function(): ABool; stdcall;
  ADataDriver_CreateDatabase_Proc = function(): ABool; stdcall;
  ADataDriver_Disconnect_Proc = function(): AError; stdcall;
  ADataDriver_ExecuteSql_Proc = function(const Sql: AString_Type): ABool; stdcall;
  ADataDriver_GetName_Proc = function(var Value: AString_Type): AError; stdcall;
  ADataDriver_NewConnection_Proc = function(): ADataConnection; stdcall;
  ADataDriver_GetConnected_Proc = function(): ABool; stdcall;
  ADataDriver_GetConnectionString_Proc = function(var Value: AString_Type): AError; stdcall;
  ADataDriver_SetConnectionString_Proc = function(const Value: AString_Type): AError; stdcall;
  ADataDriver_SetDataSetReadOnly_Proc = function(DataSet: ADataSet; ReadOnly: ABool): AError; stdcall;

type
  ADataDriverProcs = record
    Driver_Close: ADataDriver_Close_Proc;
    Driver_Connect: ADataDriver_Connect_Proc;
    Driver_CreateDatabase: ADataDriver_CreateDatabase_Proc;
    Driver_Disconnect: ADataDriver_Disconnect_Proc;
    Driver_ExecuteSql: ADataDriver_ExecuteSql_Proc;
    Driver_GetConnected: ADataDriver_GetConnected_Proc;
    Driver_GetConnectionString: ADataDriver_GetConnectionString_Proc;
    Driver_SetConnectionString: ADataDriver_SetConnectionString_Proc;
    Driver_ChangeDataSet: ADataDriver_ChangeDataSet_Proc;
    Driver_GetName: ADataDriver_GetName_Proc;
    Driver_NewConnection: ADataDriver_NewConnection_Proc; // NewDatabase
    Driver_SetDataSetReadOnly: ADataDriver_SetDataSetReadOnly_Proc;

    Connection_ChangeDataSet: ADataConnection_ChangeDataSet_Proc;
    Connection_CheckDatabaseStructure: ADataConnection_CheckDatabaseStructure_Proc;
    Connection_CheckTableStructure: ADataConnection_CheckTableStructure_Proc;
    Connection_Close: ADataConnection_Close_Proc;
    Connection_Connect: ADataConnection_Connect_Proc;
    Connection_CreateDatabase: ADataConnection_CreateDatabase_Proc;
    Connection_Disconnect: ADataConnection_Disconnect_Proc;
    Connection_ExecuteSql: ADataConnection_ExecuteSql_Proc;
    Connection_GetConnected: ADataConnection_GetConnected_Proc;
    Connection_GetConnectionString: ADataConnection_GetConnectionString_Proc;
    Connection_NewDataSet: ADataConnection_NewDataSet_Proc;
    Connection_NewDataSetEx: ADataConnection_NewDataSetEx_Proc;
    Connection_SetConnectionString: ADataConnection_SetConnectionString_Proc;
    Connection_SetReadOnly: ADataConnection_SetReadOnly_Proc;
  end;

implementation

end.
