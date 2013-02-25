{**
@Author Prof1983 <prof1983@ya.ru>
@Created 13.10.2008
@LastMod 25.02.2013
}
unit ADataUtils;

interface

uses
  ABase,
  ADataBase,
  ADataPrivData;

// --- Priv ---

function _FindConnection(Connection: ADataConnection): AInt;

function _FindDriver(Driver: ADataDriver): AInt;

implementation

// --- Private ---

function _FindConnection(Connection: ADataConnection): AInt;
var
  I: Integer;
begin
  for I := 0 to High(FConnections) do
  begin
    if (FConnections[I].Id = Connection) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

function _FindDriver(Driver: ADataDriver): AInt;
var
  I: AInt;
begin
  for I := 0 to High(FDrivers) do
  begin
    if (FDrivers[I].Id = Driver) then
    begin
      Result := I;
      Exit;
    end;
  end;
  Result := -1;
end;

end.
 