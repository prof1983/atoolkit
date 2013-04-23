{**
@Author Prof1983 <prof1983@ya.ru>
@Created 13.10.2008
@LastMod 23.04.2013
}
unit ADataMod;

interface

uses
  ABase,
  ADataBase,
  ADataConnections,
  ADataMain,
  ADataStruct,
  ARuntimeBase,
  ARuntimeMain;

// --- ADataMod ---

function ADataMod_Boot(): AError; stdcall;

function ADataMod_Fin(): AError; stdcall;

function ADataMod_GetProc(ProcName: AStr): Pointer; stdcall;

function ADataMod_Init(): AError; stdcall;

implementation

const
  AData_Version = $00060200;

const
  Module: AModule_Type = (
    Version: AData_Version;
    Uid: AData_Uid;
    Name: AData_Name;
    Description: nil;
    Init: ADataMod_Init;
    Fin: ADataMod_Fin;
    GetProc: ADataMod_GetProc;
    Procs: nil;
    );

var
  FInitialized: ABoolean;

// --- ADataMod ---

function ADataMod_Boot(): AError;
begin
  Result := ARuntime_RegisterModule(Module);
end;

function ADataMod_Fin(): AError;
begin
  FInitialized := False;
  Result := AData_Fin();
end;

function ADataMod_GetProc(ProcName: AStr): Pointer;
begin
  if (ProcName = 'ADataConnection_ChangeDataSet') then
    Result := Addr(ADataConnection_ChangeDataSet)
  else if (ProcName = 'ADataConnection_CheckDatabaseStructure') then
    Result := Addr(ADataConnection_CheckDatabaseStructure)
  else if (ProcName = 'ADataConnection_CheckTableStructure') then
    Result := Addr(ADataConnection_CheckTableStructure)
  else if (ProcName = 'ADataConnection_Close') then
    Result := Addr(ADataConnection_Close)
  else if (ProcName = 'ADataConnection_Connect') then
    Result := Addr(ADataConnection_Connect)
  else if (ProcName = 'ADataConnection_CreateDatabase') then
    Result := Addr(ADataConnection_CreateDatabase)
  else if (ProcName = 'ADataConnection_Disconnect') then
    Result := Addr(ADataConnection_Disconnect)
  else if (ProcName = 'ADataConnection_ExecuteSql') then
    Result := Addr(ADataConnection_ExecuteSql)
  else if (ProcName = 'ADataConnection_GetConnected') then
    Result := Addr(ADataConnection_GetConnected)
  else if (ProcName = 'ADataConnection_GetConnectionString') then
    Result := Addr(ADataConnection_GetConnectionString)
  else if (ProcName = 'ADataConnection_NewDataSet') then
    Result := Addr(ADataConnection_NewDataSet)
  else if (ProcName = 'ADataConnection_NewDataSetEx') then
    Result := Addr(ADataConnection_NewDataSetEx)
  else if (ProcName = 'ADataConnection_SetConnectionString') then
    Result := Addr(ADataConnection_SetConnectionString)
  else if (ProcName = 'ADataStruct_AddTable') then
    Result := Addr(ADataStruct_AddTable)
  else if (ProcName = 'ADataStruct_Clear') then
    Result := Addr(ADataStruct_Clear)
  else if (ProcName = 'AData_Fin') then
    Result := Addr(AData_Fin)
  else if (ProcName = 'AData_Init') then
    Result := Addr(AData_Init)
  else if (ProcName = 'AData_NewConnection') then
    Result := Addr(AData_NewConnection)
  else if (ProcName = 'AData_NewDatabaseStructure') then
    Result := Addr(AData_NewDatabaseStructure)
  else if (ProcName = 'AData_RegisterDriver') then
    Result := Addr(AData_RegisterDriver)
  else
    Result := nil;
end;

function ADataMod_Init(): AError;
begin
  if FInitialized then
  begin
    Result := 0;
    Exit;
  end;

  FInitialized := True;
  Result := AData_Init();
end;

end.
