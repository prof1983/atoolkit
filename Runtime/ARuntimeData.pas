{**
@Abstract ARuntime global variables
@Author Prof1983 <prof1983@ya.ru>
@Created 13.07.2011
@LastMod 24.07.2012
}
unit ARuntimeData;

interface

uses
  ABase;

var
  FIsShutdown: ABoolean;
  FOnAfterRun: AProc;
  FOnBeforeRun: AProc;
  FOnRun: AProc;
  FOnRun02: AProc02;
  FOnShutdown: AProc03;
  FOnShutdown02: AProc02;

implementation

end.
 