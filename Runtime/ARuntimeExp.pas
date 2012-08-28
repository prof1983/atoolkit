{**
@Abstract ARuntime exports
@Author Prof1983 <prof1983@ya.ru>
@Created 20.08.2007
@LastMod 28.08.2012
}
unit ARuntimeExp;

interface

uses
  ARuntimeMain;

exports
  ARuntime_GetIsShutdown,
  ARuntime_SetOnRun,
  ARuntime_SetOnShutdown,
  ARuntime_GetOnAfterRun,
  ARuntime_GetOnBeforeRun,
  ARuntime_SetOnAfterRun,
  ARuntime_SetOnBeforeRun,
  ARuntime_SetOnRun,
  ARuntime_Shutdown;

implementation

end.
 