{**
@Abstract ARuntime exports
@Author Prof1983 <prof1983@yandex.ru>
@Created 20.08.2007
@LastMod 24.06.2012
}
unit ARuntimeExp;

interface

uses
  ARuntime;

exports
  {$IFDEF A02}
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
  {$IFDEF USE_EVENTS}
  Runtime_OnAfterRun_Connect,
  Runtime_OnAfterRun_Disconnect,
  Runtime_OnBeforeRun_Connect,
  Runtime_OnBeforeRun_Disconnect,
  {$ENDIF USE_EVENTS}
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
  {$ELSE}
  ARuntime_IsShutdown name 'ARuntime_IsShutdown',
  ARuntime_OnAfterRun_Get name 'ARuntime_GetOnAfterRun',
  ARuntime_OnAfterRun_Set name 'ARuntime_SetOnAfterRun',
  ARuntime_OnBeforeRun_Get name 'ARuntime_GetOnBeforeRun',
  ARuntime_OnBeforeRun_Set name 'ARuntime_SetOnBeforeRun',
  ARuntime_OnRun_Set name 'ARuntime_SetOnRun',
  ARuntime.SetOnShutdown02 name 'ARuntime_SetOnShutdown';
  {$ENDIF}

implementation

end.
 