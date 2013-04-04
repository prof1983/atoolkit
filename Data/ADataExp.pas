{**
@Author Prof1983 <prof1983@ya.ru>
@Created 04.04.2013
@LastMod 04.04.2013
}
unit ADataExp;

interface

uses
  ABase,
  ADataConnections,
  ADataMain,
  ADataStruct;

exports
  ADataConnection_ChangeDataSet,
  ADataConnection_CheckDatabaseStructure,
  ADataConnection_CheckTableStructure,
  ADataConnection_Close,
  ADataConnection_Connect,
  ADataConnection_CreateDatabase,
  ADataConnection_Disconnect,
  ADataConnection_ExecuteSql,
  ADataConnection_GetConnected,
  ADataConnection_GetConnectionString,
  ADataConnection_NewDataSet,
  ADataConnection_NewDataSetEx,
  ADataConnection_SetConnectionString,
  ADataStruct_AddTable,
  ADataStruct_Clear,
  AData_Fin,
  AData_Init,
  AData_NewConnection,
  AData_NewDatabaseStructure,
  AData_RegisterDriver;

implementation

end.
 