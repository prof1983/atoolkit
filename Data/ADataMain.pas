{**
@Author Prof1983 <prof1983@ya.ru>
@Created 26.12.2012
@LastMod 05.02.2013
}
unit ADataMain;

{define AStdCall}

interface

uses
  ABase,
  ABaseTypes,
  ADataBase,
  ADataUtils;

// --- AData ---

function AData_Fin(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AData_Init(): AError; {$ifdef AStdCall}stdcall;{$endif}

function AData_NewDatabaseStructure(): ADataStructure; {$ifdef AStdCall}stdcall;{$endif}

function AData_NewDatabaseWS(const DriverName: AWideString): ADataConnection; {$ifdef AStdCall}stdcall;{$endif}

function AData_RegisterDriver(DataDriver: ADataDriver): AInt; {$ifdef AStdCall}stdcall;{$endif}

implementation

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
    Result := ADataUtils.Data_NewDatabaseStructure();
  except
    Result := 0;
  end;
end;

function AData_NewDatabaseWS(const DriverName: AWideString): ADataConnection;
begin
  try
    Result := ADataUtils.Data_NewDatabase(DriverName);
  except
    Result := 0;
  end;
end;

function AData_RegisterDriver(DataDriver: ADataDriver): AInt;
begin
  try
    Result := ADataUtils.Data_RegisterDriver(DataDriver);
  except
    Result := -1;
  end;
end;

end.
