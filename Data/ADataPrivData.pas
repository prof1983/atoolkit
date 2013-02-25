{**
@Author Prof1983 <prof1983@ya.ru>
@Created 25.02.2013
@LastMod 25.02.2013
}
unit ADataPrivData;

interface

uses
  ABase,
  ADataBase,
  ADataPrivTypes,
  ADataTypes;

var
  FConnections: array of record
    Id: ADataConnection;
    Driver: ADataDriver;
  end;
  FDrivers: array of record
    Id: ADataDriver;
    GetProc: ADataDriverGetProc_Proc;
    Procs: ADataDriverProcs;
  end;
  FInitialized: ABool;

implementation

end.
