{**
@Author Prof1983 <prof1983@ya.ru>
@Created 26.12.2012
@LastMod 25.02.2013
}
unit ADataMain;

{define AStdCall}

interface

uses
  ABase,
  ABaseTypes,
  ADataBase,
  ADatabaseStructure,
  ADataPrivData,
  ADataTypes,
  ADataUtils,
  AStringMain;

// --- AData ---

function AData_Fin(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AData_Init(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AData_NewConnectionP(const DriverName: APascalString): ADataConnection;

function AData_NewDatabaseStructure(): ADataStructure; {$ifdef AStdCall}stdcall;{$endif}

function AData_NewDatabaseP(const DriverName: APascalString): ADataConnection; deprecated {$ifdef ADeprText}'Use AData_NewConnectionP()'{$endif};

function AData_RegisterDriver(GetProc: ADataDriverGetProc_Proc): ADataDriver; {$ifdef AStdCall}stdcall;{$endif}

// --- Data ---

function Data_NewDatabaseP(const DriverName: APascalString): ADataConnection; deprecated {$ifdef ADeprText}'Use AData_NewConnectionP()'{$endif};

function Data_NewDatabaseStructure(): ADataStructure; {$ifdef AStdCall}stdcall;{$endif}

function Data_RegisterDriver(GetProc: ADataDriverGetProc_Proc): ADataDriver; {$ifdef AStdCall}stdcall;{$endif}

implementation

// --- Private ---

function _Driver_GetNameP(Index: AInt): APascalString;
var
  S: AString_Type;
begin
  AString_Clear(S);
  if (FDrivers[Index].Procs.Driver_GetName(S) < 0) then
  begin
    Result := '';
    Exit;
  end;
  AString_ToPascalString(S);
end;

function _Driver_NewConnection(Index: AInt): ADataConnection;
begin
  Result := FDrivers[Index].Procs.Driver_NewConnection();
end;

// --- AData ---

function AData_Fin(): AError;
begin
  FInitialized := False;
  Result := 0;
end;

function AData_Init(): AError;
begin
  if FInitialized then
  begin
    Result := 0;
    Exit;
  end;

  FInitialized := True;
  Result := 0;
end;

function AData_NewDatabaseStructure(): ADataStructure;
begin
  try
    Result := ADataStructure(TADatabaseStructure.Create());
  except
    Result := 0;
  end;
end;

function AData_NewConnectionP(const DriverName: APascalString): ADataConnection;
var
  I: Integer;
  J: Integer;
  Connection: ADataConnection;
begin
  try
    for I := 0 to High(FDrivers) do
    begin
      if (_Driver_GetNameP(I) = DriverName) then
      begin
        Connection := _Driver_NewConnection(I);
        if (Connection <> 0) then
        begin
          J := Length(FConnections);
          SetLength(FConnections, J+1);
          FConnections[J].Id := Connection;
          FConnections[J].Driver := FDrivers[I].Id;
        end;
        Result := Connection;
        Exit;
      end;
    end;
    Result := 0;
  except
    Result := 0;
  end;
end;

function AData_NewDatabaseP(const DriverName: APascalString): ADataConnection;
begin
  Result := AData_NewConnectionP(DriverName);
end;

function AData_RegisterDriver(GetProc: ADataDriverGetProc_Proc): ADataDriver;
var
  I: Integer;
  Id: Integer;
begin
  try
    Id := 1;
    for I := 0 to High(FDrivers) do
    begin
      if (FDrivers[I].Id > Id) then
        Id := FDrivers[I].Id + 1;
    end;

    I := Length(FDrivers);
    SetLength(FDrivers, I + 1);

    FDrivers[I].Id := Id;
    FDrivers[I].GetProc := GetProc;

    FDrivers[I].Procs.Driver_Close := GetProc('Driver_Close');
    FDrivers[I].Procs.Driver_Connect := GetProc('Driver_Connect');
    FDrivers[I].Procs.Driver_CreateDatabase := GetProc('Driver_CreateDatabase');
    FDrivers[I].Procs.Driver_Disconnect := GetProc('Driver_Disconnect');
    FDrivers[I].Procs.Driver_ExecuteSql := GetProc('Driver_ExecuteSql');
    FDrivers[I].Procs.Driver_GetConnected := GetProc('Driver_GetConnected');
    FDrivers[I].Procs.Driver_GetConnectionString := GetProc('Driver_GetConnectionString');
    FDrivers[I].Procs.Driver_SetConnectionString := GetProc('Driver_SetConnectionString');
    FDrivers[I].Procs.Driver_ChangeDataSet := GetProc('Driver_ChangeDataSet');
    FDrivers[I].Procs.Driver_GetName := GetProc('Driver_GetName');
    FDrivers[I].Procs.Driver_NewConnection := GetProc('Driver_NewConnection');
    FDrivers[I].Procs.Driver_SetDataSetReadOnly := GetProc('Driver_SetDataSetReadOnly');

    FDrivers[I].Procs.Connection_ChangeDataSet := GetProc('Connection_ChangeDataSet');
    FDrivers[I].Procs.Connection_CheckDatabaseStructure := GetProc('Connection_CheckDatabaseStructure');
    FDrivers[I].Procs.Connection_CheckTableStructure := GetProc('Connection_CheckTableStructure');
    FDrivers[I].Procs.Connection_Close := GetProc('Connection_Close');
    FDrivers[I].Procs.Connection_Connect := GetProc('Connection_Connect');
    FDrivers[I].Procs.Connection_CreateDatabase := GetProc('Connection_CreateDatabase');
    FDrivers[I].Procs.Connection_Disconnect := GetProc('Connection_Disconnect');
    FDrivers[I].Procs.Connection_ExecuteSql := GetProc('Connection_ExecuteSql');
    FDrivers[I].Procs.Connection_GetConnected := GetProc('Connection_GetConnected');
    FDrivers[I].Procs.Connection_GetConnectionString := GetProc('Connection_GetConnectionString');
    FDrivers[I].Procs.Connection_NewDataSet := GetProc('Connection_NewDataSet');
    FDrivers[I].Procs.Connection_NewDataSetEx := GetProc('Connection_NewDataSetEx');
    FDrivers[I].Procs.Connection_SetConnectionString := GetProc('Connection_SetConnectionString');
    FDrivers[I].Procs.Connection_SetReadOnly := GetProc('Connection_SetReadOnly');

    Result := Id;
  except
    Result := 0;
  end;
end;

// --- Data ---

function Data_NewDatabaseP(const DriverName: APascalString): ADataConnection;
begin
  Result := AData_NewConnectionP(DriverName);
end;

function Data_NewDatabaseStructure(): ADataStructure;
begin
  Result := AData_NewDatabaseStructure();
end;

function Data_RegisterDriver(GetProc: ADataDriverGetProc_Proc): ADataDriver;
begin
  Result := AData_RegisterDriver(GetProc);
end;

end.
