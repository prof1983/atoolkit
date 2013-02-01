{**
@Abstract ARuntime global variables
@Author Prof1983 <prof1983@ya.ru>
@Created 13.07.2011
@LastMod 30.01.2013
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
  FOnShutdown: AProc;

implementation

end.
 