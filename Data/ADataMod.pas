{**
@Author Prof1983 <prof1983@ya.ru>
@Created 13.10.2008
}
unit ADataMod;

interface

uses
  ABase,
  AData,
  ADataBase,
  ADataProcs,
  ARuntime,
  ARuntimeBase;

// --- Data Module ---

function Data_Boot(): AInt;

procedure Data_Done02(); stdcall;

function Data_Done03(): AInt; stdcall;

function Data_Init02(): AInt; stdcall;

function Data_Init03(): AInt; stdcall;

const
  DataProcs: ADataProcs_Type = (
    Database_Close: AData.Database_Close;                               // 00
    Database_Connect: AData.Database_Connect;                           // 01
    Database_CreateDatabase: AData.Database_CreateDatabase;             // 02
    Database_Disconnect: AData.Database_Disconnect;                     // 03
    Database_ExecuteSql: AData.Database_ExecuteSql;                     // 04
    Database_ChechDatabaseStructure: AData.Database_CheckDatabaseStructure; // 05
    Database_CheckTableStructure: AData.Database_CheckTableStructure;   // 06
    Database_GetConnected: AData.Database_GetConnected;                 // 07
    Database_GetConnectionString: AData.Database_GetConnectionString;   // 08
    Database_New: AData.Data_NewDatabase;                               // 09
    Database_NewDataSet: AData.Database_NewDataSet;                     // 10
    Database_NewDataSetA: AData.Database_NewDataSetA;                   // 11
    Database_SetConnectionString: AData.Database_SetConnectionString;   // 12
    DatabaseStructure_New: AData.Data_NewDatabaseStructure;             // 13
    Drivers_RegisterDriver: AData.Data_RegisterDriver;                  // 14
    Database_ChangeDataSet: AData.Database_ChangeDataSet;               // 15
    {$ifndef A02}
    Init: AData.Init;                                                   // 16
    Done: AData.Done;                                                   // 17
    Reserved18: 0;
    Reserved19: 0;
    Reserved20: 0;
    Reserved21: 0;
    Reserved22: 0;
    Reserved23: 0;
    Reserved24: 0;
    Reserved25: 0;
    Reserved26: 0;
    Reserved27: 0;
    Reserved28: 0;
    Reserved29: 0;
    Reserved30: 0;
    Reserved31: 0;
    {$endif}
    );

implementation

uses
  AData0;

const
  {$ifdef A02}
  AData_Version = $00020800;
  {$else}
  AData_Version = $00040100;
  {$endif}

const
  {$ifdef A02}
  Module: AModule02_Type = (
    Version: AData_Version;
    Init: Data_Init02;
    Done: Data_Done02;
    Name: AData_Name;
    Procs: Addr(DataProcs);
    Reserved1: 0;
    Reserved2: 0;
    Reserved3: 0;
    );
  {$else}
  Module: AModule03_Type = (
    Version: AData_Version;
    Uid: AData_Uid;
    Name: AData_Name;
    Description: nil;
    Init: Data_Init03;
    Done: Data_Done03;
    Reserved06: 0;
    Procs: Addr(DataProcs);
    );
  {$endif}

var
  FDrivers: array of ADataDriver;
  FInitialized: ABoolean;

// --- Data Module ---

function Data_Boot(): AInt;
begin
  {$ifdef A02}
  Result := ARuntime.Module_Register02(Module);
  {$else}
  Result := ARuntime.Module_Register(Module);
  {$endif}
end;

procedure Data_Done02();
begin
  Data_Done03();
end;

function Data_Done03(): AInt;
begin
  try
    AData.Data_Done();
  except
  end;
end;

function Data_Init02(): AInt;
begin
  Result := Data_Init03();
end;

function Data_Init03(): AInt;
begin
  try
    Result := AData.Data_Init();
  except
    Result := -1;
  end;
end;

initialization
  Data_SetProcs(DataProcs);
end.
