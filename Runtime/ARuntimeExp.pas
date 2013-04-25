{**
@Abstract ARuntime exports
@Author Prof1983 <prof1983@ya.ru>
@Created 20.08.2007
}
unit ARuntimeExp;

interface

uses
  ARuntimeMain;

exports
  {$ifdef A02}
  Runtime_GetCompanyName,
  Runtime_GetCopyright,
  Runtime_GetDescription,
  Runtime_GetExeName,
  Runtime_GetExePath,
  Runtime_GetProductName,
  Runtime_GetProductVersion,
  Runtime_GetProgramName,
  Runtime_GetProgramVersion,
  Runtime_GetTitle,
  Runtime_GetUrl,
  Runtime_GetIsShutdown,
  Runtime_GetResourceString,
  Runtime_GetConfig,
  {$ifdef USE_EVENTS}
  Runtime_OnAfterRun_Connect,
  Runtime_OnAfterRun_Disconnect,
  Runtime_OnBeforeRun_Connect,
  Runtime_OnBeforeRun_Disconnect,
  {$endif}
  Runtime_ProcessMessages,
  Runtime_SetConfig,
  Runtime_ShowError,
  Runtime_ShowMessage,
  Runtime_ShowMessageA,
  Runtime_Shutdown,
  Runtime_SetOnProcessMessages,
  Runtime_SetOnRun,
  Runtime_SetOnShutdown,
  Runtime_SetOnShowError,
  Runtime_SetOnShowMessage;
  {$else}
  ARuntime_GetIsShutdown,
  ARuntime_GetOnAfterRun,
  ARuntime_GetOnBeforeRun,
  ARuntime_SetOnAfterRun,
  ARuntime_SetOnBeforeRun,
  ARuntime_SetOnRun,
  ARuntime_SetOnShutdown,
  ARuntime_Shutdown;
  {$endif}

implementation

end.
 