{**
@abstract ASystem exports
@author Prof1983 <prof1983@ya.ru>
@created 20.08.2007
@lastmod 24.07.2012
}
unit ASystemExp;

{$IFNDEF NoRuntimeEvents}
  {$DEFINE USE_EVENTS}
{$ENDIF NoRuntimeEvents}

interface

uses
  ASystem;

exports
  ASystem.GetCompanyName name 'ASystem_GetCompanyName',
  ASystem.GetCopyright name 'ASystem_GetCopyright',
  ASystem.GetDescription name 'ASystem_GetDescription',
  ASystem.GetExeName name 'ASystem_GetExeName',
  ASystem.GetExePath name 'ASystem_GetExePath',
  ASystem.GetProductName name 'ASystem_GetProductName',
  ASystem.GetProductVersion name 'ASystem_GetProductVersion',
  ASystem.GetProgramName name 'ASystem_GetProgramName',
  ASystem.GetProgramVersionWS name 'ASystem_GetProgramVersion',
  ASystem.GetTitle name 'ASystem_GetTitle',
  ASystem.GetUrl name 'ASystem_GetUrl',
  ASystem.GetResourceStringWS name 'ASystem_GetResourceString',
  ASystem.GetConfig name 'ASystem_GetConfig',
  {$IFDEF USE_EVENTS}
  ASystem.OnAfterRun_Connect name 'ASystem_OnAfterRun_Connect',
  ASystem.OnAfterRun_Disconnect name 'ASystem_OnAfterRun_Disconnect',
  ASystem.OnBeforeRun_Connect name 'ASystem_OnBeforeRun_Connect',
  ASystem.OnBeforeRun_Disconnect name 'ASystem_OnBeforeRun_Disconnect',
  {$ENDIF USE_EVENTS}
  ASystem.ProcessMessages02 name 'ASystem_ProcessMessages',
  Runtime_SetConfig name 'ASystem_SetConfig',
  ASystem.ShowError02 name 'ASystem_ShowError',
  ASystem.ShowMessage02 name 'ASystem_ShowMessage',
  ASystem.ShowMessageExWS name 'ASystem_ShowMessageA',
  ASystem.Shutdown name 'ASystem_Shutdown',
  ASystem.SetOnProcessMessages02 name 'ASystem_SetOnProcessMessages',
  ASystem.SetOnShowError name 'ASystem_SetOnShowError',
  ASystem.SetOnShowMessage name 'ASystem_SetOnShowMessage';

implementation

end.
 