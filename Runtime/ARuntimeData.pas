{**
@Abstract ARuntime global variables
@Author Prof1983 <prof1983@ya.ru>
@Created 13.07.2011
}
unit ARuntimeData;

interface

uses
  ABase,
  ARuntimeBase;

var
  FIsShutdown: ABoolean;
  FOnAfterRun: AProc;
  FOnBeforeRun: AProc;
  FOnRun: AProc;
  FOnRun02: AProc02;
  FOnShutdown: AProc;
  FOnShutdown02: AProc02;

var
  FModules: array of AModule_Type;

implementation

end.
 