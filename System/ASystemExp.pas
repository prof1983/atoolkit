{**
@Abstract ASystem exports
@Author Prof1983 <prof1983@ya.ru>
@Created 20.08.2007
@LastMod 31.01.2013
}
unit ASystemExp;

{$ifndef NoRuntimeEvents}
  {$define UseEvents}
{$endif}

interface

uses
  ASystemEvents,
  ASystemMain,
  ASystemResourceString;

exports
  ASystem_GetConfig,
  ASystem_GetCompanyName,
  ASystem_GetCopyright,
  ASystem_GetDataDirectoryPath,
  ASystem_GetDescription,
  ASystem_GetDirectoryPath,
  ASystem_GetExeName,
  ASystem_GetExePath,
  ASystem_GetProductName,
  ASystem_GetProductVersionStr,
  ASystem_GetProgramName,
  ASystem_GetProgramVersionStr,
  ASystem_GetTitle,
  ASystem_GetUrl,
  ASystem_GetResourceString,
  {$ifdef UseEvents}
  ASystem_OnAfterRun_Connect,
  ASystem_OnAfterRun_Disconnect,
  ASystem_OnBeforeRun_Connect,
  ASystem_OnBeforeRun_Disconnect,
  {$endif}
  ASystem_Prepare,
  ASystem_PrepareA,
  ASystem_ProcessMessages,
  ASystem_SetConfig,
  ASystem_ShowError,
  ASystem_ShowMessage,
  ASystem_ShowMessageEx,
  ASystem_Shutdown,
  ASystem_SetOnProcessMessages,
  ASystem_SetOnShowErrorA,
  ASystem_SetOnShowMessageA;

implementation

end.
